<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Enrollments - Admin Portal</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
            <style>
                .filter-tabs {
                    display: flex;
                    gap: 0.5rem;
                    margin-bottom: 1.5rem;
                    border-bottom: 1px solid var(--border);
                }

                .filter-tab {
                    padding: 0.75rem 1.5rem;
                    border: none;
                    background: none;
                    color: var(--text-muted);
                    cursor: pointer;
                    border-bottom: 2px solid transparent;
                    transition: all 0.2s;
                }

                .filter-tab.active {
                    color: var(--primary);
                    border-bottom-color: var(--primary);
                }

                .status-badge {
                    padding: 0.375rem 0.75rem;
                    border-radius: 12px;
                    font-size: 0.75rem;
                    font-weight: 500;
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

                .btn-approve {
                    background: #10b981;
                    color: white;
                    border: none;
                    padding: 0.5rem 1rem;
                    border-radius: 6px;
                    cursor: pointer;
                    font-size: 0.875rem;
                    margin-right: 0.5rem;
                }

                .btn-approve:hover {
                    background: #059669;
                }

                .btn-reject {
                    background: transparent;
                    color: #ef4444;
                    border: 1px solid #ef4444;
                    padding: 0.5rem 1rem;
                    border-radius: 6px;
                    cursor: pointer;
                    font-size: 0.875rem;
                }

                .btn-reject:hover {
                    background: #ef4444;
                    color: white;
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
                    margin: 15% auto;
                    padding: 2rem;
                    border-radius: 12px;
                    width: 90%;
                    max-width: 500px;
                }

                .modal-header {
                    margin-bottom: 1rem;
                }

                .modal-header h2 {
                    margin: 0;
                }

                .form-group {
                    margin-bottom: 1rem;
                }

                .form-group label {
                    display: block;
                    margin-bottom: 0.5rem;
                    font-weight: 500;
                }

                .form-group textarea {
                    width: 100%;
                    padding: 0.75rem;
                    border: 1px solid var(--border);
                    border-radius: 6px;
                    background: var(--bg-secondary);
                    color: var(--text-primary);
                    resize: vertical;
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
                            <a href="${pageContext.request.contextPath}/manage-enrollments" class="active">
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
                            <h1>Enrollment Management</h1>
                            <p style="color: var(--text-muted);">Approve or reject student enrollment requests</p>
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

                    <!-- Filter Tabs -->
                    <div class="filter-tabs">
                        <a href="${pageContext.request.contextPath}/manage-enrollments"
                            class="filter-tab ${currentFilter == 'ALL' ? 'active' : ''}">All</a>
                        <a href="${pageContext.request.contextPath}/manage-enrollments?status=PENDING"
                            class="filter-tab ${currentFilter == 'PENDING' ? 'active' : ''}">Pending</a>
                        <a href="${pageContext.request.contextPath}/manage-enrollments?status=APPROVED"
                            class="filter-tab ${currentFilter == 'APPROVED' ? 'active' : ''}">Approved</a>
                        <a href="${pageContext.request.contextPath}/manage-enrollments?status=REJECTED"
                            class="filter-tab ${currentFilter == 'REJECTED' ? 'active' : ''}">Rejected</a>
                    </div>

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
                                                Status</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Enrollment Date</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="enrollment" items="${enrollments}">
                                            <tr style="border-bottom: 1px solid var(--border);">
                                                <td style="padding: 1rem; font-weight: 500;">
                                                    ${enrollment.studentName}
                                                    <div
                                                        style="font-size: 0.875rem; color: var(--text-muted); font-weight: normal;">
                                                        ID: ${enrollment.studentId}
                                                    </div>
                                                </td>
                                                <td style="padding: 1rem;">
                                                    ${enrollment.courseCode}: ${enrollment.courseName}
                                                    <div style="font-size: 0.875rem; color: var(--text-muted);">
                                                        ${enrollment.credits} Credits
                                                    </div>
                                                </td>
                                                <td style="padding: 1rem;">
                                                    <c:choose>
                                                        <c:when test="${enrollment.status == 'PENDING'}">
                                                            <span class="status-badge status-pending">⏳ Pending</span>
                                                        </c:when>
                                                        <c:when test="${enrollment.status == 'APPROVED'}">
                                                            <span class="status-badge status-approved">✓ Approved</span>
                                                        </c:when>
                                                        <c:when test="${enrollment.status == 'REJECTED'}">
                                                            <span class="status-badge status-rejected">✗ Rejected</span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td style="padding: 1rem; color: var(--text-muted);">
                                                    ${enrollment.enrollmentDate}
                                                </td>
                                                <td style="padding: 1rem;">
                                                    <c:choose>
                                                        <c:when test="${enrollment.status == 'PENDING'}">
                                                            <form
                                                                action="${pageContext.request.contextPath}/manage-enrollments"
                                                                method="post" style="display: inline;">
                                                                <input type="hidden" name="action" value="approve">
                                                                <input type="hidden" name="enrollmentId"
                                                                    value="${enrollment.enrollmentId}">
                                                                <button type="submit"
                                                                    class="btn-approve">Approve</button>
                                                            </form>
                                                            <button class="btn-reject"
                                                                onclick="openRejectModal(${enrollment.enrollmentId})">Reject</button>
                                                        </c:when>
                                                        <c:when
                                                            test="${enrollment.status == 'REJECTED' && not empty enrollment.rejectionReason}">
                                                            <span
                                                                style="font-size: 0.875rem; color: var(--text-muted);">
                                                                Reason: ${enrollment.rejectionReason}
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                style="font-size: 0.875rem; color: var(--text-muted);">-</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 3rem; color: var(--text-muted);">
                                    <i data-lucide="clipboard-list"
                                        style="width: 48px; height: 48px; margin-bottom: 1rem;"></i>
                                    <p>No enrollment requests found</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </main>
            </div>

            <!-- Reject Modal -->
            <div id="rejectModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Reject Enrollment</h2>
                    </div>
                    <form action="${pageContext.request.contextPath}/manage-enrollments" method="post">
                        <input type="hidden" name="action" value="reject">
                        <input type="hidden" name="enrollmentId" id="rejectEnrollmentId">
                        <div class="form-group">
                            <label>Rejection Reason</label>
                            <textarea name="reason" rows="4" required
                                placeholder="Enter reason for rejection..."></textarea>
                        </div>
                        <div style="display: flex; gap: 1rem; justify-content: flex-end;">
                            <button type="button" class="btn" onclick="closeRejectModal()"
                                style="background: var(--bg-secondary);">Cancel</button>
                            <button type="submit" class="btn-reject"
                                style="border: none; background: #ef4444; color: white;">Reject</button>
                        </div>
                    </form>
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

                function openRejectModal(enrollmentId) {
                    document.getElementById('rejectEnrollmentId').value = enrollmentId;
                    document.getElementById('rejectModal').style.display = 'block';
                }

                function closeRejectModal() {
                    document.getElementById('rejectModal').style.display = 'none';
                }

                // Close modal when clicking outside
                window.onclick = function (event) {
                    const modal = document.getElementById('rejectModal');
                    if (event.target == modal) {
                        closeRejectModal();
                    }
                }
            </script>
        </body>

        </html>