<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Reports - Admin Portal</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
            <style>
                .stats-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                    gap: 1.5rem;
                    margin-bottom: 2rem;
                }

                .stat-card {
                    background: var(--bg-card);
                    padding: 1.5rem;
                    border-radius: 12px;
                    border: 1px solid var(--border);
                }

                .stat-label {
                    font-size: 0.875rem;
                    color: var(--text-muted);
                    margin-bottom: 0.5rem;
                }

                .stat-value {
                    font-size: 2rem;
                    font-weight: 700;
                    color: var(--text-primary);
                }

                .stat-change {
                    font-size: 0.875rem;
                    margin-top: 0.5rem;
                }
            </style>
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
                            <a href="${pageContext.request.contextPath}/admin-dashboard">
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
                            <a href="${pageContext.request.contextPath}/manage-students">
                                <i data-lucide="users"></i>
                                Manage Student
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/admin-courses">
                                <i data-lucide="book-open"></i>
                                Manage Courses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/manage-enrollments">
                                <i data-lucide="clipboard-list"></i>
                                Manage Enrollments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/manage-results">
                                <i data-lucide="graduation-cap"></i>
                                Manage Results
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/admin-reports" class="active">
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
                            <h1>System Analytics & Reports</h1>
                            <p style="color: var(--text-muted);">Overview of system-wide statistics</p>
                        </div>
                    </header>

                    <c:if test="${not empty error}">
                        <div
                            style="background: rgba(239, 68, 68, 0.1); border: 1px solid #ef4444; color: #ef4444; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                            ${error}
                        </div>
                    </c:if>

                    <!-- Statistics Grid -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-label">Total Students</div>
                            <div class="stat-value">${totalStudents != null ? totalStudents : 0}</div>
                            <div class="stat-change" style="color: var(--text-muted);">Total registered students</div>
                        </div>

                        <div class="stat-card">
                            <div class="stat-label">Total Courses</div>
                            <div class="stat-value">${totalCourses != null ? totalCourses : 0}</div>
                            <div class="stat-change" style="color: var(--text-muted);">Available course offerings</div>
                        </div>

                        <div class="stat-card">
                            <div class="stat-label">Total Enrollments</div>
                            <div class="stat-value">${totalEnrollments != null ? totalEnrollments : 0}</div>
                            <div class="stat-change" style="color: var(--text-muted);">All enrollment records</div>
                        </div>

                        <div class="stat-card">
                            <div class="stat-label">Pending Approvals</div>
                            <div class="stat-value">${pendingEnrollments != null ? pendingEnrollments : 0}</div>
                            <div class="stat-change" style="color: #f59e0b;">Awaiting review</div>
                        </div>

                        <div class="stat-card">
                            <div class="stat-label">Approved Enrollments</div>
                            <div class="stat-value">${approvedEnrollments != null ? approvedEnrollments : 0}</div>
                            <div class="stat-change" style="color: #10b981;">Active enrollments</div>
                        </div>

                        <div class="stat-card">
                            <div class="stat-label">Enrollment Rate</div>
                            <div class="stat-value">
                                <c:choose>
                                    <c:when test="${totalStudents != null && totalStudents > 0}">
                                        ${(totalEnrollments * 100) / totalStudents}%
                                    </c:when>
                                    <c:otherwise>0%</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="stat-change" style="color: var(--text-muted);">Avg enrollments per student</div>
                        </div>
                    </div>

                    <!-- Summary Card -->
                    <div class="card">
                        <h3 style="margin-bottom: 1rem;">System Summary</h3>
                        <div style="color: var(--text-muted); line-height: 1.6;">
                            <p><strong>Students:</strong> ${totalStudents != null ? totalStudents : 0} students are
                                registered in the system.</p>
                            <p><strong>Courses:</strong> ${totalCourses != null ? totalCourses : 0} courses are
                                currently offered.</p>
                            <p><strong>Enrollments:</strong> ${totalEnrollments != null ? totalEnrollments : 0} total
                                enrollment records exist.</p>
                            <p><strong>Pending:</strong> ${pendingEnrollments != null ? pendingEnrollments : 0}
                                enrollment requests are pending admin approval.</p>
                            <p><strong>Approved:</strong> ${approvedEnrollments != null ? approvedEnrollments : 0}
                                enrollments have been approved and are active.</p>
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