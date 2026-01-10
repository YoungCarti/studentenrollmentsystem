<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Students - Admin Portal</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
            <style>
                .modal-overlay {
                    display: none;
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(0, 0, 0, 0.5);
                    z-index: 1000;
                    justify-content: center;
                    align-items: center;
                }

                .modal-overlay.show {
                    display: flex;
                }

                .modal {
                    background: var(--card);
                    border-radius: 12px;
                    padding: 2rem;
                    width: 100%;
                    max-width: 500px;
                    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                }

                .modal h2 {
                    margin-bottom: 1.5rem;
                    color: var(--text);
                }

                .form-group {
                    margin-bottom: 1rem;
                }

                .form-group label {
                    display: block;
                    margin-bottom: 0.5rem;
                    font-weight: 500;
                    color: var(--text-muted);
                }

                .form-group input {
                    width: 100%;
                    padding: 0.75rem;
                    border: 1px solid var(--border);
                    border-radius: 8px;
                    background: var(--background);
                    color: var(--text);
                }

                .modal-actions {
                    display: flex;
                    gap: 1rem;
                    margin-top: 1.5rem;
                    justify-content: flex-end;
                }

                .btn {
                    padding: 0.75rem 1.5rem;
                    border-radius: 8px;
                    font-weight: 500;
                    cursor: pointer;
                    border: none;
                    transition: all 0.2s;
                }

                .btn-primary {
                    background: var(--primary);
                    color: white;
                }

                .btn-primary:hover {
                    opacity: 0.9;
                }

                .btn-secondary {
                    background: var(--border);
                    color: var(--text);
                }

                .btn-danger {
                    background: #ef4444;
                    color: white;
                }

                .btn-sm {
                    padding: 0.5rem 1rem;
                    font-size: 0.875rem;
                }

                .action-btns {
                    display: flex;
                    gap: 0.5rem;
                }

                .alert {
                    padding: 1rem;
                    border-radius: 8px;
                    margin-bottom: 1rem;
                }

                .alert-success {
                    background: #10b98120;
                    color: #10b981;
                    border: 1px solid #10b981;
                }

                .alert-error {
                    background: #ef444420;
                    color: #ef4444;
                    border: 1px solid #ef4444;
                }

                .header-actions {
                    display: flex;
                    gap: 1rem;
                    align-items: center;
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
                            <a href="${pageContext.request.contextPath}/manage-students" class="active">
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
                            <h1>Student Management</h1>
                            <p style="color: var(--text-muted);">View and manage all registered students</p>
                        </div>
                        <div class="header-actions">
                            <button class="btn btn-primary" onclick="openAddModal()">
                                <i data-lucide="plus" style="width: 16px; height: 16px;"></i> Add Student
                            </button>
                        </div>
                    </header>

                    <!-- Alerts -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-error">${error}</div>
                    </c:if>

                    <div class="card">
                        <c:choose>
                            <c:when test="${not empty students}">
                                <table style="width: 100%; border-collapse: collapse; text-align: left;">
                                    <thead>
                                        <tr style="border-bottom: 2px solid var(--border);">
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Student ID</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Name</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Email</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Phone</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Date of Birth</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Enrollment Date</th>
                                            <th
                                                style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                                Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="student" items="${students}">
                                            <tr style="border-bottom: 1px solid var(--border);">
                                                <td style="padding: 1rem;">${student.studentId}</td>
                                                <td style="padding: 1rem; font-weight: 500;">${student.firstName}
                                                    ${student.lastName}</td>
                                                <td style="padding: 1rem; color: var(--text-muted);">${student.email}
                                                </td>
                                                <td style="padding: 1rem;">${student.phone != null ? student.phone :
                                                    '-'}</td>
                                                <td style="padding: 1rem;">${student.dob}</td>
                                                <td style="padding: 1rem;">${student.enrollmentDate}</td>
                                                <td style="padding: 1rem;">
                                                    <div class="action-btns">
                                                        <button class="btn btn-secondary btn-sm"
                                                            onclick="openEditModal(${student.studentId}, '${student.firstName}', '${student.lastName}', '${student.email}', '${student.dob}', '${student.phone}', '${student.address}')">
                                                            Edit
                                                        </button>
                                                        <button class="btn btn-danger btn-sm"
                                                            onclick="openDeleteModal(${student.studentId}, '${student.firstName} ${student.lastName}')">
                                                            Delete
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 3rem; color: var(--text-muted);">
                                    <i data-lucide="users" style="width: 48px; height: 48px; margin-bottom: 1rem;"></i>
                                    <p>No students registered yet</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </main>
            </div>

            <!-- Add/Edit Modal -->
            <div class="modal-overlay" id="studentModal">
                <div class="modal">
                    <h2 id="modalTitle">Add Student</h2>
                    <form action="${pageContext.request.contextPath}/manage-students" method="post">
                        <input type="hidden" name="action" id="formAction" value="add">
                        <input type="hidden" name="studentId" id="studentId">

                        <div class="form-group">
                            <label>First Name</label>
                            <input type="text" name="firstName" id="firstName" required>
                        </div>
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" name="lastName" id="lastName" required>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" id="email" required>
                        </div>
                        <div class="form-group">
                            <label>Date of Birth</label>
                            <input type="date" name="dob" id="dob" required>
                        </div>
                        <div class="form-group">
                            <label>Phone</label>
                            <input type="text" name="phone" id="phone">
                        </div>
                        <div class="form-group">
                            <label>Address</label>
                            <input type="text" name="address" id="address">
                        </div>

                        <div class="modal-actions">
                            <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Delete Confirmation Modal -->
            <div class="modal-overlay" id="deleteModal">
                <div class="modal">
                    <h2>Confirm Delete</h2>
                    <p>Are you sure you want to delete <strong id="deleteStudentName"></strong>?</p>
                    <form action="${pageContext.request.contextPath}/manage-students" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="studentId" id="deleteStudentId">

                        <div class="modal-actions">
                            <button type="button" class="btn btn-secondary" onclick="closeDeleteModal()">Cancel</button>
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                lucide.createIcons();

                function toggleProfileMenu() {
                    document.getElementById('profileDropdown').classList.toggle('show');
                }

                window.addEventListener('click', function (e) {
                    const profile = document.querySelector('.user-profile');
                    if (!profile.contains(e.target)) {
                        document.getElementById('profileDropdown').classList.remove('show');
                    }
                });

                function openAddModal() {
                    document.getElementById('modalTitle').textContent = 'Add Student';
                    document.getElementById('formAction').value = 'add';
                    document.getElementById('studentId').value = '';
                    document.getElementById('firstName').value = '';
                    document.getElementById('lastName').value = '';
                    document.getElementById('email').value = '';
                    document.getElementById('dob').value = '';
                    document.getElementById('phone').value = '';
                    document.getElementById('address').value = '';
                    document.getElementById('studentModal').classList.add('show');
                }

                function openEditModal(id, firstName, lastName, email, dob, phone, address) {
                    document.getElementById('modalTitle').textContent = 'Edit Student';
                    document.getElementById('formAction').value = 'edit';
                    document.getElementById('studentId').value = id;
                    document.getElementById('firstName').value = firstName;
                    document.getElementById('lastName').value = lastName;
                    document.getElementById('email').value = email;
                    document.getElementById('dob').value = dob;
                    document.getElementById('phone').value = phone || '';
                    document.getElementById('address').value = address || '';
                    document.getElementById('studentModal').classList.add('show');
                }

                function closeModal() {
                    document.getElementById('studentModal').classList.remove('show');
                }

                function openDeleteModal(id, name) {
                    document.getElementById('deleteStudentId').value = id;
                    document.getElementById('deleteStudentName').textContent = name;
                    document.getElementById('deleteModal').classList.add('show');
                }

                function closeDeleteModal() {
                    document.getElementById('deleteModal').classList.remove('show');
                }
            </script>
        </body>

        </html>