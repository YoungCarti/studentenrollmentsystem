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
                        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">
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
                        <a href="${pageContext.request.contextPath}/admin/reports.jsp" class="active">
                            <i data-lucide="file-bar-chart"></i>
                            Reports
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