<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Students - Admin Portal</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
        </head>

        <body>
            <script src="https://unpkg.com/lucide@latest"></script>

            <div class="dashboard-container">
                <!-- Sidebar (Admin) -->
                <aside class="sidebar" style="border-right-color: var(--primary);">
                    <div class="brand">
                        <img src="${pageContext.request.contextPath}/images/logo.png" alt="SEMS Logo"
                            style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
                        SEMS Admin
                    </div>

                    <ul class="nav-links">
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/admin-dashboard">
                                <i data-lucide="layout-dashboard"></i>
                                Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/admin/calendar.jsp">
                                <i data-lucide="calendar"></i>
                                Manage Academic Calendar
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/manage-students" class="active">
                                <i data-lucide="users"></i>
                                Manage Student
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/admin/courses.jsp">
                                <i data-lucide="book-open"></i>
                                Manage Courses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/admin/enrollments.jsp">
                                <i data-lucide="clipboard-list"></i>
                                Manage Enrollments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/admin/results.jsp">
                                <i data-lucide="graduation-cap"></i>
                                Manage Results
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/admin/reports.jsp">
                                <i data-lucide="file-bar-chart"></i>
                                Reports
                            </a>
                        </li>
                    </ul>

                    <div class="user-profile" onclick="toggleProfileMenu()">
                        <div class="avatar" style="background: #10b981;">
                            ${sessionScope.user.username.substring(0,2).toUpperCase()}</div>
                        <div>
                            <div style="font-weight: 500;">${sessionScope.user.username}</div>
                            <div style="font-size: 0.75rem; color: var(--text-muted);">Administrator</div>
                        </div>
                        <i data-lucide="chevron-up"
                            style="margin-left: auto; width: 16px; height: 16px; color: var(--text-muted);"></i>

                        <div class="profile-dropdown" id="profileDropdown">
                            <a href="#" class="dropdown-item">
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
                            <h1>Student Management</h1>
                            <p style="color: var(--text-muted);">View and manage all registered students</p>
                        </div>
                    </header>

                    <div class="card">
                        <c:choose>
                            <c:when test="${not empty students}">
                                <table style="width: 100%; border-collapse: collapse; text-align: left;">
                                    <thead>
                                        <tr style="border-bottom: 2px solid var(--border);">
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Student ID</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Name</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Email</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Phone</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Date of Birth</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Enrollment Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="student" items="${students}" varStatus="status">
                                            <tr style="border-bottom: 1px solid var(--border);">
                                                <td style="padding: 1rem;">${student.studentId}</td>
                                                <td style="padding: 1rem; font-weight: 500;">${student.firstName}
                                                    ${student.lastName}</td>
                                                <td style="padding: 1rem; color: var(--text-muted);">${student.email}
                                                </td>
                                                <td style="padding: 1rem;">${student.phone != null ? student.phone :
                                                    'N/A'}</td>
                                                <td style="padding: 1rem;">${student.dob}</td>
                                                <td style="padding: 1rem;">${student.enrollmentDate}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 3rem; color: var(--text-muted);">
                                    <i data-lucide="users" style="width: 48px; height: 48px; margin-bottom: 1rem;"></i>
                                    <p>No students registered yet</p>
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