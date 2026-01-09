<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - SEMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>

<body>
    <script src="https://unpkg.com/lucide@latest"></script>

    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar" style="border-right-color: var(--primary);">
            <div class="brand">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="SEMS Logo"
                    style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;">
                SEMS Admin
            </div>

            <ul class="nav-links">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/admin-dashboard" class="active">
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
                    <a href="${pageContext.request.contextPath}/admin/students.jsp">
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
                    <h1>Dashboard</h1>
                    <p style="color: var(--text-muted);">System overview and management</p>
                </div>
            </header>

            <!-- Stats Overview -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-label">Total Students</div>
                    <div class="stat-value">${totalStudents != null ? totalStudents : 0}</div>
                    <div style="color: var(--text-muted); font-size: 0.875rem;">Registered students</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Active Courses</div>
                    <div class="stat-value">${activeCourses != null ? activeCourses : 0}</div>
                    <div style="color: var(--text-muted); font-size: 0.875rem;">Available courses</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Pending Enrollments</div>
                    <div class="stat-value">${pendingEnrollments != null ? pendingEnrollments : 0}</div>
                    <div style="color: #f59e0b; font-size: 0.875rem;">Awaiting approval</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Approved Enrollments</div>
                    <div class="stat-value">${approvedEnrollments != null ? approvedEnrollments : 0}</div>
                    <div style="color: #10b981; font-size: 0.875rem;">Active enrollments</div>
                </div>
            </div>

            <!-- Recent Activity -->
            <h2 class="mb-4">Recent System Activity</h2>
            <div class="card">
                <c:choose>
                    <c:when test="${not empty recentActivities}">
                        <table style="width: 100%; border-collapse: collapse; text-align: left;">
                            <thead>
                                <tr style="border-bottom: 1px solid var(--border);">
                                    <th
                                        style="padding: 1rem; color: var(--text-muted); font-weight: 500; font-size: 0.875rem;">
                                        Action</th>
                                    <th
                                        style="padding: 1rem; color: var(--text-muted); font-weight: 500; font-size: 0.875rem;">
                                        User Type</th>
                                    <th
                                        style="padding: 1rem; color: var(--text-muted); font-weight: 500; font-size: 0.875rem;">
                                        Description</th>
                                    <th
                                        style="padding: 1rem; color: var(--text-muted); font-weight: 500; font-size: 0.875rem;">
                                        Time</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="activity" items="${recentActivities}">
                                    <tr style="border-bottom: 1px solid var(--border);">
                                        <td style="padding: 1rem;">${activity.actionType}</td>
                                        <td style="padding: 1rem;">${activity.userType}</td>
                                        <td style="padding: 1rem; color: var(--text-muted);">
                                            ${activity.description}</td>
                                        <td style="padding: 1rem; color: var(--text-muted);">
                                            ${activity.createdAt}
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 3rem; color: var(--text-muted);">
                            <i data-lucide="activity" style="width: 48px; height: 48px; margin-bottom: 1rem;"></i>
                            <p>No system activities recorded yet</p>
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