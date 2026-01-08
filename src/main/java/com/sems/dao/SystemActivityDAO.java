package com.sems.dao;

import com.sems.exception.DatabaseException;
import com.sems.model.SystemActivity;
import com.sems.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for SystemActivity entity.
 * Handles all database operations related to system activity logging.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class SystemActivityDAO {
    
    private static final Logger LOGGER = Logger.getLogger(SystemActivityDAO.class.getName());
    
    /**
     * Create a new system activity log entry
     * 
     * @param activity SystemActivity object to create
     * @return The generated activity ID
     * @throws DatabaseException if creation fails
     */
    public int create(SystemActivity activity) throws DatabaseException {
        String sql = "INSERT INTO system_activity (user_id, user_type, action_type, description) " +
                     "VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setObject(1, activity.getUserId());
            stmt.setString(2, activity.getUserType());
            stmt.setString(3, activity.getActionType());
            stmt.setString(4, activity.getDescription());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new DatabaseException("Creating system activity failed, no rows affected");
            }
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int activityId = generatedKeys.getInt(1);
                    activity.setActivityId(activityId);
                    return activityId;
                } else {
                    throw new DatabaseException("Creating system activity failed, no ID obtained");
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating system activity", e);
            throw new DatabaseException("Failed to create system activity: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get recent system activities
     * 
     * @param limit Maximum number of activities to retrieve
     * @return List of recent activities
     * @throws DatabaseException if query fails
     */
    public List<SystemActivity> getRecentActivities(int limit) throws DatabaseException {
        String sql = "SELECT * FROM system_activity ORDER BY created_at DESC LIMIT ?";
        List<SystemActivity> activities = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    activities.add(mapResultSetToActivity(rs));
                }
            }
            
            return activities;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting recent activities", e);
            throw new DatabaseException("Failed to get recent activities: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get all activities for a specific user
     * 
     * @param userId User ID
     * @return List of activities for the user
     * @throws DatabaseException if query fails
     */
    public List<SystemActivity> getActivitiesByUser(int userId) throws DatabaseException {
        String sql = "SELECT * FROM system_activity WHERE user_id = ? ORDER BY created_at DESC";
        List<SystemActivity> activities = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    activities.add(mapResultSetToActivity(rs));
                }
            }
            
            return activities;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting activities by user", e);
            throw new DatabaseException("Failed to get user activities: " + e.getMessage(), e);
        }
    }
    
    /**
     * Map ResultSet row to SystemActivity object
     * 
     * @param rs ResultSet with current row
     * @return SystemActivity object
     * @throws SQLException if mapping fails
     */
    private SystemActivity mapResultSetToActivity(ResultSet rs) throws SQLException {
        SystemActivity activity = new SystemActivity();
        activity.setActivityId(rs.getInt("activity_id"));
        activity.setUserId((Integer) rs.getObject("user_id"));
        activity.setUserType(rs.getString("user_type"));
        activity.setActionType(rs.getString("action_type"));
        activity.setDescription(rs.getString("description"));
        
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            activity.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        return activity;
    }
}
