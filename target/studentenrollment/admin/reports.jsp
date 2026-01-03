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
        <!-- Chart.js CDN -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            .reports-grid {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .chart-container {
                position: relative;
                height: 300px;
                width: 100%;
            }

            .popular-courses-table {
                width: 100%;
                border-collapse: collapse;
                font-size: 0.875rem;
            }

            .popular-courses-table th,
            .popular-courses-table td {
                padding: 0.75rem 0;
                text-align: left;
                border-bottom: 1px solid var(--border);
            }

            .popular-courses-table th {
                color: var(--text-muted);
                font-weight: 500;
                font-size: 0.75rem;
                text-transform: uppercase;
            }

            /* Toast Notification */
            .toast {
                visibility: hidden;
                min-width: 250px;
                margin-left: -125px;
                background-color: #333;
                color: #fff;
                text-align: center;
                border-radius: 4px;
                padding: 16px;
                position: fixed;
                z-index: 1;
                left: 50%;
                bottom: 30px;
                font-size: 14px;
                opacity: 0;
                transition: opacity 0.5s, visibility 0.5s;
            }

            .toast.show {
                visibility: visible;
                opacity: 1;
            }
        </style>
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
                        <a href="${pageContext.request.contextPath}/admin/results.jsp">
                            <i data-lucide="graduation-cap"></i>
                            Manage Results
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
                        <h1>System Analytics</h1>
                        <p style="color: var(--text-muted);">Visual insights and academic reports</p>
                    </div>
                    <div style="display: flex; gap: 1rem;">
                        <button class="btn" onclick="exportData('Full Report')">
                            <i data-lucide="download" style="width: 16px; height: 16px; margin-right: 8px;"></i>
                            dExport Full Report
                        </button>
                    </div>
                </header>

                <!-- Row 1: Charts -->
                <div class="reports-grid">
                    <!-- Enrollment Stats -->
                    <div class="card">
                        <div
                            style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                            <h3>Enrollment by Project</h3>
                            <button class="btn"
                                style="padding: 0.25rem 0.75rem; font-size: 0.75rem; background: var(--bg-main); border: 1px solid var(--border); color: var(--text-muted);"
                                onclick="exportData('Enrollment Stats')">PDF</button>
                        </div>
                        <div class="chart-container">
                            <canvas id="enrollmentChart"></canvas>
                        </div>
                    </div>

                    <!-- Grade Distribution -->
                    <div class="card">
                        <div
                            style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                            <h3>Grade Distribution</h3>
                            <button class="btn"
                                style="padding: 0.25rem 0.75rem; font-size: 0.75rem; background: var(--bg-main); border: 1px solid var(--border); color: var(--text-muted);"
                                onclick="exportData('Grade Stats')">PNG</button>
                        </div>
                        <div class="chart-container" style="height: 250px;">
                            <canvas id="gradeChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Row 2: Popular Courses Table -->
                <div class="card">
                    <div
                        style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                        <h3>Most Popular Courses</h3>
                        <button class="btn"
                            style="padding: 0.25rem 0.75rem; font-size: 0.75rem; background: var(--bg-main); border: 1px solid var(--border); color: var(--text-muted);"
                            onclick="exportData('Course Data')">CSV</button>
                    </div>
                    <table class="popular-courses-table">
                        <thead>
                            <tr>
                                <th>Rank</th>
                                <th>Course Code</th>
                                <th>Course Name</th>
                                <th>Instructor</th>
                                <th>Enrolled</th>
                                <th>Capacity</th>
                                <th>Fill Rate</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td style="font-weight: 600;">CS205</td>
                                <td>Web Development</td>
                                <td>Prof. Sarah Connor</td>
                                <td>38</td>
                                <td>40</td>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                                        <div
                                            style="width: 100px; height: 6px; background: var(--bg-main); border-radius: 3px; overflow: hidden;">
                                            <div style="width: 95%; height: 100%; background: #10b981;"></div>
                                        </div>
                                        <span style="font-size: 0.75rem; font-weight: 600; color: #10b981;">95%</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td style="font-weight: 600;">CS201</td>
                                <td>Data Structures</td>
                                <td>Dr. Alan Grant</td>
                                <td>32</td>
                                <td>35</td>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                                        <div
                                            style="width: 100px; height: 6px; background: var(--bg-main); border-radius: 3px; overflow: hidden;">
                                            <div style="width: 91%; height: 100%; background: #10b981;"></div>
                                        </div>
                                        <span style="font-size: 0.75rem; font-weight: 600; color: #10b981;">91%</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td style="font-weight: 600;">SE304</td>
                                <td>Software Architecture</td>
                                <td>Dr. Miles Bennet</td>
                                <td>28</td>
                                <td>35</td>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                                        <div
                                            style="width: 100px; height: 6px; background: var(--bg-main); border-radius: 3px; overflow: hidden;">
                                            <div style="width: 80%; height: 100%; background: #6366f1;"></div>
                                        </div>
                                        <span style="font-size: 0.75rem; font-weight: 600; color: #6366f1;">80%</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td style="font-weight: 600;">DB101</td>
                                <td>Database Systems</td>
                                <td>Prof. E. Codd</td>
                                <td>25</td>
                                <td>40</td>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                                        <div
                                            style="width: 100px; height: 6px; background: var(--bg-main); border-radius: 3px; overflow: hidden;">
                                            <div style="width: 62%; height: 100%; background: #f59e0b;"></div>
                                        </div>
                                        <span style="font-size: 0.75rem; font-weight: 600; color: #f59e0b;">62%</span>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </main>
        </div>

        <!-- Toast Notification -->
        <div id="toast" class="toast">Report generated successfully!</div>

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

            // Initialize Charts
            document.addEventListener('DOMContentLoaded', function () {
                // Enrollment Chart
                const ctxEnrollment = document.getElementById('enrollmentChart').getContext('2d');
                new Chart(ctxEnrollment, {
                    type: 'bar',
                    data: {
                        labels: ['BCS (Software Eng.)', 'BSE (Systems)', 'BIT (Info Tech)', 'BIM (Multimedia)'],
                        datasets: [{
                            label: 'Active Students',
                            data: [120, 95, 80, 60],
                            backgroundColor: [
                                'rgba(99, 102, 241, 0.7)', // Primary
                                'rgba(16, 185, 129, 0.7)', // Success
                                'rgba(245, 158, 11, 0.7)', // Warning
                                'rgba(239, 68, 68, 0.7)'   // Danger
                            ],
                            borderColor: [
                                'rgba(99, 102, 241, 1)',
                                'rgba(16, 185, 129, 1)',
                                'rgba(245, 158, 11, 1)',
                                'rgba(239, 68, 68, 1)'
                            ],
                            borderWidth: 1,
                            borderRadius: 4
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(255, 255, 255, 0.05)'
                                },
                                ticks: {
                                    color: '#a1a1aa'
                                }
                            },
                            x: {
                                grid: {
                                    display: false
                                },
                                ticks: {
                                    color: '#a1a1aa'
                                }
                            }
                        }
                    }
                });

                // Grade Chart
                const ctxGrade = document.getElementById('gradeChart').getContext('2d');
                new Chart(ctxGrade, {
                    type: 'doughnut',
                    data: {
                        labels: ['A / A-', 'B+ / B', 'C+ / C', 'Fail (F)'],
                        datasets: [{
                            data: [35, 40, 20, 5],
                            backgroundColor: [
                                '#10b981', // A (Green)
                                '#6366f1', // B (Primary)
                                '#f59e0b', // C (Orange)
                                '#ef4444'  // F (Red)
                            ],
                            borderWidth: 0
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    color: '#a1a1aa',
                                    usePointStyle: true
                                }
                            }
                        },
                        cutout: '70%'
                    }
                });
            });

            // Toast Notification Logic
            function exportData(type) {
                const toast = document.getElementById("toast");
                toast.innerText = `Preparing ${type}... Download started.`;
                toast.className = "toast show";
                setTimeout(function () { toast.className = toast.className.replace("show", ""); }, 3000);
            }
        </script>
    </body>

    </html>