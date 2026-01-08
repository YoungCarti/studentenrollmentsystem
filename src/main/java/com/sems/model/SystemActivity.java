package com.sems.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

/**
 * System Activity entity for logging user actions and system events.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class SystemActivity implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int activityId;
    private Integer userId;
    private String userType;
    private String actionType;
    private String description;
    private LocalDateTime createdAt;
    
    /**
     * Default constructor
     */
    public SystemActivity() {
    }
    
    /**
     * Constructor without ID (for new activities)
     */
    public SystemActivity(Integer userId, String userType, String actionType, String description) {
        this.userId = userId;
        this.userType = userType;
        this.actionType = actionType;
        this.description = description;
    }
    
    /**
     * Constructor with all fields
     */
    public SystemActivity(int activityId, Integer userId, String userType, 
                         String actionType, String description, LocalDateTime createdAt) {
        this.activityId = activityId;
        this.userId = userId;
        this.userType = userType;
        this.actionType = actionType;
        this.description = description;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    
    public int getActivityId() {
        return activityId;
    }
    
    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }
    
    public Integer getUserId() {
        return userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    
    public String getUserType() {
        return userType;
    }
    
    public void setUserType(String userType) {
        this.userType = userType;
    }
    
    public String getActionType() {
        return actionType;
    }
    
    public void setActionType(String actionType) {
        this.actionType = actionType;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "SystemActivity{" +
                "activityId=" + activityId +
                ", userId=" + userId +
                ", userType='" + userType + '\'' +
                ", actionType='" + actionType + '\'' +
                ", description='" + description + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SystemActivity that = (SystemActivity) o;
        return activityId == that.activityId;
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(activityId);
    }
}
