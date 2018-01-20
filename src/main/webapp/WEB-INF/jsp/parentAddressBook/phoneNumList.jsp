<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>家长通讯录</title>
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
  
  <div class="page__bd">
		        <div class="weui-panel weui-panel_access" id="phoneList">
				    
				    
				    <div id="phoneInfo">
					 <!-- <div class="weui-panel__bd">
					    <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
							<h5 class="weui-media-box__title">张秋米</h5>
						  <p class="weui-media-box__desc">语文</p>
						</div>
						<span class="weui-cell__ft">18302866774</span>
						</a>						
					 </div>			

					<div class="weui-panel__bd">
							<a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
							  <div class="weui-cell__bd">
								<h5 class="weui-media-box__title">周洋</h5>
							  <p class="weui-media-box__desc">数学</p>
							</div>
							<span class="weui-cell__ft">18302866774</span>
							</a>						
						 </div>								 
					

						<div class="weui-panel__bd">
								<a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
								  <div class="weui-cell__bd">
									<h5 class="weui-media-box__title">周洋</h5>
								  <p class="weui-media-box__desc">数学</p>
								</div>
								<span class="weui-cell__ft">18302866774</span>
								</a>						
							 </div> -->
							 
					 </div>								 
				</div>		 				
		   </div>
  
  
  
	<!--  <div class="bd">
      <div class="page__bd">
		<div class="weui-cells__title" id="className"></div>
        <div class="weui-cells" id="phoneInfo">
	        
			  
			  
        </div>
		
	  </div>
   </div> -->
	
	
	

    <script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/echarts/echarts.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script>

	//查询通讯录
	$(function(){
		 $.ajax({
				url:"../phoneNumList/searchParentsPhoneByTeacherId",
				type:"post",
				data : {
					
					},
					
				success:function(data){
					if("02" == data.code){
						 $("#phoneList").html("");
							var list=data.data;
							if( list != null && list.length > 0){
							   var html="";
							   for(var i= 0; i < list.length;i++){
									var cp = list[i];
									html+='<div class="weui-panel__hd">' + cp.className+'</div>';
									
									for (var j = 0; j < cp.length; j++) {
										var pt=cp[j];
										var parentName=pt.parentName;
										var studentName=pt.studentName;
										var phone=pt.phone;
										html+='<div class="weui-panel__bd"><a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg"><div class="weui-cell__bd"><h5 class="weui-media-box__title">'+parentName+'</h5><p class="weui-media-box__desc">'+studentName+'</p></div><span class="weui-cell__ft" style="color:#3cc51f">'+phone+'</span></a></div>';
									}
								}
								
								$("#phoneList").html(html);
							}else{
								 $("#phoneList").html("");
								
							}
					}
					
					 /*  $("#phoneInfo .weui-panel__bd").click(function(){
						var id=$(this).attr("id");
						window.location.href="../pageSkip/toStudentPage?id="+id;
						
					});   */
					
					
				}
			})  	
	});


	//查询班级
	$(function(){
		 $.ajax({
				url:"../phoneNumList/searchClassByTeacherId",
				type:"post",
				data : {
					
					},
					
				success:function(data){
					if("02" == data.code){
						var result=data.data!=null?data.data:"";
							var className=result+"家长通讯录名单";
							$("#className").html(className);
							
					}
				}
			})  	
	});


	
	</script>
 </body>
</html>