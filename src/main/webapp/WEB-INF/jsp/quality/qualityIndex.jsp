<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>学生档案</title>
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
		  <a href="javascript:void(0);" id="changeStudent"
		  class="weui-media-box weui-media-box_appmsg">
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
		<div class="weui-panel__hd">综合素质评价</div>
		<div class="weui-panel__bd">
			<div class="weui-media-box weui-media-box_text">
				<h4 class="weui-media-box__title">当前合计得分：356</h4>
				<p class="weui-media-box__desc">本合计得分根据以下各分项得分累加统计而来</p>
			</div>
		</div>
		<div class="weui-panel__bd">
			<div  class="weui-grid js_grid">
				 <div class="weui-grid__label">
					 <span style="font-size:34px">126</span>
				 </div>
				 <p class="weui-grid__label">
				  道德品质
				 </p>
			</div>
			<div  class="weui-grid js_grid">
				 <div class="weui-grid__label">
					 <span style="font-size:34px">96</span>
				 </div>
				 <p class="weui-grid__label">
				  公民素养
				 </p>
			</div>
			<div  class="weui-grid js_grid">
				 <div class="weui-grid__label">
					 <span style="font-size:34px">131</span>
				 </div>
				 <p class="weui-grid__label">
				  学习能力
				 </p>
			</div>
			<div  class="weui-grid js_grid">
				 <div class="weui-grid__label">
					 <span style="font-size:34px">87</span>
				 </div>
				 <p class="weui-grid__label">
				  交流与合作
				 </p>
			</div>
			<div  class="weui-grid js_grid">
				 <div class="weui-grid__label">
					 <span style="font-size:34px">101</span>
				 </div>
				 <p class="weui-grid__label">
				  运动与健康
				 </p>
			</div>
			<div  class="weui-grid js_grid">
				 <div class="weui-grid__label">
					 <span style="font-size:34px">73</span>
				 </div>
				 <p class="weui-grid__label">
				  审美与表现
				 </p>
			</div>
		</div>
   </div>

   <div class="weui-panel weui-panel_access">
    <div class="weui-panel__hd">综合素质评价历史记录</div>
	<section id="cd-timeline" class="cd-container">
		<div class="cd-timeline-block">
			<div class="cd-timeline-img cd-picture">
				<img src="../img/cd-icon-picture.svg" alt="Picture">
			</div>

			<div class="cd-timeline-content">
				<h4> 道德品质 +5分</h4>
				<span style="font-size:16px">参加锦江社区环境美化公益活动</span>
				<a href="#" class="" target="_blank" style="width:40px;height:20px;color:green"><span style="font-size:16px">详情</span></a>
				<span class="cd-date">2017-07-06</span>
			</div>
		</div>
		<div class="cd-timeline-block">
			<div class="cd-timeline-img cd-movie">
				<img src="../img/cd-icon-movie.svg" alt="Movie">
			</div>

			<div class="cd-timeline-content">
				<h4>公民素养 +3</h4>
				<span style="font-size:16px"> 参加法律知识竞答比赛获三等奖 </span>
				<a href="#" class="" target="_blank" style="width:40px;height:20px;color:green"><span style="font-size:16px">详情</span></a>
				<span class="cd-date">2017-06-01</span>
			</div>
		</div>
		<div class="cd-timeline-block">
			<div class="cd-timeline-img cd-picture">
				<img src="../img/cd-icon-picture.svg" alt="Picture">
			</div>

			<div class="cd-timeline-content">
				<h4> 学习能力 +10</h4>
				<span style="font-size:16px"> 参加四川省智能机器人大赛获二等奖 </span>
				<a href="#" class="" target="_blank" style="width:40px;height:20px;color:green"><span style="font-size:16px">详情</span></a>
				<span class="cd-date">2017-4-20</span>
			</div>
		</div>
		<div class="cd-timeline-block">
			<div class="cd-timeline-img cd-movie">
				<img src="../img/cd-icon-movie.svg" alt="Movie">
			</div>

			<div class="cd-timeline-content">
				<h4>运动与健康 +4</h4>
				<span style="font-size:16px"> 2017锦江校区运动会长跑第三名 </span>
				<a href="#" class="" target="_blank" style="width:40px;height:20px;color:green"><span style="font-size:16px">详情</span></a>
				<span class="cd-date">2014-12-14</span>
			</div>
		</div>
		<div class="cd-timeline-block">
			<div class="cd-timeline-img cd-movie">
				<img src="../img/cd-icon-location.svg" alt="Location">
			</div>

			<div class="cd-timeline-content">
				<h4>交流与合作</h4>
				<span style="font-size:16px"> 积极参与学习兴趣小组活动 </span>
				<a href="#" class="" target="_blank" style="width:40px;height:20px;color:green"><span style="font-size:16px">详情</span></a>
				<span class="cd-date">2014-12-05</span>
			</div>
		</div>
	</section>
   </div>
    <script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/echarts/echarts.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>

	<script>
	  $(function() {
		FastClick.attach(document.body);
	  });
	
		$("#uploadBtn").on("click",function(){
			console.log($("#half").css("display"));
			if($("#half").css("display") == "none"){
				$("#half").popup();
			} else {
				$.closePopup()
			}
			
			console.log($("#half").css("display"));
		});
		
		//学生选择
		/* $(document).on("click", "#changeStudent", function() {
	        $.actions({
	          title: "选择学生",
	          onClose: function() {
	            console.log("close");
	          },
	          actions: [
	            {
	              text: "李小明",
	              className: "color-primary",
	              onClick: function() {
					   window.location.href="nav.html";
	              }
	            },
	            {
	              text: "李小红",
	              className: "color-warning",
	              onClick: function() {
	                 window.location.href="nav.html";
	              }
	            }
	          ]
	        });
	      }); */
		
		
		//文档加载完毕执行 
		 $(function() {
		 		//解决移动端点击事件延迟
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
	</script>
 </body>
</html>