<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>家长会记录详情</title>
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<meta name="description" content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.
">
<link rel="stylesheet" href="../css/common/v-time-style.css"">
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet" href="../css/common/syllabus.css">
<style type="text/css">
br {
	margin: 15px;
}
</style>

  </head>

  <body ontouchstart>
	<input type="hidden" value="${id }" id="meetingId">
	<div class="weui-navbar">
		<div class="weui-navbar__item">家长会记录详情</div>
	</div>
	</br>
	<div class="weui-cells weui-cells_form">
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">教师姓名</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" type="text" disabled="disabled"
				id="teacherName"	value="">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">班级名称</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" disabled="disabled" type="text"
				id="className"	value="">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">家长会主题</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" id="theme" disabled="disabled" type="text" value=""/>
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">家长会时间</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input" disabled="disabled" type="textarea"
				id="mettingDate"	value="">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">家长会地点</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input"  type="textarea"
				id="place"	value="">
			</div>
		</div>
	</div>
	</br>


    <script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/echarts/echarts.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script>

	//查询学生详情
	$(function(){
		var id=$("#meetingId").val();
		 $.ajax({
				url:"../parentsMeeting/searchParentsMeetingById",
				type:"post",
				data : {
					id:id
					},
				success:function(data){
					if("02" == data.code){
					var pt=data.data;
					var id=pt.id;
					var theme=pt.theme;
					var place=pt.place;
					var mettingDate=pt.mettingDate;
					var teacherName=pt.teacherName;
					var className=pt.className;
					
				
					$("#theme").val(theme);
					$("#place").val(place);
					$("#mettingDate").val(mettingDate);
					$("#teacherName").val(teacherName);
					$("#className").val(className);
					}
				}
			})  	
	});


	
	
	 //返回
	 $("#goBack").on("click",function(){
		 window.location.href="../pageSkip/phoneNumList";
		});
	
	
	
	 


	
	</script>
 </body>
</html>