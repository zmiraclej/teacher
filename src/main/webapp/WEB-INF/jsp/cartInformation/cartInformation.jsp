<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>打卡信息</title>
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
	<div class="weui-panel weui-panel_access">
		<div class="weui-panel__hd">请选择班级</div>
		<div class="weui-panel__bd">
		
		  <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg" id="changeClass">
			<div class="weui-media-box__bd">
			  <!-- <p class="weui-media-box__desc" id="classInfo"></p> -->
			  <h4 class="weui-media-box__title" id="classInfo"></h4>
			  <input type="hidden" id="classNo">
			</div>
		  </a>
		</div>
	  </div>
	  
	 
	<!--  学生列表-->
		<div class="weui-cells weui-cells_checkbox">
		<div class="weui-panel__hd">考勤综合统计数据</div> 
			<div id="cartDetati">
			  <!-- <label class="weui-cell weui-check__label" for="s11">
			    <div class="weui-cell__hd">
			      <input type="checkbox" class="weui-check" name="checkbox1" id="s11" checked="checked">
			      <i class="weui-icon-checked"></i>
			    </div>
			    <div class="weui-cell__bd">
			      <table>
			      	<tr>
			      		<td>1</td>
			      		<td>2</td>
			      		<td>3</td>
			      	</tr>
			      </table>
			    </div>
			  </label>
 -->		  
		  
		  </div>
		  <a href="javascript:void(0);" class="weui-cell weui-cell_link" id="checkId">
		    <div class="weui-cell__bd" id="checkAll">全选</div>
		    <div class="weui-cell__bd" id="checkInvert">反选</div>
		    <div class="weui-cell__bd" id="checkNo">全不选</div>
		  </a>
		</div>

    
    	<div class="weui-panel weui-panel_access" id="checkDiv">
	        <div class="weui-panel__bd">
	          <div class="weui-media-box weui-media-box_text">
	        <input class="weui-btn weui-btn_primary"  id="propelling" type="button" value="推送给班主任">
	         
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
		
		
		
		
		 
		 
		
		 	  		
		 
		 var classList=null;
		 
		 var currentClass=null;

		 //学生选择控件内容,初始时默认为无数据状态
		 var selectClassActions= [ {
		     text: "暂无数据",
		     className: "color-primary"
		   }];

		 		$("#uploadBtn").on("click",function(){
		 			console.log($("#half").css("display"));
		 			if($("#half").css("display") == "none"){
		 				$("#half").popup();
		 			} else {
		 				$.closePopup()
		 			}
		 			
		 			console.log($("#half").css("display"));
		 		});
		 		
		 		
		 	   function initData(){
					$.ajax({
						url:"../cartInformation/searchClassByTeacherId",
						type:"get",
						success:function(data){
							classList=data.data;
							if(classList!=null&&classList.length>0){
								for(var i=0;i<classList.length;i++){
									if(i==0){
										$("#classInfo").text(classList[0].className);	
										$("#classNo").val(classList[0].classNo);
										initCartInformation(classList[0].classNo)
									}
									selectClassActions[i]={			
									 text:classList[i].className,
									 className: "color-primary",
									 onClick:selectClass(i),
								   }
								}
								
								//加载学生选择控件
								$(document).on("click", "#changeClass", function() {
							        $.actions({
							          title: "选择学生",
							          onClose: function() {
							            //console.info("close")
							          },
							          actions: selectClassActions
							        });
							      });
							}
						}
					}) 
			  }
			  	 
		 	   
		 	   	   
		 	   
		 	   $(function(){
		 		  $("#checkDiv").hide();
				$("#checkId").hide(); 
				 $("#cartDetati").html("&nbsp;&nbsp;&nbsp;暂无相关数据");  
		 	   })
		 	   
		 	  function initCartInformation(classNom){
		 		 $.ajax({
						url:"../cartInformation/searchDormBackDelayById",
						type:"get",
						data : {
							classId:classNom
							},
							
						success:function(data){
							if("02" == data.code){
								 $("#cartDetati").html("");
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
		                            
		                            html+='<label class="weui-cell weui-check__label" ><div class="weui-cell__hd"><input type="checkbox" class="weui-check"  id="'+id+'" ><i class="weui-icon-checked"></i></div><div class="weui-cell__bd"><table><tr><td>'+studentNo+'</td><td>'+name+'</td><td>'+checkDate+'</td></tr></table></div></label>';
									
		                            //html+='<label class="weui-cell weui-check__label" ><div class="weui-cell__hd"><input type="checkbox" class="weui-check"  id="'+studentNo+'" checked="checked"><i class="weui-icon-checked"></i></div><div class="weui-cell__bd"><table><tr><td>1</td><td>2</td><td>3</td></tr></table></div></label>';	
									
		                            
									}
									
									 $("#cartDetati").html(html);
								}else{
									 $("#cartDetati").html("");
									 $("#checkDiv").hide();
									 $("#checkId").hide();
									 
								}
							}
							
						}
					}) 
		 	  }	 		 
		 		
		 	 
		 		
		 		
		 		
		 		 		 
		 		 
		 		   //切换班级
		   var selectClass=function (index){
		 	  return function() { 
		 		 currentClass=classList[index];
		 		$("#classInfo").text(currentClass.className);
		 		$("#classNo").val(currentClass.classNo);
				initCartInformation(currentClass.classNo); 
		 		 }
		   }
		 		   
		 //文档加载完毕执行 
			 $(function() {
			 		//解决移动端点击事件延迟
			 	    FastClick.attach(document.body);
			 	    initData();
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
//推送给班主任消息			 
 var str="";				 
$("#propelling").on("click",function(){
	
		 var input=$(".weui-cell__hd>input");
		 if(input.length>0){
			 for(var i=0;i<input.length;i++){
				if(input[i].checked){
					str+=input.eq(i).attr("id")+",";
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
									url:"../cartInformation/informationToHeadTeacher",
									type:"get",
									data : {
										str:str
										},
										
									success:function(data){
										if("02" == data.code){
											var no=$("#classNo").val();
											initCartInformation(no);
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
			 });
	</script>
 </body>
</html>