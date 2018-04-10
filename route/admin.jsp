<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>
    <title>排考</title>
    <link rel="stylesheet" href="../assets/css/bootstrap-theme.css">
    <link rel="stylesheet" href="../assets/css/bootstrap.css">
    <link rel="stylesheet" href="../assets/css/home.css">
    <link rel="stylesheet" href="../assets/css/aside.css">

</head>
<body>
    <%@  include file="./layout/header.jsp"%>

    <div id="home" class="container">
         <%-- <%@  include file="./layout/aside.jsp"%> --%>
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li class="active"><a href="#">Overview <span class="sr-only">(current)</span></a></li>
                <li><a href="#">Reports</a></li>
                <li><a href="javascript:void(0);" type="0">管理员</a></li>
                <li><a href="#">Export</a></li>
            </ul>
            
        </div>
        <div id="content" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div id="admin">
                <button class="btn btn-default" type="button" data-toggle="modal" data-target="#myModal">添加管理员</button>
                <div class="adminList">
                    <table class="table table-hover">
                        <tbody class="adminTable">
                            <tr><th>管理员名称</th><th>联系方式</th></tr>
                            <tr class="tr">
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">添加管理员</h4>
                </div>
                <div class="modal-body">
                    <form method="post">
                        <div class="form-group">
                            <label for="exampleInputName">管理员名称</label>
                            <input type="email" class="form-control" id="exampleInputName" placeholder="Name">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPhone">联系方式</label>
                            <input type="phone" class="form-control" id="exampleInputPhone" placeholder="Phone">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPhone">权限</label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary addAdmin">添加</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
    <script src="../assets/js/jquery-3.2.1.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="./index.js"></script>
    <script>
        $.ajax({
            type:'get',
            url:"../interface/listAdmin.jsp",
        }).done((data2)=>{
            const result=JSON.parse(data2)
            const {code,data}=result
            if (code=="0000") {
              data.list.forEach((item)=>{
                  console.log(item);
                  let $clone=$(".tr").clone(true);
                  $clone.removeClass("tr").appendTo($(".adminTable"));
                  $clone.find("td").eq(0).html(item.name)
                  $clone.find("td").eq(1).html(item.phone)
              })  
            }
            
        })
        $(".addAdmin").click(function () {
            $.ajax({
                type:'post',
                url:'../interface/addAdmin.jsp',
                data:{
                    name:$("#exampleInputName").val(),
                    phone:$("#exampleInputPhone").val(),
                }
            }).done(data=>{

            })
        })
    </script>
</body>
</html>