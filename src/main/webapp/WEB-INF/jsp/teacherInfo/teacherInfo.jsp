<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>教师信息</title>
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<meta name="description" content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.
">




<!-- 引入 WeUI -->
	<link rel="stylesheet" href="../css/common/v-time-style.css"">
    <link rel="stylesheet" href="../css/common/weui.min.css">
    <link rel="stylesheet" href="../css/common/jquery-weui.css">
    <link rel="stylesheet" href="../css/common/demos.css"> 
    <link rel="stylesheet" type="text/css" href="../css/upload/imgareaselect-default.css" />
	<link rel="stylesheet" href="../js/webuploader/webuploader.css">
	<link rel="stylesheet" href="../css/common/jquery.autocomplete.css" />




<link rel="stylesheet" href="../css/common/syllabus.css">

  </head>

  <body ontouchstart>
	<div class="weui-cells weui-cells_form">
	  
	  <div class="weui-panel weui-panel_access">
		<div class="weui-panel__hd">教师信息</div>
		<div class="weui-panel__bd">
		  <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg" id="">
			<div class="weui-media-box__hd">
			  <img class="weui-media-box__thumb" id="idImg" style="border-radius:50%"  src="../img/stu.png"  alt="" height="100" width="100">
			</div>
			<div class="weui-media-box__bd">
			  <h4 class="weui-media-box__title" id=""></h4>
			  <p class="weui-media-box__desc">
              	<span id="schoolInfo"></span>&nbsp
              	<span id="classInfo"></span></p>
			</div>
		  </a>
		</div>
	  </div>
	  
	  
	  
	  <div class="weui-cell">
	    <div class="weui-cell__hd"><label class="weui-label">姓名</label></div>
	    <div class="weui-cell__bd">
	      <input class="weui-input" id="username"  >
	      <input type="hidden" id="TeacherId">
	    </div>
	  </div>
	  <div class="weui-cell">
	    <div class="weui-cell__hd"><label class="weui-label">员工编号</label></div>
	    <div class="weui-cell__bd">
	      <input class="weui-input"  id="employeeNo" >
	    </div>
	  </div>
	  <div class="weui-cell">
	    <div class="weui-cell__hd"><label class="weui-label">手机号</label></div>
	    <div class="weui-cell__bd">
	      <input class="weui-input"  id="phoneNum" >
	    </div>
	  </div>
	</div>


	
	
  <div class="weui-cells weui-cells_radio">
  <label class="weui-cell weui-check__label" for="x11">
    <div class="weui-cell__bd">
      <p>班主任</p>
    </div>
    <div class="weui-cell__ft">
      <input type="radio" class="weui-check" name="radio1" id="x11" value="1">
      <span class="weui-icon-checked"></span>
    </div>
  </label>
  <label class="weui-cell weui-check__label" for="x12">

    <div class="weui-cell__bd">
      <p>非班主任</p>
    </div>
    <div class="weui-cell__ft">
      <input type="radio" name="radio1" class="weui-check" id="x12" checked="checked" value="0">
      <span class="weui-icon-checked"></span>
    </div>
  </label>
</div>
	
	
	 
<div class="weui-cells weui-cells_radio">
  <label class="weui-cell weui-check__label" for="x21">
    <div class="weui-cell__bd">
      <p>任课老师</p>
    </div>
    <div class="weui-cell__ft">
      <input type="radio" class="weui-check" name="radio2" id="x21" checked="checked" value="01">
      <span class="weui-icon-checked"></span>
    </div>
  </label>
  <label class="weui-cell weui-check__label" for="x22">

    <div class="weui-cell__bd">
      <p>生辅老师</p>
    </div>
    <div class="weui-cell__ft">
      <input type="radio" name="radio2" class="weui-check" id="x22" value="02">
      <span class="weui-icon-checked"></span>
    </div>
  </label>
</div>
   
	 
<div class="weui-cells weui-cells_radio">
  <label class="weui-cell weui-check__label" for="x31">
    <div class="weui-cell__bd">
      <p>男</p>
    </div>
    <div class="weui-cell__ft">
      <input type="radio" class="weui-check" name="radio3" id="x31" checked="checked" value="1">
      <span class="weui-icon-checked"></span>
    </div>
  </label>
  <label class="weui-cell weui-check__label" for="x32">

    <div class="weui-cell__bd">
      <p>女</p>
    </div>
    <div class="weui-cell__ft">
      <input type="radio" name="radio3" class="weui-check" id="x32" value="0" >
      <span class="weui-icon-checked"></span>
    </div>
  </label>
</div>



  <div class="weui-cells weui-cells_form" id="uploaderCustom"> 
   <div class="weui-cell"> 
    <div class="weui-cell__bd"> 
     <div class="weui-uploader"> 
      <div class="weui-uploader__hd"> 
       <p class="weui-uploader__title">图片上传</p> 
      </div> 
      	<div class="weui-uploader__bd">
			  <ul class="weui-uploader__files" id="upDiv" >
			  </ul>
			  <div class="weui-uploader__input-box">
			  	<div id="filePicker" class="weui-uploader__input">选择图片</div>
			  </div>
		</div>
      
     </div> 
    </div> 
   </div> 
  </div>





	<div class="weui-panel weui-panel_access" id="checkDiv">
	        <div class="weui-panel__bd">
	          <div class="weui-media-box weui-media-box_text">
	        <input class="weui-btn weui-btn_primary"  id="deUpdate" type="button" value="确认修改">
	          </div>
	        </div>
	        <div class="weui-panel__ft">         
	        </div>
	 </div>
  
   

	
<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../js/fastclick.js"></script>
 <script src="../js/plugins/echarts/echarts.js"></script> 
<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
<script src="../js/plugins/jQueryUI/jquery-ui.js"></script>
<script src="../js/webuploader/webuploader.html5only.min.js"></script>		
	
	<script>
		
	
		 		
		 	 $(function(){
					$.ajax({
						url:"../teacherInfo/searchTeacherInfo",
						type:"POST",
						success:function(data){
							if(data.code==2){
								var obj=data.data;
								$("#TeacherId").val(obj.id);	
								if(obj.name!=null && obj.name!=""){
									$("#username").val(obj.name);
								}
								if(obj.phone!=null && obj.phone!=""){
									$("#phoneNum").val(obj.phone);
								}
								if(obj.jobNumber!=null && obj.jobNumber!=""){
									$("#employeeNo").val(obj.jobNumber);
								}
								var photo=obj.photo;
								if(photo.indexOf("null")>0){
									$("#idImg").attr("src","../img/stu.png");
								}else{
									$("#idImg").attr("src",photo);
								}
								
								
								if(obj.blHeadTeacher!=null && obj.jobNumber!=""){
									if(obj.blHeadTeacher==1){
										$("#x11").attr("checked",true);
										$("#x12").attr("checked",false);
									}else{
										$("#x11").attr("checked",false);
										$("#x12").attr("checked",true);
									}
									
								}
								if(obj.sex!=null){
									if(obj.sex==1){
										$("#x31").attr("checked",true);
										$("#x32").attr("checked",false);
									}else{
										$("#x31").attr("checked",false);
										$("#x32").attr("checked",true);
									}
									
								}
								if(obj.type!=null&& obj.type!=""){
									if(obj.type=="01"){
										$("#x21").attr("checked",true);
										$("#x22").attr("checked",false);
									}else{
										$("#x21").attr("checked",false);
										$("#x22").attr("checked",true);
									}
									
								}
							}	
						}
					}) 
		 	 })
			  	 
		 	   
		 $(function(){
			 $("#deUpdate").click(function(){
				 var name=$("#username").val();
				 if(name==null||name==""){
					 $.alert("姓名不能为空");
					 return false;
				 }
				 var phone=$("#phoneNum").val();
				 var jobNumber=$("#employeeNo").val();
				var bht= $("input[name='radio1']:checked").val();
				var type= $("input[name='radio2']:checked").val();
				var sex= $("input[name='radio3']:checked").val();
				 var id=$("#TeacherId").val();
				 var src=$("#idImg").attr("src");
					$.ajax({
						url:"../teacherInfo/updateTeacherInfo",
						type:"POST",
						data:{
							id:id,
							name:name,
							phone:phone,
							jobNumber:jobNumber,
							sex:sex,
							type:type,
							blHeadTeacher:bht,
							photo:src
							
						},
						success:function(data){
							if(data.code==2){
								window.location.href="../pageSkip/teacherInfo";
							}
						}
					})
			 });
		 })	   	   
		 	
		 //上传功能开始
 
		 var uploader = new WebUploader.Uploader(
				{
					// 选完文件后，是否自动上传。
					auto : true,
					server : '../teacherInfo/uploadHeadPhoto',
					pick : '#filePicker',
					fileNumLimit: 10,
					// 只允许选择图片文件。
					accept : {
						title : 'Images',
						extensions : 'gif,jpg,jpeg,bmp,png',
						mimeTypes : '*'
					}
				});

		uploader.on('fileQueued',function(file) {
				var $li = $('<div id="" class="file-item thumbnail" style="float: left">'
						+ '<img id="' + file.id + '">' + '</div>'), $img = $li
						.find('img');
				
						});
		
				uploader.on( 'uploadSuccess', function(file,response) {
			 
			   
				var idImg=$("#idImg")[0].src; 
				$("#idImg").attr('src',"");
				$("#idImg").attr('src',response.url);
				//append("<li class='weui-uploader__file' name='selectedImgs' style='background-image:url("+response.url+")'></li>");
				//$("#idPhoto").show();
			   
			}); 
				 		
		 		
		 		
		 		 		 
		
	</script>
 </body>
</html>