<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Student Dashboard - SEMS</title>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
                <script src="https://unpkg.com/lucide@latest"></script>
            </head>

            <body>
                <div class="dashboard-container">
                    <!-- Sidebar -->
                    <aside class="sidebar">
                        <div class="brand">
                            <img src="${pageContext.request.contextPath}/images/logo.png" alt="SEMS Logo"
                                style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;"> SEMS Portal
                        </div>

                        <ul class="nav-links">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/student-dashboard" class="active">
                                    <i data-lucide="layout-dashboard"></i>
                                    Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/student-timetable">
                                    <i data-lucide="calendar"></i>
                                    Timetable
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/enroll-course">
                                    <i data-lucide="book-open"></i>
                                    My Courses
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/student-results">
                                    <i data-lucide="graduation-cap"></i>
                                    My Results
                                </a>
                            </li>
                        </ul>

                        <div class="user-profile" onclick="toggleProfileMenu()">
                            <div class="avatar">${student.firstName.substring(0,1)}${student.lastName.substring(0,1)}
                            </div>
                            <div>
                                <div style="font-weight: 500;">${student.firstName} ${student.lastName}</div>
                                <div style="font-size: 0.75rem; color: var(--text-muted);">Student</div>
                            </div>
                            <i data-lucide="chevron-up"
                                style="margin-left: auto; width: 16px; height: 16px; color: var(--text-muted);"></i>

                            <div class="profile-dropdown" id="profileDropdown">
                                <a href="${pageContext.request.contextPath}/student/profile.jsp" class="dropdown-item">
                                    <i data-lucide="user" style="width: 16px; height: 16px;"></i> Profile
                                </a>
                                <div class="dropdown-divider"></div>
                                <a href="${pageContext.request.contextPath}/logout" class="dropdown-item text-red">
                                    <i data-lucide="log-out" style="width: 16px; height: 16px;"></i> Logout
                                </a>
                            </div>
                        </div>
                    </aside>

                    <!-- Main Content -->
                    <main class="main-content">
                        <header class="header">
                            <div>
                                <h1>Welcome, ${student.firstName} ${student.lastName}!</h1>
                                <p style="color: var(--text-muted);">Overview of your academic progress</p>
                            </div>
                            <!-- Logout button removed from here -->
                        </header>

                        <!-- Stats Overview -->
                        <div class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-label">Enrolled Courses</div>
                                <div class="stat-value">${totalEnrollments}</div>
                                <div style="color: #10b981; font-size: 0.875rem;">Active term</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Average Grade</div>
                                <div class="stat-value">${averageGpa != null && averageGpa != '0.00' ? averageGpa :
                                    'N/A'}
                                </div>
                                <div style="color: var(--text-muted); font-size: 0.875rem;">GPA</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Credits Earned</div>
                                <div class="stat-value">${totalCredits != null ? totalCredits : 0}</div>
                                <div style="color: var(--text-muted); font-size: 0.875rem;">Total</div>
                            </div>
                        </div>

                        <!-- Academic Calendar -->
                        <div class="calendar-section">
                            <div class="calendar-header">
                                <h3>📅 Academic Calendar - September 2025</h3>
                            </div>

                            <table class="calendar-table">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">No</th>
                                        <th>Semester Activities</th>
                                        <th style="width: 150px;">Start Date</th>
                                        <th style="width: 150px;">End Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="rowNum" value="1" />
                                    <c:forEach var="event" items="${calendarEvents}">
                                        <tr>
                                            <td>${rowNum}</td>
                                            <td>${event.activityName}</td>
                                            <td>${event.formattedStartDate}</td>
                                            <td>${event.formattedEndDate}</td>
                                        </tr>
                                        <c:set var="rowNum" value="${rowNum + 1}" />
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </main>
                </div>
                <script>
                    lucide.createIcons();

                    function toggleProfileMenu() {
                        const dropdown = document.getElementById('profileDropdown');
                        dropdown.classList.toggle('show');
                    }

                    // Close dropdown when clicking outside
                    window.addEventListener('click', function (e) {
                        const profile = document.querySelector('.user-profile');
                        if (!profile.contains(e.target)) {
                            document.getElementById('profileDropdown').classList.remove('show');
                        }
                    });
                </script>
            </body>

            </html>