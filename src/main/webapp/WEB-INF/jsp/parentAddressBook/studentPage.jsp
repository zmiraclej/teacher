<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>学生主页</title>
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<meta name="description" content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
<link rel="stylesheet" href="../css/common/v-time-style.css">
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
		<div class="weui-panel__hd">基本档案</div>
		<div class="weui-panel__bd">
			<div class="weui-media-box weui-media-box_text">
				<h4 class="weui-media-box__title">锦江校区 初一年级五班</h4>
				<p class="weui-media-box__desc">入学时间 2017/07/01</p>
			</div>
		</div>
	  </div>
	  
<div class="weui-panel weui-panel_access"><div class="weui-panel__hd">我的课程表</div>
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
						<td><p>语文</p><p>胡小林</p></td>
						<td><p>英语</p><p>杨健</p></td>
						<td><p>英语</p><p>杨健</p></td>
						<td><p>英语</p><p>杨健</p></td>
						<td><p>英语</p><p>杨健</p></td>
					</tr>
					<tr>
						<td><p>上午</p><p>第二节</p></td>
						<td><p>语文</p><p>胡小林</p></td>
						<td><p>英语</p><p>杨健</p></td>
						<td><p>语文</p><p>胡小林</p></td>
						<td><p>语文</p><p>胡小林</p></td>
						<td><p>语文</p><p>胡小林</p></td>
					</tr>
					<tr>
						<td><p>上午</p><p>第三节</p></td>
						<td><p>数学</p><p>郑伟</p></td>
						<td><p>数学</p><p>郑伟</p></td>
						<td><p>语文</p><p>胡小林</p></td>
						<td><p>化学</p><p>王垒</p></td>
						<td><p>英语</p><p>杨健</p></td>
					</tr>
					<tr>
						<td><p>上午</p><p>第四节</p></td>
						<td><p>数学</p><p>郑伟</p></td>
						<td><p>数学</p><p>郑伟</p></td>
						<td><p>化学</p><p>王垒</p></td>
						<td><p>英语</p><p>杨健</p></td>
						<td><p>物理</p><p>刘松</p></td>
					</tr>
					<tr>
						<td><p>下午</p><p>第一节</p></td>
						<td><p>化学</p><p>王垒</p></td>
						<td><p>英语</p><p>杨健</p></td>
						<td><p>英语</p><p>杨健</p></td>
						<td><p>化学</p><p>王垒</p></td>
						<td><p>自习</p></td>
					</tr>
					<tr>
						<td><p>下午</p><p>第二节</p></td>
					    <td><p>化学</p><p>王垒</p></td>
						<td><p>化学</p><p>王垒</p></td>
						<td><p>物理</p><p>刘松</p></td>
						<td><p>物理</p><p>刘松</p></td>
						<td><p>自习</p></td>
					</tr>
					<tr>
						<td><p>下午</p><p>第三节</p></td>
						<td><p>自习</p></td>
						<td><p>美术</p><p>王琳</p></td>
						<td><p>计算机</p><p>赵建</p></td>
						<td><p>物理</p><p>刘松</p></td>
						<td><p>体育</p><p>兰海</p></td>
					</tr>
					<tr>
						<td><p>下午</p><p>第四节</p></td>
						<td><p>自习</p></td>
						<td><p>自习</p></td>
						<td><p>自习</p></td>
						<td><p>自习</p></td>
						<td><p>体育</p><p>兰海</p></td>
					</tr>
				</tbody> 
			</table> 
			</div>
		</div>
		<div class="weui-panel weui-panel_access">
			<div class="weui-panel__hd">考勤详情</div>
		  
			<div class="weui-cells weui-cells_form">
			  <div class="weui-cell">
				<div class="weui-cell__hd"><label for="date3" class="weui-label">日期</label></div>
				<div class="weui-cell__bd">
				  <input class="weui-input" id="date3" type="text">
				</div>
			  </div>
			</div>
			<div id="inline-calendar"></div>
		</div>

      <div class="weui-cells__title">刷卡记录明细</div>
		<div class="weui-cells">
		  <div class="weui-cell">
			<div class="weui-cell__hd"><img src="../img/damen.png"></div>
			<div class="weui-cell__bd">
			  <p>锦江校区正门</p>
			</div>
			<div class="weui-cell__bd">
			  <p>上午 9:01</p>
			</div>
			<div class="weui-cell__bd">
			  <p>进入</p>
			</div>
			<div class="weui-cell__ft">正常刷卡</div>
		  </div>
		  <div class="weui-cell">
			<div class="weui-cell__hd"><img src="../img/damen.png"></div>
			<div class="weui-cell__bd">
			  <p>锦江校区正门</p>
			</div>
			<div class="weui-cell__bd">
			  <p>上午 11:01</p>
			</div>
			<div class="weui-cell__bd">
			  <p>外出</p>
			</div>
			<div class="weui-cell__ft">异常刷卡</div>
		  </div>
		  <div class="weui-cell">
			<div class="weui-cell__hd"><img src="../img/damen.png"></div>
			<div class="weui-cell__bd">
			  <p>锦江区正门</p>
			</div>
			<div class="weui-cell__bd">
			  <p>下午 13:01</p>
			</div>
			<div class="weui-cell__bd">
			  <p>进入</p>
			</div>
			<div class="weui-cell__ft">正常刷卡</div>
		  </div>
		  <div class="weui-cell">
			<div class="weui-cell__hd"><img src="../img/sushe.png"></div>
			<div class="weui-cell__bd">
			  <p>锦江校区寝室</p>
			</div>
			<div class="weui-cell__bd">
			  <p>下午 18:01</p>
			</div>
			<div class="weui-cell__bd">
			  <p>进入</p>
			</div>
			<div class="weui-cell__ft">正常刷卡</div>
		  </div>
		</div>
		
		
	<div class="weui-panel weui-panel_access">
        <div class="weui-panel__hd">选择考试</div>
        <div class="weui-panel__bd">
          <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
            <div class="weui-media-box__bd">
               <input class="weui-input" id="kaoshiIns" type="text" value="">
              <p class="weui-media-box__desc">锦江校区 考试时间：2017/06/21 </p>
            </div>
          </a>
        </div>
      </div>
	
	   <div id="junfenTongjiChart" class="chartDisContainer" style="height:400px;margin-top:5px"></div>
		<div class='demos-content-padded'>
			<a href="javascript:;" id="returnBtn" class="weui-btn  weui-btn_disabled  weui-btn_primary">报表切换：返回上层</a>
		</div>
		
    </div>
    
    <div class="weui-panel weui-panel_access">
		    <div class="weui-cells__title">综合素质评价</div>
	        <div class="weui-cells">
	          <div class="weui-cell">
	            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
	            <div class="weui-cell__bd">
	              <p>道德品质</p>
	            </div>
	            <div class="weui-cell__ft">H</div>
	          </div>
	          <div class="weui-cell">
	            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
	            <div class="weui-cell__bd">
	              <p>公民素养</p>
	            </div>
	            <div class="weui-cell__ft">H</div>
	          </div>
	          <div class="weui-cell">
	            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
	            <div class="weui-cell__bd">
	              <p>交流与合作能力</p>
	            </div>
	            <div class="weui-cell__ft">S</div>
	          </div>
	          <div class="weui-cell">
	            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
	            <div class="weui-cell__bd">
	              <p>学习能力</p>
	            </div>
	            <div class="weui-cell__ft">A</div>
	          </div>
	          <div class="weui-cell">
	            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
	            <div class="weui-cell__bd">
	              <p>运动与健康</p>
	            </div>
	            <div class="weui-cell__ft">B</div>
	          </div>
	          			          <div class="weui-cell">
	            <div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
	            <div class="weui-cell__bd">
	              <p>审美与表现</p>
	            </div>
	            <div class="weui-cell__ft">B</div>
	          </div>
	        </div>
	  </div>
	  
	  <div class="weui-panel weui-panel_access">
		<div class="weui-cells__title">个人作品</div>
		<div class="weui-cells">

		  <a class="weui-cell weui-cell_access" href="javascript:;">
			<div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			<div class="weui-cell__bd">
			  <p>四川省机器人大赛参赛作品</p>
			</div>
			<div class="weui-cell__ft">去看看</div>
		  </a>
		  <a class="weui-cell weui-cell_access" href="javascript:;">
			<div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
			<div class="weui-cell__bd">
			  <p>学校优秀手工作品</p>
			</div>
			<div class="weui-cell__ft">去看看</div>
		  </a>
		</div>
	  </div>
	  
	  <div class="weui-panel weui-panel_access" style="margin-bottom:30px">
		<div class="weui-panel__hd">日常照片</div>
		<div class="weui-panel__bd">
		  <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
			<div class="weui-media-box__hd">
			  <P>今天</P>
			</div>
			<div class="weui-media-box__bd">
			  <span style="font-size:16px">参加校外公益活动,锦江区</span>
			  <div>
			  <img src="../img/huodong1.jpg" alt="" height=38 width=50>
			  <img src="../img/huodong2.jpg" alt="" height=38 width=40>
			  <img src="../img/huodong3.jpg" alt="" height=38 width=40>
			  </div>
			  
			</div>
		  </a>
		  <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
			<div class="weui-media-box__hd">
			  <span style="font-size:24px">27</span><span style="font-size:16px">8月</span>
			</div>
			<div class="weui-media-box__bd">
			  <span style="font-size:16px">积极参加学校运动会比赛</span>
			  <div>
			  <img src="../img/tiyu1.jpg" alt="" height=38 width=50>
			  <img src="../img/tiyu2.jpg" alt="" height=38 width=40>
			  <img src="../img/tiyu3.jpg" alt="" height=38 width=40>
			  </div>
			  
			</div>
		  </a>
		</div>
		<div class="weui-panel__bd"></div>
	  </div>
    
    <script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/echarts/echarts.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script src="../js/pages/parentAddressBook/junfentongji.js"></script>
	<script>
	  $(function() {
		FastClick.attach(document.body);
	  });
	</script>
	<script>
	 $("#date3").calendar({
	        container: "#inline-calendar"
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
		
		 $("#kaoshiIns").val("2016-2017年下半学年6月份期末考试");
		  $("#kaoshiIns").picker({
		        title: "请选择考试",
		        cols: [
		          {
		            textAlign: 'center',
		            values: ['2016-2017年下半学年6月份期末考试',
		              		'2016-2017年下半学年5月份期末考试', 
							'2016-2017年下半学年4月份期末考试', 
							'2016-2017年下半学年3月份期末考试',
							'2016-2017年下半学年2月份期末考试', 
							'2016-2017年下半学年1月份期末考试']
		          }
		        ],
		        onChange: function(p, v, dv) {
		          console.log(p, v, dv);
		        },
		        onClose: function(p, v, d) {
		          console.log("close");
		        }
		      });
	</script>
 </body>
</html>
