<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>通知详情</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<link rel="stylesheet" href="../../css/common/weui.min.css">
<link rel="stylesheet" href="../../css/common/jquery-weui.css">
<link rel="stylesheet" href="../../css/common/demos.css">
<link rel="stylesheet" href="../css/common/notice.css">

<style>
    .send_columns {
        column-count: 3;
        column-gap: 5px;
    }

</style>
</head>
<body ontouchstart>
	<div class="weui-panel weui-panel_access">
		<div class="weui-panel__hd">通知内容</div>
		<div class="weui-panel__bd">
			<article class="weui-article">
		      <h1>${title}</h1>
		      <section>
		          <p>
		            ${content}
		          </p>
		          <p>
		            <c:forEach items="${files}" var="file">
				      <img src="${file}" alt="">
			        </c:forEach>
		          </p>
		       </section>
	   		 </article>
		</div>
	</div>
	<div class="weui-panel weui-panel_access">
		<div class="weui-panel__hd">通知发送详情：</div>
		<div class="weui-panel__bd">
			<div class="send_columns" style="width:100%">
					<div style="margin-left:15px">
						<div><span>姓名</span></div>
							<c:forEach items="${sendDetails}" var="item">
								<div><span>${item.studentName}</span></div>
							</c:forEach>
					</div>
					<div>
						<div><span>短信</div> 
						<c:forEach items="${sendDetails}" var="item">
							<div><span>${item.shortMsgStatus}</span></div>
						</c:forEach>
					</div>
					<div>
						<div><span>微信</div>
						<c:forEach items="${sendDetails}" var="item">
							<div><span>${item.wxStatus}</span></span></div>
						</c:forEach>
					</div>
			</div>
		</div>
	</div>
	
	
<script src="../../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../../js/plugins/jQueryUI/jquery-weui.js"></script>
<script src="../../js/plugins/jQueryUI/jquery-ui.js"></script>
<script>


</script>
</body>
</html>