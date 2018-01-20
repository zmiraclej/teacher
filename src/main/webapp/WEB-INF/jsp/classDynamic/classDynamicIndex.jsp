<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet" href="../js/webuploader/webuploader.css">
<link rel="stylesheet" href="../js/refreshPage/css/refreshPage.css">

<link rel="stylesheet prefetch"
	href="../css/photoswipecss/photoswipe.css">
<link rel="stylesheet prefetch"
	href="../css/photoswipecss/default-skin/default-skin.css">



</head>
<body>

	<div class="weui-panel weui-panel_access">
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
	</div>

	<div class="weui-panel weui-panel_access">
		<div class="weui-panel__bd">
			<a href="javascript:void(0);"
				class="weui-media-box weui-media-box_appmsg">
				<div class="weui-media-box__bd ">
					<input class="weui-input" id="ss" type="text" value="班级">
				</div>
			</a>
		</div>
	</div>

	<div class="weui-panel weui-panel_access">
		<div class="weui-panel__hd">
			<textarea placeholder="发表点儿什么吧。。。" id="contentInfo"
				class="weui-textarea"
				style="border: 1px solid rgb(169, 169, 169); margin-bottom: 20px;"></textarea>

			<div class="weui-panel weui-panel_access" id="js-class-img"
				style="display: none; margin-bottom: 20px;"></div>
			<div>
				<a href="javascript:;" id="filePicker">图片</a> <a href="javascript:;"
					class="weui-btn weui-btn_mini weui-btn_primary" id="js-save">发布</a>
			</div>
		</div>


		<div class="weui-panel__bd" id="classDynamic"></div>

		<div class="classcircle" id="wrapper"></div>
	</div>

	<!-- 插件固定写法开始 -->
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

					<button class="pswp__button pswp__button--close"
						title="Close (Esc)"></button>

					<button class="pswp__button pswp__button--share" title="Share"></button>

					<button class="pswp__button pswp__button--fs"
						title="Toggle fullscreen"></button>

					<button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>

					<!-- element will get class pswp__preloader--active when preloader is running -->
					<div class="pswp__preloader">
						<div class="pswp__preloader__icn">
							<div class="pswp__preloader__cut">
								<div class="pswp__preloader__donut"></div>
							</div>
						</div>
					</div>
				</div>

				<div
					class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
					<div class="pswp__share-tooltip"></div>
				</div>

				<button class="pswp__button pswp__button--arrow--left"
					title="Previous (arrow left)"></button>

				<button class="pswp__button pswp__button--arrow--right"
					title="Next (arrow right)"></button>

				<div class="pswp__caption">
					<div class="pswp__caption__center"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- 插件固定写法结束 -->




	<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script src="../js/pages/classDynamic/classDynamic.js"></script>
	<script src="../js/webuploader/webuploader.min.js"></script>
	<script src="../js/refreshPage/js/iscroll.js"></script>
	<script src="../js/refreshPage/js/refreshPage.js"></script>

	<script src="../js/plugins/photoswipejs/photoswipe.js"></script>
	<script src="../js/plugins/photoswipejs/photoswipe-ui-default.min.js"></script>
	<script type="text/javascript">
		$(function() {

			$("#ss").select({
				title : "班级",
				items : [ {
					title : "关联班级",
					value : 1
				}, {
					title : "全部班级",
					value : 2
				} ]
			});

			$
					.ajax({
						url : "../classDynamic/detail",
						type : "get",
						success : function(data) {
							$
									.each(
											data,
											function(i, info) {
												var html = "";
												var pics = info.pics;
												var arr = pics.split(",");

												var createdTime = info.createdTime;
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
												for (cd in arr) {
													html += '<figure><div style="float:left"><a href="..'+arr[cd]+'" data-size="640x426"><img height=38 width=50 src="..'+arr[cd]+'"></a></figure>';
												}
												html += '</div></div>';
												$("#classDynamic").append(html);

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
														alert("dianji");
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
						}
					});

		});

		var uploader = new WebUploader.Uploader(
				{

					// 选完文件后，是否自动上传。
					auto : true,

					// swf文件路径
					swf : '../js/webuploader/Uploader.swf',

					// 文件接收服务端。
					server : '../fileUpload/photo',

					// 选择文件的按钮。可选。
					// 内部根据当前运行是创建，可能是input元素，也可能是flash.
					pick : '#filePicker',

					// 只允许选择图片文件。
					accept : {
						title : 'Images',
						extensions : 'gif,jpg,jpeg,bmp,png,txt,doc,docx,zip,rar,pdf,xls,xlsx',
						mimeTypes : '*'
					}
				});

		uploader.on('beforeFileQueued', function(file) {
			var ext = file.ext.toLowerCase();
			var extAll = "gif,jpg,jpeg,bmp,png";
			if (extAll.indexOf(ext) == -1) {
				$.alert("请上传正确格式的图片");
				return false;
			} else {
				return true;
			}
		});

		uploader.on('uploadSuccess', function(file, response) {
			//			$("#js-class-img").append($("<i>").css("background-image","url(.."+response.url+")").css("width","100px").css("height","100px").css("display","block")
			$("#js-class-img").append(
					$("<img style='height:80px;width:80px;margin-left:5px' >")
							.attr("src", ".." + response.url).addClass(
									"icon-trash").append(
									$("<a id='aaa' onclick='hi()'> ").attr(
											"href", "javascript:void(0);")
											.addClass("icon-trash")).append(
									$("<input>").attr("type", "hidden")
											.addClass("js-add-imgurl").val(
													response.url)));
			$("#js-class-img").show();
		})

		$(function() {

			$(document).delegate('.icon-trash,.icon-remove', 'click',
					function() {
						var li = $(this);
						$.confirm({
							title : '删除',
							text : '确认要删除图片吗？',
							onOK : function() {
								li.remove();
							},
							onCancel : function() {
							}
						})

					});

			//发布朋友圈
			$("#js-save").click(
					function() {
						var content = $("#contentInfo").val();
						if (!content) {
							$.alert("请输入内容!");
							return false;
						}
						var datas = new Array();
						var uris = new Array();
						$(".js-add-imgurl").each(function() {
							uris.push($(this).val());
						});
						if (uris.length == 0) {
							$.alert("请上传您要分享的资源!");
							return false;
						}

						datas = {
							pics : uris.toString(),
							content : content,
							infoType : 'hhh'
						}

						$.post("../classDynamic/saveClassCircleInfo", datas,
								function(data) {
									if (data == "success") {
										$.alert("发布成功", function() {
											location.reload();
										});
									} else {
										$.alert(data.message);
									}
								});
					});
		});
	</script>
</body>
</html>