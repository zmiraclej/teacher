<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>教师通讯录</title>
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<meta name="description" content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.
">
<link rel="stylesheet" href="../css/common/v-time-style.css"">
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<style>
	.weui-cell:before{
		border-top:0px;
	}
	.weui-cells:after {
		border-top:0px;
		border-bottom:0px;
	}
</style>
  </head>

  <body ontouchstart>
  
        <div class="weui-panel weui-panel_access">
			<div class="weui-panel__hd">当前用户信息</div>
			<div class="weui-panel__bd">
			  <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
				<div class="weui-media-box__hd">
				  <img class="weui-media-box__thumb" style="border-radius:50%"  height="120" width="120" src="../img/stu.png" alt="" id="photo">
				</div>
				<div class="weui-media-box__bd">
				  <h4 class="weui-media-box__title" id="studentName">刘老师</h4>
				  <p class="weui-media-box__desc" id="stInfo">锦江初中一年级二班 班主任</p>
				</div>
			  </a>
			</div>
		  </div>
	    <div class="weui-panel weui-panel_access">
	      	    <div class="page__bd">
		        <div class="weui-panel weui-panel_access">
				    <div class="weui-panel__hd">锦江初中一年级班主任</div>
					 <div class="weui-panel__bd" id="headTeacherInfo">
					    <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
							<span style="font-size:12px;color:gray">一年级一班</span>&nbsp;<span class="weui-media-box__title">胡晓林</span>							
						  </div>
						  <span class="weui-cell__ft">13982057818</span>
						</a>						
					 </div>		
					 <div class="weui-panel__bd" id="headTeacherInfo">
					    <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
							<span style="font-size:12px;color:gray">一年级二班</span>&nbsp;<span class="weui-media-box__title">郑伟</span>							
						  </div>
						  <span class="weui-cell__ft">18080902180</span>
						</a>						
					 </div>			
					 <div class="weui-panel__bd" id="headTeacherInfo">
					    <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
						    <span style="font-size:12px;color:gray">一年级三班</span>&nbsp;<span class="weui-media-box__title">庞吉敏</span>							
						  </div>
						  <span class="weui-cell__ft">18608003317</span>
						</a>						
					 </div>	
					<div class="weui-panel__bd" id="headTeacherInfo">
					    <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
						    <span style="font-size:12px;color:gray">一年级四班</span>&nbsp;<span class="weui-media-box__title">王垒</span>							
						  </div>
						  <span class="weui-cell__ft">15884419396</span>
						</a>						
					 </div>
					<div class="weui-panel__bd" id="headTeacherInfo">
					    <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
						    <span style="font-size:12px;color:gray">一年级五班</span>&nbsp;<span class="weui-media-box__title">刘松</span>							
						  </div>
						  <span class="weui-cell__ft">13778321910</span>
						</a>						
					 </div>	
					 <div class="weui-panel__bd" id="headTeacherInfo">
					    <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
						    <span style="font-size:12px;color:gray">一年级六班</span>&nbsp;<span class="weui-media-box__title">杨健</span>							
						  </div>
						  <span class="weui-cell__ft">18382177210</span>
						</a>						
					 </div>						  
				</div>		   
		   </div>
	    </div>

  
	  <div class="weui-panel weui-panel_access">
	      	    <div class="page__bd">
		        <div class="weui-panel weui-panel_access">
				    <div class="weui-panel__hd">锦江初中一年级任课老师</div>
					 	
					 <div class="weui-panel__bd" id="headTeacherInfo">
					    <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
						    <span style="font-size:12px;color:gray">英语</span>&nbsp;<span class="weui-media-box__title">庞吉敏</span>							
						  </div>
						  <span class="weui-cell__ft">18608003317</span>
						</a>						
					 </div>	
					<div class="weui-panel__bd" id="headTeacherInfo">
					    <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
						    <span style="font-size:12px;color:gray">物理</span>&nbsp;<span class="weui-media-box__title">王垒</span>							
						  </div>
						  <span class="weui-cell__ft">15884419396</span>
						</a>						
					 </div>
					<div class="weui-panel__bd" id="headTeacherInfo">
					    <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
						    <span style="font-size:12px;color:gray">化学</span>&nbsp;<span class="weui-media-box__title">刘松</span>							
						  </div>
						  <span class="weui-cell__ft">13778321910</span>
						</a>						
					 </div>	
					 <div class="weui-panel__bd" id="headTeacherInfo">
					    <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
						    <span style="font-size:12px;color:gray">体育</span>&nbsp;<span class="weui-media-box__title">杨健</span>							
						  </div>
						  <span class="weui-cell__ft">18382177210</span>
						</a>						
					 </div>	
					 <div class="weui-panel__bd" id="headTeacherInfo">
					    <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
							<span style="font-size:12px;color:gray">语文</span>&nbsp;<span class="weui-media-box__title">胡晓林</span>							
						  </div>
						  <span class="weui-cell__ft">13982057818</span>
						</a>						
					 </div>		
					 <div class="weui-panel__bd" id="headTeacherInfo">
					    <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
						  <div class="weui-cell__bd">
							<span style="font-size:12px;color:gray">数学</span>&nbsp;<span class="weui-media-box__title">郑伟</span>							
						  </div>
						  <span class="weui-cell__ft">18080902180</span>
						</a>						
					 </div>							  
				</div>		   
		   </div>
	    </div>
   
        <div class="weui-panel weui-panel_access">
		    <div class="weui-panel__hd">锦江初中一年级生辅老师</div>
			 <div class="weui-panel__bd" id="dormTeacherInfo">
			   <a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
				  <div class="weui-cell__bd">
				    <span style="font-size:12px;color:gray">初一、男生</span>&nbsp;<span class="weui-media-box__title">赵建</span>							
				  </div>
				  <span class="weui-cell__ft">18608003317</span>
				</a>	
				<a href="toTeacherArchive" class="weui-media-box weui-media-box_appmsg">
				  <div class="weui-cell__bd">
				    <span style="font-size:12px;color:gray">初一、女生</span>&nbsp;<span class="weui-media-box__title">兰新</span>							
				  </div>
				  <span class="weui-cell__ft">15308197361</span>
				</a>							
			 </div>			
   		</div>
    <script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/echarts/echarts.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script>

	
	
	 $(function() {
		    FastClick.attach(document.body);
		    initData();
		  });
	
	//学生列表
	 var childrenList=null;
	 //当前选中的学生
	 var currentStudent=null;

	 //学生选择控件内容,初始时默认为无数据状态
	 var selectStudentActions= [ {
	     text: "暂无数据",
	     className: "color-primary"
	   }];
	   	
	 

	   function initData(){
			//初始化学生数据
			$.ajax({
				url:"../common/initStudentInfo",
				type:"get",
				success:function(data){
					currentStudent=data.currentStudent;
					//无所选学生，直接结束，不加载相关选择插件
					if(currentStudent==null){
						$("#studentName").text("暂无");
						return;
					}else{
						//如果存在学生，加载学生信息
						$("#studentName").text(currentStudent.name);

						var gradeNo=currentStudent.gradeNo!=null?currentStudent.gradeNo:" ";
						var classNo=currentStudent.classNo!=null?currentStudent.classNo:" ";
						var classInfo=gradeNo+"年级"+classNo+"班";
						$("#stInfo").text(classInfo);
						//$("#studentId").val(currentStudent.id);
						
						if(currentStudent.photo!=null){
							$("#photo").attr("src",currentStudent.photo);
						}else{
							$("#photo").attr("src","../img/stu.png");
						}
						
						//调用基本档案数据
						//baseDocument(currentStudent.id);
						//dailyActive(currentStudent.studentNo);
						searchSubjectTeacher(currentStudent.id);
						searchHeadTeacher(currentStudent.id);
						searchDormTeacher(currentStudent.id);
					}
					//如果存在学生列表，加载学生列表	
					if(data.childrenList!=null&&data.childrenList.length>0){
						//把后台传来的学生集合在页面中保存起来
						childrenList=data.childrenList;
						//设置可选学生
						for(var i=0;i<childrenList.length;i++){
							 selectStudentActions[i]={			
							 text:childrenList[i].name,
							 className: "color-primary",
							//点击时触发选择学生的方法，传入索引，直接从children获取学生信息
							 onClick:selectStudent(i),
						   }
						}
						
						//加载学生选择控件
						$(document).on("click", "#changeStudent", function() {
					        $.actions({
					          title: "选择学生",
					          onClose: function() {
					            //console.info("close")
					          },
					          actions: selectStudentActions
					        });
					      });
					}
				}
			}) 
	  }
	 	 
	$(function(){
		$("#goBack").click(function(){
			
			window.history.back();	
		})
		});
		

	//查询班主任通讯录
	function searchHeadTeacher(i){
		 $.ajax({
				url:"../teacherPhoneNumList/searchHeadTeacherPhoneByParentId",
				type:"post",
				data : {
					id:i
					},
				success:function(data){
					if("02" == data.code){
						 $("#headTeacherInfo").html("");
							var list=data.data;
							if(list!=null&&list.length>0){
							var html="";
								for(var i=0;i<list.length;i++){
								var pt=list[i];
								var teacherName=pt.teacherName;
								var phone=pt.teacherPhone;
							
								
							
									
								
	                            html+='<div class="weui-cell"><div class="weui-cell__bd"><p id="">'+teacherName+'</p></div><div class="weui-cell__ft">'+phone+'</div></div>';
								}
								
								 $("#headTeacherInfo").html(html);
							}else{
								 $("#headTeacherInfo").html("&nbsp;&nbsp;&nbsp;暂无信息");
							}
					}
				}
			})  	
	}
	//查询生辅老师通讯录
	function searchDormTeacher(i){
		 $.ajax({
				url:"../teacherPhoneNumList/searchDormTeacherPhoneByParentId",
				type:"post",
				data : {
					id:i
					},
				success:function(data){
					if("02" == data.code){
						 $("#dormTeacherInfo").html("");
							var list=data.data;
							if(list!=null&&list.length>0){
							var html="";
								for(var i=0;i<list.length;i++){
								var pt=list[i];
								var teacherName=pt.teacherName;
								var phone=pt.teacherPhone;
								
	                          html+='<a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg"><div class="weui-cell__bd"><h5 class="weui-media-box__title">'+teacherName+'</h5></div><span class="weui-cell__ft">'+phone+'</span></a>';
	  						
								
								}
								
								 $("#dormTeacherInfo").html(html);
							}else{
								 $("#dormTeacherInfo").html("&nbsp;&nbsp;&nbsp;暂无信息");
							}
					}
				}
			})  	
	}
	//查询科任老师通讯录
function searchSubjectTeacher(i){
		 $.ajax({
				url:"../teacherPhoneNumList/searchSubjectTeacherPhoneByParentId",
				type:"post",
				data : {
					id:i
					},
				success:function(data){
					if("02" == data.code){
						 $("#subjectTeacherInfo").html("");
							var list=data.data;
							if(list!=null&&list.length>0){
							var html="";
								for(var i=0;i<list.length;i++){
								var pt=list[i];
								var teacherName=pt.teacherName;
								var phone=pt.teacherPhone;
								var teachName=pt.teachName;
								
								
								 html+='<div class="weui-panel__bd"><a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg"><div class="weui-cell__bd"><h5 class="weui-media-box__title">'+teacherName+'</h5><p class="weui-media-box__desc">'+teachName+'</p></div><span class="weui-cell__ft">'+phone+'</span></a></div>';
								
								}
								
								 $("#subjectTeacherInfo").html(html);
							}else{
								 $("#subjectTeacherInfo").html("&nbsp;&nbsp;&nbsp;暂无信息");
							}
					}
				}
			})  	
	}


   //切换学生
   var selectStudent=function (index){
	  return function() { 
		  currentStudent=childrenList[index];
		 if(currentStudent.gradeNo==null){
			 currentStudent.gradeNo==0; 
		 }
		 if(currentStudent.classNo==null){
			 currentStudent.classNo==0; 
		 }
		  var classInfo=currentStudent.gradeNo+"年级"+currentStudent.classNo+"班";
			$("#studentName").text(currentStudent.name);
			$("#stInfo").text(classInfo);
			if(currentStudent.photo!=null){
				$("#photo").attr("src",currentStudent.photo);
			}else{
				$("#photo").attr("src","../img/stu.png");
			}
			
			searchSubjectTeacher(currentStudent.id);
			searchHeadTeacher(currentStudent.id);
			searchDormTeacher(currentStudent.id);
			
		 }
    }

	
	</script>
 </body>
</html>