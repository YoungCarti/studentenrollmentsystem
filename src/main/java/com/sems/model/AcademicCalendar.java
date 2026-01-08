package com.sems.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

/**
 * Academic Calendar entity representing semester events and activities.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class AcademicCalendar implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int calendarId;
    private String semester;
    private String activityName;
    private LocalDate startDate;
    private LocalDate endDate;
    private String description;
    
    /**
     * Default constructor
     */
    public AcademicCalendar() {
    }
    
    /**
     * Constructor without ID (for new events)
     */
    public AcademicCalendar(String semester, String activityName, LocalDate startDate, LocalDate endDate) {
        this.semester = semester;
        this.activityName = activityName;
        this.startDate = startDate;
        this.endDate = endDate;
    }
    
    /**
     * Constructor with all fields
     */
    public AcademicCalendar(int calendarId, String semester, String activityName, 
                           LocalDate startDate, LocalDate endDate, String description) {
        this.calendarId = calendarId;
        this.semester = semester;
        this.activityName = activityName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.description = description;
    }
    
    // Getters and Setters
    
    public int getCalendarId() {
        return calendarId;
    }
    
    public void setCalendarId(int calendarId) {
        this.calendarId = calendarId;
    }
    
    public String getSemester() {
        return semester;
    }
    
    public void setSemester(String semester) {
        this.semester = semester;
    }
    
    public String getActivityName() {
        return activityName;
    }
    
    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }
    
    public LocalDate getStartDate() {
        return startDate;
    }
    
    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }
    
    public LocalDate getEndDate() {
        return endDate;
    }
    
    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    @Override
    public String toString() {
        return "AcademicCalendar{" +
                "calendarId=" + calendarId +
                ", semester='" + semester + '\'' +
                ", activityName='" + activityName + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", description='" + description + '\'' +
                '}';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AcademicCalendar that = (AcademicCalendar) o;
        return calendarId == that.calendarId;
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(calendarId);
    }
}
