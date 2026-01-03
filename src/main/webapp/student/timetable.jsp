<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Timetable - SEMS</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
        <script src="https://unpkg.com/lucide@latest"></script>
        <style>
            .timetable-grid {
                display: grid;
                grid-template-columns: 50px repeat(7, 1fr);
                /* Time column + 7 days */
                grid-template-rows: 40px repeat(15, 60px);
                /* Header + 15 hours (8am - 10pm) */
                border: 1px solid var(--border);
                background: var(--bg-card);
                border-radius: var(--radius);
                overflow: auto;
                /* Allow scrolling if needed */
                font-size: 0.75rem;
            }

            /* Headers */
            .day-header {
                text-align: center;
                font-weight: 600;
                padding: 0.75rem;
                border-bottom: 1px solid var(--border);
                border-right: 1px solid var(--border);
                color: var(--primary);
                background: rgba(255, 255, 255, 0.02);
                position: sticky;
                top: 0;
                z-index: 10;
            }

            .time-slot {
                text-align: right;
                padding: 0.5rem;
                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                border-right: 1px solid var(--border);
                color: var(--text-muted);
                font-size: 0.7rem;
                background: rgba(255, 255, 255, 0.01);
            }

            /* Grid Cells (Empty) */
            .grid-cell {
                border-bottom: 1px dashed rgba(255, 255, 255, 0.05);
                border-right: 1px solid rgba(255, 255, 255, 0.05);
            }

            /* Weekend Column Background */
            .weekend-col {
                background-color: rgba(255, 255, 200, 0.05);
            }

            /* Class Event Block */
            .class-event {
                margin: 2px;
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 0.7rem;
                color: #1e293b;
                font-weight: 500;
                border-left: 3px solid;
                overflow: hidden;
                display: flex;
                flex-direction: column;
                justify-content: center;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            }

            .event-green {
                background-color: #dcfce7;
                border-color: #22c55e;
                color: #14532d;
            }

            .event-red {
                background-color: #fee2e2;
                border-color: #ef4444;
                color: #7f1d1d;
            }

            .event-title {
                font-weight: 700;
                margin-bottom: 2px;
            }
        </style>
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
                        <a href="${pageContext.request.contextPath}/student/dashboard.jsp">
                            <i data-lucide="layout-dashboard"></i>
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/timetable.jsp" class="active">
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
                        <h1>Timetable</h1>
                        <p style="color: var(--text-muted);">Weekly Class Schedule</p>
                    </div>
                </header>

                <div class="timetable-grid">
                    <!-- Header Row -->
                    <div class="grid-cell" style="border:none;"></div> <!-- Empty top-left -->
                    <div class="day-header" style="color: #3b82f6;">Sun 12/28</div>
                    <div class="day-header" style="color: #3b82f6;">Mon 12/29</div>
                    <div class="day-header" style="color: #3b82f6;">Tue 12/30</div>
                    <div class="day-header" style="color: #3b82f6;">Wed 12/31</div>
                    <div class="day-header">Thu 1/1</div>
                    <div class="day-header" style="color: #3b82f6;">Fri 1/2</div>
                    <div class="day-header" style="color: #3b82f6;">Sat 1/3</div>

                    <!-- Time Rows & Events -->

                    <!-- 8 AM -->
                    <div class="time-slot">8am</div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="class-event event-red" style="grid-column: 6; grid-row: 2 / span 2;">
                        <div class="event-title">New Year's Day</div>
                    </div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 9 AM -->
                    <div class="time-slot">9am</div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <!-- Thu spanned from above -->
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 10 AM -->
                    <div class="time-slot">10am</div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <!-- Thu continues red block? No screenshot shows full day pink but let's just mark the holiday -->
                    <div class="class-event event-red" style="grid-column: 6; grid-row: 4 / span 13; opacity: 0.5;">
                    </div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 11 AM -->
                    <div class="time-slot">11am</div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>

                    <!-- Software Project Management (Tue 11-1) -->
                    <div class="class-event event-green" style="grid-column: 4; grid-row: 5 / span 2;">
                        <div class="event-title">11:00 - 1:00</div>
                        <div>Software Project Management - Python</div>
                        <div>Level 8, Menara BAC</div>
                    </div>

                    <!-- Dynamic Web System (Wed 11:30 - 1:30) approx row 5.5 to 7.5 -->
                    <!-- Grid is hourly, so we approximate or use finer rows. Simple approach: snap to nearest hour or half hour if using detailed rows. 
                     For this demo, simply placing it in 11am-1pm slot for simplicity, or we check if we can span. 
                     Let's span 11am-1pm for now. -->
                    <div class="class-event event-green"
                        style="grid-column: 5; grid-row: 5 / span 2; margin-top: 30px; height: 90px; z-index:2;">
                        <div class="event-title">11:30 - 1:30</div>
                        <div>Dynamic Web System Development - Ruby</div>
                        <div>Level 9, Menara BAC</div>
                    </div>

                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 12 PM -->
                    <div class="time-slot">12pm</div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <!-- Tue Occupied -->
                    <!-- Wed Occupied -->
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 1 PM -->
                    <div class="time-slot">1pm</div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 2 PM -->
                    <div class="time-slot">2pm</div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>

                    <!-- AI (Wed 2-5) -->
                    <div class="class-event event-green" style="grid-column: 5; grid-row: 8 / span 3;">
                        <div class="event-title">2:00 - 5:00</div>
                        <div>Artificial Intelligence - Python</div>
                        <div>Level 8, Menara BAC</div>
                    </div>

                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 3 PM -->
                    <div class="time-slot">3pm</div>
                    <div class="grid-cell"></div>

                    <!-- Industrial Workshop (Mon 3-6) -->
                    <div class="class-event event-green" style="grid-column: 3; grid-row: 9 / span 3;">
                        <div class="event-title">3:00 - 6:00</div>
                        <div>Industrial Workshop - Flutter</div>
                        <div>Level 9, Menara BAC</div>
                    </div>

                    <div class="grid-cell"></div>
                    <!-- Wed Occupied -->
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 4 PM -->
                    <div class="time-slot">4pm</div>
                    <div class="grid-cell"></div>
                    <!-- Mon Occupied -->

                    <!-- Software Project Management (Tue 4-6) -->
                    <div class="class-event event-green" style="grid-column: 4; grid-row: 10 / span 2;">
                        <div class="event-title">4:00 - 6:00</div>
                        <div>Software Project Management - 603</div>
                        <div>Level 6, Menara BAC</div>
                    </div>

                    <!-- Wed Occupied -->
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 5 PM -->
                    <div class="time-slot">5pm</div>
                    <div class="grid-cell"></div>
                    <!-- Mon Occupied -->
                    <!-- Tue Occupied -->
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 6 PM -->
                    <div class="time-slot">6pm</div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 7 PM -->
                    <div class="time-slot">7pm</div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 8 PM -->
                    <div class="time-slot">8pm</div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 9 PM -->
                    <div class="time-slot">9pm</div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

                    <!-- 10 PM -->
                    <div class="time-slot">10pm</div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell"></div>
                    <div class="grid-cell weekend-col"></div>

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