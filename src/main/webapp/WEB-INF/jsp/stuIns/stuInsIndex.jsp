<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>学生评分实例</title>
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
	
	<meta name="description" content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
	<link rel="stylesheet" href="../css/common/v-time-style.css">
	<link rel="stylesheet" href="../css/common/weui.min.css">
	<link rel="stylesheet" href="../css/common/jquery-weui.css">
	<link rel="stylesheet" href="../css/common/demos.css">
</head>

  <body ontouchstart>
  	<div id="result" class="weui-panel weui-panel_access">
				
	</div>
	
    <script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/echarts/echarts.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script type="text/javascript">
	$(function() {
		FastClick.attach(document.body);
		$.get("../stuIns/list",function(data,status){
			data = data.data;
			for (var i = 0; i < data.length; i++) {
				var d = data[i];
				var status = "";
				if(d.authResult=='01'){
					status = "已确认";
				}else if(d.authResult=='02'){
					status = "修改确认";
				}else if(d.authResult=='03'){
					status = "作废此条记录";			
				}else if(d.authResult=='04'){
					status = "教师新增记录";
				}else{
					status = "待审核";
				}
				$("#result").append('<a class="weui-cell weui-cell_access" href="../stuIns/detail?id='+d.id+'">'+
					'<div class="weui-cell__bd">'+
					'<p>姓名：'+d.stuName+'</p>'+
					'<p>评分项：'+d.stdName+'</p>'+
					'<p>创建时间：'+d.createTime+'</p>'+
					'<p>审核：'+status+'</p>'+
					'</div>'+
					'<div class="weui-cell__ft">'+
					'</div>'+
					'<div class="weui-panel__hd"></div>'+
					'</a>'+
					'</div>');
			}
		});
	});
	</script>
 </body>
</html>