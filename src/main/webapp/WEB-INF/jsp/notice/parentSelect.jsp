<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>家长选择</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">

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
					        <label class="weui-cell__bd weui-check__label" for="${item.parentKeyNo}">
					        	<input type="checkbox" name="parentInput" class="weui-check" id="${item.parentKeyNo}" value="${item.parentKeyNo}">
					            <i class="weui-icon-checked"></i>
					            <span style="font-size:10px;color:#C0C0C0">学生:</span>
					            <span>${item.studentName}</span>
					            <span style="font-size:10px;color:#C0C0C0">家长:</span>
					            <span style="font-size:10px;color:#C0C0C0">${item.parentName}</span>
					        </label>
					         <div class="weui-cell__ft"><a style="color:#A9A9A9" href="tel:${item.parentPhone}"><img src='../img/tel.png' width="12px">${item.parentPhone}</a></div>
					      </div>
			        </c:forEach>
			        </div>
			        <div class="weui-cells">
			        	<div class="weui-cell">
			        	<p></p>
			        	</div>
			        </div>
		        </div>
		     </div>
	 	</div>
	 	
	    <div class="weui-tabbar">
			<div href="tab1" class="weui-tabbar__item weui-bar__item--on" id="commit">
	          <div class="weui-tabbar__icon">
	            <img src="../img/return.png" alt="">
	          </div>
	          <p class="weui-tabbar__label">返回</p>
	        </div>
	        
	        <input type="hidden" name="hideSchoolCode" value="${schoolCode}">
	         <input type="hidden" name="hideStage" value="${stage}">
			 <input type="hidden" name="hideGrade" value="${grade}">
	      </div>
	 </div>
     

<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../js/fastclick.js"></script>
<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
<script src="../js/plugins/jQueryUI/jquery-ui.js"></script>
<script>
$(function() {
	var pes = $(":input[name=parentInput]");
	
	$.ajax({
	    url: "../notice/searchParentSelectStatus",
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
	
    var pes = $(":input[name=parentInput]");
	
	var params = [];
	var p = {};
	p["parentKeyNo"] = $(this).val();
	p["selected"] = $(this).is(':checked');

	params.push(p);
	
	$.showLoading("正在提交选择");
	
	$.ajax({
	    url: "../notice/saveParentSelect",
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

$('#cancle').on('click',function(){
	var childrenSchoolCode = $(this).children("input[name=hideSchoolCode]");
	var schoolCode = $(childrenSchoolCode[0]).val();

	var childrenStage = $(this).children("input[name=hideStage]");
	var stage = $(childrenStage[0]).val();

	var childreGrade = $(this).children("input[name=hideGrade]");
	var hideGrade = $(childreGrade[0]).val();
	
	window.location.href="../notice/toParentClassSelect="+schoolCode+"&stage="+stage+"&grade="+hideGrade;
});



$('#commit').on('click',function(){
	var pes = $(":input[name=parentInput]");
	
	var childrenSchoolCode = $("input[name=hideSchoolCode]");
	var schoolCode = $(childrenSchoolCode[0]).val();

	var childrenStage = $("input[name=hideStage]");
	var stage = $(childrenStage[0]).val();

	var childreGrade = $("input[name=hideGrade]");
	var hideGrade = $(childreGrade[0]).val();
	
	var params = [];
	
	for (var i = 0; i < pes.length; i++) {
		var p = {};
		p["parentKeyNo"] = $(pes[i]).val();
		p["selected"] = $(pes[i]).is(':checked');
		
		params.push(p);
	}
	
	window.location.href="../notice/toParentClassSelect?schoolCode="+schoolCode+"&stage="+stage+"&grade="+hideGrade;
});


</script>
</body>
</html>