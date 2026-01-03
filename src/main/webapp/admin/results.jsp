<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Results - Admin Portal</title>
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
                        <a href="${pageContext.request.contextPath}/admin/results.jsp" class="active">
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
                        <h1>Result Management</h1>
                        <p style="color: var(--text-muted);">Manage student examination results</p>
                    </div>
                    <div style="display: flex; gap: 1rem;">
                        <button class="btn" onclick="openModal()">
                            + Add New Result
                        </button>
                    </div>
                </header>

                <div class="card">
                    <!-- Search/Actions -->
                    <div style="display: flex; gap: 1rem; margin-bottom: 1.5rem;">
                        <input type="text" id="searchInput" class="form-control"
                            placeholder="Search by student or course..." style="max-width: 300px;"
                            onkeyup="filterResults()">
                    </div>

                    <table id="resultsTable" style="width: 100%; border-collapse: collapse; text-align: left;">
                        <thead>
                            <tr style="border-bottom: 2px solid var(--border);">
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Student ID</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Student Name</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Course Code</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Grade</th>
                                <th
                                    style="padding: 1rem; color: var(--text-muted); font-weight: 600; font-size: 0.875rem;">
                                    Point</th>
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
                                <td style="padding: 1rem;">CS205</td>
                                <td style="padding: 1rem; font-weight: 600;">A</td>
                                <td style="padding: 1rem;">4.00</td>
                                <td style="padding: 1rem;"><span
                                        style="background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600;">PASS</span>
                                </td>
                                <td style="padding: 1rem;">
                                    <button onclick="openEditModal(this)"
                                        style="background: none; border: none; color: var(--primary); cursor: pointer; margin-right: 0.5rem; font-weight: 500;">Edit</button>
                                    <button onclick="openDeleteModal(this)"
                                        style="background: none; border: none; color: #ef4444; cursor: pointer; font-weight: 500;">Delete</button>
                                </td>
                            </tr>
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 1rem;">2023001</td>
                                <td style="padding: 1rem; font-weight: 500;">John Smith</td>
                                <td style="padding: 1rem;">CS201</td>
                                <td style="padding: 1rem; font-weight: 600;">B+</td>
                                <td style="padding: 1rem;">3.33</td>
                                <td style="padding: 1rem;"><span
                                        style="background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600;">PASS</span>
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
                                <td style="padding: 1rem;">CS205</td>
                                <td style="padding: 1rem; font-weight: 600;">A-</td>
                                <td style="padding: 1rem;">3.67</td>
                                <td style="padding: 1rem;"><span
                                        style="background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600;">PASS</span>
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
                </div>
            </main>
        </div>

        <!-- Add/Edit Result Modal -->
        <div id="addResultModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 id="modalTitle">Add New Result</h2>
                    <span class="close" onclick="closeModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <form id="addResultForm">
                        <input type="hidden" id="editRowIndex">
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Student ID</label>
                                <input type="text" id="resultStudentId" required placeholder="e.g. 2023001">
                            </div>
                            <div class="form-group">
                                <label>Student Name</label>
                                <input type="text" id="resultStudentName" required>
                            </div>
                            <div class="form-group">
                                <label>Course Code</label>
                                <input type="text" id="resultCourseCode" required placeholder="e.g. CS205">
                            </div>
                            <div class="form-group">
                                <label>Grade</label>
                                <select id="resultGrade" required onchange="calculatePoint()">
                                    <option value="A">A</option>
                                    <option value="A-">A-</option>
                                    <option value="B+">B+</option>
                                    <option value="B">B</option>
                                    <option value="B-">B-</option>
                                    <option value="C+">C+</option>
                                    <option value="C">C</option>
                                    <option value="F">F</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Point</label>
                                <input type="number" id="resultPoint" step="0.01" readonly
                                    style="background: var(--bg-card);">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                            <button type="button" class="btn" onclick="handleFormSubmit()">Confirm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div id="deleteResultModal" class="modal">
            <div class="modal-content" style="max-width: 400px;">
                <div class="modal-header">
                    <h2>Delete Result</h2>
                    <span class="close" onclick="closeDeleteModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove this result record?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeDeleteModal()">Cancel</button>
                    <button type="button" class="btn" style="background-color: #ef4444; color: white;"
                        onclick="confirmDelete()">Delete</button>
                </div>
            </div>
        </div>

        <style>
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
                width: 50%;
                /* Adjusted width */
                max-width: 600px;
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
                grid-template-columns: 1fr;
                /* Single column for simpler form */
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

            window.addEventListener('click', function (e) {
                const profile = document.querySelector('.user-profile');
                if (!profile.contains(e.target)) {
                    document.getElementById('profileDropdown').classList.remove('show');
                }
                const modal = document.getElementById('addResultModal');
                if (e.target == modal) {
                    closeModal();
                }
            });

            const gradePoints = {
                'A': 4.00, 'A-': 3.67, 'B+': 3.33, 'B': 3.00, 'B-': 2.67,
                'C+': 2.33, 'C': 2.00, 'F': 0.00
            };

            function calculatePoint() {
                const grade = document.getElementById('resultGrade').value;
                const point = gradePoints[grade] || 0.00;
                document.getElementById('resultPoint').value = point.toFixed(2);
            }

            function filterResults() {
                const searchInput = document.getElementById('searchInput');
                const filterValue = searchInput.value.toUpperCase();
                const table = document.getElementById('resultsTable');
                const tr = table.getElementsByTagName('tr');

                for (let i = 1; i < tr.length; i++) {
                    const tdId = tr[i].getElementsByTagName('td')[0];
                    const tdName = tr[i].getElementsByTagName('td')[1];
                    const tdCourse = tr[i].getElementsByTagName('td')[2];

                    if (tdId && tdName && tdCourse) {
                        const idText = tdId.textContent || tdId.innerText;
                        const nameText = tdName.textContent || tdName.innerText;
                        const courseText = tdCourse.textContent || tdCourse.innerText;

                        if (idText.toUpperCase().indexOf(filterValue) > -1 ||
                            nameText.toUpperCase().indexOf(filterValue) > -1 ||
                            courseText.toUpperCase().indexOf(filterValue) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }

            // Modal Functions
            function openModal() {
                document.getElementById('modalTitle').innerText = "Add New Result";
                document.getElementById('addResultForm').reset();
                document.getElementById('editRowIndex').value = "";
                calculatePoint();
                document.getElementById('addResultModal').style.display = "block";
            }

            let currentRow = null;

            function openEditModal(button) {
                currentRow = button.closest('tr');
                const cells = currentRow.getElementsByTagName('td');

                document.getElementById('modalTitle').innerText = "Edit Result";
                document.getElementById('resultStudentId').value = cells[0].innerText;
                document.getElementById('resultStudentName').value = cells[1].innerText;
                document.getElementById('resultCourseCode').value = cells[2].innerText;
                document.getElementById('resultGrade').value = cells[3].innerText;
                document.getElementById('resultPoint').value = cells[4].innerText;

                document.getElementById('editRowIndex').value = currentRow.rowIndex;

                document.getElementById('addResultModal').style.display = "block";
            }

            function closeModal() {
                document.getElementById('addResultModal').style.display = "none";
            }

            function handleFormSubmit() {
                const btn = event.target; // Simplistic prevents default not needed if type button

                const sid = document.getElementById('resultStudentId').value;
                const sname = document.getElementById('resultStudentName').value;
                const code = document.getElementById('resultCourseCode').value;
                const grade = document.getElementById('resultGrade').value;
                const point = document.getElementById('resultPoint').value;
                const status = (grade === 'F') ? 'FAIL' : 'PASS';
                const statusColor = (grade === 'F') ? '#ef4444' : '#10b981';
                const statusBg = (grade === 'F') ? 'rgba(239, 68, 68, 0.1)' : 'rgba(16, 185, 129, 0.1)';

                if (!sid || !sname || !code || !grade) {
                    alert("Please fill all required fields");
                    return;
                }

                const rowIndex = document.getElementById('editRowIndex').value;

                if (rowIndex) {
                    // Edit
                    const table = document.getElementById('resultsTable');
                    const row = table.rows[rowIndex];
                    row.cells[0].innerText = sid;
                    row.cells[1].innerText = sname;
                    row.cells[2].innerText = code;
                    row.cells[3].innerText = grade;
                    row.cells[4].innerText = point;
                    row.cells[5].innerHTML = `<span style="background: \${statusBg}; color: \${statusColor}; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600;">\${status}</span>`;
                } else {
                    // Add
                    const table = document.getElementById('resultsTable').getElementsByTagName('tbody')[0];
                    const newRow = table.insertRow();
                    newRow.style.borderBottom = "1px solid var(--border)";
                    newRow.innerHTML = `
                    <td style="padding: 1rem;">\${sid}</td>
                    <td style="padding: 1rem; font-weight: 500;">\${sname}</td>
                    <td style="padding: 1rem;">\${code}</td>
                    <td style="padding: 1rem; font-weight: 600;">\${grade}</td>
                    <td style="padding: 1rem;">\${point}</td>
                    <td style="padding: 1rem;"><span style="background: \${statusBg}; color: \${statusColor}; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600;">\${status}</span></td>
                    <td style="padding: 1rem;">
                        <button onclick="openEditModal(this)" style="background: none; border: none; color: var(--primary); cursor: pointer; margin-right: 0.5rem; font-weight: 500;">Edit</button>
                        <button onclick="openDeleteModal(this)" style="background: none; border: none; color: #ef4444; cursor: pointer; font-weight: 500;">Delete</button>
                    </td>
                `;
                }
                closeModal();
            }

            function openDeleteModal(button) {
                currentRow = button.closest('tr');
                document.getElementById('deleteResultModal').style.display = "block";
            }

            function closeDeleteModal() {
                document.getElementById('deleteResultModal').style.display = "none";
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