<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Courses - Admin Portal</title>
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
                        <a href="${pageContext.request.contextPath}/admin/courses.jsp" class="active">
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
                        <h1>Course Management</h1>
                        <p style="color: var(--text-muted);">Add and modify course offerings</p>
                    </div>
                    <div style="display: flex; gap: 1rem; align-items: center;">
                        <button class="btn" onclick="openModal()">
                            + Add New Course
                        </button>
                    </div>
                </header>

                <div class="card">
                    <div style="display: flex; gap: 1rem; margin-bottom: 1.5rem;">
                        <input type="text" id="searchInput" class="form-control" placeholder="Search by name or ID..."
                            style="max-width: 300px;" onkeyup="filterCourses()">
                        <select id="programFilter" class="form-control" style="max-width: 150px;"
                            onchange="filterCourses()">
                            <option value="">All Courses</option>
                            <option value="BCS">BCS</option>
                            <option value="BSE">BSE</option>
                        </select>
                    </div>

                    <div class="course-list">
                        <div class="course-card"
                            style="margin-bottom: 1rem; border: 1px solid var(--border); padding: 1rem; border-radius: 0.5rem;"
                            data-program="BCS">
                            <div>
                                <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                    <h3 style="font-size: 1.1rem; margin: 0;">CS205: Web Development</h3>
                                    <span
                                        style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem;">3
                                        Credits</span>
                                </div>
                                <p style="color: var(--text-muted); font-size: 0.875rem; margin: 0.5rem 0 0 0;">Program:
                                    BCS • Lecturer: Prof. Sarah Connor • Max Capacity: 40</p>
                            </div>
                            <div>
                                <button class="btn" onclick="openEditModal(this)"
                                    style="padding: 0.5rem 1rem; font-size: 0.875rem; background: var(--bg-main); border: 1px solid var(--border); color: var(--text-muted); margin-right: 0.5rem;">Edit</button>
                                <button class="btn" onclick="openDeleteModal(this)"
                                    style="padding: 0.5rem 1rem; font-size: 0.875rem; background: rgba(239, 68, 68, 0.1); border: 1px solid transparent; color: #ef4444;">Delete</button>
                            </div>
                        </div>

                        <div class="course-card"
                            style="margin-bottom: 1rem; border: 1px solid var(--border); padding: 1rem; border-radius: 0.5rem;"
                            data-program="BSE">
                            <div>
                                <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                    <h3 style="font-size: 1.1rem; margin: 0;">CS201: Data Structures</h3>
                                    <span
                                        style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem;">4
                                        Credits</span>
                                </div>
                                <p style="color: var(--text-muted); font-size: 0.875rem; margin: 0.5rem 0 0 0;">Program:
                                    BSE • Lecturer: Dr. Alan Grant • Max Capacity: 35</p>
                            </div>
                            <div>
                                <button class="btn" onclick="openEditModal(this)"
                                    style="padding: 0.5rem 1rem; font-size: 0.875rem; background: var(--bg-main); border: 1px solid var(--border); color: var(--text-muted); margin-right: 0.5rem;">Edit</button>
                                <button class="btn" onclick="openDeleteModal(this)"
                                    style="padding: 0.5rem 1rem; font-size: 0.875rem; background: rgba(239, 68, 68, 0.1); border: 1px solid transparent; color: #ef4444;">Delete</button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <!-- Add/Edit Course Modal -->
        <div id="addCourseModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 id="modalTitle">Add New Course</h2>
                    <span class="close" onclick="closeModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <form id="addCourseForm">
                        <input type="hidden" id="editCardId">
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Course Code</label>
                                <input type="text" id="courseCode" required placeholder="e.g. CS205">
                            </div>
                            <div class="form-group">
                                <label>Course Name</label>
                                <input type="text" id="courseName" required>
                            </div>
                            <div class="form-group">
                                <label>Credits</label>
                                <input type="number" id="courseCredits" required min="1" max="10">
                            </div>
                            <div class="form-group">
                                <label>Program</label>
                                <select id="courseProgram" required>
                                    <option value="BCS">BCS</option>
                                    <option value="BSE">BSE</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Lecturer Name</label>
                                <input type="text" id="courseLecturer" required placeholder="e.g. Dr. John Doe">
                            </div>
                            <div class="form-group">
                                <label>Max Capacity</label>
                                <input type="number" id="courseCapacity" required min="1">
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
        <div id="deleteCourseModal" class="modal">
            <div class="modal-content" style="max-width: 400px;">
                <div class="modal-header">
                    <h2>Delete Course</h2>
                    <span class="close" onclick="closeDeleteModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <p>Do you confirm want to delete this course?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeDeleteModal()">Cancel</button>
                    <button type="button" class="btn" style="background-color: #ef4444; color: white;"
                        onclick="confirmDelete()">Delete</button>
                </div>
            </div>
        </div>

        <style>
            /* Reuse modal styles from students.jsp or define them here */
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
                padding: 1.5rem;
                border: 1px solid var(--border);
                width: 90%;
                max-width: 600px;
                border-radius: 0.5rem;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
            }

            .close {
                color: var(--text-muted);
                float: right;
                font-size: 1.5rem;
                font-weight: bold;
                cursor: pointer;
            }

            .close:hover,
            .close:focus {
                color: var(--text-main);
                text-decoration: none;
                cursor: pointer;
            }

            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
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

            .form-group input,
            .form-group select {
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
            });

            function filterCourses() {
                const searchInput = document.getElementById('searchInput');
                const filterValue = searchInput.value.toUpperCase();
                const programSelect = document.getElementById('programFilter');
                const programValue = programSelect.value.toUpperCase();

                const cards = document.querySelectorAll('.course-card');

                cards.forEach(card => {
                    const titleElement = card.querySelector('h3');
                    const titleText = titleElement.textContent || titleElement.innerText;
                    const cardProgram = card.getAttribute('data-program').toUpperCase();

                    let matchesSearch = false;
                    let matchesProgram = false;

                    // Check Search (Name or ID)
                    if (titleText.toUpperCase().indexOf(filterValue) > -1) {
                        matchesSearch = true;
                    }

                    // Check Program
                    if (programValue === "" || cardProgram === programValue) {
                        matchesProgram = true;
                    }

                    if (matchesSearch && matchesProgram) {
                        card.style.display = "";
                    } else {
                        card.style.display = "none";
                    }
                });
            }

            // Modal Functions

            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('openModal') === 'true') {
                    openModal();
                }
            }

            window.onpopstate = function (event) {
                if (event.state && event.state.modal) {
                    document.getElementById('addCourseModal').style.display = "block";
                } else {
                    document.getElementById('addCourseModal').style.display = "none";
                }
            };

            function openModal() {
                document.getElementById('modalTitle').innerText = "Add New Course";
                document.getElementById('addCourseForm').reset();
                document.getElementById('editCardId').value = "";
                document.getElementById('addCourseModal').style.display = "block";

                if (!window.location.href.includes('add-course.jsp')) {
                    history.pushState({ modal: true }, "Add New Course", "add-course.jsp");
                }
            }

            let currentCard = null;

            function openEditModal(button) {
                currentCard = button.closest('.course-card');

                // Parse existing data
                const h3 = currentCard.querySelector('h3').innerText; // "CS205: Web Development"
                const [code, name] = h3.split(': ');
                const credits = currentCard.querySelector('span').innerText.split(' ')[0]; // "3"
                const pText = currentCard.querySelector('p').innerText;
                // "Program: BCS • Lecturer: Prof. Name • Max Capacity: 40"
                const parts = pText.split(' • ');
                const program = parts[0].split(': ')[1];
                const lecturer = parts[1].split(': ')[1];
                const capacity = parts[2].split(': ')[1];

                // Populate form
                document.getElementById('modalTitle').innerText = "Edit Course";
                document.getElementById('courseCode').value = code;
                document.getElementById('courseName').value = name;
                document.getElementById('courseCredits').value = credits;
                document.getElementById('courseProgram').value = program;
                document.getElementById('courseLecturer').value = lecturer;
                document.getElementById('courseCapacity').value = capacity;

                document.getElementById('editCardId').value = "true";

                document.getElementById('addCourseModal').style.display = "block";

                if (!window.location.href.includes('edit-course.jsp')) {
                    history.pushState({ modal: true }, "Edit Course", "edit-course.jsp");
                }
            }

            function closeModal() {
                document.getElementById('addCourseModal').style.display = "none";
                if (window.location.href.includes('add-course.jsp') || window.location.href.includes('edit-course.jsp')) {
                    history.pushState({ modal: false }, "Courses", "courses.jsp");
                }
            }

            function handleFormSubmit() {
                const code = document.getElementById('courseCode').value;
                const name = document.getElementById('courseName').value;
                const credits = document.getElementById('courseCredits').value;
                const program = document.getElementById('courseProgram').value;
                const lecturer = document.getElementById('courseLecturer').value;
                const capacity = document.getElementById('courseCapacity').value;

                if (!code || !name) {
                    alert("Please fill in required fields");
                    return;
                }

                const infoString = `Program: \${program} • Lecturer: \${lecturer} • Max Capacity: \${capacity}`;

                if (document.getElementById('editCardId').value === "true" && currentCard) {
                    // Update existing
                    currentCard.setAttribute('data-program', program);
                    currentCard.querySelector('h3').innerText = `\${code}: \${name}`;
                    currentCard.querySelector('span').innerText = `\${credits} Credits`;
                    currentCard.querySelector('p').innerText = infoString;
                } else {
                    // Add new
                    const list = document.querySelector('.course-list');
                    const newCard = document.createElement('div');
                    newCard.className = 'course-card';
                    newCard.setAttribute('data-program', program);
                    newCard.style.marginBottom = '1rem';
                    newCard.style.border = '1px solid var(--border)';
                    newCard.style.padding = '1rem';
                    newCard.style.borderRadius = '0.5rem';

                    newCard.innerHTML = `
                    <div>
                        <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                            <h3 style="font-size: 1.1rem; margin: 0;">\${code}: \${name}</h3>
                            <span style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem;">\${credits} Credits</span>
                        </div>
                        <p style="color: var(--text-muted); font-size: 0.875rem; margin: 0.5rem 0 0 0;">\${infoString}</p>
                    </div>
                    <div>
                        <button class="btn" onclick="openEditModal(this)"
                            style="padding: 0.5rem 1rem; font-size: 0.875rem; background: var(--bg-main); border: 1px solid var(--border); color: var(--text-muted); margin-right: 0.5rem;">Edit</button>
                        <button class="btn" onclick="openDeleteModal(this)"
                            style="padding: 0.5rem 1rem; font-size: 0.875rem; background: rgba(239, 68, 68, 0.1); border: 1px solid transparent; color: #ef4444;">Delete</button>
                    </div>
                `;
                    list.appendChild(newCard);
                }

                closeModal();
            }

            function openDeleteModal(button) {
                currentCard = button.closest('.course-card');
                document.getElementById('deleteCourseModal').style.display = "block";
            }

            function closeDeleteModal() {
                document.getElementById('deleteCourseModal').style.display = "none";
                currentCard = null;
            }

            function confirmDelete() {
                if (currentCard) {
                    currentCard.remove();
                }
                closeDeleteModal();
            }
        </script>
    </body>

    </html>