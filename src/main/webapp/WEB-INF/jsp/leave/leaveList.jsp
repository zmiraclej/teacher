<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description"
	content="Write an awesome description for your new site here. You can edit this line in _config.yml.
It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
<title>请假列表</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/weui.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/jquery-weui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/jquery-ui.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/demos.css">
<style type="text/css">
	span{
		margin:20px;
	}
	#button{
		 position:fixed;   
    	 top:91.5%;
    	 left:0%;
    	 margin:0px;
    	 padding:0px;
	}
	#tip{
		text-align: center;
		padding-top:15px;
		font-size:20px;
	}
</style>

</head>
<body>
	<a id="button" style="width:100%;" href="${pageContext.request.contextPath}/leave/edit" class="weui-btn weui-btn_primary">登记请假</a>

	<div class="weui-cells" id="leave-list">
		
	</div>
	<script src="${pageContext.request.contextPath}/js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/fastclick.js"></script>
	<script src="${pageContext.request.contextPath}/js/plugins/jQueryUI/jquery-weui.js"></script>
	
	<script type="text/javascript">
	$(function() {
		FastClick.attach(document.body);
		$.get("${pageContext.request.contextPath}/leave/records",function(data,status){
			if(data.length<=0 || data==''){
				$("#leave-list").before('<div class="weui-flex">'+
						'<div class="weui-flex__item" id="tip">暂无请假记录</div>'+
						'</div>');
			}else{
				for (var i = 0; i < data.length; i++) {
					$("#leave-list").append('<a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/leave/detail?id='+data[i].id+'">'+
							'<div class="weui-cell__bd">'+
							'<span>'+data[i].startTime.substring(0,4)+'年'+data[i].startTime.substring(5,7)+'月'+data[i].startTime.substring(8,10)+'日</span>'+
							'<span>'+data[i].studentName+'</span>'+
							'</div><div class="weui-cell__ft"></div></a>');
				}
			}
		});
	});
	</script>
</body>
</html>