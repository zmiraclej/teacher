<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description"
	content="Write an awesome description for your new site here. You can edit this line in _config.yml.
It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
<title>Insert title here</title>
<base target="_blank" />
<link rel="stylesheet"
	href="http://hovertree.com/texiao/jqimg/6/css/bootstrap-grid.min.css">
<link rel="stylesheet"
	href="http://hovertree.com/texiao/jqimg/6/dist/zoomify.min.css">
<link rel="stylesheet"
	href="http://hovertree.com/texiao/jqimg/6/css/style.css">
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/jquery-ui.min.css">
<link rel="stylesheet" href="../css/common/demos.css">
<style type="text/css">
img {
	text-align: center;
	height: 300px;
	width: 300px;
}
</style>
</head>
<body>
	<div class="weui-cell">
		<div class="weui-cell__bd col-md-3 col-xs-3">
			<div class="weui-cell__hd">
				<div style="font-size: 16">老师，您好，请将以下二维码转发给来访者，供其出入校门使用。</div>
			</div>
			</br>
			<img src="http://report.cdwtrj.com:8000/qcode/${qcodeNum }"
				class="img-rounded" alt="">
		</div>
	</div>

	<script src="http://down.hovertree.com/jquery/jquery-2.2.4.min.js"
		type="text/javascript"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script src="http://hovertree.com/texiao/jqimg/6/dist/zoomify.min.js"></script>
	<script type="text/javascript">
		$('.qcode img').zoomify();
	</script>
</body>
</html>