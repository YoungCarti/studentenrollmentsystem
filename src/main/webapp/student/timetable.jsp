<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Timetable - SEMS</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
            <script src="https://unpkg.com/lucide@latest"></script>
            <style>
                .calendar-grid {
                    display: grid;
                    grid-template-columns: 80px repeat(7, 1fr);
                    gap: 1px;
                    background: var(--border);
                    border: 1px solid var(--border);
                    overflow-x: auto;
                    margin-top: 1.5rem;
                }

                .calendar-header {
                    background: var(--bg-secondary);
                    padding: 1rem;
                    text-align: center;
                    font-weight: 600;
                    color: var(--text-primary);
                }

                .time-slot {
                    background: var(--bg-secondary);
                    padding: 0.5rem;
                    text-align: center;
                    font-size: 0.75rem;
                    color: var(--text-muted);
                    border-right: 1px solid var(--border);
                }

                .calendar-cell {
                    background: var(--bg-card);
                    min-height: 60px;
                    padding: 0.25rem;
                    position: relative;
                }

                .class-block {
                    background: linear-gradient(135deg, rgba(99, 102, 241, 0.9), rgba(168, 85, 247, 0.9));
                    color: white;
                    padding: 0.5rem;
                    border-radius: 6px;
                    font-size: 0.75rem;
                    margin-bottom: 0.25rem;
                    cursor: pointer;
                    transition: transform 0.2s;
                }

                .class-block:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                }

                .class-code {
                    font-weight: 700;
                    margin-bottom: 0.25rem;
                }

                .class-name {
                    font-size: 0.7rem;
                    opacity: 0.9;
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
                            <a href="${pageContext.request.contextPath}/student-dashboard">
                                <i data-lucide="layout-dashboard"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/student-timetable" class="active">
                                <i data-lucide="calendar"></i> Timetable
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/enroll-course">
                                <i data-lucide="book-open"></i> My Courses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/student/results.jsp">
                                <i data-lucide="graduation-cap"></i> My Results
                            </a>
                        </li>
                    </ul>
                    <div class="user-profile" onclick="toggleProfileMenu()">
                        <div class="avatar">${sessionScope.user.username.substring(0,2).toUpperCase()}</div>
                        <div>
                            <div style="font-weight: 500;">${sessionScope.user.username}</div>
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
                    <header class="header">
                        <div>
                            <h1>Weekly Timetable</h1>
                            <p style="color: var(--text-muted);">Your class schedule</p>
                        </div>
                    </header>

                    <c:choose>
                        <c:when test="${not empty enrollments}">
                            <!-- Calendar Grid -->
                            <div class="calendar-grid">
                                <!-- Header Row -->
                                <div class="calendar-header" style="background: var(--bg-main);"></div>
                                <div class="calendar-header">Monday</div>
                                <div class="calendar-header">Tuesday</div>
                                <div class="calendar-header">Wednesday</div>
                                <div class="calendar-header">Thursday</div>
                                <div class="calendar-header">Friday</div>
                                <div class="calendar-header">Saturday</div>
                                <div class="calendar-header">Sunday</div>

                                <!-- Time slots 8am - 8pm -->
                                <c:forEach var="hour" begin="8" end="20">
                                    <div class="time-slot">${hour}:00</div>
                                    <div class="calendar-cell" id="cell-mon-${hour}"></div>
                                    <div class="calendar-cell" id="cell-tue-${hour}"></div>
                                    <div class="calendar-cell" id="cell-wed-${hour}"></div>
                                    <div class="calendar-cell" id="cell-thu-${hour}"></div>
                                    <div class="calendar-cell" id="cell-fri-${hour}"></div>
                                    <div class="calendar-cell" id="cell-sat-${hour}"></div>
                                    <div class="calendar-cell" id="cell-sun-${hour}"></div>
                                </c:forEach>
                            </div>

                            <!-- JavaScript to populate calendar -->
                            <script>
                                const enrollments = [
                                    <c:forEach var="enrollment" items="${enrollments}" varStatus="status">
                                        {
                                            courseCode: '${enrollment.courseCode}',
                                        courseName: '${enrollment.courseName}',
                                        schedule: '${enrollment.schedule}',
                                        instructor: '${enrollment.instructor}'
                                        }${!status.last ? ',' : ''}
                                    </c:forEach>
                                ];

                                // Parse schedule and place in calendar
                                enrollments.forEach(course => {
                                    if (!course.schedule || course.schedule === 'null' || course.schedule.trim() === '') return;

                                    // Normalize schedule string
                                    const scheduleStr = course.schedule.toLowerCase().replace(/\s+/g, ' ').trim();
                                    const days = [];

                                    // Day Parsing
                                    if (scheduleStr.includes('mon') || /\bm\b/.test(scheduleStr)) days.push('mon');
                                    if (scheduleStr.includes('tue') || /\bt\b/.test(scheduleStr)) days.push('tue');
                                    if (scheduleStr.includes('wed') || /\bw\b/.test(scheduleStr)) days.push('wed');
                                    if (scheduleStr.includes('thu') || scheduleStr.includes('r') || /\br\b/.test(scheduleStr)) days.push('thu');
                                    if (scheduleStr.includes('fri') || /\bf\b/.test(scheduleStr)) days.push('fri');
                                    if (scheduleStr.includes('sat') || /\bs\b/.test(scheduleStr)) days.push('sat');
                                    if (scheduleStr.includes('sun') || /\bu\b/.test(scheduleStr)) days.push('sun');

                                    if (scheduleStr.includes('tth') || (scheduleStr.includes('t') && scheduleStr.includes('th') && !scheduleStr.includes('tue'))) {
                                        if (!days.includes('tue')) days.push('tue');
                                        if (!days.includes('thu')) days.push('thu');
                                    }

                                    // Time Parsing for Range (e.g., "9:00 AM - 11:00 AM")
                                    let startHour = -1;
                                    let endHour = -1;

                                    const timeMatches = scheduleStr.match(/(\d{1,2})(:(\d{2}))?\s*(am|pm)?/gi);

                                    function parseMatch(matchStr) {
                                        const parts = matchStr.match(/(\d{1,2})(:(\d{2}))?\s*(am|pm)?/i);
                                        if (!parts) return -1;
                                        let h = parseInt(parts[1]);
                                        const isPM = (parts[4] && parts[4].toLowerCase() === 'pm') || (h < 8 && !parts[4]);
                                        if (isPM && h < 12) h += 12;
                                        if (!isPM && h === 12) h = 0;
                                        return h;
                                    }

                                    if (timeMatches && timeMatches.length >= 1) {
                                        startHour = parseMatch(timeMatches[0]);
                                        if (timeMatches.length >= 2) {
                                            endHour = parseMatch(timeMatches[1]);
                                        } else {
                                            endHour = startHour + 1; // Default 1 hour duration
                                        }
                                    }

                                    if (startHour === -1 && days.length > 0) {
                                        startHour = 9;
                                        endHour = 10;
                                    }

                                    // Place course in cells for the entire duration
                                    days.forEach(day => {
                                        // Loop through each hour in the range
                                        for (let h = startHour; h < endHour; h++) {
                                            const displayHour = Math.max(8, Math.min(20, h));
                                            const cellId = "cell-" + day + "-" + displayHour;
                                            const cell = document.getElementById(cellId);

                                            if (cell) {
                                                const classBlock = document.createElement('div');
                                                classBlock.className = 'class-block';
                                                classBlock.innerHTML =
                                                    '<div class="class-code">' + course.courseCode + '</div>' +
                                                    '<div class="class-name">' + course.courseName + '</div>';

                                                classBlock.title = course.courseName + '\nSchedule: ' + course.schedule + '\nInstructor: ' + course.instructor;
                                                cell.appendChild(classBlock);
                                            }
                                        }
                                    });
                                });
                            </script>
                        </c:when>
                        <c:otherwise>
                            <!-- Empty State -->
                            <div style="text-align: center; padding: 4rem 2rem; color: var(--text-muted);">
                                <i data-lucide="calendar-x"
                                    style="width: 80px; height: 80px; margin: 0 auto 1.5rem; opacity: 0.3;"></i>
                                <h2 style="margin-bottom: 0.5rem;">No Classes Scheduled</h2>
                                <p>Your timetable will appear here once you enroll in courses.</p>
                                <a href="${pageContext.request.contextPath}/enroll-course" class="btn"
                                    style="margin-top: 1rem;">
                                    Browse Courses
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </main>
            </div>
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
            </script>
        </body>

        </html>