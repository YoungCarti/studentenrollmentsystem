package com.sems.dao;

import com.sems.exception.DatabaseException;
import com.sems.model.AcademicCalendar;
import com.sems.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for AcademicCalendar entity.
 * Handles all database operations related to academic calendar.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class AcademicCalendarDAO {
    
    private static final Logger LOGGER = Logger.getLogger(AcademicCalendarDAO.class.getName());
    
    /**
     * Create a new calendar event
     * 
     * @param calendar AcademicCalendar object to create
     * @return The generated calendar ID
     * @throws DatabaseException if creation fails
     */
    public int create(AcademicCalendar calendar) throws DatabaseException {
        String sql = "INSERT INTO academic_calendar (semester, activity_name, start_date, end_date, description) " +
                     "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, calendar.getSemester());
            stmt.setString(2, calendar.getActivityName());
            stmt.setDate(3, Date.valueOf(calendar.getStartDate()));
            stmt.setDate(4, Date.valueOf(calendar.getEndDate()));
            stmt.setString(5, calendar.getDescription());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new DatabaseException("Creating calendar event failed, no rows affected");
            }
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int calendarId = generatedKeys.getInt(1);
                    calendar.setCalendarId(calendarId);
                    LOGGER.info("Created calendar event with ID: " + calendarId);
                    return calendarId;
                } else {
                    throw new DatabaseException("Creating calendar event failed, no ID obtained");
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating calendar event", e);
            throw new DatabaseException("Failed to create calendar event: " + e.getMessage(), e);
        }
    }
    
    /**
     * Find a calendar event by ID
     * 
     * @param calendarId Calendar ID to search for
     * @return AcademicCalendar object if found, null otherwise
     * @throws DatabaseException if query fails
     */
    public AcademicCalendar findById(int calendarId) throws DatabaseException {
        String sql = "SELECT * FROM academic_calendar WHERE calendar_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, calendarId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCalendar(rs);
                }
            }
            
            return null;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding calendar event by ID", e);
            throw new DatabaseException("Failed to find calendar event: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get all calendar events
     * 
     * @return List of all calendar events
     * @throws DatabaseException if query fails
     */
    public List<AcademicCalendar> getAllEvents() throws DatabaseException {
        String sql = "SELECT * FROM academic_calendar ORDER BY start_date ASC";
        List<AcademicCalendar> events = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                events.add(mapResultSetToCalendar(rs));
            }
            
            return events;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting all calendar events", e);
            throw new DatabaseException("Failed to get calendar events: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get events for a specific semester
     * 
     * @param semester Semester name
     * @return List of events for the semester
     * @throws DatabaseException if query fails
     */
    public List<AcademicCalendar> getEventsBySemester(String semester) throws DatabaseException {
        String sql = "SELECT * FROM academic_calendar WHERE semester = ? ORDER BY start_date ASC";
        List<AcademicCalendar> events = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, semester);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    events.add(mapResultSetToCalendar(rs));
                }
            }
            
            return events;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting events by semester", e);
            throw new DatabaseException("Failed to get semester events: " + e.getMessage(), e);
        }
    }
    
    /**
     * Update an existing calendar event
     * 
     * @param calendar AcademicCalendar object with updated data
     * @return true if update successful, false otherwise
     * @throws DatabaseException if update fails
     */
    public boolean update(AcademicCalendar calendar) throws DatabaseException {
        String sql = "UPDATE academic_calendar SET semester = ?, activity_name = ?, " +
                     "start_date = ?, end_date = ?, description = ? WHERE calendar_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, calendar.getSemester());
            stmt.setString(2, calendar.getActivityName());
            stmt.setDate(3, Date.valueOf(calendar.getStartDate()));
            stmt.setDate(4, Date.valueOf(calendar.getEndDate()));
            stmt.setString(5, calendar.getDescription());
            stmt.setInt(6, calendar.getCalendarId());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                LOGGER.info("Updated calendar event ID: " + calendar.getCalendarId());
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating calendar event", e);
            throw new DatabaseException("Failed to update calendar event: " + e.getMessage(), e);
        }
    }
    
    /**
     * Delete a calendar event by ID
     * 
     * @param calendarId Calendar ID to delete
     * @return true if deletion successful, false otherwise
     * @throws DatabaseException if deletion fails
     */
    public boolean delete(int calendarId) throws DatabaseException {
        String sql = "DELETE FROM academic_calendar WHERE calendar_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, calendarId);
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                LOGGER.info("Deleted calendar event ID: " + calendarId);
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting calendar event", e);
            throw new DatabaseException("Failed to delete calendar event: " + e.getMessage(), e);
        }
    }
    
    /**
     * Map ResultSet row to AcademicCalendar object
     * 
     * @param rs ResultSet with current row
     * @return AcademicCalendar object
     * @throws SQLException if mapping fails
     */
    private AcademicCalendar mapResultSetToCalendar(ResultSet rs) throws SQLException {
        AcademicCalendar calendar = new AcademicCalendar();
        calendar.setCalendarId(rs.getInt("calendar_id"));
        calendar.setSemester(rs.getString("semester"));
        calendar.setActivityName(rs.getString("activity_name"));
        
        Date startDate = rs.getDate("start_date");
        if (startDate != null) {
            calendar.setStartDate(startDate.toLocalDate());
        }
        
        Date endDate = rs.getDate("end_date");
        if (endDate != null) {
            calendar.setEndDate(endDate.toLocalDate());
        }
        
        calendar.setDescription(rs.getString("description"));
        
        return calendar;
    }
}
