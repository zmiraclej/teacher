<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>通知人员选择</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet" href="../js/webuploader/webuploader.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="../css/common/tab.css">
<link rel="stylesheet" href="../css/common/notice.css">
<style type="text/css">
    
	.subject_columns {
		column-count: 2;
		column-gap: 1px;
	}
	
	.two_columns {
		column-count: 2;
		column-gap: 10px;
	}
	.two_columns>div{
		padding-left:10px
	}
	
	.ui-accordion .ui-accordion-content {
	    padding: 0em 0.2em;
	    border-top: 0;
	    overflow: auto;
	}
	
	#st1>div>span {
		padding-left:10px;
	}
	
	
</style>

</head>
<body ontouchstart>
   	<div class="content-area">
   	     <div style='background-color:#f8f8f8;padding:10px 5px;font-size:14px;'><span>设置筛选条件选择通知接收教师</span></div>
   	     <div class="accordion" style="margin-top:5px">
			<span style="font-size:14px">教师分组</span>
			 <div class="weui-cells weui-cells_checkbox">
					<div class="weui-cell">
					        <label class="weui-cell__bd weui-check__label" for="role1">
					        	<input type="checkbox" name="roleInput" class="weui-check role_select" id="role1"  value="1">
					            <i class="weui-icon-checked"></i>班主任
					        </label>
				       </div>
  				       	   <div class="weui-cell">
					        <label class="weui-cell__bd weui-check__label" for="role2">
					        	<input type="checkbox" name="roleInput" class="weui-check role_select" id="role2"  value="2">
					            <i class="weui-icon-checked"></i>任课老师
					        </label>
				       </div>
				       <div class="weui-cell">
					        <label class="weui-cell__bd weui-check__label" for="role3">
					        	<input type="checkbox" name="roleInput" class="weui-check role_select" id="role3"  value="3">
					            <i class="weui-icon-checked"></i>生辅老师
					        </label>
				       </div>
				       <div class="weui-cell">
					        <label class="weui-cell__bd weui-check__label" for="role4">
					        	<input type="checkbox" name="roleInput" class="weui-check role_select" id="role4"  value="4">
					            <i class="weui-icon-checked"></i>备课组长
					        </label>
				       </div>
				       <div class="weui-cell">
					        <label class="weui-cell__bd weui-check__label" for="role5">
					        	<input type="checkbox" name="roleInput" class="weui-check role_select" id="role5"  value="5">
					            <i class="weui-icon-checked"></i>年级组长
					        </label>
				       </div>
				       <div class="weui-cell">
					        <label class="weui-cell__bd weui-check__label" for="role6">
					        	<input type="checkbox" name="roleInput" class="weui-check role_select" id="role6"  value="6">
					            <i class="weui-icon-checked"></i>教研组长
					        </label>
				       </div>
				       <div class="weui-cell">
					        <label class="weui-cell__bd weui-check__label" for="role7">
					        	<input type="checkbox" name="roleInput" class="weui-check role_select" id="role7"  value="7">
					            <i class="weui-icon-checked"></i>德育老师
					        </label>
				       </div>
				       <div class="weui-cell">
					        <label class="weui-cell__bd weui-check__label" for="role101">
					        	<input type="checkbox" name="roleInput" class="weui-check role_select" id="role101"  value="101">
					            <i class="weui-icon-checked"></i>学部领导
					        </label>
				       </div>
				</dv>
			 </div>
			
			<span style="font-size:14px">年级选择</span>
			<div class="weui-cells weui-cells_checkbox">
					<c:forEach items="${array}" var="arr">
					      <div class="weui-cell">
						      <div class="weui-cell__bd">
						          <p>${arr.schoolName}</p>
						       </div>
					       </div>
					       <c:forEach items="${arr.grades}" var="item">
					       		 <div class="weui-cell">
							        <label class="weui-cell__bd weui-check__label" for="${item.gradeKeyNo}">
							        	<input type="checkbox" name="gradeInput" class="weui-check grade_select" id="${item.gradeKeyNo}"  value="${item.gradeKeyNo}">
							            <i class="weui-icon-checked"></i>${item.dispayName}
							        </label>
							        <a class="weui-cell weui-cell_access" name="gradeSelect" href="javascript:;">
							        	<input type="hidden" name="hideSchoolCode" value="${item.schoolCode}">
							        	<input type="hidden" name="hideStage" value="${item.stage}">
							        	<input type="hidden" name="hideGrade" value="${item.grade}">
							           <label class="weui-cell__ft">
							           </label>
							          </a>
							      </div>
					       
					       </c:forEach>
				  </c:forEach>
				</dv>
			 </div>
			 
			  <h3>科目选择</h3>
			  <div class="subject_columns" style="width:100%; margin-bottom:60px;display:inline-block">
	       		<div class="weui-cells weui-cells_checkbox">
						<c:forEach items="${courses}" var="item"  begin="0" step="2">
				       		 <div class="weui-cell">
						        <label class="weui-cell__bd weui-check__label" for="${item.code}">
						        	<input type="checkbox" name="courseInput" class="weui-check course_select" id="${item.code}"  value="${item.code}">
						            <i class="weui-icon-checked"></i>${item.name}
						        </label>
						      </div>
				       </c:forEach>
	       		</div>
	       		<div class="weui-cells weui-cells_checkbox">
	       		 		<c:forEach items="${courses}" var="item"  begin="1" step="2">
				       		 <div class="weui-cell">
						        <label class="weui-cell__bd weui-check__label" for="${item.code}">
						        	<input type="checkbox" name="courseInput" class="weui-check course_select" id="${item.code}"  value="${item.code}">
						            <i class="weui-icon-checked"></i>${item.name}
						        </label>
						      </div>
				       </c:forEach>
	       		</div>
      		 </div>
		 </div>
		 
		 <div style="margin-top:10px;margin-bottom:50px">
 	      	<div style='background-color:#f8f8f8;padding:5px'>
 	      		<span>当前所选教师名单</span>
 	      		<a href="#" id="createGroupBtn" class="ref-btn" style="width:140px;float:right;margin-right:10px;background:transparent;">添加到自定义分组</a>
 	      	</div>
 	      	<div class="two_columns"><div><span style="margin-left:15px;color:#707070">可选人数</span><span id="totalNum" style="margin-left:15px;font-size:30px;color:#DAA520">0</span></div><div><span style="color:#707070">已选人数</span><span id="selectedNum" style="margin-left:15px;font-size:30px;color:green">0</span></div></div>
 	      	<div class="two_columns" id="selectedTeachers">
 	      		<div id="st1"></div>
 	      		<div id="st2"></div>
 	      	</div>
	      </div>
    </div>
    
    <div class="controlbar">
          <ul>
              <li>
                  <a href="javascript:void(0);" id="commit">
                      <i class="icon icon-wegene-2"></i>
                      <span>返回</span>
                  </a>
              </li>
              <li  class="active">
                  <a href="javascript:void(0);">
                      <i class="icon icon-wegene-2"></i>
                      <span>筛选人员</span>
                  </a>
              </li>

              <li>
                  <a href="../teacherNotice/toTeacherGroup">
                      <i class="icon icon-cart"></i>
                      <span>自定义分组</span>
                  </a>
              </li>
          </ul>
      </div>
    
      <input type="hidden" id="psId" value="${tempNoticeId}">
<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../js/fastclick.js"></script>
<script src="../js/plugins/echarts/echarts.js"></script>
<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
<script src="../js/plugins/jQueryUI/jquery-ui.js"></script>
<script>
$(function() {
	var pes = $(":input[name=gradeInput]");
	
	$.ajax({
	    url: "../teacherNotice/searchGradeSelectStatus",
	    type: "GET",
	    contentType: "application/json",
	    dataType:"json",
	    success: function(result) {
	        if('02'==result.code){
	        	var data = result.data;
	       		console.log(data);
	        	for (var i = 0; i < pes.length; i++) {
	        		console.log($(pes[i]).attr('id'));
	        		$(pes[i]).prop('checked',data[$(pes[i]).attr('id')])
				}
	        	
	        } else {
	        }
	    }
	});
	
	var courseInputs = $(":input[name=courseInput]");
	$.ajax({
	    url: "../teacherNotice/searchCourseSelectStatus",
	    type: "GET",
	    contentType: "application/json",
	    dataType:"json",
	    success: function(result) {
	        if('02'==result.code){
	        	var data = result.data;
	        	for (var i = 0; i < courseInputs.length; i++) {
	        		$(courseInputs[i]).prop('checked',data[$(courseInputs[i]).attr('id')])
				}
	        } else {
	        }
	    }
	});
	
	var roleInputs = $(":input[name=roleInput]");
	$.ajax({
	    url: "../teacherNotice/searchRoleSelectStatus",
	    type: "GET",
	    contentType: "application/json",
	    dataType:"json",
	    success: function(result) {
	        if('02'==result.code){
	        	var data = result.data;
	        	for (var i = 0; i < roleInputs.length; i++) {
	        		$(roleInputs[i]).prop('checked',data[$(roleInputs[i]).attr('id')])
				}
	        } else {
	        }
	    }
	});
	
	refreshSelectedInfo();
});

$('input:checkbox.grade_select').click(function () { 
	
    var pes = $(":input[name=gradeInput]");
	
	var params = [];
	var p = {};
	p["gradeKeyNo"] = $(this).val();
	p["selected"] = $(this).is(':checked');

	params.push(p);
	
	$.showLoading("正在提交选择");
	
	$.ajax({
	    url: "../teacherNotice/saveTeacherGradeSelect",
	    type: "POST",
	    contentType: "application/json",
	    dataType:"json",
	    data:JSON.stringify(params),
	    success: function(result) {
	        
	        if('02'==result.code){
	        	refreshSelectedInfo();
	        } else {
	        }
	        $.hideLoading();
	    }
	});
	
});

$('input:checkbox.course_select').click(function () { 
	
	var params = [];
	var p = {};
	p["courseCode"] = $(this).val();
	p["selected"] = $(this).is(':checked');

	params.push(p);
	
	$.showLoading("正在提交选择");
	
	$.ajax({
	    url: "../teacherNotice/saveTeacherCourseSelect",
	    type: "POST",
	    contentType: "application/json",
	    dataType:"json",
	    data:JSON.stringify(params),
	    success: function(result) {
	        
	        if('02'==result.code){
	        	refreshSelectedInfo();
	        } else {
	        }
	        $.hideLoading();
	    }
	});
	
}); 

$('input:checkbox.role_select').click(function () { 
	
	var pes = $(":input[name=roleInput]");
		
	var params = [];
	
	for (var i = 0; i < pes.length; i++) {
		var p = {};
		p["role"] = $(pes[i]).val();
		p["selected"] = $(pes[i]).is(':checked');
		
		params.push(p);
	}
	
	$.showLoading("正在提交选择");
	
	$.ajax({
	    url: "../teacherNotice/saveTeacherRoleSelect",
	    type: "POST",
	    contentType: "application/json",
	    dataType:"json",
	    data:JSON.stringify(params),
	    success: function(result) {
	        
	        if('02'==result.code){
	        	refreshSelectedInfo();
	        } else {
	        }
	        $.hideLoading();
	    }
	});
	
}); 
	
$('#commit').on('click',function(){
	window.location.href="../teacherNotice/toAddTeacherNotice";
});

$('a[name=gradeSelect]').on('click',function(){
	var childrenSchoolCode = $(this).children("input[name=hideSchoolCode]");
	var schoolCode = $(childrenSchoolCode[0]).val();
	
	var childrenStage = $(this).children("input[name=hideStage]");
	var stage = $(childrenStage[0]).val();
	
	var childreGrade = $(this).children("input[name=hideGrade]");
	var hideGrade = $(childreGrade[0]).val();
	
    var pes = $(":input[name=teacherInput]");
	
	var params = [];
	
	for (var i = 0; i < pes.length; i++) {
		var p = {};
		p["gradeKeyNo"] = $(pes[i]).val();
		p["selected"] = $(pes[i]).is(':checked');
		
		params.push(p);
	}
	window.location.href="../teacherNotice/toTeacherClassSelect?schoolCode="+schoolCode+"&stage="+stage+"&grade="+hideGrade;

});

$(function() {
	$( ".accordion" ).accordion({
		 collapsible: true,
		 heightStyle :'content'
	});
	});
	
function refreshSelectedInfo(){
	$.ajax({
	    url: "../teacherNotice/searchSelectedInfo",
	    type: "GET",
	    contentType: "application/json",
	    dataType:"json",
	    success: function(result) {
	        if('02'==result.code){
	        	var data = result.data;
	        	$("#totalNum").html(data["total"]);
	        	$("#selectedNum").html(data["selected"]);
	        	var ts = data["selectedTeachers"];
	        	var disVal1 = "";
	        	var disVal2 = "";
	        	for (var i = 0; i < ts.length; i = i + 2) {
	        		disVal1 = disVal1 + "<div><span>"+ts[i]+"</span></div>";
	        	}
	        	for (var i = 1; i < ts.length; i = i + 2) {
	        		disVal2 = disVal2 + "<div><span>"+ts[i]+"</span></div>";
	        	}
	        	$("#st1").html(disVal1);
	        	$("#st2").html(disVal2);
	        } else {
	        }
	    }
	});
}

$("#createGroupBtn").on('click',function(){
	if($("#selectedNum").html()=='0'){
		$.alert("请选择发送对象","提示");
		return;
	}
	$.prompt({
        text: "请输入自定义分组名称",
        title: "输入分组名称",
        onOK: function(text) {
        	var params = {};
        	params['name'] = text;
        	$.ajax({
        	    url: "../teacherNotice/saveNoticeGroup",
        	    type: "POST",
        	    contentType: "application/json",
        	    dataType:"json",
        	    data:JSON.stringify(params),
        	    success: function(result) {
        	        if('02'==result.code){
        	        	$.toast("操作成功");
        	        } else {
        	        }
        	    }
        	});
        },
        onCancel: function() {
          console.log("取消了");
        },
        input: ''
      });
});
</script>
</body>
</html>