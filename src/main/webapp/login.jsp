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
            background: linear-gradient(135deg, #93c5fd 0%, #60a5fa 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            width: 100%;
            max-width: 400px;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-header {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
        }

        .login-header h1 {
            font-size: 32px;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .login-header p {
            font-size: 14px;
            opacity: 0.9;
        }

        .login-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
        }

        .login-body {
            padding: 40px 30px;
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

        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: #666;
        }

        .remember-me input[type="checkbox"] {
            margin-right: 8px;
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .forgot-password {
            font-size: 14px;
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
        }

        .forgot-password:hover {
            text-decoration: underline;
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

        @media (max-width: 480px) {
            .login-container {
                border-radius: 15px;
            }

            .login-header {
                padding: 30px 20px;
            }

            .login-header h1 {
                font-size: 26px;
            }

            .login-body {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <div class="login-icon">🚗</div>
            <h1>GaraMan</h1>
            <p>Hệ thống quản lý gara ô tô</p>
        </div>
        
        <div class="login-body">
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
            
            
            <form action="login" method="post">
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
                
                <div class="form-options">
                    <label class="remember-me">
                        <input type="checkbox" name="remember" />
                        Ghi nhớ đăng nhập
                    </label>
                    <a href="#" class="forgot-password">Quên mật khẩu?</a>
                </div>
                
                <button type="submit" class="btn-login">Đăng Nhập</button>
            </form>
            
            <div class="register-link">
                Chưa có tài khoản? <a href="#">Đăng ký ngay</a>
            </div>
            
            <div class="back-to-home">
                <a href="HomePage.jsp" class="btn-home">
                    🏠 Về trang chủ
                </a>
            </div>
        </div>
    </div>
</body>
</html>

