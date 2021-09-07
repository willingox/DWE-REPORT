<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员登录</title>
<link href="h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="h-ui/css/H-ui.login.css" rel="stylesheet" type="text/css" />
<link href="h-ui/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="h-ui/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="h-ui/js/H-ui.js"></script>
<script type="text/javascript"
	src="h-ui/lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/sha1.js"></script>
<script type="text/javascript">
	$(function() {
		//登录
		$("#submitBtn").click(function() {
			//var data = $("#form").serialize();
			var uname = $("#username").val();
			var upwd = $("#pwd").val();
			var shapwd = hex_sha1(upwd);
			$.ajax({
				type : "post",
				url : "login",
				data : {
					"username" : uname,
					"password" : shapwd,
				},
				dataType : "json", //返回数据类型
				success : function(data) {
					if ("success" == data.type) {
						window.parent.location.href = "index";
					} else {
						$.messager.alert("消息提醒", data.msg, "warning");
					}
				},
				error : function(data) {
					alert("没有获取到数据！");
				}
			});
		});
	})
</script>
</head>
<body>
	<div class="header" style="padding: 0;">
		<h2
			style="color: white; width: 400px; height: 60px; line-height: 60px; margin: 0 0 0 30px; padding: 0;">许继风电监控分析系统</h2>
	</div>
	<div class="loginWraper">
		<div id="loginform" class="loginBox">
			<form id="form" class="form form-horizontal" method="post">
				<div class="row cl">
					<label class="form-label col-3"><i class="Hui-iconfont">&#xe60d;</i></label>
					<div class="formControls col-8">
						<input id="username"  type="text" placeholder="账户"
							class="input-text size-L">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-3"><i class="Hui-iconfont">&#xe60e;</i></label>
					<div class="formControls col-8">
						<input id="pwd"  type="password" placeholder="密码"
							class="input-text size-L">
					</div>
				</div>
				<div class="row">
					<div class="formControls col-8 col-offset-3">
						<input id="submitBtn" type="button"
							class="btn btn-success radius size-L"
							value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="footer">许继风电科技所有@2020</div>
</body>
</html>