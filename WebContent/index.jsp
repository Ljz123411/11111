<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>
    <title>排考</title>
    <link rel="stylesheet" href="./assets/css/bootstrap-theme.css">
    <link rel="stylesheet" href="./assets/css/bootstrap.css">
    <link rel="stylesheet" href="./index.css">
</head>
<body>
    <div class="login">
        <form >
            <div class="form-group">
            <label for="">角色</label>
                <div class="btn-group">
                    <input type="text" class="btn btn-default" id="categoryInp" placeholder="角色"  name="type" value="学生"/>
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="caret"></span>
                  
                    </button>
                    <ul class="dropdown-menu">
                        <li>学生</li>
                        <li>老师</li>
                        <li>管理员</li>
                    </ul>
                    </div>
                </div>
            <div  class="form-group">
                <label for="">账号</label>
                <input type="text" class="form-control" placeholder="请输入学号或工号" name="username" id="username">
            </div>
            <div  class="form-group">
                <label for="">密码</label>
                <input type="text" class="form-control" placeholder="请输入密码" name="password" id="password"> 
            </div>
            <div id="error">登录名或密码错误</div>
            <div class="loginbox">
                <button  class="btn btn-default btn-login" id="login">登录</button>
            </div>
        </form>
    </div>
    <script src="./assets/js/jquery-3.2.1.js"></script>
    <script src="./assets/js/bootstrap.min.js"></script>
    <script>
        $(".dropdown-menu").click(function (e) {
            $("#categoryInp").val(e.target.innerHTML);
        })
        $("#login").click(function (e) {
            e.preventDefault();
            let type=$("#categoryInp").val();
            const username=$("#username").val();
            const password=$("#password").val();
            if (type=="管理员") {
                type=0;
            } else if(type=="老师"){
                type=1
            }else {
                type=2;//学生
            }
            $.ajax({
                type:'post',
                url:'./interface/login.jsp',
                data:{
                    type,
                    username,
                    password,
                },
            }).done((data)=>{
                let result=JSON.parse(data);
                const {code}=result;
                if(code=="0000"){
                    $("#error").hide();
                    localStorage.setItem("id",result.data.id);
                    location.href="./route/home.jsp";
                }else if(code=="0001"){
                    $("#error").show();
                }                
            })
        })
    </script>
</body>
</html>