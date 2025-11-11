<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GaraMan - Đăng Nhập</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            overflow: hidden;
        }

        .login-container {
            display: flex;
            height: 100vh;
            width: 100%;
        }

        /* Phần bên trái - Logo và branding (60%) */
        .login-left {
            flex: 0 0 60%;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .login-left::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 1px, transparent 1px);
            background-size: 50px 50px;
            animation: backgroundMove 20s linear infinite;
        }

        @keyframes backgroundMove {
            0% {
                transform: translate(0, 0);
            }
            100% {
                transform: translate(50px, 50px);
            }
        }

        .logo-content {
            position: relative;
            z-index: 1;
            text-align: center;
            animation: fadeInUp 0.8s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-icon {
            width: 180px;
            height: 180px;
            margin: 0 auto 30px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 90px;
            backdrop-filter: blur(10px);
            border: 3px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        }

        .logo-content h1 {
            font-size: 56px;
            margin-bottom: 15px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .logo-content p {
            font-size: 20px;
            opacity: 0.95;
            font-weight: 300;
            letter-spacing: 0.5px;
        }

        /* Phần bên phải - Form đăng nhập (40%) */
        .login-right {
            flex: 0 0 40%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
            overflow-y: auto;
        }

        .login-body {
            width: 100%;
            max-width: 450px;
            animation: slideInRight 0.6s ease-out;
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .login-body h2 {
            font-size: 32px;
            margin-bottom: 10px;
            color: #1e293b;
        }

        .login-body .subtitle {
            font-size: 15px;
            color: #64748b;
            margin-bottom: 35px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-group input:focus {
            outline: none;
            border-color: #3b82f6;
            background: white;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .form-group input::placeholder {
            color: #aaa;
        }

        .remember-me {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }

        .remember-me input[type="checkbox"] {
            margin-right: 8px;
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white !important;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.4);
        }
        
        .btn-login:hover {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.5);
        }

        .alert {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .alert-error {
            background-color: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }

        .alert-success {
            background-color: #efe;
            color: #3c3;
            border: 1px solid #cfc;
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            font-size: 14px;
            color: #666;
        }

        .register-link a {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .back-to-home {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
        }

        .btn-home {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #3b82f6;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            padding: 10px 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .btn-home:hover {
            background: #3b82f6;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

    </style>
</head>
<body>
    <div class="login-container">
        <!-- Phần bên trái - Logo và branding -->
        <div class="login-left">
            <div class="logo-content">
                <div class="login-icon">🚗</div>
                <h1>GaraMan</h1>
                <p>Hệ thống quản lý gara ô tô chuyên nghiệp</p>
            </div>
        </div>
        
        <!-- Phần bên phải - Form đăng nhập -->
        <div class="login-right">
            <div class="login-body">
                <h2>Đăng Nhập</h2>
                <p class="subtitle">Chào mừng bạn trở lại! Vui lòng đăng nhập để tiếp tục.</p>
                
                <% 
                    String error = request.getParameter("error");
                    String success = request.getParameter("success");
                    String message = (String) request.getAttribute("message");
                %>
                
                <% if (error != null) { %>
                    <div class="alert alert-error">
                        <% if ("invalid".equals(error)) { %>
                            ❌ Tên đăng nhập hoặc mật khẩu không đúng!
                        <% } else if ("empty".equals(error)) { %>
                            ⚠️ Vui lòng nhập đầy đủ thông tin!
                        <% } else if ("session".equals(error)) { %>
                            ℹ️ Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại!
                        <% } else { %>
                            <%= message != null ? message : "Có lỗi xảy ra!" %>
                        <% } %>
                    </div>
                <% } %>
                
                <form action="../login" method="post">
                    <div class="form-group">
                        <label for="username">Tên đăng nhập</label>
                        <input 
                            type="text" 
                            id="username" 
                            name="username" 
                            placeholder="Nhập tên đăng nhập"
                            required
                            autofocus
                        />
                    </div>
                    
                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input 
                        type="password" 
                        id="password" 
                        name="password" 
                        placeholder="Nhập mật khẩu"
                        required
                    />
                </div>
                
                <label class="remember-me">
                    <input type="checkbox" name="remember" />
                    Ghi nhớ đăng nhập
                </label>
                
                <button type="submit" class="btn-login">Đăng Nhập</button>
                </form>
                
                <div class="register-link">
                    Chưa có tài khoản? <a href="#">Đăng ký ngay</a>
                </div>
                
                <div class="back-to-home">
                    <a href="/" class="btn-home">
                        🏠 Về trang chủ
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

