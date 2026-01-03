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
                        <a href="${pageContext.request.contextPath}/admin/enrollments.jsp" class="active">
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
                        <h1>Enrollment Oversight</h1>
                        <p style="color: var(--text-muted);">Manage student course enrollments</p>
                    </div>
                </header>

                <div class="card">
                    <div style="display: flex; gap: 1rem; margin-bottom: 1.5rem;">
                        <input type="text" id="searchInput" class="form-control"
                            placeholder="Search by student or course..." style="max-width: 300px;"
                            onkeyup="filterEnrollments()">
                        <select id="statusFilter" class="form-control" style="max-width: 150px;"
                            onchange="filterEnrollments()">
                            <option value="">All Status</option>
                            <option value="Pending">Pending</option>
                            <!-- Future proofing if we show history later -->
                        </select>
                    </div>

                    <h3 class="mb-4">Pending Requests</h3>
                    <table id="enrollmentsTable" style="width: 100%; border-collapse: collapse; text-align: left;">
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
                        <tbody id="enrollmentsBody">
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">
                                    <div style="font-weight: 500;">Alice Walker</div>
                                    <div style="font-size: 0.75rem; color: var(--text-muted);">ID: 2023055</div>
                                </td>
                                <td style="padding: 1rem;">CS205: Web Development</td>
                                <td style="padding: 1rem;">Oct 24, 2023</td>
                                <td style="padding: 1rem;">
                                    <button class="btn" onclick="processEnrollment(this, 'approved')"
                                        style="padding: 0.25rem 0.75rem; font-size: 0.75rem; background: #10b981; margin-right: 0.5rem;">Approve</button>
                                    <button class="btn" onclick="processEnrollment(this, 'rejected')"
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
                                    <button class="btn" onclick="processEnrollment(this, 'approved')"
                                        style="padding: 0.25rem 0.75rem; font-size: 0.75rem; background: #10b981; margin-right: 0.5rem;">Approve</button>
                                    <button class="btn" onclick="processEnrollment(this, 'rejected')"
                                        style="padding: 0.25rem 0.75rem; font-size: 0.75rem; background: #ef4444;">Reject</button>
                                </td>
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

            function filterEnrollments() {
                const searchInput = document.getElementById('searchInput');
                const filterValue = searchInput.value.toUpperCase();
                const table = document.getElementById('enrollmentsTable');
                const tr = table.getElementsByTagName('tr');

                for (let i = 1; i < tr.length; i++) {
                    const tdStudent = tr[i].getElementsByTagName('td')[0]; // Student Name/ID
                    const tdCourse = tr[i].getElementsByTagName('td')[1]; // Course

                    if (tdStudent && tdCourse) {
                        const studentText = tdStudent.textContent || tdStudent.innerText;
                        const courseText = tdCourse.textContent || tdCourse.innerText;

                        if (studentText.toUpperCase().indexOf(filterValue) > -1 || courseText.toUpperCase().indexOf(filterValue) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }

            function processEnrollment(button, action) {
                if (confirm('Are you sure you want to ' + action.slice(0, -1) + ' this request?')) {
                    const row = button.closest('tr');
                    // Simulate processing by removing the row
                    row.style.opacity = '0';
                    setTimeout(() => {
                        row.remove();
                        // Implementation Note: In a real backend, this would make an API call 
                        // to update the status in the database, which would then reflect on the student's page.
                    }, 300);
                }
            }
        </script>
    </body>

    </html>