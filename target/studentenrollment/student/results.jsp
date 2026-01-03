<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Results - SEMS</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
        <script src="https://unpkg.com/lucide@latest"></script>
        <style>
            .results-table {
                width: 100%;
                border-collapse: collapse;
                font-size: 0.875rem;
                margin-bottom: 2rem;
                background: var(--bg-card);
                border-radius: var(--radius);
                overflow: hidden;
                border: 1px solid var(--border);
            }

            .results-table th,
            .results-table td {
                padding: 0.75rem 1rem;
                text-align: left;
                border-bottom: 1px solid var(--border);
            }

            .results-table th {
                background-color: rgba(255, 255, 255, 0.02);
                font-weight: 500;
                color: var(--text-muted);
                text-transform: uppercase;
                font-size: 0.75rem;
            }

            .results-table tr:last-child td {
                border-bottom: none;
            }

            .gpa-summary {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 2rem;
                background: var(--bg-card);
                padding: 1.5rem;
                border-radius: var(--radius);
                border: 1px solid var(--border);
            }

            .summary-column h3 {
                font-size: 1rem;
                margin-bottom: 1rem;
                color: var(--text-main);
                border-bottom: 1px solid var(--border);
                padding-bottom: 0.5rem;
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                padding: 0.5rem 0;
                font-size: 0.875rem;
                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            }

            .summary-row:last-child {
                border-bottom: none;
                font-weight: 600;
                color: var(--primary);
            }

            .academic-standing {
                margin-top: 1.5rem;
                padding: 1rem;
                background: rgba(16, 185, 129, 0.1);
                color: #10b981;
                border-radius: var(--radius);
                font-weight: 500;
                font-size: 0.9rem;
            }
        </style>
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
                        <a href="${pageContext.request.contextPath}/student/courses.jsp">
                            <i data-lucide="book-open"></i>
                            My Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/results.jsp" class="active">
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
                        <h1>My Results</h1>
                        <p style="color: var(--text-muted);">Examination results and academic performance</p>
                    </div>
                </header>

                <div class="card" style="background: transparent; border: none; padding: 0;">

                    <!-- Results Table -->
                    <table class="results-table">
                        <thead>
                            <tr>
                                <th style="width: 50px;">No</th>
                                <th>Subject Code</th>
                                <th>Subject Name</th>
                                <th style="text-align: center;">Credit Hour</th>
                                <th style="text-align: center;">Grade</th>
                                <th style="text-align: center;">Point</th>
                                <th style="text-align: center;">Result</th>
                                <th style="text-align: center;">Note</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>BCC52023</td>
                                <td>Computer Science Theory</td>
                                <td style="text-align: center;">3</td>
                                <td style="text-align: center;">C+</td>
                                <td style="text-align: center;">2.33</td>
                                <td style="text-align: center;">PASS</td>
                                <td style="text-align: center;">-</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>BCCS2053</td>
                                <td>Algorithm Design & Analysis</td>
                                <td style="text-align: center;">3</td>
                                <td style="text-align: center;">B</td>
                                <td style="text-align: center;">3.00</td>
                                <td style="text-align: center;">PASS</td>
                                <td style="text-align: center;">-</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>BCCS2093</td>
                                <td>Compiler & Program Analysis</td>
                                <td style="text-align: center;">3</td>
                                <td style="text-align: center;">A-</td>
                                <td style="text-align: center;">3.67</td>
                                <td style="text-align: center;">PASS</td>
                                <td style="text-align: center;">-</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>BCCS3013</td>
                                <td>Network Defence</td>
                                <td style="text-align: center;">3</td>
                                <td style="text-align: center;">A</td>
                                <td style="text-align: center;">4.00</td>
                                <td style="text-align: center;">PASS</td>
                                <td style="text-align: center;">-</td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>BCCY2013</td>
                                <td>Information Assurance & Security</td>
                                <td style="text-align: center;">3</td>
                                <td style="text-align: center;">A</td>
                                <td style="text-align: center;">4.00</td>
                                <td style="text-align: center;">PASS</td>
                                <td style="text-align: center;">-</td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td>MPU3333</td>
                                <td>Integrity & Anti-Corruption</td>
                                <td style="text-align: center;">3</td>
                                <td style="text-align: center;">B-</td>
                                <td style="text-align: center;">2.67</td>
                                <td style="text-align: center;">PASS</td>
                                <td style="text-align: center;">-</td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- GPA Summary -->
                    <div class="gpa-summary">
                        <!-- This Semester -->
                        <div class="summary-column">
                            <h3>This Semester</h3>
                            <div class="summary-row">
                                <span>Semester Credits Taken</span>
                                <span>26</span>
                            </div>
                            <div class="summary-row">
                                <span>Semester Credits Gained</span>
                                <span>26</span>
                            </div>
                            <div class="summary-row">
                                <span>Semester Credits Calculated</span>
                                <span>26</span>
                            </div>
                            <div class="summary-row">
                                <span>Semester Grade Point</span>
                                <span>89.00</span>
                            </div>
                            <div class="summary-row">
                                <span>Grade Point Average (GPA)</span>
                                <span>3.42</span>
                            </div>
                        </div>

                        <!-- Overall Semester -->
                        <div class="summary-column">
                            <h3>Overall Semester</h3>
                            <div class="summary-row">
                                <span>Cumulative Credits Taken</span>
                                <span>67</span>
                            </div>
                            <div class="summary-row">
                                <span>Cumulative Credits Gained</span>
                                <span>61</span>
                            </div>
                            <div class="summary-row">
                                <span>Cumulative Credits Calculated</span>
                                <span>65</span>
                            </div>
                            <div class="summary-row">
                                <span>Cumulative Grade Point</span>
                                <span>176.00</span>
                            </div>
                            <div class="summary-row">
                                <span>Cumulative Grade Point Average (CGPA)</span>
                                <span>2.71</span>
                            </div>
                        </div>
                    </div>

                    <div class="academic-standing">
                        Academic Standing - A (Active)
                    </div>

                </div>
            </main>
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
        </script>
    </body>

    </html>