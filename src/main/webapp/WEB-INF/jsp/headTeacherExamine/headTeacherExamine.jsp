<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>班主任查看信息</title>
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
	
	  
	 
	<!--  学生列表-->
		<div class="weui-cells weui-cells_checkbox">
		<div class="weui-panel__hd">班主任查看考勤异常数据</div> 
			<div id="headTeacherInfo">
			 
		  
		  </div>
		  <a href="javascript:void(0);" class="weui-cell weui-cell_link" id="checkId">
		    <div class="weui-cell__bd" id="checkAll">全选</div>
		    <div class="weui-cell__bd" id="checkInvert">反选</div>
		    <div class="weui-cell__bd" id="checkNo">全不选</div>
		  </a>
		</div>

    
    	<div class="weui-panel weui-panel_access" id="checkDiv">
	        <div class="weui-panel__hd"></div>
	        <div class="weui-panel__bd">
	          <div class="weui-media-box weui-media-box_text">
	        <input class="weui-btn weui-btn_primary"  id="InfoToParents" type="button" value="推送给家长">
	        
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
		$("#uploadBtn").on("click",function(){
			console.log($("#half").css("display"));
			if($("#half").css("display") == "none"){
				$("#half").popup();
			} else {
				$.closePopup()
			}
			
			console.log($("#half").css("display"));
		});
		
		
		
		
		
		 
		 //全选按钮
		 $("#checkAll").on("click",function(){
			 var input=$(".weui-cell__hd>input");	
				 if(input.length>0){
					for(var i=0;i<input.length;i++){
						input[i].checked = true;
					}
				} 
			});
	 //全不选按钮
		 $("#checkNo").on("click",function(){
			 var input=$(".weui-cell__hd>input");	
			 if(input.length>0){
				for(var i=0;i<input.length;i++){
					input[i].checked = false;
				}
			} 
			});
		 //反选按钮
		 $("#checkInvert").on("click",function(){
			 var input=$(".weui-cell__hd>input");		
			 if(input.length>0){
					for(var i=0;i<input.length;i++){
					if(input[i].checked){
						input[i].checked= false;
					}else{
						input[i].checked= true;
					}
					}
				} 
				
				
		});		 
	
		 
		//推送消息给家长			 
	var str="";	 	  		
	$(function(){
		$("#InfoToParents").on("click",function(){
			str="";
			 var input=$(".weui-cell__hd>input");
			 if(input.length>0){
				 for(var i=0;i<input.length;i++){
					if(input[i].checked){
						str+=input.eq(i).attr("id")+",";
						console.info(str);
					}
				 }
				
				 if(str==null||""==str){
					 $.alert("你没有选择需要推送的选项");
					 return;
				 }else{
					 $.confirm({
							title : '',
							text : '确认要推送吗？',
							onOK : function() {
								 $.ajax({
										url:"../cartInformation/informationToHouseholder",
										type:"post",
										data : {
											str:str
											},
											
										success:function(data){
											if("02" == data.code){
												headTeacherSearchDormBackDelay();
											}
											
										}
									})  	
							},
							onCancel : function() {
								return;
							}
						}) 
				 }
			 }
			
		})
	});	 
	
	
	
	

	//班主任查询异常归寝列表
		headTeacherSearchDormBackDelay();
		function headTeacherSearchDormBackDelay(){
		 $.ajax({
				url:"../cartInformation/headTeacherSearchDormBackDelay",
				type:"get",
				data : {
					
					},
					
				success:function(data){
					if("02" == data.code){
						
						 $("#headTeacherInfo").html("");
							var list=data.data;
							if(list!=null&&list.length>0){
								 $("#checkId").show();
								 $("#checkDiv").show();
							var html="";
								for(var i=0;i<list.length;i++){
								var cartInformation=list[i];
								var studentNo=cartInformation.studentNo;
								var name=cartInformation.name;
								var id=cartInformation.id;
								var checkDate=cartInformation.checkDate;
								checkDate=checkDate.substring(0,checkDate.length-2);
	                            
	                            html+='<label class="weui-cell weui-check__label" ><div class="weui-cell__hd"><input type="checkbox" class="weui-check" id="'+id+'"><i class="weui-icon-checked"></i></div><div class="weui-cell__bd"><table><tr><td>'+studentNo+'</td><td>'+name+'</td><td>'+checkDate+'</td></tr></table></div></label>';
								}
								
								 $("#headTeacherInfo").html(html);
							}else{
								 $("#headTeacherInfo").html("");
								 $("#checkDiv").hide();
								 $("#checkId").hide();
								
								 
								 
							}
					}
					
				}
			})  	
		
	}

	</script>
 </body>
</html>