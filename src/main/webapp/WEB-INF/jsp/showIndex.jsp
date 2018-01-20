<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>教务工作台</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">

<meta name="description"
	content="Write an awesome description for your new site here. You can edit this line in _config.yml.
It will appear in your document head meta (for Google search results) and in your feed.xml site description.">

<link rel="stylesheet" href="css/common/weui.min.css">
<link rel="stylesheet" href="css/common/jquery-weui.min.css">
<link rel="stylesheet" href="css/common/demos.css">

</head>
<body ontouchstart>
    <header class='demos-header'>
      <h1 class="demos-title">教务工作台</h1>
    </header>
      
	<!-- 来访登记 -->
	<a href="pageSkip/visitor/list" class="weui-grid js_grid">
		<div class="weui-grid__icon">
			<img src="img/laifangdengji.png" alt="">
		</div>
		<p class="weui-grid__label">来访登记</p>
	</a>

	<!-- 请假登记 -->
	<a href="pageSkip/leave/list" class="weui-grid js_grid">
		<div class="weui-grid__icon">
			<img src="img/qinjiadengji.png" alt="">
		</div>
		<p class="weui-grid__label">请假登记</p>
	</a>

<!-- 	<a href="pageSkip/cartInformation" class="weui-grid js_grid">
		<div class="weui-grid__icon">
			<img src="img/shushe.png" alt="">
		</div>
		<p class="weui-grid__label">宿舍归寝(生辅老师)</p>
	</a> -->
	
	<a href="pageSkip/headTeacherExamine" class="weui-grid js_grid">
		<div class="weui-grid__icon">
			<img src="img/shushe.png" alt="">
		</div>
		<p class="weui-grid__label">宿舍归寝</p>
	</a>

	<a href="pageSkip/parentsMeeting" class="weui-grid js_grid">
		<div class="weui-grid__icon">
			<img src="img/jiazhanghui.png" alt="">
		</div>
		<p class="weui-grid__label">家长会</p>
	</a>
	</div>
	
	<a href="pageSkip/toParentAddressBook" class="weui-grid js_grid">
		<div class="weui-grid__icon">
			<img src="img/tongxunlu1.png" alt="">
		</div>
		<p class="weui-grid__label">家长通讯录</p>
	</a>
	
	<a href="notice/index" class="weui-grid js_grid">
		<div class="weui-grid__icon">
			<img src="img/tongzhi.png" alt="">
		</div>
		<p class="weui-grid__label">通知</p>
	</a>
	

	
		<!-- 发布班级圈 pageSkip/classCircleIndex-->
  <!--   <a href="javascript:void(0)" class="weui-grid js_grid">
		<div class="weui-grid__icon">
			<img src="img/banjiquan.png" alt="">
		</div>
		<p class="weui-grid__label">发布班级圈</p>
	</a> -->
	</div>
	
	<c:if test="${wtrj_ecom_teacher_user.blHeadTeacher=='1'}">
	    <a href="pageSkip/paymentSummary" class="weui-grid js_grid">
			<div class="weui-grid__icon">
				<img src="img/jiaofei.png" alt="">
			</div>
			<p class="weui-grid__label">班级缴费查询</p>
		</a>
		</div>
	</c:if>
    <a href="pageSkip/toScore" class="weui-grid js_grid">
		<div class="weui-grid__icon">
			<img src="img/Pie_Chart_127.77892918826px_1154205_easyicon.net.png" alt="">
		</div>
		<p class="weui-grid__label">成绩分析</p>
	</a>
    <a href="pageSkip/toTeacherAddressBook" class="weui-grid js_grid">
		<div class="weui-grid__icon">
			<img src="img/tongxunlu1.png" alt="">
		</div>
		<p class="weui-grid__label">教师通讯录</p>
	</a>

	<script src="js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="js/fastclick.js"></script>
	<script>
		$(function() {
			FastClick.attach(document.body);
		});
	</script>
	<script src="js/plugins/jQueryUI/jquery-weui.js"></script>

</body>
</html>