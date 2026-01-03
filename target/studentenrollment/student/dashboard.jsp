<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Dashboard - SEMS</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
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
                        <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="active">
                            Available Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/courses.jsp">
                            My Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/student/profile.jsp">
                            Profile
                        </a>
                    </li>
                </ul>

                <div class="user-profile">
                    <div class="avatar">JS</div>
                    <div>
                        <div style="font-weight: 500;">John Smith</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">Student</div>
                    </div>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <header class="header">
                    <div>
                        <h1>Welcome,
                            <c:out value="${sessionScope.user.name}" default="John Smith" />
                        </h1>
                        <p style="color: var(--text-muted);">Overview of your academic progress</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/auth/logout" class="btn"
                        style="background-color: rgba(239, 68, 68, 0.1); color: #ef4444; display: flex; align-items: center; gap: 0.5rem;">
                        <i data-lucide="log-out" style="width: 16px; height: 16px;"></i>
                        Logout
                    </a>
                </header>

                <!-- Stats Overview -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-label">Enrolled Courses</div>
                        <div class="stat-value">4</div>
                        <div style="color: #10b981; font-size: 0.875rem;">Active term</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-label">Average Grade</div>
                        <div class="stat-value">3.8</div>
                        <div style="color: var(--text-muted); font-size: 0.875rem;">GPA</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-label">Credits Earned</div>
                        <div class="stat-value">12</div>
                        <div style="color: var(--text-muted); font-size: 0.875rem;">Total</div>
                    </div>
                </div>

                <!-- Academic Calendar -->
                <div class="calendar-section">
                    <div class="calendar-header">
                        <h3>📅 Academic Calendar for SEPTEMBER 2025 Semester</h3>
                        <a href="#" class="btn-download">
                            <span>📄</span> Download
                        </a>
                    </div>

                    <table class="calendar-table">
                        <thead>
                            <tr>
                                <th style="width: 50px;">No</th>
                                <th>Semester Activities</th>
                                <th style="width: 150px;">Start Date</th>
                                <th style="width: 150px;">End Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Subject registration</td>
                                <td>15-09-2025</td>
                                <td>29-09-2025</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Registration of new student</td>
                                <td>18-09-2025</td>
                                <td>19-09-2025</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Orientation for new student</td>
                                <td>18-09-2025</td>
                                <td>19-09-2025</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Lecture session</td>
                                <td>22-09-2025</td>
                                <td>02-11-2025</td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>Add Drop session</td>
                                <td>29-09-2025</td>
                                <td>12-10-2025</td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td>Add Drop session with penalty</td>
                                <td>13-10-2025</td>
                                <td>26-10-2025</td>
                            </tr>
                            <tr>
                                <td>7</td>
                                <td>Mid semester break</td>
                                <td>03-11-2025</td>
                                <td>09-11-2025</td>
                            </tr>
                            <tr>
                                <td>8</td>
                                <td class="text-blue">Lecture session</td>
                                <td class="text-blue">10-11-2025</td>
                                <td class="text-blue">04-01-2026</td>
                            </tr>
                            <tr>
                                <td>9</td>
                                <td class="text-blue">Lecturer Evaluation</td>
                                <td class="text-blue">02-12-2025</td>
                                <td class="text-blue">11-01-2026</td>
                            </tr>
                            <tr>
                                <td>10</td>
                                <td>Study week</td>
                                <td>05-01-2026</td>
                                <td>11-01-2026</td>
                            </tr>
                            <tr>
                                <td>11</td>
                                <td>Final exam</td>
                                <td>12-01-2026</td>
                                <td>23-01-2026</td>
                            </tr>
                            <tr>
                                <td>12</td>
                                <td>Semester break</td>
                                <td>24-01-2026</td>
                                <td>01-02-2026</td>
                            </tr>
                            <tr>
                                <td>13</td>
                                <td>Meeting senate standing committee on examination/results</td>
                                <td>02-02-2026</td>
                                <td>05-02-2026</td>
                            </tr>
                            <tr>
                                <td>14</td>
                                <td>Examination Result Announcement</td>
                                <td>05-02-2026</td>
                                <td>08-02-2026</td>
                            </tr>
                            <!-- Festive Breaks -->
                            <tr class="festive-row">
                                <td colspan="4">FESTIVE BREAKS</td>
                            </tr>
                            <tr>
                                <td>15</td>
                                <td>Malaysia Day</td>
                                <td>16-09-2025</td>
                                <td>16-09-2025</td>
                            </tr>
                            <tr>
                                <td>16</td>
                                <td>DEEPAVALI</td>
                                <td>20-10-2025</td>
                                <td>20-10-2025</td>
                            </tr>
                            <tr>
                                <td>17</td>
                                <td>Sultan of Selangor's Birthday</td>
                                <td>11-12-2025</td>
                                <td>11-12-2025</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </body>

    </html>