<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Results - Admin Portal</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
            <style>
                .grade-form {
                    display: inline-flex;
                    gap: 0.5rem;
                    align-items: center;
                }

                .grade-select {
                    padding: 0.5rem;
                    border: 1px solid var(--border);
                    border-radius: 6px;
                    background: var(--bg-secondary);
                    color: var(--text-primary);
                }

                .btn-assign {
                    background: var(--primary);
                    color: white;
                    border: none;
                    padding: 0.5rem 1rem;
                    border-radius: 6px;
                    cursor: pointer;
                    font-size: 0.875rem;
                }

                .btn-assign:hover {
                    opacity: 0.9;
                }

                .grade-display {
                    font-weight: 600;
                    font-size: 1.1rem;
                    color: var(--primary);
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
                            <a href="${pageContext.request.contextPath}/manage-results" class="active">
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

                <!--Main Content -->
                <main class="main-content">
                    <header class="header">
                        <div>
                            <h1>Results Management</h1>
                            <p style="color: var(--text-muted);">Assign grades to student enrollments</p>
                        </div>
                    </header>

                    <c:if test="${not empty param.success}">
                        <div
                            style="background: rgba(16, 185, 129, 0.1); border: 1px solid #10b981; color: #10b981; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                            ${param.success}
                        </div>
                    </c:if>

                    <c:if test="${not empty param.error}">
                        <div
                            style="background: rgba(239, 68, 68, 0.1); border: 1px solid #ef4444; color: #ef4444; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                            ${param.error}
                        </div>
                    </c:if>

                    <div class="card">
                        <c:choose>
                            <c:when test="${not empty enrollments}">
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
                                                Current Grade</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Assign Grade</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="enrollment" items="${enrollments}">
                                            <tr style="border-bottom: 1px solid var(--border);">
                                                <td style="padding: 1rem;">
                                                    <div style="font-weight: 500;">${enrollment.studentName}</div>
                                                    <div style="font-size: 0.875rem; color: var(--text-muted);">ID:
                                                        ${enrollment.studentId}</div>
                                                </td>
                                                <td style="padding: 1rem;">
                                                    ${enrollment.courseCode}: ${enrollment.courseName}
                                                    <div style="font-size: 0.875rem; color: var(--text-muted);">
                                                        ${enrollment.credits} Credits</div>
                                                </td>
                                                <td style="padding: 1rem;">
                                                    <c:choose>
                                                        <c:when test="${not empty enrollment.grade}">
                                                            <span class="grade-display">${enrollment.grade}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span style="color: var(--text-muted);">Not graded</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td style="padding: 1rem;">
                                                    <form action="${pageContext.request.contextPath}/manage-results"
                                                        method="post" class="grade-form">
                                                        <input type="hidden" name="enrollmentId"
                                                            value="${enrollment.enrollmentId}">
                                                        <select name="grade" class="grade-select" required>
                                                            <option value="">Select Grade</option>
                                                            <option value="A">A (4.0)</option>
                                                            <option value="A-">A- (3.7)</option>
                                                            <option value="B+">B+ (3.3)</option>
                                                            <option value="B">B (3.0)</option>
                                                            <option value="B-">B- (2.7)</option>
                                                            <option value="C+">C+ (2.3)</option>
                                                            <option value="C">C (2.0)</option>
                                                            <option value="C-">C- (1.7)</option>
                                                            <option value="D">D (1.0)</option>
                                                            <option value="F">F (0.0)</option>
                                                        </select>
                                                        <button type="submit" class="btn-assign">Assign</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 3rem; color: var(--text-muted);">
                                    <i data-lucide="graduation-cap"
                                        style="width: 48px; height: 48px; margin-bottom: 1rem;"></i>
                                    <p>No approved enrollments to grade</p>
                                    <p style="font-size: 0.875rem;">Students need to be enrolled and approved before
                                        grades can be assigned.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
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