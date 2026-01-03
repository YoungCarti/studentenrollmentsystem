<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                        <a href="${pageContext.request.contextPath}/admin/calendar.jsp" class="active">
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
                            <!-- Activities -->
                            <tr>
                                <td>1</td>
                                <td>Subject registration</td>
                                <td>15-08-2025</td>
                                <td>29-09-2025</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Registration of new student</td>
                                <td>18-09-2025</td>
                                <td>19-09-2025</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Orientation for new student</td>
                                <td>18-09-2025</td>
                                <td>19-09-2025</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Lecture session</td>
                                <td>22-09-2025</td>
                                <td>02-11-2025</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>Add Drop session</td>
                                <td>29-09-2025</td>
                                <td>12-10-2025</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td>Add Drop session with penalty</td>
                                <td>13-10-2025</td>
                                <td>28-10-2025</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>7</td>
                                <td>Mid semester break</td>
                                <td>03-11-2025</td>
                                <td>09-11-2025</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>8</td>
                                <td class="text-primary" style="color: #6366f1;">Lecture session</td>
                                <td>10-11-2025</td>
                                <td>04-01-2026</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>9</td>
                                <td class="text-primary" style="color: #6366f1;">Lecturer Evaluation</td>
                                <td>02-12-2025</td>
                                <td>11-01-2026</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>10</td>
                                <td>Study week</td>
                                <td>05-01-2026</td>
                                <td>11-01-2026</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>11</td>
                                <td>Final exam</td>
                                <td>12-01-2026</td>
                                <td>23-01-2026</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>12</td>
                                <td>Semester break</td>
                                <td>24-01-2026</td>
                                <td>01-02-2026</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>

                            <!-- Breaks -->
                            <tr>
                                <td colspan="5" class="section-header">FESTIVE BREAKS</td>
                            </tr>
                            <tr>
                                <td>15</td>
                                <td>Malaysia Day</td>
                                <td>16-09-2025</td>
                                <td>16-09-2025</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>16</td>
                                <td>DEEPAVALI</td>
                                <td>20-10-2025</td>
                                <td>20-10-2025</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
                            <tr>
                                <td>17</td>
                                <td>Sultan of Selangor's Birthday</td>
                                <td>11-12-2025</td>
                                <td>11-12-2025</td>
                                <td><button class="btn-icon" onclick="openEditModal(this)"><i data-lucide="edit-2"
                                            style="width: 16px; height: 16px;"></i></button></td>
                            </tr>
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
                    <form id="editForm">
                        <div class="form-group">
                            <label>Activity Name</label>
                            <input type="text" id="editActivity" required>
                        </div>
                        <div class="form-group">
                            <label>Start Date</label>
                            <input type="text" id="editStartDate" required placeholder="DD-MM-YYYY">
                        </div>
                        <div class="form-group">
                            <label>End Date</label>
                            <input type="text" id="editEndDate" required placeholder="DD-MM-YYYY">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                            <button type="button" class="btn" onclick="saveChanges()">Save Changes</button>
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
                const cells = currentRow.getElementsByTagName('td');
                // Index 0 is No, 1 is Activity, 2 is Start, 3 is End
                document.getElementById('editActivity').value = cells[1].innerText;
                document.getElementById('editStartDate').value = cells[2].innerText;
                document.getElementById('editEndDate').value = cells[3].innerText;

                document.getElementById('editModal').style.display = 'block';
            }

            function closeModal() {
                document.getElementById('editModal').style.display = 'none';
            }

            function saveChanges() {
                if (currentRow) {
                    const cells = currentRow.getElementsByTagName('td');
                    cells[1].innerText = document.getElementById('editActivity').value;
                    cells[2].innerText = document.getElementById('editStartDate').value;
                    cells[3].innerText = document.getElementById('editEndDate').value;
                }
                closeModal();
                // In real app, send AJAX request to update DB
            }
        </script>
    </body>

    </html>