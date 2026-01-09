<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile - SEMS</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
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
                        <a href="${pageContext.request.contextPath}/enroll-course">
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
                    <div class="avatar">${student.firstName.substring(0,1)}${student.lastName.substring(0,1)}</div>
                    <div>
                        <div style="font-weight: 500;">${student.firstName} ${student.lastName}</div>
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
                <div class="profile-container">
                    <!-- Grid Layout for 2 Columns -->
                    <!-- We place items in order: Left1, Right1, Left2, Right2, etc. so they align in rows -->
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 3rem; align-items: start;">

                        <!-- Row 1 Left: Student Info -->
                        <div class="section-block">
                            <h3 class="section-title">Student Information</h3>
                            <div class="info-grid">
                                <div class="info-row">
                                    <span class="label">Name</span>
                                    <span class="value">SAABIRESH LETCHUMANAN</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Student No.</span>
                                    <span class="value">B02240005</span>
                                </div>

                                <div class="info-row">
                                    <span class="label">Campus</span>
                                    <span class="value">University Malaysia of Computer Science and Engineering
                                        (UNIMY)</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Programme</span>
                                    <span class="value">Bachelor of Computer Science with Honours (BCS)</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Intake</span>
                                    <span class="value">February 2024 (B2402)</span>
                                </div>
                            </div>
                        </div>

                        <!-- Row 1 Right: Preference -->
                        <div class="section-block">
                            <h3 class="section-title">Preference</h3>
                            <div class="info-grid">
                                <div class="info-row">
                                    <span class="label">Gender</span>
                                    <span class="value">Male</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Race</span>
                                    <span class="value">Indian</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Religion</span>
                                    <span class="value">Hindu</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Marital Status</span>
                                    <span class="value">Single</span>
                                </div>
                            </div>
                        </div>

                        <!-- Row 2 Left: Personal Information -->
                        <div class="section-block">
                            <h3 class="section-title">Personal Information</h3>
                            <div class="info-grid">
                                <div class="info-row">
                                    <span class="label">Nationality</span>
                                    <span class="value">Malaysian</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Country of Origin</span>
                                    <span class="value">Malaysia</span>
                                </div>

                                <div class="info-row">
                                    <span class="label">IC/Passport No.</span>
                                    <span class="value">-</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">D.O.B</span>
                                    <span class="value">23/11/2004</span>
                                </div>
                            </div>
                        </div>



                        <!-- Row 3 Left: Contact Information -->


                        <!-- Row 3 Right: HOC/Dean -->
                        <div class="section-block">
                            <h3 class="section-title">HOC/Dean Details</h3>
                            <div class="info-grid">
                                <div class="info-row">
                                    <span class="label">Name</span>
                                    <span class="value">NUR FAIQAH BINTI AB HAMID @ FAUZI</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Email</span>
                                    <span class="value text-blue">faiqah.fauzi@unimy.edu.my</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Mobile No</span>
                                    <span class="value text-blue">0136279412</span>
                                </div>
                            </div>
                        </div>

                        <!-- Row 4 Left: Status -->
                        <div class="section-block">
                            <h3 class="section-title">Status</h3>
                            <div class="info-grid">
                                <div class="info-row">
                                    <span class="label">Registered</span>
                                    <span class="value">19/02/2024</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Active</span>
                                    <span class="value">19/02/2024</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <style>
                    .section-title {
                        color: #10b981;
                        font-size: 1rem;
                        margin-bottom: 1rem;
                        font-weight: 600;
                    }

                    .section-block {
                        /* margin-bottom is handled by grid gap now, largely */
                        height: 100%;
                        /* Ensure decent spacing */
                    }

                    .info-grid {
                        display: grid;
                        gap: 0.5rem;
                    }

                    .info-row {
                        display: grid;
                        grid-template-columns: 180px 1fr;
                        align-items: baseline;
                    }

                    .label {
                        font-weight: 600;
                        color: var(--text-main);
                        font-size: 0.9rem;
                    }

                    .value {
                        color: var(--text-muted);
                        font-size: 0.9rem;
                    }

                    .text-blue {
                        color: #3b82f6;
                    }
                </style>
            </main>
        </div>
        <script src="https://unpkg.com/lucide@latest"></script>
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
        </script>
    </body>

    </html>