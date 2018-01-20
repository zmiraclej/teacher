<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>教师选择</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet" href="../js/webuploader/webuploader.css">
<link rel="stylesheet" href="../css/common/notice.css">

</style>
</head>
<body ontouchstart>
	 <div class="weui-tab">
	 	<div class="weui-tab__bd">
		 	<div  id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active weui-cells_checkbox">
		 	      <div class="bd">
		 	       <div class="weui-cells weui-cells_checkbox">
				       <c:forEach items="${array}" var="item">
				       		 <div class="weui-cell">
						        <label class="weui-cell__bd weui-check__label" for="${item.teacherKeyNo}">
						        	<input type="checkbox" name="teacherInput" class="weui-check" id="${item.teacherKeyNo}" value="${item.teacherKeyNo}">
						            <i class="weui-icon-checked"></i>${item.teacherName}
						        </label>
						         <div class="weui-cell__ft"><a style="color:#A9A9A9" href="tel:${item.teacherPhone}"><img src='../img/tel.png' width="12px">${item.teacherPhone}</a></div>
						      </div>
				       </c:forEach>
				      </div>
				      <div style="display:none">
				        <input type="hidden" name="hideSchoolCode" value="${schoolCode}">
					    <input type="hidden" name="hideStage" value="${stage}">
						<input type="hidden" name="hideGrade" value="${grade}">
				      </div>
				      
				      <div class="weui-cells">
			        	<div class="weui-cell">
			        	<div class="weui-cell__bd"><p></p></div>
			        	</div>
			        </div>
		 	      </div>
		 	 </div>
	 	    
	 	</div>
	 	
    </div>
    
    <div class="controlbar">
          <ul>
           <li >
                  <a href="javascript:void(0);" id="commit">
                      <i class="icon icon-wegene-2"></i>
                      <span>返回上一步</span>
                  </a>
              </li>
              <li>
                  <a href="../teacherNotice/toTeacherGradeSelect" id="publish">
                      <i class="icon icon-wegene-2"></i>
                      <span>结束选择</span>
                  </a>
              </li>
             
          </ul>
      </div>
<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../js/fastclick.js"></script>
<script src="../js/plugins/echarts/echarts.js"></script>
<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
<script src="../js/plugins/jQueryUI/jquery-ui.js"></script>
<script src="../js/webuploader/webuploader.min.js"></script>
<script src="../js/plugins/My97DatePicker/WdatePicker.js"></script>
<script>
$(function() {
	var pes = $(":input[name=teacherInput]");
	
	$.ajax({
	    url: "../teacherNotice/searchTeacherSelectStatus",
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

$('input:checkbox').click(function () { 
	
    var pes = $(":input[name=teacherInput]");
	
	var params = [];
	var p = {};
	p["teacherKeyNo"] = $(this).val();
	p["selected"] = $(this).is(':checked');

	params.push(p);
	
	$.showLoading("正在提交选择");
	
	$.ajax({
	    url: "../teacherNotice/saveTeacherSelect",
	    type: "POST",
	    contentType: "application/json",
	    dataType:"json",
	    data:JSON.stringify(params),
	    success: function(result) {
	        
	        if('02'==result.code){
	        	
	        } else {
	        }
	        $.hideLoading();
	    }
	});
	
}); 

$('#cancle').on('click',function(){
	var childrenSchoolCode = $(this).children("input[name=hideSchoolCode]");
	var schoolCode = $(childrenSchoolCode[0]).val();

	var childrenStage = $(this).children("input[name=hideStage]");
	var stage = $(childrenStage[0]).val();

	var childreGrade = $(this).children("input[name=hideGrade]");
	var hideGrade = $(childreGrade[0]).val();
	
	window.location.href="../teacherNotice/toTeacherClassSelect="+schoolCode+"&stage="+stage+"&grade="+hideGrade;
});



$('#commit').on('click',function(){
	var pes = $(":input[name=teacherInput]");
	
	var childrenSchoolCode = $("input[name=hideSchoolCode]");
	var schoolCode = $(childrenSchoolCode[0]).val();

	var childrenStage = $("input[name=hideStage]");
	var stage = $(childrenStage[0]).val();

	var childreGrade = $("input[name=hideGrade]");
	var hideGrade = $(childreGrade[0]).val();
	
	var params = [];
	
	for (var i = 0; i < pes.length; i++) {
		var p = {};
		p["teacherKeyNo"] = $(pes[i]).val();
		p["selected"] = $(pes[i]).is(':checked');
		
		params.push(p);
	}
	
	window.location.href="../teacherNotice/toTeacherClassSelect?schoolCode="+schoolCode+"&stage="+stage+"&grade="+hideGrade;
});


</script>
</body>
</html>