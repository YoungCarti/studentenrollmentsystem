<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Students - Admin Portal</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
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
                        <a href="${pageContext.request.contextPath}/admin/calendar.jsp">
                            <i data-lucide="calendar"></i>
                            Manage Academic Calendar
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/students.jsp" class="active">
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
                        <h1>Student Management</h1>
                        <p style="color: var(--text-muted);">View and manage student records</p>
                    </div>
                    <div style="display: flex; gap: 1rem;">
                        <button class="btn" onclick="openModal()">
                            + Add New Student
                        </button>
                    </div>
                </header>

                <div class="card">
                    <!-- Search/Actions -->
                    <div style="display: flex; gap: 1rem; margin-bottom: 1.5rem;">
                        <input type="text" id="searchInput" class="form-control" placeholder="Search by name or ID..."
                            style="max-width: 300px;" onkeyup="filterTable()">
                        <select id="programFilter" class="form-control" style="max-width: 150px;"
                            onchange="filterTable()">
                            <option value="">All Programs</option>
                            <option value="BCS">BCS</option>
                            <option value="BSE">BSE</option>
                        </select>
                    </div>

                    <table id="studentsTable" style="width: 100%; border-collapse: collapse; text-align: left;">
                        <thead>
                            <tr style="border-bottom: 2px solid var(--border);">
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    ID</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Name</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Program</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Email</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Status</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">2023001</td>
                                <td style="padding: 1rem; font-weight: 500;">John Smith</td>
                                <td style="padding: 1rem;">BCS</td>
                                <td style="padding: 1rem; color: var(--text-muted);">john.smith@university.edu</td>
                                <td style="padding: 1rem;"><span
                                        style="background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600;">Active</span>
                                </td>
                                <td style="padding: 1rem;">
                                    <button onclick="openEditModal(this)"
                                        style="background: none; border: none; color: var(--primary); cursor: pointer; margin-right: 0.5rem; font-weight: 500;">Edit</button>
                                    <button onclick="openDeleteModal(this)"
                                        style="background: none; border: none; color: #ef4444; cursor: pointer; font-weight: 500;">Delete</button>
                                </td>
                            </tr>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">2023002</td>
                                <td style="padding: 1rem; font-weight: 500;">Sarah Johnson</td>
                                <td style="padding: 1rem;">BSE</td>
                                <td style="padding: 1rem; color: var(--text-muted);">sarah.j@university.edu</td>
                                <td style="padding: 1rem;"><span
                                        style="background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600;">Active</span>
                                </td>
                                <td style="padding: 1rem;">
                                    <button onclick="openEditModal(this)"
                                        style="background: none; border: none; color: var(--primary); cursor: pointer; margin-right: 0.5rem; font-weight: 500;">Edit</button>
                                    <button onclick="openDeleteModal(this)"
                                        style="background: none; border: none; color: #ef4444; cursor: pointer; font-weight: 500;">Delete</button>
                                </td>
                            </tr>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">2023003</td>
                                <td style="padding: 1rem; font-weight: 500;">Michael Brown</td>
                                <td style="padding: 1rem;">BCS</td>
                                <td style="padding: 1rem; color: var(--text-muted);">m.brown@university.edu</td>
                                <td style="padding: 1rem;"><span
                                        style="background: rgba(245, 158, 11, 0.1); color: #f59e0b; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600;">Probation</span>
                                </td>
                                <td style="padding: 1rem;">
                                    <button onclick="openEditModal(this)"
                                        style="background: none; border: none; color: var(--primary); cursor: pointer; margin-right: 0.5rem; font-weight: 500;">Edit</button>
                                    <button onclick="openDeleteModal(this)"
                                        style="background: none; border: none; color: #ef4444; cursor: pointer; font-weight: 500;">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Pagination -->

                </div>
            </main>
        </div>
        <!-- Add/Edit Student Modal -->
        <div id="addStudentModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 id="modalTitle">Add New Student</h2>
                    <span class="close" onclick="closeModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <form id="addStudentForm">
                        <input type="hidden" id="editRowId">
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Name</label>
                                <input type="text" id="newStudentName" required>
                            </div>
                            <div class="form-group">
                                <label>Student ID</label>
                                <input type="text" id="newStudentId" required>
                            </div>
                            <!-- ... existing fields ... -->
                            <div class="form-group">
                                <label>Program</label>
                                <select id="newStudentProgram" required>
                                    <option value="BCS">BCS</option>
                                    <option value="BSE">BSE</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" id="newStudentEmail" required>
                            </div>
                            <div class="form-group">
                                <label>Intake</label>
                                <input type="text" id="newStudentIntake" placeholder="e.g. Feb 2024">
                            </div>
                            <div class="form-group">
                                <label>Nationality</label>
                                <input type="text" id="newStudentNationality">
                            </div>
                            <div class="form-group">
                                <label>Country of Origin</label>
                                <input type="text" id="newStudentCountry">
                            </div>
                            <div class="form-group">
                                <label>IC Number</label>
                                <input type="text" id="newStudentIC">
                            </div>
                            <div class="form-group">
                                <label>D.O.B</label>
                                <input type="date" id="newStudentDOB">
                            </div>
                            <div class="form-group">
                                <label>Gender</label>
                                <select id="newStudentGender">
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Race</label>
                                <input type="text" id="newStudentRace">
                            </div>
                            <div class="form-group">
                                <label>Religion</label>
                                <input type="text" id="newStudentReligion">
                            </div>
                            <div class="form-group">
                                <label>Marital Status</label>
                                <select id="newStudentMarital">
                                    <option value="Single">Single</option>
                                    <option value="Married">Married</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Dean Name</label>
                                <input type="text" id="newStudentDeanName">
                            </div>
                            <div class="form-group">
                                <label>Dean's Email</label>
                                <input type="email" id="newStudentDeanEmail">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                            <button type="button" class="btn" id="modalConfirmBtn"
                                onclick="handleFormSubmit()">Confirm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div id="deleteStudentModal" class="modal">
            <div class="modal-content" style="max-width: 400px;">
                <div class="modal-header">
                    <h2>Delete Student</h2>
                    <span class="close" onclick="closeDeleteModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <p>Do you confirm want to delete this student?</p>
                    <input type="hidden" id="deleteRowId">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeDeleteModal()">Cancel</button>
                    <button type="button" class="btn" style="background-color: #ef4444; color: white;"
                        onclick="confirmDelete()">Delete</button>
                </div>
            </div>
        </div>

        <style>
            /* Modal Styles */
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
                margin: 5% auto;
                padding: 0;
                border: 1px solid var(--border);
                width: 60%;
                max-width: 800px;
                border-radius: 0.75rem;
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            }

            .modal-header {
                padding: 1.5rem;
                border-bottom: 1px solid var(--border);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .modal-header h2 {
                margin: 0;
                font-size: 1.25rem;
            }

            .close {
                color: var(--text-muted);
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }

            .close:hover,
            .close:focus {
                color: var(--text-main);
                text-decoration: none;
                cursor: pointer;
            }

            .modal-body {
                padding: 1.5rem;
            }

            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }

            .form-group label {
                font-size: 0.875rem;
                font-weight: 500;
                color: var(--text-muted);
            }

            .form-group input,
            .form-group select {
                padding: 0.5rem;
                border-radius: 0.375rem;
                border: 1px solid var(--border);
                background: var(--bg-main);
                color: var(--text-main);
            }

            .modal-footer {
                padding: 1.5rem;
                border-top: 1px solid var(--border);
                display: flex;
                justify-content: flex-end;
                gap: 1rem;
            }

            .btn-secondary {
                background: transparent;
                border: 1px solid var(--border);
                color: var(--text-muted);
            }
        </style>

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
                // Close modal if clicking outside
                const modal = document.getElementById('addStudentModal');
                if (e.target == modal) {
                    closeModal();
                }
            });

            function filterTable() {
                const searchInput = document.getElementById('searchInput');
                const filterValue = searchInput.value.toUpperCase();
                const programSelect = document.getElementById('programFilter');
                const programValue = programSelect.value.toUpperCase();

                const table = document.getElementById('studentsTable');
                const tr = table.getElementsByTagName('tr');

                // Loop through all table rows, and hide those who don't match the search query and program
                for (let i = 0; i < tr.length; i++) {
                    const tdId = tr[i].getElementsByTagName('td')[0]; // ID column
                    const tdName = tr[i].getElementsByTagName('td')[1]; // Name column
                    const tdProgram = tr[i].getElementsByTagName('td')[2]; // Program column

                    if (tdId && tdName && tdProgram) {
                        const idValue = tdId.textContent || tdId.innerText;
                        const nameValue = tdName.textContent || tdName.innerText;
                        const programText = tdProgram.textContent || tdProgram.innerText;

                        let matchesSearch = false;
                        let matchesProgram = false;

                        // Check Search (Name or ID)
                        if (idValue.toUpperCase().indexOf(filterValue) > -1 || nameValue.toUpperCase().indexOf(filterValue) > -1) {
                            matchesSearch = true;
                        }

                        // Check Program
                        if (programValue === "" || programText.toUpperCase() === programValue) {
                            matchesProgram = true;
                        }

                        if (matchesSearch && matchesProgram) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }

            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('openModal') === 'true') {
                    openModal();
                }
            }

            window.onpopstate = function (event) {
                if (event.state && event.state.modal) {
                    document.getElementById('addStudentModal').style.display = "block";
                } else {
                    document.getElementById('addStudentModal').style.display = "none";
                }
            };

            // Modal Functions
            function openModal() {
                // Reset/Setup Modal for ADD
                document.getElementById('modalTitle').innerText = "Add New Student";
                document.getElementById('addStudentForm').reset();
                document.getElementById('editRowId').value = ""; // clear edit ID

                document.getElementById('addStudentModal').style.display = "block";

                if (!window.location.href.includes('add-student.jsp')) {
                    history.pushState({ modal: true }, "Add New Student", "add-student.jsp");
                }
            }

            let currentRow = null; // Store row for editing/deleting

            function openEditModal(button) {
                currentRow = button.closest('tr');
                const cells = currentRow.getElementsByTagName('td');
                const id = cells[0].innerText;
                const name = cells[1].innerText;
                const program = cells[2].innerText;
                const email = cells[3].innerText;

                // Populate form
                document.getElementById('modalTitle').innerText = "Edit Student";
                document.getElementById('newStudentId').value = id;
                document.getElementById('newStudentName').value = name;
                document.getElementById('newStudentProgram').value = program;
                document.getElementById('newStudentEmail').value = email;
                document.getElementById('editRowId').value = "true"; // mark as edit mode

                document.getElementById('addStudentModal').style.display = "block";

                if (!window.location.href.includes('edit-student.jsp')) {
                    history.pushState({ modal: true }, "Edit Student", "edit-student.jsp");
                }
            }

            function closeModal() {
                document.getElementById('addStudentModal').style.display = "none";
                // Revert URL
                if (window.location.href.includes('add-student.jsp')) {
                    history.pushState({ modal: false }, "Students", "students.jsp");
                } else if (window.location.href.includes('edit-student.jsp')) {
                    history.pushState({ modal: false }, "Students", "students.jsp");
                }
            }

            function handleFormSubmit() {
                const isEdit = document.getElementById('editRowId').value === "true";

                // Get form values
                const name = document.getElementById('newStudentName').value;
                const id = document.getElementById('newStudentId').value;
                const program = document.getElementById('newStudentProgram').value;
                const email = document.getElementById('newStudentEmail').value;

                if (!name || !id || !program || !email) {
                    alert("Please fill in at least Name, ID, Program and Email.");
                    return;
                }

                if (isEdit && currentRow) {
                    // Update existing row
                    const cells = currentRow.getElementsByTagName('td');
                    cells[0].innerText = id;
                    cells[1].innerText = name;
                    cells[2].innerText = program;
                    cells[3].innerText = email;
                } else {
                    // Add new row
                    addStudentRow(id, name, program, email);
                }

                closeModal();
                // Reset form
                document.getElementById('addStudentForm').reset();
            }

            function addStudentRow(id, name, program, email) {
                const table = document.getElementById('studentsTable').getElementsByTagName('tbody')[0];
                const newRow = table.insertRow();
                newRow.style.borderBottom = "1px solid var(--border)";

                newRow.innerHTML = `
                    <td style="padding: 1rem;">${id}</td>
                    <td style="padding: 1rem; font-weight: 500;">${name}</td>
                    <td style="padding: 1rem;">${program}</td>
                    <td style="padding: 1rem; color: var(--text-muted);">${email}</td>
                    <td style="padding: 1rem;"><span style="background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600;">Active</span></td>
                    <td style="padding: 1rem;">
                        <button onclick="openEditModal(this)" style="background: none; border: none; color: var(--primary); cursor: pointer; margin-right: 0.5rem; font-weight: 500;">Edit</button>
                        <button onclick="openDeleteModal(this)" style="background: none; border: none; color: #ef4444; cursor: pointer; font-weight: 500;">Delete</button>
                    </td>
                `;
            }

            // Delete Functions
            function openDeleteModal(button) {
                currentRow = button.closest('tr');
                document.getElementById('deleteStudentModal').style.display = "block";
            }

            function closeDeleteModal() {
                document.getElementById('deleteStudentModal').style.display = "none";
                currentRow = null;
            }

            function confirmDelete() {
                if (currentRow) {
                    currentRow.remove();
                }
                closeDeleteModal();
            }
        </script>
    </body>

    </html>