<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>学生评分实例</title>
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
	
	<meta name="description" content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
	<link rel="stylesheet" href="../css/common/v-time-style.css">
	<link rel="stylesheet" href="../css/common/weui.min.css">
	<link rel="stylesheet" href="../css/common/jquery-weui.css">
	<link rel="stylesheet" href="../css/common/demos.css">
	<style>
	.ft-size1{font-size: 24px;}
	.ft-size2{font-size: 18px;}
	</style>
	<script type="text/javascript">
	function calFile(f){
		if(f){
			var f_ = f.split(';');
			return f_.length+"文件";
		}
	}
	</script>
</head>
<body ontouchstart>
	<header class="demos-header">
		<h2 class="demos-title ft-size1" >${ins.stuName}</h2>
		<h3 class="demos-title ft-size2" >${ins.stdName}</h3>
	</header>
  	<div id="result" class="weui-panel weui-panel_access">
  		<div class="weui-form-preview__bd">
  			<c:if test="${not empty ins.content}">
  				<div class="weui-form-preview__item">
			      <label class="weui-form-preview__label">内容</label>
			      <span class="weui-form-preview__value">${ins.content}</span>
		    	</div>
  			</c:if>
		    <div class="weui-form-preview__item">
		      <label class="weui-form-preview__label">记入日期</label>
		      <span class="weui-form-preview__value"><fmt:formatDate value="${ins.recDate}" pattern="YYYY-MM-dd"/></span>
		    </div>
		    <c:if test="${not empty ins.attachFile}">
		    <div class="weui-form-preview__item">
		      <label class="weui-form-preview__label">学生附件</label>
		      <span class="weui-form-preview__value">
		       <script>document.write(calFile('${ins.attachFile}'))</script>
		      </span>
		    </div>
		    </c:if>
		    <div class="weui-form-preview__item">
		      <label class="weui-form-preview__label">实际得分</label>
		      <span class="weui-form-preview__value">${ins.actScore}</span>
		    </div>
		    <div class="weui-form-preview__item">
		      <label class="weui-form-preview__label">审核状态</label>
		      <span class="weui-form-preview__value">
		      	<c:if test="${ins.authResult=='01'}">直接确认</c:if>
		      	<c:if test="${ins.authResult=='02'}">修改确认</c:if>
		      	<c:if test="${ins.authResult=='03'}">作废此条记录</c:if>
		      	<c:if test="${ins.authResult=='04'}">教师新增记录</c:if>
		      	<c:if test="${empty ins.authResult}">待审核</c:if>
		      </span>
		    </div>
		    <div class="weui-form-preview__item">
		      <label class="weui-form-preview__label">审核日期</label>
		      <span class="weui-form-preview__value"><fmt:formatDate value="${ins.authDate}" pattern="YYYY-MM-dd"/></span>
		    </div>
		    <c:if test="${not empty ins.authContent}">
		    <div class="weui-form-preview__item">
		      <label class="weui-form-preview__label">教师评价</label>
		      <span class="weui-form-preview__value">${ins.authContent}</span>
		    </div>
		    </c:if>
		    <c:if test="${not empty ins.alterContent}">
		    <div class="weui-form-preview__item">
		      <label class="weui-form-preview__label">教师修改内容</label>
		      <span class="weui-form-preview__value">${ins.alterContent}</span>
		    </div>
		    </c:if>
		    <c:if test="${not empty ins.authAttachFile}">
		    <div class="weui-form-preview__item">
		      <label class="weui-form-preview__label">教师附件</label>
		      <span class="weui-form-preview__value">
		      <script>document.write(calFile('${ins.authAttachFile}'))</script>
		      
		      </span>
		    </div>
		    </c:if>
		    <div class="weui-form-preview__item">
		      <label class="weui-form-preview__label">创建时间</label>
		      <span class="weui-form-preview__value"><fmt:formatDate value="${ins.createTime}" pattern="YYYY-MM-dd"/></span>
		    </div>
	    </div>
	</div>
	
    <script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/echarts/echarts.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script type="text/javascript">
	$(function() {
		FastClick.attach(document.body);
	});
	</script>
 </body>
</html>