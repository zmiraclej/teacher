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
<link rel="stylesheet" href="../../css/common/notice.css">
<style>
    .send_columns {
        column-count: 3;
        column-gap: 5px;
    }
    
    table tbody tr td {
    	text-align:center;
    }

</style>
</head>
<body ontouchstart>
   	<div class="content-area">
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
				<table style="width:100%">
					<thead>
						<tr>
							<th>姓名</th>
							<th>微信</th>
							<th>短信</th>
						</tr>
					</thead>
					 <tbody>
					    <c:forEach items="${sendDetails}" var="item">
						    <tr>
						      <td>${item.teacherName}</td>
						      <td>${item.wxStatus}</td>
						      <td>${item.shortMsgStatus}</td>
						    </tr>
					    </c:forEach>
					  </tbody>
				</table>
		</div>
	</div>
	</div>
	<div class="controlbar">
          <ul>
              <li>
                  <a href="../../notice/index" >
                      <i class="icon icon-wegene-2"></i>
                      <span>返回</span>
                  </a>
              </li>
          </ul>
      </div>
<script src="../../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../../js/plugins/jQueryUI/jquery-weui.js"></script>
<script src="../../js/plugins/jQueryUI/jquery-ui.js"></script>
<script>


</script>
</body>
</html>