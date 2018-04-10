<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<link rel="stylesheet" href="../assets/css/header.css">
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#">排考系统</a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
        <div class="nav navbar-nav navbar-right">
            <div class="dropdown">
                <div class="header-nav-right dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                    个人中心
                    <span class="caret"></span>
                </div>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                    <li><a href="#">Action</a></li>
                    <li><a href="#">Another action</a></li>
                    <li onClick="logout()">注销</li>
                </ul>
                </div>
        </div>

    </div>
    </div>
</nav>
<script>
    function logout() {
        localStorage.removeItem("id");
        location.href="../index.jsp";
    }
</script>