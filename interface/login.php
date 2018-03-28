<?php
	header('content-type:text/html;charset="utf-8"');
	require "conn.php";
	if(isset($_POST['username'])){//验证匹配文件不能直接预览。
		$username=$_POST['username'];
		$pwd=md5($_POST['password']);
	}else{
		exit ("非法登录");
	}
//echo $username;
//echo $pwd;

	$query = "select * from admin where username='$username' and password='$pwd'";
	$result = mysql_query($query);
	if (mysql_fetch_array($result)) {//用户名密码正确
		echo true;
		//true输出1
	} else {//用户名密码错误
		echo false;
		//false输出空
	}
?>