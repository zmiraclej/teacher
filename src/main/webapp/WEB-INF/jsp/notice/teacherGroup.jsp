<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>自定义分组</title>
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
    <div style='background-color:#f8f8f8;padding:5px;height:30px'><span>请选择教师自定义分组</span><a href="#" id="commitGroup" class="ref-btn" style='float:right;background:transparent'><span>提交选择</span></a></div>
	<div class="content-area">
         <div class=" weui-cells_checkbox" style="border-top:0px;">
           <c:if test="${empty groups}"><div style="height:60px;text-align:center;border:0px;"><span><i class="weui-icon-info-circle"></i>当前暂无教师自定义分组</span></div></c:if>
           <c:forEach items="${groups}" var="item">
	       	 <label class="weui-cell weui-check__label" for="${item.code}">
		        <div class="weui-cell__hd">
		          <input type="checkbox" class="weui-check" name="group" id="${item.code}" value="${item.code}">
		          <i class="weui-icon-checked"></i>
		        </div>
		        <div class="weui-cell__bd">
		          <p>${item.name}</p>
		        </div>
		      </label>
	       </c:forEach>
    </div>
		<div style="margin-top:10px;margin-bottom:50px">
 	      	<div style='background-color:#f8f8f8;padding:5px'><span>分组教师名单</span></div>
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
              <li >
                  <a href="../teacherNotice/toTeacherGradeSelect">
                      <i class="icon icon-wegene-2"></i>
                      <span>筛选人员</span>
                  </a>
              </li>

              <li class="active">
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
$('#commit').on('click',function(){
	window.location.href="../teacherNotice/toAddTeacherNoticeFromGroup";
});

$('input:checkbox[name=group]').click(function () { 
	var pes = $(":input[name=group]");
	
	var params = [];
	
	for (var i = 0; i < pes.length; i++) {
		if($(pes[i]).is(':checked')) {
			var p = {};
			p["code"] = $(pes[i]).val();
			
			params.push(p);
		}
		
	}
	
	if(params.length == 0){
		$("#st1").html("");
		$("#st2").html("");
	} else {
		$.showLoading("正在提交选择");
		
		$.ajax({
		    url: "../teacherNotice/searchGroupMembers",
		    type: "POST",
		    contentType: "application/json",
		    dataType:"json",
		    data:JSON.stringify(params),
		    success: function(result) {
		    	 $.hideLoading();
		        console.log(result);
		        if('02'==result.code){
		        	var data = result.data;
		        	var disVal1 = "";
		        	var disVal2 = "";
		        	for (var i = 0; i < data.length; i = i + 2) {
		        		disVal1 = disVal1 + "<div><span>"+data[i].name+"</span></div>";
		        	}
		        	for (var i = 1; i < data.length; i = i + 2) {
		        		disVal2 = disVal2 + "<div><span>"+data[i].name+"</span></div>";
		        	}
		        	$("#st1").html(disVal1);
		        	$("#st2").html(disVal2);
		        } else {
		        }
		       
		    }
		});
	}
}); 

$('#commitGroup').click(function () { 
	var pes = $(":input[name=group]");
	
	var params = [];
	
	for (var i = 0; i < pes.length; i++) {
		if($(pes[i]).is(':checked')) {
			var p = {};
			p["code"] = $(pes[i]).val();
			
			params.push(p);
		}
		
	}
	
	if(params.length == 0){
		$.alert("未选择分组");
	} else {
		$.confirm("是否提交当前选择？", function() {
			$.showLoading("正在提交选择");
			
			$.ajax({
			    url: "../teacherNotice/commitGroupSelect",
			    type: "POST",
			    contentType: "application/json",
			    dataType:"json",
			    data:JSON.stringify(params),
			    success: function(result) {
			    	 $.hideLoading();
			        console.log(result);
			        if('02'==result.code){
			        	$.toast("提交成功");
			        	window.location.href="../teacherNotice/toAddTeacherNoticeFromGroup"
			        } else {
			        	$.toast("提交失败");
			        }
			       
			    }
			});
			
		});
	}
}); 
	
</script>
</body>
</html>