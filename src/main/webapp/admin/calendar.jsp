<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Academic Calendar - SEMS Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
        <style>
            .calendar-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1rem;
            }

            .calendar-table th {
                text-align: left;
                padding: 1rem;
                color: var(--text-muted);
                font-size: 0.75rem;
                font-weight: 600;
                text-transform: uppercase;
                border-bottom: 1px solid var(--border);
            }

            .calendar-table td {
                padding: 1rem;
                border-bottom: 1px solid var(--border);
                color: var(--text-main);
                font-size: 0.875rem;
            }

            .calendar-table tr:hover {
                background-color: rgba(255, 255, 255, 0.02);
            }

            .section-header {
                background-color: rgba(255, 255, 255, 0.05);
                font-weight: 600;
                color: var(--text-muted);
                font-size: 0.75rem;
                letter-spacing: 0.05em;
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
                        <a href="${pageContext.request.contextPath}/admin-calendar" class="active">
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
                        <h1>Academic Calendar</h1>
                        <p style="color: var(--text-muted);">September 2025 Semester</p>
                    </div>
                </header>

                <div class="card">
                    <table class="calendar-table" id="calendarTable">
                        <thead>
                            <tr>
                                <th style="width: 50px;">No</th>
                                <th>Semester Activities</th>
                                <th style="width: 150px;">Start Date</th>
                                <th style="width: 150px;">End Date</th>
                                <th style="width: 80px;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="rowNum" value="1" />
                            <c:forEach var="event" items="${calendarEvents}">
                                <tr data-calendar-id="${event.calendarId}">
                                    <td>${rowNum}</td>
                                    <td>${event.activityName}</td>
                                    <td>${event.formattedStartDate}</td>
                                    <td>${event.formattedEndDate}</td>
                                    <td>
                                        <button class="btn-icon" onclick="openEditModal(this)">
                                            <i data-lucide="edit-2" style="width: 16px; height: 16px;"></i>
                                        </button>
                                    </td>
                                </tr>
                                <c:set var="rowNum" value="${rowNum + 1}" />
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>

        <!-- Edit Modal -->
        <div id="editModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2>Edit Activity</h2>
                    <span class="close" onclick="closeModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <form id="editForm" action="${pageContext.request.contextPath}/admin-calendar" method="post">
                        <input type="hidden" name="calendarId" id="editCalendarId">
                        <div class="form-group">
                            <label>Activity Name</label>
                            <input type="text" name="activityName" id="editActivity" required>
                        </div>
                        <div class="form-group">
                            <label>Start Date</label>
                            <input type="text" name="startDate" id="editStartDate" required placeholder="DD-MM-YYYY">
                        </div>
                        <div class="form-group">
                            <label>End Date</label>
                            <input type="text" name="endDate" id="editEndDate" required placeholder="DD-MM-YYYY">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                            <button type="submit" class="btn">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Reuse Redirect Page for Edit -->
        <!-- Ideally we should create a separate edit-calendar.jsp redirector, but for now we can just use the modal logic -->

        <style>
            .btn-icon {
                background: none;
                border: none;
                color: var(--text-muted);
                cursor: pointer;
                padding: 4px;
                border-radius: 4px;
                transition: all 0.2s;
            }

            .btn-icon:hover {
                background: rgba(255, 255, 255, 0.1);
                color: var(--text-main);
            }

            /* Modal Styles (Consistent) */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.5);
                backdrop-filter: blur(8px);
            }

            .modal-content {
                background-color: var(--bg-card);
                margin: 10% auto;
                padding: 1.5rem;
                border: 1px solid var(--border);
                width: 90%;
                max-width: 500px;
                border-radius: 0.5rem;
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
            }

            .close {
                color: var(--text-muted);
                font-size: 1.5rem;
                cursor: pointer;
            }

            .form-group {
                margin-bottom: 1rem;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                color: var(--text-muted);
                font-size: 0.875rem;
            }

            .form-group input {
                width: 100%;
                padding: 0.5rem;
                background: var(--bg-main);
                border: 1px solid var(--border);
                border-radius: 0.375rem;
                color: var(--text-main);
            }

            .modal-footer {
                margin-top: 1.5rem;
                display: flex;
                justify-content: flex-end;
                gap: 0.5rem;
            }

            .btn-secondary {
                background: transparent;
                border: 1px solid var(--border);
                color: var(--text-muted);
                padding: 0.5rem 1rem;
                border-radius: 0.25rem;
                cursor: pointer;
            }

            .btn {
                background: var(--primary);
                border: none;
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 0.25rem;
                cursor: pointer;
                font-weight: 500;
            }
        </style>

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

            let currentRow = null;

            function openEditModal(button) {
                currentRow = button.closest('tr');
                const calendarId = currentRow.getAttribute('data-calendar-id');
                const cells = currentRow.getElementsByTagName('td');

                // Set calendarId in hidden input
                document.getElementById('editCalendarId').value = calendarId || '';

                // Index 0 is No, 1 is Activity, 2 is Start, 3 is End
                document.getElementById('editActivity').value = cells[1].innerText;
                document.getElementById('editStartDate').value = cells[2].innerText;
                document.getElementById('editEndDate').value = cells[3].innerText;

                document.getElementById('editModal').style.display = 'block';
            }

            function closeModal() {
                document.getElementById('editModal').style.display = 'none';
            }
        </script>
    </body>

    </html>