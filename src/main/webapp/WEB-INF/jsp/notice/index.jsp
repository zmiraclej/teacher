<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>通知</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet" href="../js/webuploader/webuploader.css">

</head>
<body ontouchstart>
    <div class="weui-tab">
	      <div class="weui-navbar">
	        <a class="weui-navbar__item weui-bar__item--on" href="#tab1" id="parent">
	          家长通知
	        </a>
	        <a class="weui-navbar__item" href="#tab2" id="teacher">
	          教师通知
	        </a>
	      </div>
	      <div class="weui-tab__bd">
	        <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
	          <div class="bd">
              <c:forEach items="${array}" var="arr">
	              <div class="page__bd">
				     <div class="weui-cells__title">${arr.month}月</div>
			         <div class="weui-cells">
			           <c:forEach items="${arr.notices}" var="item">
			           	  <a class="weui-cell weui-cell_access" href="../notice/detail/${item.noticeNo}">
				            <div class="weui-cell__bd">
				              <p>${item.title}</p>
				            </div>
				            <div class="weui-cell__ft">${item.publishTime}
				            </div>
				          </a>
			           </c:forEach>

			        </div>
				  </div>
              </c:forEach>
		      
			</div>
	        </div>
	        <div id="tab2" class="weui-tab__bd-item">
	             <div class="bd">
		              <c:forEach items="${teacherArray}" var="arr">
			              <div class="page__bd">
						     <div class="weui-cells__title">${arr.month}月</div>
					         <div class="weui-cells">
					           <c:forEach items="${arr.notices}" var="item">
					           	  <a class="weui-cell weui-cell_access" href="../teacherNotice/detail/${item.noticeNo}">
						            <div class="weui-cell__bd">
						              <p>${item.title}</p>
						            </div>
						            <div class="weui-cell__ft">${item.publishTime}
						            </div>
						          </a>
					           </c:forEach>
		
					        </div>
						  </div>
		              </c:forEach>
				      
					</div>
	        </div>
	      </div>
    </div>
    
     <div class="weui-tabbar">
        <a href="javascript:void(0)" class="weui-tabbar__item weui-bar__item--on" id="toAddNotice">
          <div class="weui-tabbar__icon">
            <img src="../img/add.png" alt="">
          </div>
           <p class="weui-tabbar__label">新增</p>
        </a>
      </div>
<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../js/fastclick.js"></script>
<script src="../js/plugins/echarts/echarts.js"></script>
<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
<script src="../js/plugins/jQueryUI/jquery-ui.js"></script>
<script src="../js/webuploader/webuploader.min.js"></script>
<script src="../js/plugins/My97DatePicker/WdatePicker.js"></script>
<script>
    $("#toAddNotice").on("click",function(){
    	console.log($("div .weui-bar__item--on"));
    	var selectedId = $("div .weui-bar__item--on")[0].id;
    	if (selectedId == "parent") {
    		window.location.href="../notice/toAddParentNotice";
    	} else {
    		window.location.href="../teacherNotice/toAddTeacherNotice";
    	}
    });

</script>
</body>
</html>