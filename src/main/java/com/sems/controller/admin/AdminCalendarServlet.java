package com.sems.controller.admin;

import com.sems.exception.DatabaseException;
import com.sems.model.AcademicCalendar;
import com.sems.model.User;
import com.sems.service.AcademicCalendarService;
import com.sems.service.SystemActivityService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/admin-calendar")
public class AdminCalendarServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AdminCalendarServlet.class.getName());
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd-MM-yyyy");
    
    private final AcademicCalendarService calendarService = new AcademicCalendarService();
    private final SystemActivityService activityService = new SystemActivityService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Load all calendar events from database
            List<AcademicCalendar> calendarEvents = calendarService.getAllEvents();
            request.setAttribute("calendarEvents", calendarEvents);
            
            request.getRequestDispatcher("/admin/calendar.jsp").forward(request, response);
            
        } catch (DatabaseException e) {
            LOGGER.log(Level.SEVERE, "Error loading calendar events", e);
            request.setAttribute("error", "Failed to load calendar events");
            request.getRequestDispatcher("/admin/calendar.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        try {
            int calendarId = Integer.parseInt(request.getParameter("calendarId"));
            String activityName = request.getParameter("activityName");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            
            LocalDate startDate = LocalDate.parse(startDateStr, DATE_FORMATTER);
            LocalDate endDate = LocalDate.parse(endDateStr, DATE_FORMATTER);
            
            AcademicCalendar calendar = calendarService.getEventById(calendarId);
            if (calendar != null) {
                calendar.setActivityName(activityName);
                calendar.setStartDate(startDate);
                calendar.setEndDate(endDate);
                
                calendarService.updateEvent(calendar);
                
                // Log activity
                activityService.logActivity(user.getUserId(), user.getRole().toString(), "UPDATE_CALENDAR", 
                    "Updated calendar event: " + activityName);
                
                LOGGER.info("Updated calendar event ID: " + calendarId + " to: " + activityName);
            }
            
            response.sendRedirect(request.getContextPath() + "/admin-calendar?success=true");
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating calendar event", e);
            response.sendRedirect(request.getContextPath() + "/admin-calendar?error=true");
        }
    }
}
