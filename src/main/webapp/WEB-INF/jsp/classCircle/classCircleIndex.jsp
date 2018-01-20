<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班级圈</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">

<meta name="description"
	content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.
">
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet" href="../js/webuploader/webuploader.css">

<link rel="stylesheet prefetch"
	href="../css/photoswipecss/photoswipe.css">
<link rel="stylesheet prefetch"
	href="../css/photoswipecss/default-skin/default-skin.css">

<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
<!-- 	<script src="../js/pages/classCircle/classCirclePublish.js"></script>-->	
	<script src="../js/webuploader/webuploader.min.js"></script>


	<script src="../js/plugins/photoswipejs/photoswipe.js"></script>
	<script src="../js/plugins/photoswipejs/photoswipe-ui-default.min.js"></script>


</head>
<body>

	<!-- <div class="weui-panel weui-panel_access">
		<div class="weui-panel__hd">学生信息</div>
		<div class="weui-panel__bd">
			<a href="javascript:void(0);" id="changeStudent"
				class="weui-media-box weui-media-box_appmsg">
				<div class="weui-media-box__hd">
					<img class="weui-media-box__thumb" src="../img/stu.png" alt="">
				</div>
				<div class="weui-media-box__bd">
					<h4 id="studentName" class="weui-media-box__title"></h4>
					<p id="studentInfo" class="weui-media-box__desc"></p>
				</div>
			</a>
		</div>
	</div> -->
	
	<div class="weui-panel weui-panel_access">
	        <!-- <div class="weui-panel__hd">
	        班级：<input id="cc" type="text" value="请选择班级"> 
	        可见范围： <input  id="ccType" type="text" value="请选择可见范围">
	        </div> -->
	        
	        <div class="weui-cell">
							<div class="weui-cell__hd">
								<label class="weui-label">班级：</label>
							</div>
							<div class="weui-cell__bd">
								<input id="cc" name="cc" class="weui-input required"
									type="text" placeholder="请选择班级">
							</div>
							<div class="weui-cell__hd">
								<label class="weui-label">可见范围：</label>
							</div>
							<div class="weui-cell__bd">
								<input id="ccType" name="ccType" class="weui-input required"
									type="text" placeholder="请选择可见范围">
							</div>
						</div>
        </div>
		
		<div class="weui-panel weui-panel_access">
		<div class="weui-panel__bd" id="classDynamic"></div>
		</div>
		<div class="weui-panel weui-panel_access">
			<div class="weui-panel__hd">
				<a href="javascript:;"class="weui-btn weui-btn_mini weui-btn_primary" id="js-redirect">发布页面</a>
			</div>
		</div>
	
	   <!-- Root element of PhotoSwipe. Must have class pswp. -->
	<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
        <!-- Background of PhotoSwipe. 
         It's a separate element as animating opacity is faster than rgba(). -->
        <div class="pswp__bg"></div>
        <!-- Slides wrapper with overflow:hidden. -->
        <div class="pswp__scroll-wrap">
            <!-- Container that holds slides. 
            PhotoSwipe keeps only 3 of them in the DOM to save memory.
            Don't modify these 3 pswp__item elements, data is added later on. -->
            <div class="pswp__container">
                <div class="pswp__item"></div>
                <div class="pswp__item"></div>
                <div class="pswp__item"></div>
            </div>
            <!-- Default (PhotoSwipeUI_Default) interface on top of sliding area. Can be changed. -->
            <div class="pswp__ui pswp__ui--hidden">
                <div class="pswp__top-bar">
                    <!--  Controls are self-explanatory. Order can be changed. -->
                    <div class="pswp__counter"></div>
                    <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>
                    <!-- <button class="pswp__button pswp__button--share" title="Share"></button> -->
                    <!--  <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button> -->
                    <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>
                    <!-- Preloader demo http://codepen.io/dimsemenov/pen/yyBWoR -->
                    <!-- element will get class pswp__preloader--active when preloader is running -->
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

	<script type="text/javascript">
	
	function selectClassCircle(){
			
		var datas = {
				classId:$("#cc").attr("data-values"),
				type:$("#ccType").attr("data-values")
			}
		$.ajax({
			url : "../classCircle/searchWtrjEcomClassCircle",
			type : "get",
			data:datas,
			success : function(data) {
				$("#classDynamic").html("");
				$.each(data,function(i, info) {
									var html = "";
									var pics = info.attachFile;
									var arr = pics.split(",");

									var publishTime = info.publishTime;
									var month = publishTime
											.substring(5, 7)
											+ "月";
									var day = publishTime
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
									for (cd in arr) {
										html += '<figure><div style="float:left"><a href="'+arr[cd]+'" data-size="640x426"><img height=38 width=50 src="'+arr[cd]+'"></a></figure>';
									}
									html += '</div></div>';
									$("#classDynamic").append(html);

									//下面固定			
									var initPhotoSwipeFromDOM = function(gallerySelector) {
										// 解析来自DOM元素幻灯片数据（URL，标题，大小...）
										// (children of gallerySelector)
										var parseThumbnailElements = function(el) {

											var thumbElements = el.childNodes, numNodes = thumbElements.length, items = [], figureEl, linkEl, size, item, divEl;

											for (var i = 0; i < numNodes; i++) {

												figureEl = thumbElements[i]; // <figure> element

												// 仅包括元素节点
												if (figureEl.nodeType !== 1) {
													continue;
												}
												divEl = figureEl.children[0];
												linkEl = divEl.children[0]; // <a> element

												size = linkEl.getAttribute('data-size').split('x');

												// 创建幻灯片对象
												item = {
													src : linkEl.getAttribute('href'),
													w : parseInt(size[0],10),h : parseInt(size[1],10)
												};

												if (figureEl.children.length > 1) {
													// <figcaption> content
													item.title = figureEl.children[1].innerHTML;
												}

												if (linkEl.children.length > 0) {
													// <img> 缩略图节点, 检索缩略图网址
													item.msrc = linkEl.children[0].getAttribute('src');
												}

												item.el = figureEl; // 保存链接元素 for getThumbBoundsFn
												items.push(item);
											}

											return items;
										};

										// 查找最近的父节点
										var closest = function closest(el, fn) {
											return el&& (fn(el) ? el: closest(el.parentNode,fn));
										};

										// 当用户点击缩略图触发
										var onThumbnailsClick = function(e) {
											e = e || window.event;
											e.preventDefault ? e.preventDefault(): e.returnValue = false;

											var eTarget = e.target|| e.srcElement;

											// find root element of slide
											var clickedListItem = closest(eTarget,function(el) {
														return (el.tagName && el.tagName.toUpperCase() === 'FIGURE');
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
												openPhotoSwipe(index,clickedGallery);
											}
											return false;
										};

										// parse picture index and gallery index from URL (#&pid=1&gid=2)
										var photoswipeParseHash = function() {
											var hash = window.location.hash.substring(1), params = {};

											if (hash.length < 5) {
												return params;
											}

											var vars = hash.split('&');
											for (var i = 0; i < vars.length; i++) {
												if (!vars[i]) {
													continue;
												}
												var pair = vars[i].split('=');
												if (pair.length < 2) {
													continue;
												}
												params[pair[0]] = pair[1];
											}

											if (params.gid) {
												params.gid = parseInt(params.gid,10);
											}

											return params;
										};

										var openPhotoSwipe = function(index,galleryElement,disableAnimation,fromURL) {

											var pswpElement = document.querySelectorAll('.pswp')[0], gallery, options, items;

											items = parseThumbnailElements(galleryElement);

											// 这里可以定义参数
											options = {
												barsSize : {
													top : 100,
													bottom : 100
												},
												fullscreenEl : false,
												shareButtons : [
														{
															id : 'wechat',
															label : '分享微信',
															url : '#'
														},
														{
															id : 'weibo',
															label : '新浪微博',
															url : '#'
														},
														{
															id : 'download',
															label : '保存图片',
															url : '{{raw_image_url}}',
															download : true
														} ],

												// define gallery index (for URL)
												galleryUID : galleryElement.getAttribute('data-pswp-uid'),

												getThumbBoundsFn : function(index) {
													// See Options -> getThumbBoundsFn section of documentation for more info
													var thumbnail = items[index].el.getElementsByTagName('img')[0], // find thumbnail
													pageYScroll = window.pageYOffset|| document.documentElement.scrollTop, rect = thumbnail.getBoundingClientRect();

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
													options.index = parseInt(index,10) - 1;
												}
											} else {
												options.index = parseInt(index, 10);
											}

											// exit if index not found
											if (isNaN(options.index)) {
												return;
											}

											if (disableAnimation) {
												options.showAnimationDuration = 0;
											}

											// Pass data to PhotoSwipe and initialize it
											gallery = new PhotoSwipe(pswpElement,PhotoSwipeUI_Default,items, options);
											gallery.init();
										};

										// loop through all gallery elements and bind events
										var galleryElements = document.querySelectorAll(gallerySelector);

										for (var i = 0, l = galleryElements.length; i < l; i++) {
											galleryElements[i].setAttribute('data-pswp-uid',i + 1);
											galleryElements[i].onclick = onThumbnailsClick;
										}

										// Parse URL and open gallery if it contains #&pid=3&gid=1
										var hashData = photoswipeParseHash();
										if (hashData.pid&& hashData.gid) {
											openPhotoSwipe(hashData.pid,galleryElements[hashData.gid - 1],true, true);
										}
									};

									// execute above function
									initPhotoSwipeFromDOM('.my-gallery');

									$(".my-gallery>figure>div").each(function() {
														$(this).height($(this).width());
													});
									function more(obj, id) {

										if ($('#txt' + id).is(":hidden")) {
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
			}
		});
	}
	
	$(function() {
		
		$.ajax({
			url : "../classCircle/selectUserClass",
			type : "get",
			success : function(data) {
				var arr = new Array();
				$.each(data,function(i, info) {
					var c = new Object();
					c.title = info.className;
					c.value = info.id;
					arr.push(c);
				}); 
				
				$("#cc").select({
					  title: "请选择班级！",
					  items:arr,
					  onChange: function() {
						   var c =$("#cc").attr("data-values");
						//   $.alert(c);
						   selectClassCircle();
				        },
					});
			}
			
		});
		
		$("#ccType").select({
			title: "请选择可见范围",
			items: [
			    {
			      title: "班级可见",
			      value: "01",
			    },
			    {
			      title: "公开",
			      value: "02",
			    }],
			onChange: function() {
					   var ccType =$("#ccType").attr("data-values");
					//   $.alert(ccType);
					   selectClassCircle();
			},
		});
		
		//初始化加载发布者的所有班级圈
		selectClassCircle();
		
		
		$("#js-redirect").click(function(){
			window.location.href ="classCirclePublish"
		});
		

		
		
		

	});
</script>
</body>
</html>