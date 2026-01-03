<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Students - Admin Portal</title>
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
                        <a href="${pageContext.request.contextPath}/admin/students.jsp" class="active">
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
                        <h1>Student Management</h1>
                        <p style="color: var(--text-muted);">View and manage student records</p>
                    </div>
                    <button class="btn">
                        + Add New Student
                    </button>
                </header>

                <div class="card">
                    <!-- Search/Actions -->
                    <div style="display: flex; gap: 1rem; margin-bottom: 1.5rem;">
                        <input type="text" class="form-control" placeholder="Search by name or ID..."
                            style="max-width: 300px;">
                        <select class="form-control" style="max-width: 150px;">
                            <option>All Depts</option>
                            <option>CS</option>
                            <option>Math</option>
                        </select>
                    </div>

                    <table style="width: 100%; border-collapse: collapse; text-align: left;">
                        <thead>
                            <tr style="border-bottom: 2px solid var(--border);">
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    ID</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Name</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Email</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Status</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">2023001</td>
                                <td style="padding: 1rem; font-weight: 500;">John Smith</td>
                                <td style="padding: 1rem; color: var(--text-muted);">john.smith@university.edu</td>
                                <td style="padding: 1rem;"><span
                                        style="background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600;">Active</span>
                                </td>
                                <td style="padding: 1rem;">
                                    <button
                                        style="background: none; border: none; color: var(--primary); cursor: pointer; margin-right: 0.5rem; font-weight: 500;">Edit</button>
                                    <button
                                        style="background: none; border: none; color: #ef4444; cursor: pointer; font-weight: 500;">Delete</button>
                                </td>
                            </tr>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">2023002</td>
                                <td style="padding: 1rem; font-weight: 500;">Sarah Johnson</td>
                                <td style="padding: 1rem; color: var(--text-muted);">sarah.j@university.edu</td>
                                <td style="padding: 1rem;"><span
                                        style="background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600;">Active</span>
                                </td>
                                <td style="padding: 1rem;">
                                    <button
                                        style="background: none; border: none; color: var(--primary); cursor: pointer; margin-right: 0.5rem; font-weight: 500;">Edit</button>
                                    <button
                                        style="background: none; border: none; color: #ef4444; cursor: pointer; font-weight: 500;">Delete</button>
                                </td>
                            </tr>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">2023003</td>
                                <td style="padding: 1rem; font-weight: 500;">Michael Brown</td>
                                <td style="padding: 1rem; color: var(--text-muted);">m.brown@university.edu</td>
                                <td style="padding: 1rem;"><span
                                        style="background: rgba(245, 158, 11, 0.1); color: #f59e0b; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600;">Probation</span>
                                </td>
                                <td style="padding: 1rem;">
                                    <button
                                        style="background: none; border: none; color: var(--primary); cursor: pointer; margin-right: 0.5rem; font-weight: 500;">Edit</button>
                                    <button
                                        style="background: none; border: none; color: #ef4444; cursor: pointer; font-weight: 500;">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <div style="display: flex; justify-content: flex-end; padding-top: 1.5rem; gap: 0.5rem;">
                        <button class="btn"
                            style="padding: 0.25rem 0.75rem; background: transparent; color: var(--text-muted); border: 1px solid var(--border);">Prev</button>
                        <button class="btn" style="padding: 0.25rem 0.75rem; background: var(--primary);">1</button>
                        <button class="btn"
                            style="padding: 0.25rem 0.75rem; background: transparent; color: var(--text-muted); border: 1px solid var(--border);">2</button>
                        <button class="btn"
                            style="padding: 0.25rem 0.75rem; background: transparent; color: var(--text-muted); border: 1px solid var(--border);">Next</button>
                    </div>
                </div>
            </main>
        </div>
    </body>

    </html>