<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>学生信息详情</title>
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


  </head>

  <body ontouchstart>
	<input type="hidden" value="${id }" id="studentId">
	
	
	<div class="weui-panel weui-panel_access">
		<div class="weui-panel__hd">学生信息</div>
		<div class="weui-panel__bd">
		  <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg" id="changeStudent">
			<div class="weui-media-box__hd">
			  <img id="photo" style="border-radius:50%"  height="120" width="120" class="weui-media-box__thumb" src="../img/stu.png" alt=""></div>
			</div>
			<div class="weui-media-box__bd">
			  <h4 class="weui-media-box__title" id="studentName"></h4>
			  <p class="weui-media-box__desc">
              	<span id="schoolInfo"></span>
              	<span id="classInfo"></span></p>
			</div>
		  </a>
		</div>
	  </div>
	  
	 <div class="weui-panel weui-panel_access">
		<div class="weui-panel__hd">基本档案</div>
		<div class="weui-panel__bd">
			<div class="weui-media-box weui-media-box_text">
				<h4 class="weui-media-box__title" id="schoolClassInfo"></h4>
				<p class="weui-media-box__desc" id="registerYear"></p>
			</div>
		</div>
		<div class="weui-panel__bd">
		</div>
	  </div>
  
	  <div class="weui-panel weui-panel_access" style="margin-bottom:30px">
			<div class="weui-panel__hd" >日常活动</div>
			<div margin-top="5px" class="weui-panel__bd" id="dailyActive">	
			
    		</div>
		    <div class="weui-panel__bd"></div>
	  </div>
 
 
 <!-- 插件固定写法开始 -->
<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">

    <div class="pswp__bg"></div>

    <div class="pswp__scroll-wrap">

        <div class="pswp__container">
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
        </div>

        <div class="pswp__ui pswp__ui--hidden">

            <div class="pswp__top-bar">


                <div class="pswp__counter"></div>

                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>


                <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>

                <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>

                <div class="pswp__preloader">
                    <div class="pswp__preloader__icn">
                      <div class="pswp__preloader__cut">
                        <div class="pswp__preloader__donut"></div>
                      </div>
                    </div>
                </div>
            </div>

            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                <div class="pswp__share-tooltip"></div> 
            </div>

            <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
            </button>

            <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
            </button>

            <div class="pswp__caption">
                <div class="pswp__caption__center"></div>
            </div>
        </div>
    </div>
</div>
 <!-- 插件固定写法结束 -->
	


    <script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/echarts/echarts.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script>

	//查询学生详情
	$(function(){
		var studentNo=$("#studentId").val();
		 $.ajax({
				url:"../phoneNumList/searchWtrjStudent",
				type:"post",
				data : {
					studentNo:studentNo
					},
				success:function(data){
					if("02" == data.code){
					var student=data.data;
					var name=student.name;	
					var gradeNo=student.gradeNo!=null?student.gradeNo:" ";
					var classNo=student.classNo!=null?student.classNo:" ";
					var code=student.cureentSchoolCode;
					var photo=student.photo;
					if(code==""||code==null){
						code=="";
					}
					if(code==1||code==2||code==3||code==4||code==5){
						code="锦江校区";
					}
					if(code==6||code==7||code==8||code==9){
						code="成华校区";
					}
					if(code==10||code==12||code==13||code==11){
						code="郫都校区";
					}
					if(code==14||code==15||code==16||code==17){
						code="北城校区";
					}
					if(code==18||code==19||code==20||code==21){
						code="达州校区";
					}
					if(code==22||code==23||code==24||code==25){
						code="都江堰校区";
					}
					var classInfo=gradeNo+"年级"+classNo+"班";
					var schoolClassInfo=code+" "+classInfo;
					$("#studentName").text(name);
					$("#schoolInfo").text(code);
					$("#classInfo").text(classInfo);
					$("#schoolClassInfo").text(schoolClassInfo);
					
					if(photo.indexOf("null")>0){
						$("#photo").attr("src","../img/stu.png");
					}else{
						$("#photo").attr("src",photo);
					}
					}
				}
			})  	
	});


	
	
	 //返回
	 $("#goBack").on("click",function(){
		 window.location.href="../pageSkip/phoneNumList";
		});
	
	
	//查询活动详情
	$(function(){
		var id=$("#studentId").val();
		
	FastClick.attach(document.body);
	$.ajax({
	url : "../phoneNumList/searchDailyActivities",
	type : "get",
	 data : {
			stuIdCard:id
		}, 
	success : function(data) {
		if("02" == data.code){
			$("#dailyActive").html("");
		var result=data.data;
		$.each(result,function(i, info) {
							var html = "";
							var pics = info.attachFile;
							
							var createdTime = info.activityDate;
							var month = createdTime
									.substring(5, 7)
									+ "月";
							var day = createdTime
									.substring(8);

							html += '<div class="weui-media-box__hd" style="width:100px;margin-left: 20px;"><span style="font-size:24px">'
									+ day
									+ '</span>&nbsp;<span style="font-size:16px">'
									+ month
									+ '</span></div>'
									+'<div class="weui-media-box__bd" >'
									+ '<span style="font-size:16px;margin-left:20px;">'
									+ info.content
									+ '</span>'
									+ '<div class="my-gallery" data-pswp-uid="3" style="margin-left: 20px;">';
							
									
									
									//多个图片
								if(pics.indexOf(",")!= -1){
									var arr = pics.split(",");
									for (cd in arr) {
										html += '<figure><div style="float:left"><a href="'+arr[cd]+'" data-size="600x600"><img height=100 width=100 src="'+arr[cd]+'"></a></figure>';
									}
								}else{
									html += '<figure><div style="float:left"><a href="'+pics+'" data-size="600x600"><img height=100 width=100 src="'+pics+'"></a></figure>';
								}	
								
							html += '</div></div>';
							$("#dailyActive").append(html);

							//下面固定			
							var initPhotoSwipeFromDOM = function(
									gallerySelector) {

								// 解析来自DOM元素幻灯片数据（URL，标题，大小...）
								// (children of gallerySelector)
								var parseThumbnailElements = function(
										el) {

									var thumbElements = el.childNodes, numNodes = thumbElements.length, items = [], figureEl, linkEl, size, item, divEl;

									for (var i = 0; i < numNodes; i++) {

										figureEl = thumbElements[i]; // <figure> element

										// 仅包括元素节点
										if (figureEl.nodeType !== 1) {
											continue;
										}
										divEl = figureEl.children[0];
										linkEl = divEl.children[0]; // <a> element

										size = linkEl
												.getAttribute(
														'data-size')
												.split('x');

										// 创建幻灯片对象
										item = {
											src : linkEl
													.getAttribute('href'),
											w : parseInt(
													size[0],
													10),
											h : parseInt(
													size[1],
													10)
										};

										if (figureEl.children.length > 1) {
											// <figcaption> content
											item.title = figureEl.children[1].innerHTML;
										}

										if (linkEl.children.length > 0) {
											// <img> 缩略图节点, 检索缩略图网址
											item.msrc = linkEl.children[0]
													.getAttribute('src');
										}

										item.el = figureEl; // 保存链接元素 for getThumbBoundsFn
										items.push(item);
									}

									return items;
								};

								// 查找最近的父节点
								var closest = function closest(
										el, fn) {
									return el
											&& (fn(el) ? el
													: closest(
															el.parentNode,
															fn));
								};

								// 当用户点击缩略图触发
								var onThumbnailsClick = function(
										e) {
									
									e = e || window.event;
									e.preventDefault ? e
											.preventDefault()
											: e.returnValue = false;

									var eTarget = e.target
											|| e.srcElement;

									// find root element of slide
									var clickedListItem = closest(
											eTarget,
											function(el) {
												return (el.tagName && el.tagName
														.toUpperCase() === 'FIGURE');
											});

									if (!clickedListItem) {
										return;
									}

									// find index of clicked item by looping through all child nodes
									// alternatively, you may define index via data- attribute
									var clickedGallery = clickedListItem.parentNode, childNodes = clickedListItem.parentNode.childNodes, numChildNodes = childNodes.length, nodeIndex = 0, index;

									for (var i = 0; i < numChildNodes; i++) {
										if (childNodes[i].nodeType !== 1) {
											continue;
										}

										if (childNodes[i] === clickedListItem) {
											index = nodeIndex;
											break;
										}
										nodeIndex++;
									}

									if (index >= 0) {
										// open PhotoSwipe if valid index found
										openPhotoSwipe(
												index,
												clickedGallery);
									}
									return false;
								};

								// parse picture index and gallery index from URL (#&pid=1&gid=2)
								var photoswipeParseHash = function() {
									var hash = window.location.hash
											.substring(1), params = {};

									if (hash.length < 5) {
										return params;
									}

									var vars = hash
											.split('&');
									for (var i = 0; i < vars.length; i++) {
										if (!vars[i]) {
											continue;
										}
										var pair = vars[i]
												.split('=');
										if (pair.length < 2) {
											continue;
										}
										params[pair[0]] = pair[1];
									}

									if (params.gid) {
										params.gid = parseInt(
												params.gid,
												10);
									}

									return params;
								};

								var openPhotoSwipe = function(
										index,
										galleryElement,
										disableAnimation,
										fromURL) {

									var pswpElement = document
											.querySelectorAll('.pswp')[0], gallery, options, items;

									items = parseThumbnailElements(galleryElement);

									// 这里可以定义参数
									options = {
										barsSize : {
											top : 100,
											bottom : 100
										},
										fullscreenEl : false,
										shareButtons : [
												 ],

										// define gallery index (for URL)
										galleryUID : galleryElement
												.getAttribute('data-pswp-uid'),

										getThumbBoundsFn : function(
												index) {
											// See Options -> getThumbBoundsFn section of documentation for more info
											var thumbnail = items[index].el
													.getElementsByTagName('img')[0], // find thumbnail
											pageYScroll = window.pageYOffset
													|| document.documentElement.scrollTop, rect = thumbnail
													.getBoundingClientRect();

											return {
												x : rect.left,
												y : rect.top
														+ pageYScroll,
												w : rect.width
											};
										}

									};

									// PhotoSwipe opened from URL
									if (fromURL) {
										if (options.galleryPIDs) {
											// parse real index when custom PIDs are used 
											for (var j = 0; j < items.length; j++) {
												if (items[j].pid == index) {
													options.index = j;
													break;
												}
											}
										} else {
											// in URL indexes start from 1
											options.index = parseInt(
													index,
													10) - 1;
										}
									} else {
										options.index = parseInt(
												index, 10);
									}

									// exit if index not found
									if (isNaN(options.index)) {
										return;
									}

									if (disableAnimation) {
										options.showAnimationDuration = 0;
									}

									// Pass data to PhotoSwipe and initialize it
									gallery = new PhotoSwipe(
											pswpElement,
											PhotoSwipeUI_Default,
											items, options);
									gallery.init();
								};

								// loop through all gallery elements and bind events
								var galleryElements = document
										.querySelectorAll(gallerySelector);

								for (var i = 0, l = galleryElements.length; i < l; i++) {
									galleryElements[i]
											.setAttribute(
													'data-pswp-uid',
													i + 1);
									galleryElements[i].onclick = onThumbnailsClick;
								}

								// Parse URL and open gallery if it contains #&pid=3&gid=1
								var hashData = photoswipeParseHash();
								if (hashData.pid
										&& hashData.gid) {
									openPhotoSwipe(
											hashData.pid,
											galleryElements[hashData.gid - 1],
											true, true);
								}
							};

							// execute above function
							initPhotoSwipeFromDOM('.my-gallery');

							$(".my-gallery>figure>div")
									.each(
											function() {
												$(this)
														.height(
																$(
																		this)
																		.width());
											});
							function more(obj, id) {

								if ($('#txt' + id).is(
										":hidden")) {
									$('#p' + id).hide();
									$('#txt' + id).show();
									obj.innerHTML = '收起';
								} else {
									$('#p' + id).show();
									$('#txt' + id).hide();
									obj.innerHTML = '全文';
								}
							}

						});
		//
	}else{
		$("#dailyActive").html("&nbsp;&nbsp;&nbsp;"+"暂无活动记录");
	}
	}
});
	 
})
	 


	
	</script>
 </body>
</html>