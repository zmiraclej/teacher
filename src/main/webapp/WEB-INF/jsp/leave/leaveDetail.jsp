<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description"
	content="Write an awesome description for your new site here. You can edit this line in _config.yml.
It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
<title>请假详情</title>
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/jquery-ui.min.css">
<link rel="stylesheet" href="../css/common/demos.css">
<style type="text/css">
br {
	margin: 15px;
}
</style>
</head>
<body>
	<div class="weui-navbar">
		<div class="weui-navbar__item">请假详情</div>
	</div>
	</br>
	<div class="weui-cells weui-cells_form">
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">学生姓名</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" type="text" disabled="disabled"
					value="${leave.studentName }">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">请假类型</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" disabled="disabled" type="text"
					value="${type }">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">开始时间</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" disabled="disabled" type="text" value="${startTime.substring(0,10)}"/>
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">截止时间</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" disabled="disabled" type="text" value="${endTime.substring(0,10)}"/>
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">请假事由</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" disabled="disabled" type="textarea"
					value="${leave.reason }">
			</div>
		</div>
	</div>
	</br>
	<a href="${pageContext.request.contextPath}/pageSkip/leave/list"
		class="weui-btn weui-btn_primary">返回</a>
	</br>

	<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
</body>
</html>