<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>综合分析</title>
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<meta name="description" content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.
">
<link rel="stylesheet" href="../css/common/v-time-style.css">
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">


</head>

<body ontouchstart>

   <div class="weui-panel weui-panel_access">
	<div class="weui-panel__hd">学生信息</div>
	<div class="weui-panel__bd">
	  <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
		<div class="weui-media-box__hd">
		  <img class="weui-media-box__thumb" src="../img/stu.png" alt="">
		</div>
		<div class="weui-media-box__bd">
		  <h4 class="weui-media-box__title">李明</h4>
		  <p class="weui-media-box__desc">锦江校区、初中一年级五班</p>
		</div>
	  </a>
	</div>
   </div>

   <div class="weui-panel weui-panel_access">
	<div class="weui-panel__hd">成绩综合数据</div>
	<div class="weui-panel__bd">
		   <div  class="weui-grid js_grid">
				 <div class="weui-grid__label">
					 <span style="font-size:24px">6</span>
				 </div>
				 <p class="weui-grid__label">
				     最近进步名次
				 </p>
			</div>
			<div  class="weui-grid js_grid">
				 <div class="weui-grid__label">
					 <span style="font-size:24px">化学</span>
				 </div>
				 <p class="weui-grid__label">
				     排名最低学科
				 </p>
			</div>
			<div  class="weui-grid js_grid">
				 <div class="weui-grid__label">
					 <span style="font-size:24px">阅读理解</span>
				 </div>
				 <p class="weui-grid__label">
				     失分率最高
					 
				 </p>
			</div>
	</div>
	<div class="weui-panel__bd">
	</div>
	<div class="weui-panel__ft">
	  <a href="score.html" class="weui-cell weui-cell_access weui-cell_link">
		<div class="weui-cell__bd">查看更多</div>
		<span class="weui-cell__ft"></span>
	  </a>    
	</div>
  </div>
  
  <div class="weui-panel weui-panel_access">
	<div class="weui-panel__hd">综合素质数据</div>
	<div class="weui-panel__bd" style="height:200x;width:100%">
			 <div id="navQualityChart" class="chartDisContainer" style="height:400px;margin-top:5px"></div>
	</div>
	<div class="weui-panel__bd">
	</div>
	<div class="weui-panel__ft">
	  <a href="quality.html" class="weui-cell weui-cell_access weui-cell_link">
		<div class="weui-cell__bd">查看更多</div>
		<span class="weui-cell__ft"></span>
	  </a>    
	</div>
  </div>
  
  <div class="weui-panel weui-panel_access">
	<div class="weui-panel__hd">考勤综合统计数据</div>
	<div class="weui-panel__bd">
		    <div  class="weui-grid js_grid">
				 <div class="weui-grid__label">
					 <span style="font-size:34px">2</span>
				 </div>
				 <p class="weui-grid__label">
				     本月迟到次数
				 </p>
			</div>
			<div  class="weui-grid js_grid">
				 <div class="weui-grid__label">
					 <span style="font-size:34px">0</span>
				 </div>
				 <p class="weui-grid__label">
				     本月早退次数
				 </p>
			</div>
			<div  class="weui-grid js_grid">
				 <div class="weui-grid__label">
					 <span style="font-size:34px">0</span>
				 </div>
				 <p class="weui-grid__label">
				     本月缺勤次数
				 </p>
			</div>
	</div>
	<div class="weui-panel__bd">
	</div>
	<div class="weui-panel__ft">
	  <a href="attendance.html" class="weui-cell weui-cell_access weui-cell_link">
		<div class="weui-cell__bd">查看更多</div>
		<span class="weui-cell__ft"></span>
	  </a>    
	</div>
  </div>
  
   <div class="weui-panel weui-panel_access">
	<div class="weui-panel__hd">成长足迹综合数据</div>
	<div class="weui-panel__bd">
	     <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>话剧团演出</p>
            </div>
            <div class="weui-cell__ft">6月20日</div>
          </div>
		  <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>非物质文化传承宣传活动</p>
            </div>
            <div class="weui-cell__ft">5月15日</div>
          </div>
	</div>
	<div class="weui-panel__bd">
	</div>
	<div class="weui-panel__ft">
	  <a href="growth.html" class="weui-cell weui-cell_access weui-cell_link">
		<div class="weui-cell__bd">查看更多</div>
		<span class="weui-cell__ft"></span>
	  </a>    
	</div>
  </div>
			  
	
    <script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/echarts/echarts.js"></script>


	<script>
	  $(function() {
		FastClick.attach(document.body);
	  });
	</script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
    <script src="../js/pages/comprehensiveAnalysis/index.js"></script>
 </body>
</html>