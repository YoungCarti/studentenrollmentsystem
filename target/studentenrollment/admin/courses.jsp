<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Courses - Admin Portal</title>
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
                        <a href="${pageContext.request.contextPath}/admin/courses.jsp" class="active">
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
                        <h1>Course Management</h1>
                        <p style="color: var(--text-muted);">Add and modify course offerings</p>
                    </div>
                    <button class="btn">
                        + Add New Course
                    </button>
                </header>

                <div class="course-list">
                    <div class="course-card">
                        <div>
                            <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                <h3 style="font-size: 1.1rem;">CS205: Web Development</h3>
                                <span
                                    style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem;">3
                                    Credits</span>
                            </div>
                            <p style="color: var(--text-muted); font-size: 0.875rem;">Department: Computer Science • Max
                                Capacity: 40</p>
                        </div>
                        <div>
                            <button class="btn"
                                style="padding: 0.5rem 1rem; font-size: 0.875rem; background: var(--bg-card); border: 1px solid var(--border); color: var(--text-muted);">Edit</button>
                        </div>
                    </div>

                    <div class="course-card">
                        <div>
                            <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                <h3 style="font-size: 1.1rem;">CS201: Data Structures</h3>
                                <span
                                    style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem;">4
                                    Credits</span>
                            </div>
                            <p style="color: var(--text-muted); font-size: 0.875rem;">Department: Computer Science • Max
                                Capacity: 35</p>
                        </div>
                        <div>
                            <button class="btn"
                                style="padding: 0.5rem 1rem; font-size: 0.875rem; background: var(--bg-card); border: 1px solid var(--border); color: var(--text-muted);">Edit</button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body>

    </html>