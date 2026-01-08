<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>My Courses - SEMS</title>
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
                            <a href="${pageContext.request.contextPath}/student-dashboard">
                                <i data-lucide="layout-dashboard"></i>
                                Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/student/timetable.jsp">
                                <i data-lucide="calendar"></i>
                                Timetable
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/enroll-course" class="active">
                                <i data-lucide="book-open"></i>
                                My Courses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/student/results.jsp">
                                <i data-lucide="graduation-cap"></i>
                                My Results
                            </a>
                        </li>
                    </ul>

                    <div class="user-profile" onclick="toggleProfileMenu()">
                        <div class="avatar">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
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
                            <h1>My Courses</h1>
                            <p style="color: var(--text-muted);">View your course enrollments and their status</p>
                        </div>
                    </header>

                    <c:if test="${not empty error}">
                        <div class="alert alert-error"
                            style="background: rgba(239, 68, 68, 0.1); border: 1px solid #ef4444; color: #ef4444; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                            ${error}
                        </div>
                    </c:if>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success"
                            style="background: rgba(16, 185, 129, 0.1); border: 1px solid #10b981; color: #10b981; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                            ${success}
                        </div>
                    </c:if>

                    <!-- Available Courses Section -->
                    <div class="card" style="margin-bottom: 2rem;">
                        <h2 style="margin-bottom: 1.5rem;">Available Courses</h2>
                        <div
                            style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 1.5rem;">
                            <c:choose>
                                <c:when test="${not empty courses}">
                                    <c:forEach var="course" items="${courses}">
                                        <div class="course-card"
                                            style="background: var(--bg-card); border: 1px solid var(--border); border-radius: 12px; padding: 1.5rem;">
                                            <div
                                                style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 1rem;">
                                                <div>
                                                    <h3 style="font-size: 1.1rem; margin-bottom: 0.25rem;">
                                                        ${course.courseName}</h3>
                                                    <p style="color: var(--text-muted); font-size: 0.875rem;">
                                                        ${course.courseCode}</p>
                                                </div>
                                                <span
                                                    style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.25rem 0.5rem; border-radius: 0.25rem; font-weight: 500;">
                                                    ${course.credits} Credits
                                                </span>
                                            </div>
                                            <c:if test="${not empty course.instructor}">
                                                <p
                                                    style="color: var(--text-muted); font-size: 0.875rem; margin-bottom: 0.5rem;">
                                                    <i data-lucide="user"
                                                        style="width: 14px; height: 14px; display: inline-block;"></i>
                                                    ${course.instructor}
                                                </p>
                                            </c:if>
                                            <c:if test="${not empty course.schedule}">
                                                <p
                                                    style="color: var(--text-muted); font-size: 0.875rem; margin-bottom: 1rem;">
                                                    <i data-lucide="clock"
                                                        style="width: 14px; height: 14px; display: inline-block;"></i>
                                                    ${course.schedule}
                                                </p>
                                            </c:if>
                                            <form action="${pageContext.request.contextPath}/enroll-course"
                                                method="post" style="margin-top: 1rem;">
                                                <input type="hidden" name="action" value="enroll">
                                                <input type="hidden" name="courseId" value="${course.courseId}">
                                                <button type="submit" class="btn btn-primary" style="width: 100%;">
                                                    <i data-lucide="plus-circle" style="width: 16px; height: 16px;"></i>
                                                    Enroll
                                                </button>
                                            </form>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state"
                                        style="grid-column: 1 / -1; text-align: center; padding: 3rem;">
                                        <i data-lucide="book-open"
                                            style="width: 64px; height: 64px; color: var(--text-muted); margin-bottom: 1rem;"></i>
                                        <h3>No courses available</h3>
                                        <p style="color: var(--text-muted);">There are currently no courses available
                                            for enrollment.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
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