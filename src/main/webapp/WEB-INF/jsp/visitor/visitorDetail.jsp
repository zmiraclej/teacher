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
<title>来访详情</title>
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/jquery-ui.min.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet"
	href="http://hovertree.com/texiao/jqimg/6/css/bootstrap-grid.min.css">
<link rel="stylesheet"
	href="http://hovertree.com/texiao/jqimg/6/dist/zoomify.min.css">
<link rel="stylesheet"
	href="http://hovertree.com/texiao/jqimg/6/css/style.css">
<style type="text/css">
br {
	margin: 15px;
}
</style>
</head>
<body>
	<div class="weui-navbar">
		<div class="weui-navbar__item">来访记录详情</div>
	</div>
	</br>
	<div class="weui-cells weui-cells_form">
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">访客姓名</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" type="text" disabled="disabled"
					value="${visit.visitorName }">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">访客电话</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" disabled="disabled" type="text"
					value="${visit.visitorPhone }">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">来访时间</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" disabled="disabled" type="text"
					value="${visit.visitTime.substring(0,10)}" />
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">来访事由</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" disabled="disabled" type="textarea"
					value="${visit.remark }">
			</div>
		</div>

		<div class="weui-cell">
			<div class="weui-cell__bd qcode col-md-3 col-xs-3 ">
				<div class="weui-cell__hd">
					<label class="weui-label">访客二维码</label>
				</div>
				<div class="weui-cell__bd">
					<img style="padding-left: 20px;"
						src="http://report.cdwtrj.com:8000/qcode/${qcodeNum}"
						class="img-rounded" alt="">
				</div>
			</div>
		</div>
	</div>
	</br>
	<a href="${pageContext.request.contextPath}/pageSkip/visitor/list"
		class="weui-btn weui-btn_primary">返回</a>
	</br>

	<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script src="http://hovertree.com/texiao/jqimg/6/dist/zoomify.min.js"></script>
	<script type="text/javascript">
		$('.qcode img').zoomify();
	</script>
</body>
</html>