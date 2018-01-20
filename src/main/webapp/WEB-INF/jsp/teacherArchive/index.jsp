<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>教师档案</title>
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<meta name="description" content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.
">
<link rel="stylesheet" href="../css/common/v-time-style.css"">
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet" href="../css/common/syllabus.css">

<style>
	.weui-cell:before{
		border-top:0px;
	}
	.weui-cells:after {
		border-top:0px;
		border-bottom:0px;
	}
</style>
  </head>

  <body ontouchstart style="background-color:#f8f8f8">
  
        <div class="weui-panel weui-panel_access">
			<div class="weui-panel__hd">教师档案</div>
			<div class="weui-panel__bd">
			  <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
				<div class="weui-media-box__hd">
				  <img class="weui-media-box__thumb" style="border-radius:50%"  height="120" width="120" src="../img/stu.png" alt="" id="photo">
				</div>
				<div class="weui-media-box__bd">
				  <span class="weui-media-box__title" id="studentName">胡晓林</span>&nbsp;<span style="color:gray;font-size:12px"></span>
				  <p class="weui-media-box__desc" id="stInfo">女</p>
				   <p class="weui-media-box__desc" id="stInfo"></p>
				</div>
			  </a>
			</div>
		</div>
		
	    <div class="weui-panel weui-panel_access">
		    <div class="weui-cells__title">职务</div>
		    <div class="weui-cells">
	          <div class="weui-cell">
	            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
	            <div class="weui-cell__bd">
	              <p>备课组长</p>
	            </div>
	            <div class="weui-cell__ft">锦江初中一年级</div>
	          </div>
	         </div>
	         <div class="weui-cell">
	            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
	            <div class="weui-cell__bd">
	              <p>班主任</p>
	            </div>
	            <div class="weui-cell__ft">锦江初中一年级二班</div>
	          </div>
	    </div>
	    
	    <div class="weui-panel weui-panel_access">
	        <div class="weui-cells__title">教授课程</div>
		    <div class="weui-cells">
	          <div class="weui-cell">
	            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
	            <div class="weui-cell__bd">
	              <p>初中语文</p>
	            </div>
	            <div class="weui-cell__ft">教龄：10年</div>
	          </div>
	         </div>
	         <div class="weui-cell">
	            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
	            <div class="weui-cell__bd">
	              <p>社会实践</p>
	            </div>
	            <div class="weui-cell__ft">教龄：2年</div>
	          </div>
         </div>
         
	    <div class="weui-panel weui-panel_access">
		     <div class="weui-cells__title">授课班级</div>
			    <div class="weui-cells">
		          <div class="weui-cell">
		            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
		            <div class="weui-cell__bd">
		              <p>初中语文</p>
		            </div>
		            <div class="weui-cell__ft">初中一年级：1、2、3、4班</div>
		          </div>
		         </div>
		         <div class="weui-cell">
		            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
		            <div class="weui-cell__bd">
		              <p>社会实践</p>
		            </div>
		            <div class="weui-cell__ft">初中一年级：1、2班</div>
		          </div>
	    </div>
	    
	    <div class="weui-panel weui-panel_access">
	        <div class="weui-panel__hd">我的课程表</div>
	        <div class="weui-panel__bd">
				<table> 
				    <thead id="courseTableHeader"> 
				    	<tr>
				    		<td></td>
				    		<td>周一</td>
				    		<td>周二</td>
				    		<td>周三</td>
				    		<td>周四</td>
				    		<td>周五</td>
				    	</tr>
				    </thead> 
				    <tbody id="courseTableBody"> 
				    	<tr>
				    		<td><p>上午</p><p>第一节</p></td>
				    		<td><p>初一一班</p><p>教室306</p></td>
				    		<td></td>
				    		<td><p>初一一班</p><p>教室306</p></td>
				    		<td></td>
				    		<td><p>初一二班</p><p>教室306</p></td>
				    	</tr>
				    	<tr>
				    		<td><p>上午</p><p>第二节</p></td>
				    		<td><p>初一一班</p><p>教室306</p></td>
				    		<td></td>
				    		<td><p>初一一班</p><p>教室306</p></td>
				    		<td></td>
				    		<td><p>初一二班</p><p>教室306</p></td>
				    	</tr>
				    	<tr>
				    		<td><p>上午</p><p>第三节</p></td>
				    		<td><p>初一二班</p><p>教室308</p></td>
				    		<td></td>
				    		<td></td>
				    		<td><p>初一二班</p><p>教室308</p></td>
				    		<td></td>
				    	</tr>
				    	<tr>
				    		<td><p>上午</p><p>第四节</p></td>
				    		<td><p>初一二班</p><p>教室308</p></td>
				    		<td></td>
				    		<td></td>
				    		<td><p>初一二班</p><p>教室308</p></td>
				    		<td></td>
				    	</tr>
				    	<tr>
				    		<td><p>下午</p><p>第一节</p></td>
				    		<td></td>
				    		<td><p>初一一班</p><p>教室306</p></td>
				    		<td><p>初一二班</p><p>教室308</p></td>
				    		<td></td>
				    		<td></td>
				    	</tr>
				    	<tr>
				    		<td><p>下午</p><p>第二节</p></td>
				    		<td></td>
				    		<td><p>初一一班</p><p>教室306</p></td>
				    		<td><p>初一二班</p><p>教室308</p></td>
				    		<td></td>
				    		<td></td>
				    	</tr>
				    	<tr>
				    		<td><p>下午</p><p>第三节</p></td>
				    		<td></td>
				    		<td></td>
				    		<td></td>
				    		<td></td>
				    		<td><p>初一一班</p><p>教室306</p></td>
				    	</tr>
				    	<tr>
				    		<td><p>下午</p><p>第四节</p></td>
				    		<td></td>
				    		<td></td>
				    		<td></td>
				    		<td></td>
				    		<td><p>初一一班</p><p>教室306</p></td>
				    	</tr>
				    </tbody> 
		    	</table> 
			</div>
		</div>
		<div class="weui-panel weui-panel_access">
				<div class="weui-panel__hd">最近一月考勤统计</div>
				<div class="weui-panel__bd">
					<div class="weui-grid js_grid">
						<div class="weui-grid__label">
							<span style="font-size: 24px;color:green">0</span>
						</div>
						<p class="weui-grid__label">上课迟到次数</p>
					</div>
					<div class="weui-grid js_grid">
						<div class="weui-grid__label">
							<span style="font-size: 24px;color:green">0</span>
						</div>
						<p class="weui-grid__label">上课早退次数</p>
					</div>
					<div class="weui-grid js_grid">
						<div class="weui-grid__label">
							<span style="font-size: 24px;color:green">0</span>
						</div>
						<p class="weui-grid__label">代课次数</p>
					</div>
					<div class="weui-grid js_grid">
						<div class="weui-grid__label">
							<span style="font-size: 20px;color:green">2</span>
						</div>
						<p class="weui-grid__label">调课次数</p>
					</div>
					<div class="weui-grid js_grid">
						<div class="weui-grid__label">
							<span style="font-size: 20px;color:green">0</span>
						</div>
						<p class="weui-grid__label">升旗迟到次数</p>
					</div>
					<div class="weui-grid js_grid">
						<div class="weui-grid__label">
							<span style="font-size: 20px;color:green">0</span>
						</div>
						<p class="weui-grid__label">升旗早退次数</p>
					</div>
					<div class="weui-grid js_grid">
						<div class="weui-grid__label">
							<span style="font-size: 20px;color:red">1</span>
						</div>
						<p class="weui-grid__label">升旗缺席次数</p>
					</div>
					<div class="weui-grid js_grid">
						<div class="weui-grid__label">
							<span style="font-size: 20px;color:red">1</span>
						</div>
						<p class="weui-grid__label">会议迟到次数</p>
					</div>
					<div class="weui-grid js_grid">
						<div class="weui-grid__label">
							<span style="font-size: 20px;color:green">0</span>
						</div>
						<p class="weui-grid__label">会议早退次数</p>
					</div>
					<div class="weui-grid js_grid">
						<div class="weui-grid__label">
							<span style="font-size: 20px;color:red">2</span>
						</div>
						<p class="weui-grid__label">会议缺席次数</p>
					</div>
					<div class="weui-grid js_grid">
						<div class="weui-grid__label">
							<span style="font-size: 20px;color:green">0</span>
						</div>
						<p class="weui-grid__label">请假次数</p>
					</div>
				</div>
				<div class="weui-panel__bd"></div>
				<div class="weui-panel__ft"></div>
			</div> 
	  		<div class="weui-panel weui-panel_access">
		        <div class="weui-panel__hd">考试成绩统计分析</div>
		        <div class="weui-panel__bd">
		          <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
		            <div class="weui-media-box__bd" id="examSelect">
		               <input class="weui-input" id="kaoshiIns" type="text" value="第一次周考考试成绩统计" readonly="readonly">
		              <p class="weui-media-box__desc" id="examInfo"></p>
		            </div>
		          </a>
		        </div>
		        <div class="weui-panel__bd">
		         <div id="junfenTongjiChart" class="chartDisContainer" style="height:400px;margin-top:5px"></div>
				</div>
			</div>
			
		    <div class="weui-panel weui-panel_access">
				    <div class="weui-cells__title">教学活动</div>
			        <div class="weui-cells">
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>教研组计划</p>
			            </div>
			            <div class="weui-cell__ft">已提交</div>
			          </div>
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>备课组计划</p>
			            </div>
			            <div class="weui-cell__ft">未提交</div>
			          </div>
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>备课资料</p>
			            </div>
			            <div class="weui-cell__ft">15份</div>
			          </div>
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>半期分析</p>
			            </div>
			            <div class="weui-cell__ft"></div>
			          </div>
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>期末总结</p>
			            </div>
			            <div class="weui-cell__ft"></div>
			          </div>
			        </div>
			  </div>
			  
			  <div class="weui-panel weui-panel_access">
				    <div class="weui-cells__title">教研活动</div>
			        <div class="weui-cells">
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>2017-8-20</p>
			            </div>
			            <div class="weui-cell__ft">备课经验（主讲）</div>
			          </div>
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>2017-8-3</p>
			            </div>
			            <div class="weui-cell__ft">板书技巧（参与）</div>
			          </div>
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>2017-7-18</p>
			            </div>
			            <div class="weui-cell__ft">语文“写读创”教学（主讲）</div>
			          </div>
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>2017-6-20</p>
			            </div>
			            <div class="weui-cell__ft">备课经验（主讲）</div>
			          </div>
			        </div>
			  </div>
			  
			  <div class="weui-panel weui-panel_access">
				    <div class="weui-cells__title">教师综合考评</div>
			        <div class="weui-cells">
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>考评时间</p>
			            </div>
			            <div class="weui-cell__ft">2017/08/01</div>
			          </div>
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>综合评分</p>
			            </div>
			            <div class="weui-cell__ft">96</div>
			          </div>
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>自评</p>
			            </div>
			            <div class="weui-cell__ft">92</div>
			          </div>
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>教研组长评分</p>
			            </div>
			            <div class="weui-cell__ft">94</div>
			          </div>
			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>年级组长评分</p>
			            </div>
			            <div class="weui-cell__ft">97</div>
			          </div>
			          			          <div class="weui-cell">
			            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			            <div class="weui-cell__bd">
			              <p>学生评分</p>
			            </div>
			            <div class="weui-cell__ft">98</div>
			          </div>
			        </div>
			  </div>
	
   <div class="weui-panel weui-panel_access" id="checkDiv">
   	   <input class="weui-btn weui-btn_primary"  id="goBack" type="button" value="返回">
   </div>

    <script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/echarts/echarts.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script src="../js/pages/teacherArchive/junfentongji.js"></script>
	<script>

	
	
	 $(function() {
		    FastClick.attach(document.body);
		    initData();
		  });
	
	//学生列表
	 var childrenList=null;
	 //当前选中的学生
	 var currentStudent=null;

	 //学生选择控件内容,初始时默认为无数据状态
	 var selectStudentActions= [ {
	     text: "暂无数据",
	     className: "color-primary"
	   }];
	   	
	 

	   function initData(){
			//初始化学生数据
			$.ajax({
				url:"../common/initStudentInfo",
				type:"get",
				success:function(data){
					currentStudent=data.currentStudent;
					//无所选学生，直接结束，不加载相关选择插件
					if(currentStudent==null){
						$("#studentName").text("暂无");
						return;
					}else{
						//如果存在学生，加载学生信息
						$("#studentName").text(currentStudent.name);

						var gradeNo=currentStudent.gradeNo!=null?currentStudent.gradeNo:" ";
						var classNo=currentStudent.classNo!=null?currentStudent.classNo:" ";
						var classInfo=gradeNo+"年级"+classNo+"班";
						$("#stInfo").text(classInfo);
						//$("#studentId").val(currentStudent.id);
						
						if(currentStudent.photo!=null){
							$("#photo").attr("src",currentStudent.photo);
						}else{
							$("#photo").attr("src","../img/stu.png");
						}
						
						//调用基本档案数据
						//baseDocument(currentStudent.id);
						//dailyActive(currentStudent.studentNo);
						searchSubjectTeacher(currentStudent.id);
						searchHeadTeacher(currentStudent.id);
						searchDormTeacher(currentStudent.id);
					}
					//如果存在学生列表，加载学生列表	
					if(data.childrenList!=null&&data.childrenList.length>0){
						//把后台传来的学生集合在页面中保存起来
						childrenList=data.childrenList;
						//设置可选学生
						for(var i=0;i<childrenList.length;i++){
							 selectStudentActions[i]={			
							 text:childrenList[i].name,
							 className: "color-primary",
							//点击时触发选择学生的方法，传入索引，直接从children获取学生信息
							 onClick:selectStudent(i),
						   }
						}
						
						//加载学生选择控件
						$(document).on("click", "#changeStudent", function() {
					        $.actions({
					          title: "选择学生",
					          onClose: function() {
					            //console.info("close")
					          },
					          actions: selectStudentActions
					        });
					      });
					}
				}
			}) 
	  }
	 	 
	
	$(function(){
		$("#goBack").click(function(){
			
			window.history.back();	
		})
		});
		

	//查询班主任通讯录
	function searchHeadTeacher(i){
		 $.ajax({
				url:"../teacherPhoneNumList/searchHeadTeacherPhoneByParentId",
				type:"post",
				data : {
					id:i
					},
				success:function(data){
					if("02" == data.code){
						 $("#headTeacherInfo").html("");
							var list=data.data;
							if(list!=null&&list.length>0){
							var html="";
								for(var i=0;i<list.length;i++){
								var pt=list[i];
								var teacherName=pt.teacherName;
								var phone=pt.teacherPhone;
								
	                            html+='<div class="weui-cell"><div class="weui-cell__bd"><p id="">'+teacherName+'</p></div><div class="weui-cell__ft">'+phone+'</div></div>';
								}
								
								 $("#headTeacherInfo").html(html);
							}else{
								 $("#headTeacherInfo").html("&nbsp;&nbsp;&nbsp;暂无信息");
							}
					}
				}
			})  	
	}
	//查询生辅老师通讯录
	function searchDormTeacher(i){
		 $.ajax({
				url:"../teacherPhoneNumList/searchDormTeacherPhoneByParentId",
				type:"post",
				data : {
					id:i
					},
				success:function(data){
					if("02" == data.code){
						 $("#dormTeacherInfo").html("");
							var list=data.data;
							if(list!=null&&list.length>0){
							var html="";
								for(var i=0;i<list.length;i++){
								var pt=list[i];
								var teacherName=pt.teacherName;
								var phone=pt.teacherPhone;
								
	                          html+='<a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg"><div class="weui-cell__bd"><h5 class="weui-media-box__title">'+teacherName+'</h5></div><span class="weui-cell__ft">'+phone+'</span></a>';
	  						
								
								}
								
								 $("#dormTeacherInfo").html(html);
							}else{
								 $("#dormTeacherInfo").html("&nbsp;&nbsp;&nbsp;暂无信息");
							}
					}
				}
			})  	
	}
	//查询科任老师通讯录
function searchSubjectTeacher(i){
		 $.ajax({
				url:"../teacherPhoneNumList/searchSubjectTeacherPhoneByParentId",
				type:"post",
				data : {
					id:i
					},
				success:function(data){
					if("02" == data.code){
						 $("#subjectTeacherInfo").html("");
							var list=data.data;
							if(list!=null&&list.length>0){
							var html="";
								for(var i=0;i<list.length;i++){
								var pt=list[i];
								var teacherName=pt.teacherName;
								var phone=pt.teacherPhone;
								var teachName=pt.teachName;
								
								
								 html+='<div class="weui-panel__bd"><a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg"><div class="weui-cell__bd"><h5 class="weui-media-box__title">'+teacherName+'</h5><p class="weui-media-box__desc">'+teachName+'</p></div><span class="weui-cell__ft">'+phone+'</span></a></div>';
								
								}
								
								 $("#subjectTeacherInfo").html(html);
							}else{
								 $("#subjectTeacherInfo").html("&nbsp;&nbsp;&nbsp;暂无信息");
							}
					}
				}
			})  	
	}


	
	
//切换学生
var selectStudent=function (index){
	  return function() { 
		  currentStudent=childrenList[index];
		 if(currentStudent.gradeNo==null){
			 currentStudent.gradeNo==0; 
		 }
		 if(currentStudent.classNo==null){
			 currentStudent.classNo==0; 
		 }
		  var classInfo=currentStudent.gradeNo+"年级"+currentStudent.classNo+"班";
			$("#studentName").text(currentStudent.name);
			$("#stInfo").text(classInfo);
			if(currentStudent.photo!=null){
				$("#photo").attr("src",currentStudent.photo);
			}else{
				$("#photo").attr("src","../img/stu.png");
			}
			
			searchSubjectTeacher(currentStudent.id);
			searchHeadTeacher(currentStudent.id);
			searchDormTeacher(currentStudent.id);
			
		 }
}
	
	</script>
 </body>
</html>