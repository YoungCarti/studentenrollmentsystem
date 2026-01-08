package com.sems.dao;

import com.sems.exception.DatabaseException;
import com.sems.model.User;
import com.sems.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for User entity.
 * Handles all database operations related to user authentication.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class UserDAO {
    
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());
    
    /**
     * Create a new user account
     * 
     * @param user User object to create
     * @return The generated user ID
     * @throws DatabaseException if creation fails
     */
    public int create(User user) throws DatabaseException {
        String sql = "INSERT INTO users (username, password_hash, role, student_id, is_active) " +
                     "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPasswordHash());
            stmt.setString(3, user.getRole().name());
            
            if (user.getStudentId() != null) {
                stmt.setInt(4, user.getStudentId());
            } else {
                stmt.setNull(4, Types.INTEGER);
            }
            
            stmt.setBoolean(5, user.isActive());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new DatabaseException("Creating user failed, no rows affected");
            }
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int userId = generatedKeys.getInt(1);
                    user.setUserId(userId);
                    LOGGER.info("Created user with ID: " + userId);
                    return userId;
                } else {
                    throw new DatabaseException("Creating user failed, no ID obtained");
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating user", e);
            throw new DatabaseException("Failed to create user: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find a user by ID
     * 
     * @param userId User ID to search for
     * @return User object if found, null otherwise
     * @throws DatabaseException if query fails
     */
    public User findById(int userId) throws DatabaseException {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
            
            return null;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding user by ID", e);
            throw new DatabaseException("Failed to find user: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find a user by username
     * 
     * @param username Username to search for
     * @return User object if found, null otherwise
     * @throws DatabaseException if query fails
     */
    public User findByUsername(String username) throws DatabaseException {
        String sql = "SELECT * FROM users WHERE username = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
            
            return null;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding user by username", e);
            throw new DatabaseException("Failed to find user by username: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find a user by student ID
     * 
     * @param studentId Student ID to search for
     * @return User object if found, null otherwise
     * @throws DatabaseException if query fails
     */
    public User findByStudentId(int studentId) throws DatabaseException {
        String sql = "SELECT * FROM users WHERE student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
            
            return null;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding user by student ID", e);
            throw new DatabaseException("Failed to find user by student ID: " + e.getMessage(), e);
        }
    }
    
    /**
     * Update an existing user
     * 
     * @param user User object with updated data
     * @return true if update successful, false otherwise
     * @throws DatabaseException if update fails
     */
    public boolean update(User user) throws DatabaseException {
        String sql = "UPDATE users SET username = ?, role = ?, student_id = ?, is_active = ? " +
                     "WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getRole().name());
            
            if (user.getStudentId() != null) {
                stmt.setInt(3, user.getStudentId());
            } else {
                stmt.setNull(3, Types.INTEGER);
            }
            
            stmt.setBoolean(4, user.isActive());
            stmt.setInt(5, user.getUserId());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                LOGGER.info("Updated user ID: " + user.getUserId());
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating user", e);
            throw new DatabaseException("Failed to update user: " + e.getMessage(), e);
        }
    }
    
    /**
     * Change user password
     * 
     * @param userId User ID
     * @param newPasswordHash New password hash
     * @return true if update successful, false otherwise
     * @throws DatabaseException if update fails
     */
    public boolean changePassword(int userId, String newPasswordHash) throws DatabaseException {
        String sql = "UPDATE users SET password_hash = ? WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newPasswordHash);
            stmt.setInt(2, userId);
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                LOGGER.info("Changed password for user ID: " + userId);
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error changing password", e);
            throw new DatabaseException("Failed to change password: " + e.getMessage(), e);
        }
    }
    
    /**
     * Delete a user by ID
     * 
     * @param userId User ID to delete
     * @return true if deletion successful, false otherwise
     * @throws DatabaseException if deletion fails
     */
    public boolean delete(int userId) throws DatabaseException {
        String sql = "DELETE FROM users WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                LOGGER.info("Deleted user ID: " + userId);
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting user", e);
            throw new DatabaseException("Failed to delete user: " + e.getMessage(), e);
        }
    }
    
    /**
     * Map ResultSet row to User object
     * 
     * @param rs ResultSet with current row
     * @return User object
     * @throws SQLException if mapping fails
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setRole(User.Role.valueOf(rs.getString("role")));
        
        int studentId = rs.getInt("student_id");
        if (!rs.wasNull()) {
            user.setStudentId(studentId);
        }
        
        user.setActive(rs.getBoolean("is_active"));
        
        return user;
    }
}
