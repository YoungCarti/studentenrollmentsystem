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
                        <a href="${pageContext.request.contextPath}/student-profile" class="dropdown-item">
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
                    <c:if test="${not empty error}">
                        <div class="alert alert-error" style="margin-bottom: 2rem;">
                            <i data-lucide="alert-circle"></i>
                            ${error}
                        </div>
                    </c:if>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 3rem; align-items: start;">

                        <!-- Student Information -->
                        <div class="section-block">
                            <h3 class="section-title">Student Information</h3>
                            <div class="info-grid">
                                <div class="info-row">
                                    <span class="label">Full Name</span>
                                    <span class="value">${student.firstName} ${student.lastName}</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Student ID</span>
                                    <span class="value">STU-${student.studentId}</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Email Address</span>
                                    <span class="value">${student.email}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Personal Information -->
                        <div class="section-block">
                            <h3 class="section-title">Personal Information</h3>
                            <div class="info-grid">
                                <div class="info-row">
                                    <span class="label">Date of Birth</span>
                                    <span class="value">${student.dob}</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Enrollment Date</span>
                                    <span class="value">${student.enrollmentDate}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Contact Information -->
                        <div class="section-block">
                            <h3 class="section-title">Contact Information</h3>
                            <div class="info-grid">
                                <div class="info-row">
                                    <span class="label">Phone Number</span>
                                    <span class="value">${not empty student.phone ? student.phone : '-'}</span>
                                </div>
                                <div class="info-row">
                                    <span class="label">Address</span>
                                    <span class="value">${not empty student.address ? student.address : '-'}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Status -->
                        <div class="section-block">
                            <h3 class="section-title">Account Status</h3>
                            <div class="info-grid">
                                <div class="info-row">
                                    <span class="label">Status</span>
                                    <span class="value">
                                        <span class="badge badge-success">Active</span>
                                    </span>
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