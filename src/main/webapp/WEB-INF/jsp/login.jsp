<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<h2>LoginSuccess</h2>
<div>
  <span>${code}</span>
  <p>====================================</p>
  <span>token:</span><span>${token}</span>
  <p>====================================</p>
  <span>userId:</span><span>${userId}</span>
  <div>
  	<a href="toHome">去首页</a>
  </div>
</div>
</body>
</html>
