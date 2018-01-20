<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>均分统计</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="../js/plugins/bootstrap/css/bootstrap.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="../css/ionicons/ionicons.min.css">
<!-- Theme style -->
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css">
<link rel="stylesheet" href="../js/plugins/layui/css/layui.css">

<link href="../css/myCss.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="../css/common/v-time-style.css"">
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet" href="../css/common/syllabus.css">
<!-- jQuery 2.2.3 -->
<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
</head>

<body>

		<div class="weui-panel weui-panel_access">
	        <div class="weui-panel__hd">考试成绩均分统计分析</div>
	        <div class="weui-panel__bd">
	          <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
	            <div class="weui-media-box__bd" id="examSelect">
	               <input class="weui-input" id="kaoshiIns" type="text" value="2016-2017学年初2017级下学期4月月考" readonly="readonly">
	              <p class="weui-media-box__desc" id="examInfo"></p>
	            </div>
	          </a>
	        </div>
	        <div class="weui-panel__bd">
	       		<div style="width:100%;	margin-top:10px;overflow-x:scroll">
				   <div id="junfenTongjiChart" style="height: 400px; width: 550px; margin-top:5px"></div>
				</div>
			</div>
		</div>
				
		   <div class="weui-panel weui-panel_access" id="checkDiv">
		   	   <input  id="backParent" class="weui-btn weui-btn_primary" type="button" value="报表切换：返回上层">
		   </div>

		<div id="studentScore" style="display:none;width:100%;height:100%;">
			<div style="width:200px;height:200px;padding-left:5px;font-size:15px">
				<span id="studentName"><b>陈澎</b> 同学:</span>
				<p style="margin-top:5px">
				你的 <b><font color="green"><span id="subjectName">英语</span></font></b> 优秀,请继续保持。
				</p>
				<p style="margin-top:5px">
				你的 <b><font color="red">听力</font></b> 有待提高。
				</p>
				<p style="margin-top:5px">
				你的 <b><font color="green">语言知识/阅读/写作</font></b> 优秀,请继续保持。
				</p>
				<p style="margin-top:5px">
				你的 <b><font color="green">应用/理解/掌握</font></b> 优秀,请继续保持。
				</p>
			</div>
			<div id="personScoreRadar" style="width:400px;height:100%">
			</div>
		</div>
		
	<!-- ./wrapper -->

	<script src="../js/plugins/bootstrap/js/bootstrap.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="../js/plugins/jQueryUI/jquery-ui.min.js"></script>
	<script type="text/javascript" src="../js/plugins/layer/layer.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script src="../js/plugins//layui/layui.js"></script>
	<!-- 报表js -->
	<script src="../js/plugins/echarts/echarts-all-3.js"></script>
	<script src="../js/pages/score/junfenTongji.js"></script>
</body>
</html>