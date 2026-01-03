<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile - SEMS</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    </head>

    <body>
        <div class="dashboard-container">
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="brand">
                    <span>🎓</span> SEMS Portal
                </div>

                <ul class="nav-links">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/dashboard.jsp">
                            <i data-lucide="layout-dashboard"></i>
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/courses.jsp">
                            <i data-lucide="book-open"></i>
                            My Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/results.jsp">
                            <i data-lucide="graduation-cap"></i>
                            My Results
                        </a>
                    </li>
                </ul>

                <div class="user-profile" onclick="toggleProfileMenu()">
                    <div class="avatar">JS</div>
                    <div>
                        <div style="font-weight: 500;">John Smith</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">Student</div>
                    </div>
                    <i data-lucide="chevron-up"
                        style="margin-left: auto; width: 16px; height: 16px; color: var(--text-muted);"></i>

                    <div class="profile-dropdown" id="profileDropdown">
                        <a href="${pageContext.request.contextPath}/student/profile.jsp" class="dropdown-item">
                            <i data-lucide="user" style="width: 16px; height: 16px;"></i> Profile
                        </a>
                        <div class="dropdown-divider"></div>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="dropdown-item text-red">
                            <i data-lucide="log-out" style="width: 16px; height: 16px;"></i> Logout
                        </a>
                    </div>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <div style="max-width: 600px;">
                    <header class="header">
                        <div>
                            <h1>My Profile</h1>
                            <p style="color: var(--text-muted);">Manage your account settings</p>
                        </div>
                    </header>

                    <div class="card mb-4">
                        <h2 style="font-size: 1.25rem; margin-bottom: 1.5rem;">Personal Information</h2>
                        <form>
                            <div class="form-group">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" value="John Smith" readonly>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Email Address</label>
                                <input type="email" class="form-control" value="john.smith@university.edu" readonly>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Student ID</label>
                                <input type="text" class="form-control" value="2023001" readonly>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" value="2000-05-15" readonly>
                            </div>
                        </form>
                    </div>

                    <div class="card">
                        <h2 style="font-size: 1.25rem; margin-bottom: 1.5rem;">Security</h2>
                        <button class="btn" style="background: transparent; border: 1px solid var(--border);">Change
                            Password</button>
                    </div>
                </div>
            </main>
        </div>
        <script src="https://unpkg.com/lucide@latest"></script>
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