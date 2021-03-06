<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>班级选择</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet" href="../js/webuploader/webuploader.css">

</style>
</head>
<body ontouchstart>
	<div class="weui-tab">
	 	<div class="weui-tab__bd">
	 	     <div  id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active weui-cells_checkbox">
		 	      <div class="bd">
		 	      	     <div class="weui-cells weui-cells_checkbox">
				           <div class="weui-cell">
						      <div class="weui-cell__bd">
						          <p>班级选择</p>
						       </div>
					       </div>
					       <c:forEach items="${array}" var="item">
					       		 <div class="weui-cell">
							        <label class="weui-cell__bd weui-check__label" for="${item.classKeyNo}">
							        	<input type="checkbox" name="classInput" class="weui-check" id="${item.classKeyNo}"  value="${item.classKeyNo}">
							            <i class="weui-icon-checked"></i>${item.dispayName}
							        </label>
							        <a class="weui-cell weui-cell_access" name="gradeSelect" href="javascript:;">
							        	<input type="hidden" name="hideSchoolCode" value="${item.schoolCode}">
							        	<input type="hidden" name="hideStage" value="${item.stage}">
							        	<input type="hidden" name="hideGrade" value="${item.grade}">
							        	<input type="hidden" name="hideClass" value="${item.classNo}">
							           <label class="weui-cell__ft">
							           </label>
							          </a>
							      </div>
					       </c:forEach>
					    </div>
					    
					    <div class="weui-cells">
				        	<div class="weui-cell">
				        	<div class="weui-cell__bd"><p></p></div>
				        	</div>
				        </div>
		 	      </div>
	 	      </div>
	 	 </div>

  
	<div class="weui-tabbar">
		<a href="javascript:void(0);" class="weui-tabbar__item weui-bar__item--on" id="commit">
          
          <div class="weui-tabbar__icon">
            <img src="../img/return.png" alt="">
          </div>
          <p class="weui-tabbar__label">返回</p>
        </a>
      </div>
    
    </div>
      <input type="hidden" id="psId" value="${tempNoticeId}">
<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../js/fastclick.js"></script>
<script src="../js/plugins/echarts/echarts.js"></script>
<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
<script src="../js/plugins/jQueryUI/jquery-ui.js"></script>
<script src="../js/webuploader/webuploader.min.js"></script>
<script src="../js/plugins/My97DatePicker/WdatePicker.js"></script>
<script>

$(function() {
	var pes = $(":input[name=classInput]");
	
	$.ajax({
	    url: "../notice/searchClassSelectStatus",
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
});

$('#commit').on('click',function(){
	window.location.href="../notice/toParentGradeSelect";
});

$('#cancel').on('click',function(){
	window.location.href="../notice/toParentGradeSelect";
});

$('input:checkbox').click(function () { 
	
    var pes = $(":input[name=classInput]");
	
	var params = [];
	var p = {};
	p["classKeyNo"] = $(this).val();
	p["selected"] = $(this).is(':checked');

	params.push(p);
	
	$.showLoading("正在提交选择");
	
	$.ajax({
	    url: "../notice/saveParentClassSelect",
	    type: "POST",
	    contentType: "application/json",
	    dataType:"json",
	    data:JSON.stringify(params),
	    success: function(result) {
	        
	        if('02'==result.code){
	        	console.log(result.data);
	        } else {
	        }
	        $.hideLoading();
	    }
	});
	
}); 

$('a[name=gradeSelect]').on('click',function(){
	var childrenSchoolCode = $(this).children("input[name=hideSchoolCode]");
	var schoolCode = $(childrenSchoolCode[0]).val();
	
	var childrenStage = $(this).children("input[name=hideStage]");
	var stage = $(childrenStage[0]).val();
	
	var childreGrade = $(this).children("input[name=hideGrade]");
	var hideGrade = $(childreGrade[0]).val();
	
	var childreClass = $(this).children("input[name=hideClass]");
	var hideClass = $(childreClass[0]).val();


    window.location.href="../notice/toParentSelect?schoolCode="+schoolCode+"&stage="+stage+"&grade="+hideGrade +"&classNo="+hideClass;
});


</script>
</body>
</html>