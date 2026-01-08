<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - Student Enrollment System</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
        <div class="auth-wrapper">
            <div class="card auth-card" style="max-width: 500px;">
                <div class="text-center mb-4">
                    <h1 style="color: var(--primary); margin-bottom: 0.5rem;">Create Account</h1>
                    <p style="color: var(--text-muted)">Join the student enrollment portal</p>
                </div>

                <%-- Error Message Handling --%>
                    <% if (request.getAttribute("error") !=null) { %>
                        <div
                            style="background: rgba(239, 68, 68, 0.1); color: #ef4444; padding: 0.75rem; border-radius: var(--radius); margin-bottom: 1.5rem; font-size: 0.875rem; border: 1px solid rgba(239, 68, 68, 0.2);">
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>

                            <form action="${pageContext.request.contextPath}/register" method="post">
                                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                                    <div class="form-group">
                                        <label for="firstName" class="form-label">First Name</label>
                                        <input type="text" id="firstName" name="firstName" class="form-control"
                                            required>
                                    </div>
                                    <div class="form-group">
                                        <label for="lastName" class="form-label">Last Name</label>
                                        <input type="text" id="lastName" name="lastName" class="form-control" required>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="email" class="form-label">Email Address</label>
                                    <input type="email" id="email" name="email" class="form-control"
                                        placeholder="student@student.edu" required>
                                </div>

                                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                                    <div class="form-group">
                                        <label for="password" class="form-label">Password</label>
                                        <input type="password" id="password" name="password" class="form-control"
                                            minlength="6" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                                        <input type="password" id="confirmPassword" name="confirmPassword"
                                            class="form-control" minlength="6" required>
                                    </div>
                                </div>

                                <button type="submit" class="btn w-full mt-4">Create Account</button>
                            </form>

                            <div class="mt-4 text-center" style="font-size: 0.875rem; color: var(--text-muted);">
                                Already have an account? <a href="${pageContext.request.contextPath}/login"
                                    style="font-weight: 500;">Sign In</a>
                            </div>
            </div>
        </div>
    </body>

    </html>