<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="active">
                            <i data-lucide="layout-dashboard"></i>
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/students.jsp">
                            <i data-lucide="users"></i>
                            Students
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/courses.jsp">
                            <i data-lucide="book-open"></i>
                            Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/enrollments.jsp">
                            <i data-lucide="clipboard-list"></i>
                            Enrollments
                        </a>
                    </li>
                </ul>

                <div class="user-profile" onclick="toggleProfileMenu()">
                    <div class="avatar" style="background: #10b981;">AD</div>
                    <div>
                        <div style="font-weight: 500;">System Admin</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">Administrator</div>
                    </div>
                    <i data-lucide="chevron-up"
                        style="margin-left: auto; width: 16px; height: 16px; color: var(--text-muted);"></i>

                    <div class="profile-dropdown" id="profileDropdown">
                        <a href="#" class="dropdown-item">
                            <i data-lucide="user" style="width: 16px; height: 16px;"></i> Profile
                        </a>
                        <div class="dropdown-divider"></div>
                        <a href="${pageContext.request.contextPath}/auth/login.jsp" class="dropdown-item text-red">
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
                        <div class="stat-value">1,240</div>
                        <div style="color: #10b981; font-size: 0.875rem;">+12% this semester</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-label">Active Courses</div>
                        <div class="stat-value">48</div>
                        <div style="color: var(--text-muted); font-size: 0.875rem;">Across 6 depts</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-label">New Enrollments</div>
                        <div class="stat-value">356</div>
                        <div style="color: #f59e0b; font-size: 0.875rem;">Pending approval</div>
                    </div>
                </div>

                <!-- Recent Activity -->
                <h2 class="mb-4">Recent System Activity</h2>
                <div class="card">
                    <table style="width: 100%; border-collapse: collapse; text-align: left;">
                        <thead>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 500; font-size: 0.875rem;">
                                    Action</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 500; font-size: 0.875rem;">
                                    User</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 500; font-size: 0.875rem;">
                                    Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">New Student Registration</td>
                                <td style="padding: 1rem;">John Doe</td>
                                <td style="padding: 1rem; color: var(--text-muted);">03/01/2026 09:15 PM</td>
                            </tr>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">Course CS101 Updated</td>
                                <td style="padding: 1rem;">Admin</td>
                                <td style="padding: 1rem; color: var(--text-muted);">03/01/2026 08:15 PM</td>
                            </tr>
                            <tr>
                                <td style="padding: 1rem;">Enrollment Request</td>
                                <td style="padding: 1rem;">Jane Smith</td>
                                <td style="padding: 1rem; color: var(--text-muted);">03/01/2026 06:15 PM</td>
                            </tr>
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