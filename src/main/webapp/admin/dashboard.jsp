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
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/students.jsp">
                            Students
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/courses.jsp">
                            Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/enrollments.jsp">
                            Enrollments
                        </a>
                    </li>
                </ul>

                <div class="user-profile">
                    <div class="avatar" style="background: #10b981;">AD</div>
                    <div>
                        <div style="font-weight: 500;">System Admin</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">Administrator</div>
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
                    <a href="${pageContext.request.contextPath}/auth/login.jsp" class="btn"
                        style="background-color: rgba(239, 68, 68, 0.1); color: #ef4444; display: flex; align-items: center; gap: 0.5rem;">
                        <i data-lucide="log-out" style="width: 16px; height: 16px;"></i>
                        Logout
                    </a>
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
                                <td style="padding: 1rem; color: var(--text-muted);">2 mins ago</td>
                            </tr>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">Course CS101 Updated</td>
                                <td style="padding: 1rem;">Admin</td>
                                <td style="padding: 1rem; color: var(--text-muted);">1 hour ago</td>
                            </tr>
                            <tr>
                                <td style="padding: 1rem;">Enrollment Request</td>
                                <td style="padding: 1rem;">Jane Smith</td>
                                <td style="padding: 1rem; color: var(--text-muted);">3 hours ago</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </body>

    </html>