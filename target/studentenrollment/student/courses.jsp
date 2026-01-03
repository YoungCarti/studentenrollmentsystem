<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Courses - SEMS</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
        <script src="https://unpkg.com/lucide@latest"></script>
    </head>

    <body>
        <div class="dashboard-container">
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="brand">
                    <i data-lucide="graduation-cap"></i> SEMS Portal
                </div>

                <ul class="nav-links">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/dashboard.jsp">
                            <i data-lucide="layout-dashboard"></i>
                            Available Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/courses.jsp" class="active">
                            <i data-lucide="book-open"></i>
                            My Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/profile.jsp">
                            <i data-lucide="user"></i>
                            Profile
                        </a>
                    </li>
                </ul>

                <div class="user-profile">
                    <div class="avatar">JS</div>
                    <div>
                        <div style="font-weight: 500;">John Smith</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">Student</div>
                    </div>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <header class="header">
                    <div>
                        <h1>Course Registration</h1>
                        <p style="color: var(--text-muted);">Browse and enroll in available courses</p>
                    </div>
                    <div class="actions">
                        <!-- Search Bar -->
                        <input type="text" placeholder="Search courses..." class="form-control"
                            style="width: 250px; background: var(--bg-card); border: 1px solid var(--border); padding: 0.5rem 1rem; border-radius: var(--radius); color: var(--text-main);">
                    </div>
                </header>

                <h2 class="mb-4">Available Courses</h2>
                <div class="course-list">
                    <!-- Mock Course 1 -->
                    <div class="course-card">
                        <div>
                            <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                <h3 style="font-size: 1.1rem; margin: 0;">Web Development</h3>
                                <span
                                    style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem; font-weight: 500;">3
                                    Credits</span>
                            </div>
                            <p style="color: var(--text-muted); font-size: 0.875rem; margin-top: 0.25rem;">CS205 • Prof.
                                Johnson • Mon/Wed 10:00 AM</p>
                        </div>
                        <div>
                            <button class="btn" style="padding: 0.5rem 1rem; font-size: 0.875rem;">Enroll</button>
                        </div>
                    </div>

                    <!-- Mock Course 2 -->
                    <div class="course-card">
                        <div>
                            <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                <h3 style="font-size: 1.1rem; margin: 0;">Data Structures</h3>
                                <span
                                    style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem; font-weight: 500;">4
                                    Credits</span>
                            </div>
                            <p style="color: var(--text-muted); font-size: 0.875rem; margin-top: 0.25rem;">CS201 • Prof.
                                Davis • Tue/Thu 1:00 PM</p>
                        </div>
                        <div>
                            <button class="btn" style="padding: 0.5rem 1rem; font-size: 0.875rem;">Enroll</button>
                        </div>
                    </div>

                    <!-- Mock Enrolled Course -->
                    <div class="course-card" style="border-left: 4px solid #10b981;">
                        <div>
                            <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                <h3 style="font-size: 1.1rem; margin: 0;">Database Systems</h3>
                                <span
                                    style="background: rgba(16, 185, 129, 0.1); color: #10b981; font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem; font-weight: 500;">Enrolled</span>
                            </div>
                            <p style="color: var(--text-muted); font-size: 0.875rem; margin-top: 0.25rem;">CS302 • Prof.
                                Williams • Fri 9:00 AM</p>
                        </div>
                        <div>
                            <button class="btn" disabled
                                style="background: transparent; color: #10b981; border: 1px solid #10b981; cursor: default; opacity: 0.7; padding: 0.5rem 1rem; font-size: 0.875rem;">Selected</button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script>
            lucide.createIcons();
        </script>
    </body>

    </html>