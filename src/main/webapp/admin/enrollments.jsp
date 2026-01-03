<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Enrollments - Admin Portal</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    </head>

    <body>
        <div class="dashboard-container">
            <!-- Sidebar (Admin) -->
            <aside class="sidebar" style="border-right-color: var(--primary);">
                <div class="brand">
                    <span>🛡️</span> Admin Portal
                </div>

                <ul class="nav-links">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">
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
                        <a href="${pageContext.request.contextPath}/admin/enrollments.jsp" class="active">
                            Enrollments
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/reports.jsp">
                            Reports
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
                        <h1>Enrollment Oversight</h1>
                        <p style="color: var(--text-muted);">Manage student course enrollments</p>
                    </div>
                </header>

                <div class="card">
                    <h3 class="mb-4">Pending Requests</h3>
                    <table style="width: 100%; border-collapse: collapse; text-align: left;">
                        <thead>
                            <tr style="border-bottom: 2px solid var(--border);">
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Student</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Course</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Date</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">
                                    <div style="font-weight: 500;">Alice Walker</div>
                                    <div style="font-size: 0.75rem; color: var(--text-muted);">ID: 2023055</div>
                                </td>
                                <td style="padding: 1rem;">CS205: Web Development</td>
                                <td style="padding: 1rem;">Oct 24, 2023</td>
                                <td style="padding: 1rem;">
                                    <button class="btn"
                                        style="padding: 0.25rem 0.75rem; font-size: 0.75rem; background: #10b981; margin-right: 0.5rem;">Approve</button>
                                    <button class="btn"
                                        style="padding: 0.25rem 0.75rem; font-size: 0.75rem; background: #ef4444;">Reject</button>
                                </td>
                            </tr>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">
                                    <div style="font-weight: 500;">Robert Chen</div>
                                    <div style="font-size: 0.75rem; color: var(--text-muted);">ID: 2023089</div>
                                </td>
                                <td style="padding: 1rem;">CS201: Data Structures</td>
                                <td style="padding: 1rem;">Oct 23, 2023</td>
                                <td style="padding: 1rem;">
                                    <button class="btn"
                                        style="padding: 0.25rem 0.75rem; font-size: 0.75rem; background: #10b981; margin-right: 0.5rem;">Approve</button>
                                    <button class="btn"
                                        style="padding: 0.25rem 0.75rem; font-size: 0.75rem; background: #ef4444;">Reject</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </body>

    </html>