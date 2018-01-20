<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>发布家长会</title>
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


  </head>

  <body ontouchstart>
	
	<div class="weui-cells weui-cells_checkbox">
		<div class="weui-panel__hd">发布家长会</div>
		<input type="hidden" id="teacherId"> 
	</div>
	
	<div class="weui-cells">
		  <div class="weui-cell">
			    <div class="weui-cell__hd"><img src=""></div>
			    <div class="weui-cell__bd">
			      <p>开始时间</p>
			    </div> 
						
			    <div class="weui-cell__ft"><input type="text" id='startTime' class="weui-input required" placeholder="请选择开始时间" /></div>
		  </div>
		  <div class="weui-cell">
			    <div class="weui-cell__hd"><img src=""></div>
			    <div class="weui-cell__bd">
			      <p>结束时间</p>
			    </div>
			    <div class="weui-cell__ft"><input type="text" id='endTime' class="weui-input required" placeholder="请选择结束时间" /></div>
		  </div>
		  <div class="weui-cell">
			    <div class="weui-cell__hd"><img src=""></div>
			    <div class="weui-cell__bd">
			      <p>家长会主题</p>
			    </div>
			    <div class="weui-cell__ft"><input type="text" id='theme' class="weui-input required" placeholder="家长会主题" /></div>
		  </div> 
		  
		   <!-- <div class="weui-cells weui-cells_form">  -->
			<div class="weui-cell">
				<div class="weui-cell__bd">
					<textarea id="place" class="weui-textarea" onkeyup="changeNum()"
						placeholder="在这里填写家长会地址。。。" rows="3"></textarea>
						<div class="weui-textarea-counter">
					<span id="wordNum">0</span>/200
				</div>
				</div>
			</div>
	
 
	
   <div class="weui-panel weui-panel_access" id="checkDiv">
   	   <input class="weui-btn weui-btn_primary"  id="publishMeeting" type="button" value="确认发布">
   	   <input class="weui-btn weui-btn_disabled weui-btn_primary"  id="hiddenPublish" type="button" value="发布中"  style="display:none">
   </div> 
    
    
    
    <script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/echarts/echarts.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script>
	
	
	$(function() {
		 $("#startTime,#endTime").datetimePicker();
	})
	
	function changeNum(){
		var content = $("#place").val();
		$("#wordNum").html(content.length)
	}
	
	$(function(){ 
		$("#place").keyup( function(){ 
			var lonval=$("#place").val(); 
			lonlength=lonval.length; 
			if (lonlength>50) { 
				$.alert("输入长度超出限制!"); 
				}
			} );
		})
	
	//发布家长会
	$(function(){
		$("#publishMeeting").click(function(){
			var place=$("#place").val();
			var theme=$("#theme").val();
			var startTime=$("#startTime").val();
			var endTime=$("#endTime").val()
			if (place == "" || place == null||place.length==0) {
				$.alert("你还没有输入家长会召开地址!");
				return false;
			}
			if (place.length>50) {
				$.alert("字数超出限制!");
				return false;
			}
			if (startTime == "" || startTime == null) {
				$.alert("家长会召开时间不能为空!");
				return false;
			}
			if (endTime == "" || endTime == null) {
				$.alert("家长会结束时间不能为空!");
				return false;
			}
			if (theme == "" || theme == null) {
				$.alert("家长会主题不能为空!");
				return false;
			}
			
			 $.confirm({
					title : '',
					text : '确认要发布吗？',
					onOK : function() {
						 $("#publishMeeting").hide();
						   $("#hiddenPublish").show();
						 $.ajax({
								url:"../parentsMeeting/publishPt",
								type:"post",
								data : {
									place:place,
								    startTime:startTime,
								    endTime:endTime,
								    theme:theme
									},
									
								success:function(data){
									if("02" == data.code){
									$.alert("家长会发布成功!");
									window.location.href="../pageSkip/parentsMeeting";	
										
								}
							}
					}); 	
					},
					onCancel : function() {
						return;
					}
				}) 
			
			/*   $("#publishMeeting").hide();
			   $("#hiddenPublish").show();
			 $.ajax({
					url:"../parentsMeeting/publishPt",
					type:"post",
					data : {
						place:place,
					    startTime:startTime,
					    endTime:endTime
						},
						
					success:function(data){
						if("02" == data.code){
						$.alert("家长会发布成功!");
						window.location.href="../pageSkip/parentsMeeting";	
							
					}
				}
		}); 		 */
		 
		});
	})
	
	
	</script>
 </body>
</html>