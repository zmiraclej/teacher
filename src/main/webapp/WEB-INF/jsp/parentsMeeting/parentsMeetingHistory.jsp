	
		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>家长会历史记录</title>
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
		
			 	<!--  <label class="weui-cell weui-check__label" >
				 	<div class="weui-cell__bd">
					 	<table>
						 	<tr>
							 	<td>班级名称</td>
							 	<td>班主任姓名</td>
							 	<td>召开地点</td>
							 	<td>召开时间</td>
						 	</tr>
					 	</table>
				 	</div>
			 	</label>
		  <div id="ptInfo">
		  </div> -->
		  <div class="weui-cells" id="">
			  <div class="weui-cell">
			    <div class="weui-cell__hd"><img src=""></div>
			    <div class="weui-cell__bd">
			      召开主题
			    </div>
			    <div class="weui-cell__ft">召开时间</div>
			  </div>
		 </div> 
		 <div id="ptInfo"></div>
	</div>


  <!--  <div class="weui-panel weui-panel_access" id="checkDiv">
   	   <input class="weui-btn weui-btn_primary"  id="publishMeetingUi" type="button" value="发布家长会">
   </div>  -->
    
    <div class="weui-panel weui-panel_access" id="checkDiv">
	        <div class="weui-panel__bd">
	          <div class="weui-media-box weui-media-box_text">
	        <input class="weui-btn weui-btn_primary"  id="publishMeetingUi" type="button" value="发布家长会">
	         
	          </div>
	        </div>
	        <div class="weui-panel__ft">         
	        </div>
	    </div>
    
    
    <script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/echarts/echarts.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script>
		//班主任查询异常归寝列表
		/*$(function(){
			 $.ajax({
					url:"../parentsMeeting/searchPrentsMeetingByTeacherId",
					type:"post",
					data : {
						
						},
						
					success:function(data){
						if("02" == data.code){
							
							 $("#studentInfo").html("");
								var list=data.data;
								if(list!=null&&list.length>0){
									
								var html="";
									for(var i=0;i<list.length;i++){
									var pt=list[i];
									
									var place=pt.place;
									var className=pt.className;
									var mettingDate=pt.mettingDate;
									var teacherName=pt.teacherName;
		                            html+='<label class="weui-cell weui-check__label" ><div class="weui-cell__bd"><table><tr><td>'+className+'</td><td>'+teacherName+'</td><td>'+place+'</td><td>'+mettingDate+'</td></tr></table></div></label>';
									}
									
									 $("#ptInfo").html(html);
								}else{
									 $("#ptInfo").html("");
									
								}
						}
					}
				})  	
		});*/
	
		
		
		$(function(){
			 $.ajax({
					url:"../parentsMeeting/searchPrentsMeetingByTeacherId",
					type:"post",
					data : {
						
						},
						
					success:function(data){
						if("02" == data.code){
							
							 $("#studentInfo").html("");
								var list=data.data;
								if(list!=null&&list.length>0){
									
								var html="";
									for(var i=0;i<list.length;i++){
									var pt=list[i];
									var place=pt.place;
									var className=pt.className;
									var mettingDate=pt.mettingDate;
									var teacherName=pt.teacherName;
									var theme=pt.theme;
									var id=pt.id;
		                            html+=' <div class="weui-cell"><div class="weui-cell__hd"></div><div class="weui-cell__bd"><p id="'+id+'">'+theme+'</p></div><div class="weui-cell__ft">'+mettingDate+'</div></div>';
									}
									 $("#ptInfo").html(html);
								}else{
									 $("#ptInfo").html("");
									
								}
						}
						
					
						
						 $(".weui-cell__bd>p").click(function(){
								var id=$(this).attr("id");
								window.location.href="../pageSkip/parentsMeetingDitail?id="+id;
								
							})  
						
					}
				})  	
		});	
		
		
	
	$(function(){
		$("#publishMeetingUi").click(function(){
			
			window.location.href="../pageSkip/publishParentsMeeting";
		 
		});
	})
	
	
	
	 		
						
	
	</script>
 </body>
</html>