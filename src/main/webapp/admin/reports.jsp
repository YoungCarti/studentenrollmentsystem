<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reports - Admin Portal</title>
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
                        <a href="${pageContext.request.contextPath}/admin/enrollments.jsp">
                            Enrollments
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/reports.jsp" class="active">
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
                        <h1>System Reports</h1>
                        <p style="color: var(--text-muted);">Generate and view academic reports</p>
                    </div>
                </header>

                <div class="stats-grid">
                    <div class="card" style="display: flex; flex-direction: column; gap: 1rem;">
                        <h3>Student Enrollment Report</h3>
                        <p style="color: var(--text-muted); font-size: 0.875rem;">Detailed report of all student
                            enrollments by department and semester.</p>
                        <button class="btn"
                            style="background: var(--bg-body); border: 1px solid var(--border); margin-top: auto;">Generate
                            PDF</button>
                    </div>

                    <div class="card" style="display: flex; flex-direction: column; gap: 1rem;">
                        <h3>Course Popularity</h3>
                        <p style="color: var(--text-muted); font-size: 0.875rem;">Analysis of course registration
                            numbers and waitlist statistics.</p>
                        <button class="btn"
                            style="background: var(--bg-body); border: 1px solid var(--border); margin-top: auto;">Generate
                            CSV</button>
                    </div>

                    <div class="card" style="display: flex; flex-direction: column; gap: 1rem;">
                        <h3>Academic Performance</h3>
                        <p style="color: var(--text-muted); font-size: 0.875rem;">Average GPA distribution and grade
                            summaries per course.</p>
                        <button class="btn"
                            style="background: var(--bg-body); border: 1px solid var(--border); margin-top: auto;">Generate
                            PDF</button>
                    </div>
                </div>
            </main>
        </div>
    </body>

    </html>