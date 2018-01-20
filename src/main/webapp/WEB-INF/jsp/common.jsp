<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div class="weui-panel weui-panel_access">
		<div class="weui-panel__hd">学生信息</div>
		<div class="weui-panel__bd">
			<a href="javascript:void(0);" id="changeStudent"
				class="weui-media-box weui-media-box_appmsg">
				<div class="weui-media-box__hd">
					<img class="weui-media-box__thumb" src="../img/stu.png" alt="">
				</div>
				<div class="weui-media-box__bd">
					<h4 id="studentName" class="weui-media-box__title"></h4>
					<p id="studentInfo" class="weui-media-box__desc"></p>
					<p id="currentStudent" hidden="true"></p>
				</div>
			</a>
		</div>
	</div>
</body>
</html>