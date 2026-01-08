package com.sems.service;

import com.sems.dao.AcademicCalendarDAO;
import com.sems.exception.DatabaseException;
import com.sems.model.AcademicCalendar;

import java.util.List;

/**
 * Service layer for Academic Calendar operations.
 * Provides business logic for calendar management.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class AcademicCalendarService {
    
    private final AcademicCalendarDAO calendarDAO;
    
    public AcademicCalendarService() {
        this.calendarDAO = new AcademicCalendarDAO();
    }
    
    /**
     * Create a new calendar event
     * 
     * @param calendar AcademicCalendar object
     * @return Generated calendar ID
     * @throws DatabaseException if creation fails
     */
    public int createEvent(AcademicCalendar calendar) throws DatabaseException {
        return calendarDAO.create(calendar);
    }
    
    /**
     * Get calendar event by ID
     * 
     * @param calendarId Calendar ID
     * @return AcademicCalendar object
     * @throws DatabaseException if query fails
     */
    public AcademicCalendar getEventById(int calendarId) throws DatabaseException {
        return calendarDAO.findById(calendarId);
    }
    
    /**
     * Get all calendar events
     * 
     * @return List of all events
     * @throws DatabaseException if query fails
     */
    public List<AcademicCalendar> getAllEvents() throws DatabaseException {
        return calendarDAO.getAllEvents();
    }
    
    /**
     * Get events for a specific semester
     * 
     * @param semester Semester name
     * @return List of semester events
     * @throws DatabaseException if query fails
     */
    public List<AcademicCalendar> getEventsBySemester(String semester) throws DatabaseException {
        return calendarDAO.getEventsBySemester(semester);
    }
    
    /**
     * Update an existing calendar event
     * 
     * @param calendar AcademicCalendar with updated data
     * @return true if successful
     * @throws DatabaseException if update fails
     */
    public boolean updateEvent(AcademicCalendar calendar) throws DatabaseException {
        return calendarDAO.update(calendar);
    }
    
    /**
     * Delete a calendar event
     * 
     * @param calendarId Calendar ID to delete
     * @return true if successful
     * @throws DatabaseException if deletion fails
     */
    public boolean deleteEvent(int calendarId) throws DatabaseException {
        return calendarDAO.delete(calendarId);
    }
}
