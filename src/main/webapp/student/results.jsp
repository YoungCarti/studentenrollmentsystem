<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>My Results - SEMS</title>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
                <script src="https://unpkg.com/lucide@latest"></script>
            </head>

            <body>
                <div class="dashboard-container">
                    <!-- Sidebar -->
                    <aside class="sidebar">
                        <div class="brand">
                            <img src="${pageContext.request.contextPath}/images/logo.png" alt="SEMS Logo"
                                style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%;"> SEMS Portal
                        </div>

                        <ul class="nav-links">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/student-dashboard">
                                    <i data-lucide="layout-dashboard"></i>
                                    Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/student-timetable">
                                    <i data-lucide="calendar"></i>
                                    Timetable
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/enroll-course">
                                    <i data-lucide="book-open"></i>
                                    My Courses
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/student/results.jsp" class="active">
                                    <i data-lucide="graduation-cap"></i>
                                    My Results
                                </a>
                            </li>
                        </ul>

                        <div class="user-profile" onclick="toggleProfileMenu()">
                            <div class="avatar">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
                            <div>
                                <div style="font-weight: 500;">${sessionScope.user.username}</div>
                                <div style="font-size: 0.75rem; color: var(--text-muted);">Student</div>
                            </div>
                            <i data-lucide="chevron-up"
                                style="margin-left: auto; width: 16px; height: 16px; color: var(--text-muted);"></i>

                            <div class="profile-dropdown" id="profileDropdown">
                                <a href="${pageContext.request.contextPath}/student/profile.jsp" class="dropdown-item">
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
                                <h1>My Results</h1>
                                <p style="color: var(--text-muted);">View your examination results and academic
                                    performance</p>
                            </div>
                        </header>

                        <div class="empty-state"
                            style="text-align: center; padding: 4rem 2rem; background: var(--bg-card); border-radius: 12px;">
                            <i data-lucide="file-text"
                                style="width: 64px; height: 64px; color: var(--text-muted); margin-bottom: 1rem;"></i>
                            <h2 style="color: var(--text-primary); margin-bottom: 0.5rem;">No Results Available</h2>
                            <p style="color: var(--text-muted); max-width: 500px; margin: 0 auto;">
                                You don't have any completed courses with grades yet. Results will appear here once your
                                courses are completed and graded by instructors.
                            </p>
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