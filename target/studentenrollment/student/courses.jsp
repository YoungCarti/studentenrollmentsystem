<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>My Courses - SEMS</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
            <script src="https://unpkg.com/lucide@latest"></script>
            <style>
                .course-list-item {
                    background: var(--bg-card);
                    border: 1px solid var(--border);
                    border-radius: 8px;
                    padding: 1.25rem;
                    margin-bottom: 1rem;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    transition: box-shadow 0.2s;
                }

                .course-list-item:hover {
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                }

                .course-main-info {
                    flex: 1;
                }

                .course-title-row {
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                    margin-bottom: 0.5rem;
                }

                .course-name {
                    font-size: 1rem;
                    font-weight: 600;
                    color: var(--text-primary);
                }

                .course-credits-badge {
                    background: rgba(99, 102, 241, 0.1);
                    color: var(--primary);
                    font-size: 0.75rem;
                    padding: 0.25rem 0.5rem;
                    border-radius: 4px;
                    font-weight: 500;
                }

                .course-details {
                    color: var(--text-muted);
                    font-size: 0.875rem;
                    line-height: 1.6;
                }

                .course-actions {
                    display: flex;
                    gap: 0.5rem;
                    align-items: center;
                }

                .status-badge {
                    padding: 0.375rem 0.75rem;
                    border-radius: 12px;
                    font-size: 0.75rem;
                    font-weight: 500;
                    margin-right: 0.5rem;
                }

                .status-pending {
                    background: rgba(245, 158, 11, 0.1);
                    color: #f59e0b;
                    border: 1px solid #f59e0b;
                }

                .status-approved {
                    background: rgba(16, 185, 129, 0.1);
                    color: #10b981;
                    border: 1px solid #10b981;
                }

                .status-rejected {
                    background: rgba(239, 68, 68, 0.1);
                    color: #ef4444;
                    border: 1px solid #ef4444;
                }

                .status-completed {
                    background: rgba(59, 130, 246, 0.1);
                    color: #3b82f6;
                    border: 1px solid #3b82f6;
                }

                .btn-drop {
                    background: transparent;
                    border: 1px solid #ef4444;
                    color: #ef4444;
                    padding: 0.5rem 1rem;
                    border-radius: 6px;
                    font-size: 0.875rem;
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .btn-drop:hover {
                    background: #ef4444;
                    color: white;
                }

                .btn-enroll {
                    background: var(--primary);
                    border: none;
                    color: white;
                    padding: 0.5rem 1rem;
                    border-radius: 6px;
                    font-size: 0.875rem;
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .btn-enroll:hover {
                    background: var(--primary-hover);
                }

                .section-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 1.5rem;
                }

                .section-title {
                    font-size: 1.25rem;
                    font-weight: 600;
                    color: var(--text-primary);
                }

                .filter-controls {
                    display: flex;
                    gap: 0.75rem;
                    align-items: center;
                }

                .search-input {
                    padding: 0.5rem 1rem;
                    border: 1px solid var(--border);
                    border-radius: 6px;
                    background: var(--bg-secondary);
                    color: var(--text-primary);
                    font-size: 0.875rem;
                    width: 250px;
                }

                .section-divider {
                    margin: 2.5rem 0;
                    border-top: 1px solid var(--border);
                }
            </style>
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
                            <a href="${pageContext.request.contextPath}/enroll-course" class="active">
                                <i data-lucide="book-open"></i>
                                My Courses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/student-results">
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
                            <h1>My Courses</h1>
                            <p style="color: var(--text-muted);">Manage your course enrollments</p>
                        </div>
                    </header>

                    <c:if test="${not empty error}">
                        <div class="alert alert-error"
                            style="background: rgba(239, 68, 68, 0.1); border: 1px solid #ef4444; color: #ef4444; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                            ${error}
                        </div>
                    </c:if>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success"
                            style="background: rgba(16, 185, 129, 0.1); border: 1px solid #10b981; color: #10b981; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                            ${success}
                        </div>
                    </c:if>

                    <!-- My Enrolled Courses Section -->
                    <div class="card" style="margin-bottom: 2rem;">
                        <div class="section-header">
                            <h2 class="section-title">My Enrolled Courses</h2>
                        </div>

                        <c:choose>
                            <c:when test="${not empty enrollments}">
                                <c:forEach var="enrollment" items="${enrollments}">
                                    <div class="course-list-item">
                                        <div class="course-main-info">
                                            <div class="course-title-row">
                                                <span class="course-name">${enrollment.courseCode}:
                                                    ${enrollment.courseName}</span>
                                                <span class="course-credits-badge">${enrollment.credits} Credits</span>
                                            </div>
                                            <div class="course-details">
                                                <c:if test="${not empty enrollment.instructor}">Instructor:
                                                    ${enrollment.instructor} • </c:if>
                                                <c:if test="${not empty enrollment.schedule}">${enrollment.schedule}
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="course-actions">
                                            <c:choose>
                                                <c:when test="${enrollment.status == 'PENDING'}">
                                                    <span class="status-badge status-pending">⏳ Pending Approval</span>
                                                </c:when>
                                                <c:when test="${enrollment.status == 'APPROVED'}">
                                                    <span class="status-badge status-approved">✓ Approved</span>
                                                    <form action="${pageContext.request.contextPath}/enroll-course"
                                                        method="post" style="display: inline;">
                                                        <input type="hidden" name="action" value="drop">
                                                        <input type="hidden" name="enrollmentId"
                                                            value="${enrollment.enrollmentId}">
                                                        <button type="submit" class="btn-drop"
                                                            onclick="return confirm('Are you sure you want to drop this course?')">Drop</button>
                                                    </form>
                                                </c:when>
                                                <c:when test="${enrollment.status == 'REJECTED'}">
                                                    <span class="status-badge status-rejected">✗ Rejected</span>
                                                    <c:if test="${not empty enrollment.rejectionReason}">
                                                        <span
                                                            style="color: var(--text-muted); font-size: 0.875rem;">(${enrollment.rejectionReason})</span>
                                                    </c:if>
                                                </c:when>
                                                <c:when test="${enrollment.status == 'COMPLETED'}">
                                                    <span class="status-badge status-completed">✓ Completed</span>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 3rem; color: var(--text-muted);">
                                    <i data-lucide="book-open"
                                        style="width: 48px; height: 48px; margin-bottom: 1rem;"></i>
                                    <p>You haven't enrolled in any courses yet. Browse available courses below to get
                                        started.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="section-divider"></div>

                    <!-- Available Courses Section -->
                    <div class="card">
                        <div class="section-header">
                            <h2 class="section-title">Available Courses for Enrollment</h2>
                            <div class="filter-controls">
                                <input type="text" class="search-input" placeholder="Search by name or code..."
                                    id="searchInput">
                            </div>
                        </div>

                        <c:choose>
                            <c:when test="${not empty courses}">
                                <c:forEach var="course" items="${courses}">
                                    <div class="course-list-item" data-course-name="${course.courseName}"
                                        data-course-code="${course.courseCode}">
                                        <div class="course-main-info">
                                            <div class="course-title-row">
                                                <span class="course-name">${course.courseCode}:
                                                    ${course.courseName}</span>
                                                <span class="course-credits-badge">${course.credits} Credits</span>
                                            </div>
                                            <div class="course-details">
                                                Program: ${course.department} •
                                                <c:if test="${not empty course.instructor}">Lecturer:
                                                    ${course.instructor} • </c:if>
                                                Max Capacity: ${course.capacity}
                                                <c:if test="${not empty course.schedule}"> • ${course.schedule}</c:if>
                                            </div>
                                        </div>
                                        <div class="course-actions">
                                            <form action="${pageContext.request.contextPath}/enroll-course"
                                                method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="enroll">
                                                <input type="hidden" name="courseId" value="${course.courseId}">
                                                <button type="submit" class="btn-enroll">Enroll</button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 3rem; color: var(--text-muted);">
                                    <i data-lucide="inbox" style="width: 48px; height: 48px; margin-bottom: 1rem;"></i>
                                    <p>No courses available at the moment.</p>
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

                // Search functionality
                const searchInput = document.getElementById('searchInput');
                if (searchInput) {
                    searchInput.addEventListener('input', function (e) {
                        const searchTerm = e.target.value.toLowerCase();
                        const courseItems = document.querySelectorAll('[data-course-name]');

                        courseItems.forEach(item => {
                            const courseName = item.getAttribute('data-course-name').toLowerCase();
                            const courseCode = item.getAttribute('data-course-code').toLowerCase();

                            if (courseName.includes(searchTerm) || courseCode.includes(searchTerm)) {
                                item.style.display = 'flex';
                            } else {
                                item.style.display = 'none';
                            }
                        });
                    });
                }
            </script>
        </body>

        </html>