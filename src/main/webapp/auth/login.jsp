<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Student Enrollment System</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <script src="https://unpkg.com/lucide@latest"></script>
    </head>

    <body>
        <div class="auth-wrapper">
            <div class="card auth-card">
                <div class="text-center mb-4">
                    <img src="${pageContext.request.contextPath}/images/logo.png" alt="SEMS Logo"
                        style="width: 80px; height: 80px; object-fit: cover; border-radius: 50%; margin-bottom: 1rem;">
                    <h1 style="color: var(--primary); margin-bottom: 0.5rem; font-size: 1.5rem;">SEMS Portal</h1>
                    <p style="color: var(--text-muted)">Welcome back! Please sign in to continue.</p>
                </div>

                <%-- Error Message Handling --%>
                    <% if (request.getAttribute("error") !=null) { %>
                        <div
                            style="background: rgba(239, 68, 68, 0.1); color: #ef4444; padding: 0.75rem; border-radius: var(--radius); margin-bottom: 1.5rem; font-size: 0.875rem; border: 1px solid rgba(239, 68, 68, 0.2);">
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>

                            <form action="${pageContext.request.contextPath}/login" method="post">
                                <div class="form-group">
                                    <label for="username" class="form-label">Email or Username</label>
                                    <input type="text" id="username" name="username" class="form-control"
                                        placeholder="Enter your email or username" required autofocus>
                                </div>

                                <div class="form-group">
                                    <label for="password" class="form-label">Password</label>
                                    <div class="password-wrapper">
                                        <input type="password" id="password" name="password" class="form-control"
                                            placeholder="Enter your password" required>
                                        <button type="button" class="password-toggle"
                                            onclick="togglePassword('password', this)">
                                            <i data-lucide="eye"></i>
                                        </button>
                                    </div>
                                </div>

                                <div
                                    style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; font-size: 0.875rem;">
                                    <label
                                        style="display: flex; align-items: center; gap: 0.5rem; color: var(--text-muted); cursor: pointer;">
                                        <input type="checkbox" name="remember" style="accent-color: var(--primary);">
                                        Remember me
                                    </label>
                                    <a href="#" style="font-size: 0.875rem;">Forgot password?</a>
                                </div>

                                <button type="submit" class="btn w-full">Sign In</button>
                            </form>

                            <div class="mt-4 text-center" style="font-size: 0.875rem; color: var(--text-muted);">
                                Don't have an account? <a href="${pageContext.request.contextPath}/register"
                                    style="font-weight: 500;">Create account</a>
                            </div>
            </div>
        </div>

        <script>
            lucide.createIcons();

            function togglePassword(inputId, button) {
                const input = document.getElementById(inputId);
                const icon = button.querySelector('i');

                if (input.type === 'password') {
                    input.type = 'text';
                    icon.setAttribute('data-lucide', 'eye-off');
                } else {
                    input.type = 'password';
                    icon.setAttribute('data-lucide', 'eye');
                }

                lucide.createIcons();
            }
        </script>
    </body>

    </html>