<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Timetable - SEMS</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
            <script src="https://unpkg.com/lucide@latest"></script>
            <style>
                .timetable-container {
                    background: var(--bg-card);
                    border-radius: 12px;
                    padding: 1.5rem;
                    margin-top: 1.5rem;
                }

                .schedule-item {
                    background: linear-gradient(135deg, rgba(99, 102, 241, 0.1), rgba(168, 85, 247, 0.1));
                    border-left: 4px solid var(--primary);
                    padding: 1rem;
                    border-radius: 8px;
                    margin-bottom: 1rem;
                }

                .schedule-item h4 {
                    margin: 0 0 0.5rem 0;
                    color: var(--text-primary);
                    font-size: 1rem;
                }

                .schedule-item p {
                    margin: 0.25rem 0;
                    color: var(--text-muted);
                    font-size: 0.875rem;
                }

                .schedule-badge {
                    display: inline-block;
                    background: var(--primary);
                    color: white;
                    padding: 0.25rem 0.75rem;
                    border-radius: 6px;
                    font-size: 0.75rem;
                    font-weight: 600;
                }
            </style>
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
                            <a href="${pageContext.request.contextPath}/student-dashboard">
                                <i data-lucide="layout-dashboard"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/student-timetable" class="active">
                                <i data-lucide="calendar"></i> Timetable
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/enroll-course">
                                <i data-lucide="book-open"></i> My Courses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/student/results.jsp">
                                <i data-lucide="graduation-cap"></i> My Results
                            </a>
                        </li>
                    </ul>
                    <div class="user-profile" onclick="toggleProfileMenu()">
                        <div class="avatar">${sessionScope.user.username.substring(0,2).toUpperCase()}</div>
                        <div>
                            <div style="font-weight: 500;">${sessionScope.user.username}</div>
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
                            <h1>My Timetable</h1>
                            <p style="color: var(--text-muted);">Your weekly class schedule</p>
                        </div>
                    </header>

                    <c:if test="${not empty error}">
                        <div
                            style="background: rgba(239, 68, 68, 0.1); border: 1px solid #ef4444; color: #ef4444; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                            ${error}
                        </div>
                    </c:if>

                    <div class="timetable-container">
                        <c:choose>
                            <c:when test="${not empty enrollments}">
                                <h3 style="margin-bottom: 1.5rem;">Enrolled Classes</h3>
                                <c:forEach var="enrollment" items="${enrollments}">
                                    <div class="schedule-item">
                                        <h4>
                                            <span class="schedule-badge">${enrollment.courseCode}</span>
                                            ${enrollment.courseName}
                                        </h4>
                                        <p><strong>Schedule:</strong>
                                            <c:choose>
                                                <c:when test="${not empty enrollment.schedule}">
                                                    ${enrollment.schedule}
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: var(--text-muted);">Schedule not
                                                        specified</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <p><strong>Instructor:</strong> ${enrollment.instructor}</p>
                                        <p><strong>Credits:</strong> ${enrollment.credits}</p>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <!-- Empty State -->
                                <div style="text-align: center; padding: 4rem 2rem; color: var(--text-muted);">
                                    <i data-lucide="calendar-x"
                                        style="width: 80px; height: 80px; margin: 0 auto 1.5rem; opacity: 0.3;"></i>
                                    <h2 style="margin-bottom: 0.5rem;">No Classes Scheduled</h2>
                                    <p>Your timetable will appear here once you enroll in courses.</p>
                                    <a href="${pageContext.request.contextPath}/enroll-course" class="btn"
                                        style="margin-top: 1rem;">
                                        Browse Courses
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </main>
            </div>
            <script>
                lucide.createIcons();

                function toggleProfileMenu() {
                    const dropdown = document.getElementById('profileDropdown');
                    dropdown.classList.toggle('show');
                }

                window.addEventListener('click', function (e) {
                    const profile = document.querySelector('.user-profile');
                    if (!profile.contains(e.target)) {
                        document.getElementById('profileDropdown').classList.remove('show');
                    }
                });
            </script>
        </body>

        </html>