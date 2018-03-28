<?php
	header('content-type:text/html;charset=utf-8');
	$conn=mysql_connect("localhost:7070","root","") or die("数据库连接失败");
	mysql_query("SET NAMES UTF8");
	mysql_select_db("test",$conn);
	
	
?>