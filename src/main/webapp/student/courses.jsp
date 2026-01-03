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
                    <span>🎓</span> SEMS Portal
                </div>

                <ul class="nav-links">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/dashboard.jsp">
                            <i data-lucide="layout-dashboard"></i>
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/timetable.jsp">
                            <i data-lucide="calendar"></i>
                            Timetable
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/courses.jsp" class="active">
                            <i data-lucide="book-open"></i>
                            My Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/results.jsp">
                            <i data-lucide="graduation-cap"></i>
                            My Results
                        </a>
                    </li>
                </ul>

                <div class="user-profile" onclick="toggleProfileMenu()">
                    <div class="avatar">JS</div>
                    <div>
                        <div style="font-weight: 500;">John Smith</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">Student</div>
                    </div>
                    <i data-lucide="chevron-up"
                        style="margin-left: auto; width: 16px; height: 16px; color: var(--text-muted);"></i>

                    <div class="profile-dropdown" id="profileDropdown">
                        <a href="${pageContext.request.contextPath}/student/profile.jsp" class="dropdown-item">
                            <i data-lucide="user" style="width: 16px; height: 16px;"></i> Profile
                        </a>
                        <div class="dropdown-divider"></div>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="dropdown-item text-red">
                            <i data-lucide="log-out" style="width: 16px; height: 16px;"></i> Logout
                        </a>
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
                    <div class="actions" style="display: flex; gap: 1rem; align-items: center;">
                        <!-- Action Buttons -->
                        <button id="btnAddCourse" onclick="toggleAddMode()" class="btn btn-green">
                            <i data-lucide="plus-circle" style="width: 18px; height: 18px; margin-right: 0.5rem;"></i>
                            Add Course
                        </button>
                        <button id="btnDropCourse" onclick="toggleDropMode()" class="btn btn-red">
                            <i data-lucide="trash-2" style="width: 18px; height: 18px; margin-right: 0.5rem;"></i>
                            Drop Course
                        </button>

                        <!-- Confirmation Controls (Hidden by default) -->
                        <div id="confirmControls" style="display: none; gap: 0.5rem;">
                            <button onclick="confirmAction()" class="btn"
                                style="background-color: var(--primary);">Confirm</button>
                            <button onclick="cancelMode()" class="btn"
                                style="background-color: var(--bg-card); border: 1px solid var(--border);">Cancel</button>
                        </div>

                        <!-- Search Bar -->
                        <input type="text" placeholder="Search courses..." class="form-control"
                            style="width: 250px; background: var(--bg-card); border: 1px solid var(--border); padding: 0.5rem 1rem; border-radius: var(--radius); color: var(--text-main);">
                    </div>
                </header>

                <h2 id="sectionTitle" class="mb-4">Available Courses</h2>

                <div class="course-list">
                    <!-- Data Structures -->
                    <div class="course-card" id="course-cs201" data-status="available">
                        <div style="display: flex; align-items: center;">
                            <div class="checkbox-overlay">
                                <input type="checkbox" class="course-checkbox"
                                    style="width: 20px; height: 20px; accent-color: var(--primary);">
                            </div>
                            <div>
                                <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                    <h3 style="font-size: 1.1rem; margin: 0;">Data Structures</h3>
                                    <span
                                        style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem; font-weight: 500;">4
                                        Credits</span>
                                </div>
                                <p style="color: var(--text-muted); font-size: 0.875rem; margin-top: 0.25rem;">CS201 •
                                    Prof. Davis • Tue/Thu 1:00 PM</p>
                            </div>
                        </div>
                    </div>

                    <!-- Web Development -->
                    <div class="course-card" id="course-cs205" data-status="available">
                        <div style="display: flex; align-items: center;">
                            <div class="checkbox-overlay">
                                <input type="checkbox" class="course-checkbox"
                                    style="width: 20px; height: 20px; accent-color: var(--primary);">
                            </div>
                            <div>
                                <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                    <h3 style="font-size: 1.1rem; margin: 0;">Web Development</h3>
                                    <span
                                        style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem; font-weight: 500;">3
                                        Credits</span>
                                </div>
                                <p style="color: var(--text-muted); font-size: 0.875rem; margin-top: 0.25rem;">CS205 •
                                    Prof. Johnson • Mon/Wed 10:00 AM</p>
                            </div>
                        </div>
                    </div>

                    <!-- Software Engineering -->
                    <div class="course-card" id="course-cs301" data-status="available">
                        <div style="display: flex; align-items: center;">
                            <div class="checkbox-overlay">
                                <input type="checkbox" class="course-checkbox"
                                    style="width: 20px; height: 20px; accent-color: var(--primary);">
                            </div>
                            <div>
                                <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                    <h3 style="font-size: 1.1rem; margin: 0;">Software Engineering</h3>
                                    <span
                                        style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem; font-weight: 500;">3
                                        Credits</span>
                                </div>
                                <p style="color: var(--text-muted); font-size: 0.875rem; margin-top: 0.25rem;">CS301 •
                                    Prof. Alan • Mon/Fri 11:00 AM</p>
                            </div>
                        </div>
                    </div>

                    <!-- Operating Systems -->
                    <div class="course-card" id="course-cs305" data-status="available">
                        <div style="display: flex; align-items: center;">
                            <div class="checkbox-overlay">
                                <input type="checkbox" class="course-checkbox"
                                    style="width: 20px; height: 20px; accent-color: var(--primary);">
                            </div>
                            <div>
                                <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                    <h3 style="font-size: 1.1rem; margin: 0;">Operating Systems</h3>
                                    <span
                                        style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem; font-weight: 500;">4
                                        Credits</span>
                                </div>
                                <p style="color: var(--text-muted); font-size: 0.875rem; margin-top: 0.25rem;">CS305 •
                                    Prof. Tanenbaum • Wed/Fri 2:00 PM</p>
                            </div>
                        </div>
                    </div>

                    <!-- Artificial Intelligence -->
                    <div class="course-card" id="course-cs401" data-status="available">
                        <div style="display: flex; align-items: center;">
                            <div class="checkbox-overlay">
                                <input type="checkbox" class="course-checkbox"
                                    style="width: 20px; height: 20px; accent-color: var(--primary);">
                            </div>
                            <div>
                                <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                    <h3 style="font-size: 1.1rem; margin: 0;">Introduction to AI</h3>
                                    <span
                                        style="background: rgba(99, 102, 241, 0.1); color: var(--primary); font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem; font-weight: 500;">3
                                        Credits</span>
                                </div>
                                <p style="color: var(--text-muted); font-size: 0.875rem; margin-top: 0.25rem;">CS401 •
                                    Prof. Turing • Tue/Thu 4:00 PM</p>
                            </div>
                        </div>
                    </div>

                    <!-- Database Systems (Enrolled) -->
                    <div class="course-card" id="course-cs302" data-status="enrolled"
                        style="border-left: 4px solid #10b981;">
                        <div style="display: flex; align-items: center;">
                            <div class="checkbox-overlay">
                                <input type="checkbox" class="course-checkbox"
                                    style="width: 20px; height: 20px; accent-color: #ef4444;">
                            </div>
                            <div>
                                <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.25rem;">
                                    <h3 style="font-size: 1.1rem; margin: 0;">Database Systems</h3>
                                    <span id="badge-cs302"
                                        style="background: rgba(16, 185, 129, 0.1); color: #10b981; font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem; font-weight: 500;">Enrolled</span>
                                </div>
                                <p style="color: var(--text-muted); font-size: 0.875rem; margin-top: 0.25rem;">CS302 •
                                    Prof. Williams • Fri 9:00 AM</p>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script>
            lucide.createIcons();

            let currentMode = null; // 'add' or 'drop'

            function toggleAddMode() {
                currentMode = 'add';
                updateUIState();
            }

            function toggleDropMode() {
                currentMode = 'drop';
                updateUIState();
            }

            function cancelMode() {
                currentMode = null;
                // Uncheck all boxes
                document.querySelectorAll('.course-checkbox').forEach(cb => cb.checked = false);
                updateUIState();
            }

            function updateUIState() {
                const btnAdd = document.getElementById('btnAddCourse');
                const btnDrop = document.getElementById('btnDropCourse');
                const confirmControls = document.getElementById('confirmControls');
                const checkboxes = document.querySelectorAll('.checkbox-overlay');
                // Target all course cards directly
                const cards = document.querySelectorAll('.course-card');

                if (currentMode === 'add') {
                    // ADD MODE: SHOW Available, HIDE Enrolled
                    btnAdd.style.display = 'none';
                    btnDrop.style.display = 'none';
                    confirmControls.style.display = 'flex';
                    document.getElementById('sectionTitle').innerText = 'Select Courses to Add';

                    cards.forEach(card => {
                        const status = card.getAttribute('data-status');
                        const checkbox = card.querySelector('.checkbox-overlay');

                        // Check if status is explicitly available
                        if (status === 'available') {
                            card.style.display = 'flex'; // Make sure it's visible
                            checkbox.style.display = 'block';
                            card.style.opacity = '1';
                        } else {
                            card.style.display = 'none'; // Hide enrolled/pending
                        }
                    });

                } else if (currentMode === 'drop') {
                    // DROP MODE: SHOW Enrolled, HIDE Available
                    btnAdd.style.display = 'none';
                    btnDrop.style.display = 'none';
                    confirmControls.style.display = 'flex';
                    document.getElementById('sectionTitle').innerText = 'Select Courses to Drop';

                    cards.forEach(card => {
                        const status = card.getAttribute('data-status');
                        const checkbox = card.querySelector('.checkbox-overlay');

                        // Check if status is enrolled or pending
                        if (status === 'enrolled' || status === 'pending') {
                            card.style.display = 'flex'; // Make sure visible
                            checkbox.style.display = 'block';
                            card.style.opacity = '1';
                        } else {
                            card.style.display = 'none'; // Hide available
                        }
                    });
                } else {
                    // DEFAULT MODE: SHOW Enrolled, HIDE Available
                    btnAdd.style.display = 'inline-flex';
                    btnDrop.style.display = 'inline-flex';
                    confirmControls.style.display = 'none';
                    document.getElementById('sectionTitle').innerText = 'My Enrolled Courses';

                    checkboxes.forEach(cb => cb.style.display = 'none');

                    cards.forEach(card => {
                        const status = card.getAttribute('data-status');
                        if (status === 'enrolled' || status === 'pending') {
                            card.style.display = 'flex'; // Show enrolled
                        } else {
                            card.style.display = 'none'; // Hide available
                        }
                        card.style.opacity = '1';
                    });
                }
            }

            // Ensure logic runs on initial load
            window.addEventListener('load', function () {
                updateUIState();
            });

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

            function confirmAction() {
                const cards = document.querySelectorAll('.course-card');

                cards.forEach(card => {
                    const checkbox = card.querySelector('.course-checkbox');
                    if (checkbox.checked) {
                        if (currentMode === 'add') {
                            // Change to Waiting for Approval
                            card.setAttribute('data-status', 'pending');
                            // Add Badge
                            const titleDiv = card.querySelector('h3').parentNode;
                            // Remove existing badges if any
                            const existingBadge = titleDiv.querySelector('span');
                            if (existingBadge) existingBadge.remove();

                            const badge = document.createElement('span');
                            badge.className = 'status-badge';
                            badge.style = 'background: rgba(234, 179, 8, 0.1); color: #eab308; font-size: 0.75rem; padding: 0.1rem 0.5rem; border-radius: 0.25rem; font-weight: 500;';
                            badge.innerText = 'Waiting for Approval';
                            titleDiv.appendChild(badge);

                            card.style.borderLeft = '4px solid #eab308'; // Yellow border

                        } else if (currentMode === 'drop') {
                            // Switch back to available
                            card.setAttribute('data-status', 'available');
                            // Add Badge (Credits) - Reverting to credits badge is tricky without storing it, 
                            // so for this dummy simulation we'll just restore the default look or hide the enrolled badge.
                            // Simplest for simulation: Just remove the "Enrolled" badge and green border.

                            const titleDiv = card.querySelector('h3').parentNode;
                            const existingBadge = titleDiv.querySelector('span');
                            if (existingBadge) existingBadge.innerText = 'Dropped (Available)'; // Indicate change

                            card.style.borderLeft = '1px solid var(--border)';
                        }
                        checkbox.checked = false;
                    }
                });

                cancelMode(); // Reset UI
            }
        </script>
    </body>

    </html>