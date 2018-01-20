<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>课程表</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<link rel="stylesheet" href="../css/common/v-time-style.css">
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/demos.css">
<link rel="stylesheet" href="../css/common/syllabus.css">
<link rel="stylesheet" href="../js/webuploader/webuploader.css">

<style>
	.weui-cell__bd{
		padding-left: 49%;
	}
</style>
</head>
<body ontouchstart>
		<div class="weui-panel weui-panel_access">
			<div class="weui-panel__hd">学生信息</div>
			<div class="weui-panel__bd">
			  <a href="javascript:void(0);" id="changeStudent" class="weui-media-box weui-media-box_appmsg">
				<div class="weui-media-box__hd">
				  <img class="weui-media-box__thumb" src="../img/stu.png" alt=""  id="photo">
				</div>
				<div class="weui-media-box__bd">
				  <h4 class="weui-media-box__title" id="studentName"></h4>
				  <input type="hidden" id="studentNo"/>
				  <p class="weui-media-box__desc">
				  	<span id="schoolInfo"></span>&nbsp
	              	<span id="classInfo"></span>
				  </p>
				</div>
			  </a>
			</div>
		</div>
		
		<!-- <div class="weui-panel weui-panel_access">
	        <div class="weui-panel__hd">选择所属分类</div>
	        <div class="weui-panel__bd">
			  <a href="javascript:void(0);" id="changeStudent" class="weui-media-box weui-media-box_appmsg">
				<div class="weui-media-box__hd">
				</div>
				  <h4 class="weui-media-box__title" id="studentName"></h4>
			  </a>
			</div>
        </div> -->
		<div class="weui-panel weui-panel_access">
		<div class="weui-panel__hd">请选择活动类别</div>
		<div class="weui-panel__bd">
		  <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg" id="changeTag">
			<div class="weui-media-box__bd">
			  <h4 class="weui-media-box__title" id="tagName"></h4>
			</div>
		  </a>
		</div>
	  </div>
		
		
		<div class="weui-panel weui-panel_access">
	        <div class="weui-panel__hd">请在下面填写内容</div>
	        <div class="weui-panel__bd">
				<a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
	            <div class="weui-media-box__bd ">
	               <input class="weui-input" id="content" type="text" placeholder="发表点什么。。。">
	            </div>
	          </a>
			</div>
		</div>
		
		<div class="weui-panel weui-panel_access">
	        <div class="weui-panel__hd">请在下面填写活动时间</div>
	        <div class="weui-panel__bd">
				<a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
	            <div class="weui-media-box__bd ">
	               <input id="activeTime"  type="text"
									class="weui-input required" placeholder="请选择活动时间"
									 onFocus="WdatePicker({isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
	            </div>
	          </a>
			</div>
		</div>
	
		<div class="weui-panel weui-panel_access">
	        <div class="weui-panel__hd"></div>
	        <div class="weui-panel__bd">
	          <div class="weui-media-box weui-media-box_text">
	            <div id="uploader-demo">
			    <!--用来存放item-->
				    <div id="fileList" class="uploader-list"></div>
				    <div id="filePicker" name="filePicker">选择图片</div>
			   	</div>
	            
	            <button id="publish"  style="width: 90px; height: 30px;background:blue;color:white " >发表</button>
	          </div>
	        </div>
	        <div class="weui-panel__ft">         
	        </div>
	    </div>
	    <div id="upDiv"></div>
	    <input type="hidden" id="hiddenUrl" value="">
<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../js/fastclick.js"></script>
<script src="../js/plugins/echarts/echarts.js"></script>
<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
<script src="../js/plugins/jQueryUI/jquery-ui.js"></script>
<script src="../js/webuploader/webuploader.min.js"></script>
<script src="../js/plugins/My97DatePicker/WdatePicker.js"></script>
<script>
//上传功能开始

var uploader =new WebUploader.Uploader({
    // 选完文件后，是否自动上传。
    auto: true,
    server: '../personalHome/uploadPhoto',
    pick: '#filePicker',
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
uploader.on( 'uploadSuccess', function(file,response) {
  /*  resUrl=$("#hiddenUrl").val()+response.url+";";
   $("#hiddenUrl").val(resUrl);
   //图片回显
   $("#"+file.id+"").attr('src',".."+response.url) */
   
	$("#upDiv").append($("<img style='height:80px;width:80px;margin-left:5px' >").attr("src","http://localhost:8000"+response.url).addClass("icon-trash")
			.append($("<a id=''> ").attr("href","javascript:void(0);").addClass("icon-trash"))
			.append($("<input>").attr("type","hidden").addClass("js-add-imgurl").val(response.url)));
	$("#upDiv").show();
   
});
$(function() {
	
	$(document).delegate('.icon-trash,.icon-remove','click',function(){
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
		var uris = new Array();
		$(".js-add-imgurl").each(function(){uris.push($(this).val());});
		var studentName=$("#studentName").html();
		var tag=$("#tagName").html();
	 	var content=$("#content").val();
	 	var activeTime=$("#activeTime").val();
		var studentNo=$("#studentNo").val();
		 $.ajax({
			url:"../personalHome/saveDailyActivities",
			type:"post",
			dataType: 'json',
			data : {
					studentName:studentName,
					tag:tag,
				 	content:content,
			 		attachFile:uris.toString(),
			 		activityDate:activeTime,
			 		studentNo:studentNo
				}, 
			success:function(data){
				if("02" == data.code){
					 $.alert("发布成功");
					$("#content").val("");
				    $("#upDiv").empty();
				    $("#hiddenUrl").val("");
				    $("#activeTime").val("");
				}
			}
		});
	});
});

//学生列表
var childrenList=null;
//当前选中的学生
var currentStudent=null;


//标签列表
var tagList=null;
//当前选中的标签
var currentTag=null;
//文档加载完毕执行 
$(function() {
		//解决移动端点击事件延迟
	    FastClick.attach(document.body);
	  initDataTag();
	  initDataStudent();
	});
var selectStudentActions= [ {
    text: "暂无数据",
    className: "color-primary"
  }];
var selectTagActions= [ {
    text: "暂无数据",
    className: "color-primary"
  }];
  //初始化学生信息
function initDataStudent(){
			$.ajax({
				url:"../common/initStudentInfo",
				type:"get",
				success:function(data){
					currentStudent=data.currentStudent;
					//无所选学生，直接结束，不加载相关选择插件
					if(currentStudent==null){
						$("#studentName").text("暂无数据");
						return;
					}else{
						//如果存在学生，加载学生信息
						var classInfo=currentStudent.gradeNo+"年级"+currentStudent.classNo+"班";
						$("#studentName").text(currentStudent.name);
						$("#schoolInfo").text(currentStudent.schoolName);
						$("#classInfo").text(classInfo);
						$("#studentNo").val(currentStudent.studentNo);
						if(currentStudent.photo!=null){
							$("#photo").attr("src",currentStudent.photo);
						}else{
							$("#photo").attr("src","../img/stu.png");
						}
						
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
	  
//初始化标签数据
function initDataTag(){
	$.ajax({
		url:"../personalHome/searchWtrjEcomTagList",
		type:"get",
		success:function(data){
			
			if(data.code==2){
				for(var i=0;i<data.data.length;i++){
					if(i==0){
						var tag=data.data[0];
						var name =tag.name;
						$("#tagName").text(name);
					}
					 tagList=data.data;
					 selectTagActions[i]={	
							 text:tagList[i].name,
							 className: "color-primary",
							 onClick:selectTag(i),
						   }
				}
			}
				
				$(document).on("click", "#changeTag", function() {
			        $.actions({
			          title: "选择标签",
			          onClose: function() {
			            //console.info("close")
			          },
			          actions: selectTagActions
			        });
			      });
			
		}
	}) 
}
//给文本赋分类标签值
var selectTag=function (index){
	  return function() { 
		  currentTag=tagList[index];
		 $("#tagName").text(currentTag.name);
		 }
}
//给文本赋基础数据值
var selectStudent=function (index){
	  return function() { 
		  currentStudent=childrenList[index];
		  alert(currentStudent.name);
		  var classInfo=currentStudent.gradeNo+"年级"+currentStudent.classNo+"班";
			$("#studentName").text(currentStudent.name);
			$("#schoolInfo").text(currentStudent.schoolName);
			$("#classInfo").text(classInfo);
			$("#studentNo").val(currentStudent.studentNo);
			if(currentStudent.photo!=null){
				$("#photo").attr("src",currentStudent.photo);
			}else{
				$("#photo").attr("src","../img/stu.png");
			}
			baseDocument(currentStudent.id);
			dailyActive(currentStudent.studentNo); 
		 }
}



</script>
</body>
</html>