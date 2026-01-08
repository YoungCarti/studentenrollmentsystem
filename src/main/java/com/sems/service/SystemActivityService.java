package com.sems.service;

import com.sems.dao.SystemActivityDAO;
import com.sems.exception.DatabaseException;
import com.sems.model.SystemActivity;

import java.util.List;

/**
 * Service layer for System Activity operations.
 * Provides business logic for activity logging.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class SystemActivityService {
    
    private final SystemActivityDAO activityDAO;
    
    public SystemActivityService() {
        this.activityDAO = new SystemActivityDAO();
    }
    
    /**
     * Log a system activity
     * 
     * @param userId User ID performing the action
     * @param userType Type of user (ADMIN/STUDENT)
     * @param actionType Type of action performed
     * @param description Description of the action
     * @throws DatabaseException if logging fails
     */
    public void logActivity(Integer userId, String userType, String actionType, String description) throws DatabaseException {
        SystemActivity activity = new SystemActivity(userId, userType, actionType, description);
        activityDAO.create(activity);
    }
    
    /**
     * Get recent system activities
     * 
     * @param limit Maximum number of activities to retrieve
     * @return List of recent activities
     * @throws DatabaseException if query fails
     */
    public List<SystemActivity> getRecentActivities(int limit) throws DatabaseException {
        return activityDAO.getRecentActivities(limit);
    }
    
    /**
     * Get all activities for a specific user
     * 
     * @param userId User ID
     * @return List of user activities
     * @throws DatabaseException if query fails
     */
    public List<SystemActivity> getUserActivities(int userId) throws DatabaseException {
        return activityDAO.getActivitiesByUser(userId);
    }
}
