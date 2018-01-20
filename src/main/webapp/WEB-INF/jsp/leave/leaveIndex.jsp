<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description"
	content="Write an awesome description for your new site here. You can edit this line in _config.yml.
It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
<title>请假登记</title>
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet" href="../css/common/jquery.autocomplete.css" />
<style type="text/css">
label.error {
	color: Red;
	font-size: 13px;
	margin-left: 5px;
	padding-left: 16px;
}

a:hover {
	text-decoration: underline;
	color: #09f;
	font-size: 19px;
}
</style>

</head>
<body>
	<div class="weui-tab__bd">
		<form id="leave" name="leave"
			action="${pageContext.request.contextPath }/leave/save" method="post">
			<input type="hidden" name="token" value="${token}" />
			<div class="weui-cells weui-cells_form">
				<div class="weui-cell weui-cell_select">
					<div class="weui-cell__hd">
						<label for="student" class="weui-label" style="padding-left:15px;padding-bottom:5px;">请假学生</label>
					</div>
					<div class="weui-cell__bd">
						<select id="student" name="studentId" class="weui-select" style="padding-left:0px;">
						</select>
					</div>
				</div>

				<div class="weui-cell weui-cell_select">
					<div class="weui-cell__hd">
						<label for="type"  class="weui-label" style="padding-left:15px;padding-bottom:5px;">请假类型</label>
					</div>
					<div class="weui-cell__bd">
						<select class="weui-select" name="type" style="padding-left:0px;">
							<option selected="" value="01">事假</option>
							<option value="02">病假</option>
							<option value="03">其他</option>
						</select>
					</div>
				</div>
				
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label for="datetime-picker" class="weui-label">开始时间</label>
					</div>
					<div class="weui-cell__bd">
						<input id="start" name="start" type="text"
							class="weui-input required" placeholder="请选择开始时间"
							onfocus="WdatePicker({minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'end\')||\'2100-10-01 00:00\'}',dateFmt:'yyyy年M月d日 HH时mm分'})" />
					</div>
				</div>

				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label for="end" class="weui-label">截止时间</label>
					</div>
					<div class="weui-cell__bd">
						<input id="end" name="end" type="text"
							class="weui-input required" placeholder="请选择截止时间"
							onFocus="WdatePicker({minDate:'#F{$dp.$D(\'start\',{H:+1})}',maxDate:'2100-10-01 00:00',dateFmt:'yyyy年M月d日 HH时mm分'})" />
					</div>
				</div>

				<div class="weui-cell">
					<div class="weui-cell__bd">
						<textarea id="reason" name="reason"
							class="weui-textarea" placeholder="请输入请假事由" rows="3"></textarea>
						<div class="weui-textarea-counter">
							<span>0</span>/200
						</div>
					</div>
				</div>
			</div>
			<input class="weui-btn weui-btn_primary" type="submit" value="提交登记">
		</form>
	</div>


	<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/plugins/jQuery/jquery.validate.js"></script>
	<script src="../js/plugins/jQuery/jquery.validate.extend.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script src="../js/plugins/My97DatePicker/WdatePicker.js"></script>
	<script
		src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
	<script>
		$(function(){
			$.get("${pageContext.request.contextPath}/leave/students",function(data,status){
				for(var i=0;i<data.length;i++){
					$("#student").append('<option value="'+data[i].id+'">'+data[i].name+'</option>');
				}
			});
			
			 $("#datetime-picker").datetimePicker();
			
			$("#leave").validate({
				messages : {
					studentId : {
						required : "学生姓名不能为空",
					},
					type : {
						required : "请假类型不能为空"
					},
					start: {
						required : "开始时间不能为空"
					},
					end : {
						required : "截止时间不能为空"
					}
				},
				errorPlacement : function(error, element) {
					if (element.is("input"))
						error.appendTo(element.parent().parent());
				}
			});
		})
	</script>
</body>
</html>