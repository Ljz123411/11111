<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<link rel="stylesheet" href="../../assets/css/aside.css">
<div class="col-sm-3 col-md-2 sidebar">
    <ul class="nav nav-sidebar">
        <li class="active"><a href="#">Overview <span class="sr-only">(current)</span></a></li>
        <li><a href="#">Reports</a></li>
        <li><a href="javascript:void(0);" type="0">管理员</a></li>
        <li><a href="#">Export</a></li>
    </ul>
    
</div>
<script src="../../assets/js/jquery-3.2.1.js"></script>
<script>
    $(".nav-sidebar").click(function (e) {
        let type=e.target.getAttribute("type");

        $(this).change(e);
    });
</script>