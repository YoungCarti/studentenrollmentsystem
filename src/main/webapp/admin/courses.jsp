<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Courses - Admin Portal</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
            <style>
                .course-card {
                    margin-bottom: 1rem;
                    border: 1px solid var(--border);
                    padding: 1.25rem;
                    border-radius: 8px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .course-card:hover {
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                }

                .course-info h3 {
                    font-size: 1.1rem;
                    margin: 0 0 0.5rem 0;
                }

                .credits-badge {
                    background: rgba(99, 102, 241, 0.1);
                    color: var(--primary);
                    font-size: 0.75rem;
                    padding: 0.25rem 0.5rem;
                    border-radius: 4px;
                    margin-left: 0.5rem;
                }

                .course-details {
                    color: var(--text-muted);
                    font-size: 0.875rem;
                    margin: 0;
                }

                .modal {
                    display: none;
                    position: fixed;
                    z-index: 1000;
                    left: 0;
                    top: 0;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0, 0, 0, 0.5);
                }

                .modal-content {
                    background-color: var(--bg-card);
                    margin: 5% auto;
                    padding: 0;
                    border-radius: 12px;
                    width: 90%;
                    max-width: 600px;
                }

                .modal-header {
                    padding: 1.5rem;
                    border-bottom: 1px solid var(--border);
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .modal-body {
                    padding: 1.5rem;
                }

                .close {
                    color: var(--text-muted);
                    font-size: 28px;
                    font-weight: bold;
                    cursor: pointer;
                }

                .close:hover {
                    color: var(--text-primary);
                }

                .form-group {
                    margin-bottom: 1rem;
                }

                .form-group label {
                    display: block;
                    margin-bottom: 0.5rem;
                    font-weight: 500;
                    color: var(--text-primary);
                }

                .form-group input,
                .form-group select {
                    width: 100%;
                    padding: 0.75rem;
                    border: 1px solid var(--border);
                    border-radius: 6px;
                    background: var(--bg-secondary);
                    color: var(--text-primary);
                }

                .form-grid {
                    display: grid;
                    grid-template-columns: repeat(2, 1fr);
                    gap: 1rem;
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
                            <a href="${pageContext.request.contextPath}/admin-courses" class="active">
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

                <!-- Main Content -->
                <main class="main-content">
                    <header class="header">
                        <div>
                            <h1>Course Management</h1>
                            <p style="color: var(--text-muted);">Add and modify course offerings</p>
                        </div>
                        <div>
                            <button class="btn" onclick="openModal()">
                                + Add New Course
                            </button>
                        </div>
                    </header>

                    <c:if test="${not empty param.success}">
                        <div
                            style="background: rgba(16, 185, 129, 0.1); border: 1px solid #10b981; color: #10b981; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                            ${param.success}
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div
                            style="background: rgba(239, 68, 68, 0.1); border: 1px solid #ef4444; color: #ef4444; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                            ${error}
                        </div>
                    </c:if>

                    <div class="card">
                        <c:choose>
                            <c:when test="${not empty courses}">
                                <c:forEach var="course" items="${courses}">
                                    <div class="course-card">
                                        <div class="course-info">
                                            <h3>
                                                ${course.courseCode}: ${course.courseName}
                                                <span class="credits-badge">${course.credits} Credits</span>
                                            </h3>
                                            <p class="course-details">
                                                Department: ${course.department} •
                                                <c:if test="${not empty course.instructor}">Instructor:
                                                    ${course.instructor} • </c:if>
                                                <c:if test="${not empty course.schedule}">Schedule: ${course.schedule} •
                                                </c:if>
                                                Capacity: ${course.capacity}
                                            </p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 3rem; color: var(--text-muted);">
                                    <i data-lucide="book-open"
                                        style="width: 48px; height: 48px; margin-bottom: 1rem;"></i>
                                    <p>No courses available. Click "+ Add New Course" to create one.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </main>
            </div>

            <!-- Add Course Modal -->
            <div id="addCourseModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Add New Course</h2>
                        <span class="close" onclick="closeModal()">&times;</span>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/admin-courses" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="form-grid">
                                <div class="form-group">
                                    <label>Course Code</label>
                                    <input type="text" name="courseCode" required placeholder="e.g. CS301">
                                </div>
                                <div class="form-group">
                                    <label>Course Name</label>
                                    <input type="text" name="courseName" required placeholder="e.g. Database Systems">
                                </div>
                                <div class="form-group">
                                    <label>Credits</label>
                                    <input type="number" name="credits" required min="1" max="4" value="3">
                                </div>
                                <div class="form-group">
                                    <label>Department</label>
                                    <input type="text" name="department" required placeholder="e.g. Computer Science">
                                </div>
                                <div class="form-group">
                                    <label>Instructor</label>
                                    <input type="text" name="instructor" required placeholder="e.g. Dr. John Smith">
                                </div>
                                <div class="form-group">
                                    <label>Schedule</label>
                                    <input type="text" name="schedule" placeholder="e.g. Mon/Wed 2-4 PM">
                                </div>
                                <div class="form-group">
                                    <label>Max Capacity</label>
                                    <input type="number" name="capacity" required min="1" value="30">
                                </div>
                            </div>
                            <div style="margin-top: 1.5rem; display: flex; gap: 1rem; justify-content: flex-end;">
                                <button type="button" class="btn" onclick="closeModal()"
                                    style="background: var(--bg-secondary);">Cancel</button>
                                <button type="submit" class="btn">Add Course</button>
                            </div>
                        </form>
                    </div>
                </div>
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

                function openModal() {
                    document.getElementById('addCourseModal').style.display = 'block';
                }

                function closeModal() {
                    document.getElementById('addCourseModal').style.display = 'none';
                }

                // Close modal when clicking outside
                window.onclick = function (event) {
                    const modal = document.getElementById('addCourseModal');
                    if (event.target == modal) {
                        closeModal();
                    }
                }
            </script>
        </body>

        </html>