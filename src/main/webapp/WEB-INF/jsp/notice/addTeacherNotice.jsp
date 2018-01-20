<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>新增教师通知</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet" href="../js/webuploader/webuploader.css">
<link rel="stylesheet" href="../css/common/notice.css">

</style>
</head>
<body ontouchstart>
   <div class="weui-tab">
      <div class="weui-tab__bd">
        <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
            <div class="bd">
	            <div class="weui-cells">
	
				  <a class="weui-cell weui-cell_access" href="javascript:void(0)" id="toTeacherSelect">
					<div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII=" alt="" style="width:20px;margin-right:5px;display:block"></div>
					<div class="weui-cell__bd">
					  <p>发送给谁</p>
					</div>
					<div class="weui-cell__ft">已选${selectedNum}人</div>
				  </a>
				</div>
				
			   <div class="weui-cells">
					  <div class="weui-cell weui-cell_switch">
				        <div class="weui-cell__bd">短信通知</div>
				        <div class="weui-cell__ft">
				          <input class="weui-switch" id="sendMessageFlg" type="checkbox">
				        </div>
				      </div>
			   </div>
				
				<div class="weui-panel weui-panel_access">
					<div class="weui-cells__title">通知内容</div>
				    <div class="weui-cells weui-cells_form">
				      <div class="weui-cell">
				        <div class="weui-cell__bd">
				          <textarea class="weui-textarea" placeholder="请输入通知内容" rows="3" id="content"></textarea>
				        </div>
				      </div>
				    </div>
			    </div>
			    
				<input type="hidden" id="groupFlag" value="${groupFlag}">
			  <div style="height:30px">
			  	<br>
				 <p>  </p>
		      </div>
            </div>
        </div>
      </div>
	
   </div>
   <div class="controlbar">
          <ul>
              <li>
                  <a href="javascript:void(0);" id="publish">
                      <i class="icon icon-wegene-2"></i>
                      <span>提交</span>
                  </a>
              </li>
              <li >
                  <a href="../notice/index" id="cancel">
                      <i class="icon icon-wegene-2"></i>
                      <span>返回</span>
                  </a>
              </li>
          </ul>
      </div>
    <input type="hidden" id="psId" value="${psId}">
<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../js/fastclick.js"></script>
<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
<script src="../js/plugins/jQueryUI/jquery-ui.js"></script>
<script src="../js/webuploader/webuploader.html5only.min.js"></script>
<script>
//上传功能开始

var uploader =new WebUploader.Uploader({
    // 选完文件后，是否自动上传。
    auto: true,
    server: '../notice/uploadPhoto',
    pick: '#imgInput',
    // 只允许选择图片文件。
    accept : {
		title: 'Images',
		extensions: 'gif,jpg,jpeg,bmp,png,txt,doc,docx,zip,rar,pdf,xls,xlsx',
	    mimeTypes: '*'
	}
});

uploader.on( 'fileQueued', function( file ) {
	var $li = $(
            '<div id="" class="file-item thumbnail" style="float: left">' +
                '<img id="' + file.id + '">' +
            '</div>'
            ),
        $img = $li.find('img');
    // $list为容器jQuery实例
    //$("#upDiv").append( $li );
   //$img.attr('height','200');
   // $img.attr('width','200');
});
//var resUrl="";

// 文件上传过程中创建进度条实时显示。
uploader.on( 'uploadProgress', function( file, percentage ) {
    var $li = $( '#'+file.id ),
        $percent = $li.find('.progress .progress-bar');

    // 避免重复创建
    if ( !$percent.length ) {
        $percent = $('<div class="progress progress-striped active">' +
          '<div class="progress-bar" role="progressbar" style="width: 0%">' +
          '</div>' +
        '</div>').appendTo( $li ).find('.progress-bar');
    }

    $li.find('p.state').text('上传中');

    $percent.css( 'width', percentage * 100 + '%' );
});

uploader.on( 'uploadSuccess', function(file,response) {
  /*  resUrl=$("#hiddenUrl").val()+response.url+";";
   $("#hiddenUrl").val(resUrl);
   //图片回显
   $("#"+file.id+"").attr('src',".."+response.url) */
   
	$("#uploaderFiles").append("<li class='weui-uploader__file' name='selectedImgs' style='background-image:url("+response.url+")'></li>");
	$("#uploaderFiles").show();
   
});


$(function() {
	
	$(document).delegate('.weui-uploader__file','click',function(){
		var li = $(this);
		$.confirm({
			  title: '删除',
			  text: '确认要删除图片吗？',
			  onOK: function () {
				  li.remove();
			  },
			  onCancel: function () {
			  }
			})
		
	}); 
}); 

$(function(){
	$("#publish").click(function(){
		
		var content=$("#content").val();
		var pNum = ${selectedNum};
		if (content==''){
			$.alert("请输入通知内容", "提示");
		} if(pNum == 0){
			$.alert("请选择发送对象", "提示");
		}else {
			$.confirm("您是否要发布此教师通知", "确认发布?", function() {

				var files = [];
				// console.log(publish);
				
				// $("li[name='selectedImgs']").each(function(){files.push($(this).attr("background-image")); console.log($(this));});
				var imgs = $("li[name='selectedImgs']");
				for (var i = 0; i < imgs.length; i++) {
					files.push($(imgs[i]).css("backgroundImage").replace(/.*\s?url\([\'\"]?/, '').replace(/[\'\"]?\).*/, ''));
				}
			 	var content=$("#content").val();
			 	var psId=$("#psId").val();
			 	
			 	var param = {};
			 	param["title"] = "";
			 	param["content"] = content;
			 	param["psId"] = psId;
			 	param["files"] = files;
			 	param["sendMessageFlg"] = $("#sendMessageFlg").is(':checked');
			 	
			 	$.showLoading("正在发送通知");
			 	/*console.log($("#groupFlag").val());*/
			 	alert($("#groupFlag").val());
				debugger;
			 	if($("#groupFlag").val()){
			 		$.ajax({
						url:"../teacherNotice/saveNoticeWithGroup",
						type:"post",
						contentType: "application/json",
						dataType: "json",
						data: JSON.stringify(param), 
						success:function(data){
							$.hideLoading();
							if("02" == data.code){
								$.toast("操作成功");
								window.location.href="../notice/index";
							} else {
								$.toast("操作失败");
							}
						}
					});
			 	} else {
			 		$.ajax({
						url:"../teacherNotice/saveNotice",
						type:"post",
						contentType: "application/json",
						dataType: "json",
						data: JSON.stringify(param), 
						success:function(data){
							$.hideLoading();
							if("02" == data.code){
								$.toast("操作成功");
								window.location.href="../notice/index";
							} else {
								$.toast("操作失败");
							}
						}
					});
			 	}
				
	        }, function() {
	          //取消操作
	        });
		}
		

	});
});

$(function(){
	$("#toTeacherSelect").click(function(){
		var files = [];
		$(".weui-uploader__file").each(function(){
			console.log($(this));
			files.push($(this).val());
			});
		
		var title=$("#title").val();
	 	var content=$("#content").val();
	 	var psId=$("#psId").val();
	 	
	 	var param = {};
	 	param["title"] = title;
	 	param["content"] = content;
	 	param["psId"] = psId;
	 	param["files"] = files;
	 	
	 	console.log(param);
		$.ajax({
			url:"../teacherNotice/saveNoticeTemp",
			type:"post",
			contentType: "application/json",
			dataType: "json",
			data: JSON.stringify(param), 
			success:function(result){
				if("02" == result.code){
					window.location.href="../teacherNotice/toTeacherGradeSelect";
				}
			}
		});
	});
});


</script>
</body>
</html>