<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发布班级圈</title>
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
	<script src="../js/pages/classCircle/classCirclePublish.js"></script>
	<script src="../js/webuploader/webuploader.html5only.min.js"></script>

	<script src="../js/plugins/photoswipejs/photoswipe.js"></script>
	<script src="../js/plugins/photoswipejs/photoswipe-ui-default.min.js"></script>


</head>
<body>
	
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
		<div class="weui-panel__hd">
			<textarea placeholder="发表点儿什么吧。。。" id="contentInfo"
				class="weui-textarea"
				style="border: 1px solid rgb(169, 169, 169); margin-bottom: 20px;"></textarea>

			<div class="weui-panel weui-panel_access" id="js-class-img"
				style="display: none; margin-bottom: 20px;"></div>
			<div>
				<a href="javascript:;" id="filePicker">图片</a> 
				
			</div>
		</div>
		</div>
		
		<div class="weui-panel weui-panel_access">
			<div class="weui-panel__hd">
				<a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary" id="js-save">发布</a>
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
	var uploader = new WebUploader.Uploader(
			{   // 选完文件后，是否自动上传。
				auto : true,
				// swf文件路径
				swf : '../js/webuploader/Uploader.swf',
				// 文件接收服务端。
				server : '../classCircle/uploadPhoto',
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
		$("#js-class-img").append(
				$("<img style='height:80px;width:80px;margin-left:5px' >")
						.attr("src",response.url).addClass(
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
				//		   $.alert(c);
				        },
					});
			}
			
		});
		
		$("#ccType").select({
			 title: "请选择类型！",
			  items: [
			    {
			      title: "班级可见",
			      value: "01",
			    },
			    {
			      title: "公开",
			      value: "02",
			    }]
			});
		
		
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

					
					
					if(typeof($("#cc").attr("data-values"))=="undefined"){
						$.alert("请选择班级");
						return false;
					}
					if(typeof($("#ccType").attr("data-values"))=="undefined"){
						$.alert("请选择可见范围");
						return false;
					}
					
					datas = {
							content : content,
							attachFile : uris.toString(),
							classId:$("#cc").attr("data-values"),
							type:$("#ccType").attr("data-values")
						}
					
					$.post("../classCircle/saveClassCircle", datas,
							function(data) {
								if (data == "success") {
									$.alert("发布成功", function() {
										location.reload();
									});
								} else {
									$.alert(data);
								}
							});
				});
		
		
	});
</script>
</body>
</html>