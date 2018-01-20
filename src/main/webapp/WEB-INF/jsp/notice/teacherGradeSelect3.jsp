<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>年级选择</title>
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
		 	      	     <div class="weui-cells weui-cells_checkbox" id="gradeSelect">
					       <%-- <c:forEach items="${array}" var="arr">
						      <div class="weui-cells weui-cells_checkbox">
							      <div class="weui-cell">
								      <div class="weui-cell__bd">
								          <p>${arr.schoolName}</p>
								       </div>
							       </div>
							      <% String detail_prefix = "s"; int j = 0; %>
							       <c:forEach items="${arr.grades}" var="item">
							       		 <div class="weui-cell">
									        <label class="weui-cell__bd weui-check__label" for="${item.gradeKeyNo}">
									        	<input type="checkbox" name="gradeInput" class="weui-check" id="${item.gradeKeyNo}"  value="${item.gradeKeyNo}">
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
							    </div>
						  
						  </c:forEach> --%>
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
	var pes = $(":input[name=gradeInput]");
	
	/* $.ajax({
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
	}); */
	
	var shoolDiv = $("#gradeSelect");
	
	var page = JSON.parse(sessionStorage.getItem('noticeTeachers'));
	console.log(page)
	var newElement = '';
	for(var i=0;i< page.schools.length;i++){
		var school = page.schools[i];
		newElement += ' <div class="weui-cells weui-cells_checkbox">';
		newElement += '<div class="weui-cell">';
		newElement += '<div class="weui-cell__bd">';
		newElement += '<p>'+school.schoolName+'</p>';
		newElement += '</div>';
		newElement += '</div>';
		for (var j = 0; j < school.grades.length; j++) {
			var grade = school.grades[j];
			var gradeKeyNo = school.schoolCode + '_' + grade.grade;
			newElement += '<div class="weui-cell">';
			newElement += '<label class="weui-cell__bd weui-check__label" for="'+gradeKeyNo+'">';
			newElement += '<input type="checkbox" name="gradeInput" class="weui-check" id="'+gradeKeyNo+'"  value="'+gradeKeyNo+'">';
			newElement += '<i class="weui-icon-checked"></i>' + grade.grade;
			newElement += '</label>';
			newElement += '<a class="weui-cell weui-cell_access" name="gradeSelect" href="javascript:;">';
			newElement += '<input type="hidden" name="hideSchoolCode" value="'+school.schoolCode+'">';
			newElement += '<input type="hidden" name="hideStage" value="'+school.stage+'">';
			newElement += '<input type="hidden" name="hideGrade" value="'+school.grade+'">';
			newElement += '<label class="weui-cell__ft">';
			newElement += '</label>';
			newElement += '</a>';
			newElement += '</div>';
			newElement += '</div>';
		}
		
	}
	shoolDiv.append(newElement);


});

$('input:checkbox').click(function () { 
	
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


</script>
</body>
</html>