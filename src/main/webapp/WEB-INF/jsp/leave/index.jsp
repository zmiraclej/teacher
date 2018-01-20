<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cxt" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description"
	content="Write an awesome description for your new site here. You can edit this line in _config.yml.
It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
<title>请假登记</title>
<link rel="stylesheet" href="${cxt}/css/common/weui.min.css">
<link rel="stylesheet" href="${cxt}/css/common/jquery-weui.css">
<link rel="stylesheet" href="${cxt}/css/common/tab.css">
<link rel="stylesheet" href="${cxt}/css/common/jquery.autocomplete.css" />
<style type="text/css">
label.error {
	color: Red;
	font-size: 13px;
	margin-left: 5px;
	padding-left: 16px;
}

a:hover {
	text-decoration: underline;
	color: #09f;
	font-size: 19px;
}
</style>

</head>
<body>
	<div class="tab-box">
	    <input type="radio" name="demo" id="tab-switch-input1" checked="">
	    <input type="radio" name="demo" id="tab-switch-input2">
	    <input type="radio" name="demo" id="tab-switch-input3">
	    <div class="tab-box-label" style="text-align:center;width:100%">
	    	 <div style="display:inline-block">
	    	 <label for="tab-switch-input1" class="">发起请假</label>
		     <label for="tab-switch-input2" id="starterForm" class="">我的请假</label>
	         <label for="tab-switch-input3" id="confirmForm" class="">收到的请假</label>
	    	 </div>
		     
	        <!-- <label for="tab-switch-input1" style="border-radius:10px">
	            <span>发起请假</span>
	        </label> 
	        <label for="tab-switch-input2" style="border-radius:10px;margin-left:10px;">
	            <span>我的发起</span>
	        </label>
	        <label for="tab-switch-input3" style="border-radius:10px;margin-left:10px;">
	            <span>接收的请假</span>
	        </label>-->
	    </div>
	    <div class="tab-contents">
	        <div class="tab-content" style="height:300px">
	           <div class="weui-cells weui-cells_form">
						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label for="student" class="weui-label">请假学生</label>
							</div>
							<div class="weui-cell__bd">
								<input id='studentPicker' placeholder="请选择请假学生" class="weui-input" id="name" type="text" data-values="" value="">
							</div>
						</div>
						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label for="student" class="weui-label">请假类型</label>
							</div>
							<div class="weui-cell__bd">
								<input id='leaveTypePicker'  placeholder="请选择请假类型" class="weui-input" id="name" type="text" data-values="" value="">
							</div>
						</div>
		
						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label for="start" class="weui-label">开始时间</label>
							</div>
							<div class="weui-cell__bd">
								 <input class="weui-input" id="startPicker" type="text" value="">
							</div>
						</div>
		
						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label for="end" class="weui-label">截止时间</label>
							</div>
							<div class="weui-cell__bd">
								 <input class="weui-input" id="endPicker" type="text" value="">
							</div>
						</div>
		
						<div class="weui-cell">
							<div class="weui-cell__bd">
								<textarea id="reason" name="reason"
									class="weui-textarea" placeholder="请输入请假事由" rows="3"></textarea>
								<div class="weui-textarea-counter">
									<span id="red">0</span>/200
								</div>
							</div>
						</div>
						<div class="weui-cell">
							<input class="weui-btn weui-btn_primary" id="commitLeave" value="提交登记">
						</div>
					</div>
	        </div>
	        <div class="tab-content">
	            
					<div class="weui-form-preview" id="starterData">
						
					</div>
	        </div>
	        <div class="tab-content" >
					<div class="weui-form-preview" id="confirmData">
						
					</div>
				
			</div>
	    </div>
	</div>

	<script src="${cxt}/js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="${cxt}/js/plugins/jQuery/jquery.validate.js"></script>
	<script src="${cxt}/js/plugins/jQuery/jquery.validate.extend.js"></script>
	<script src="${cxt}/js/fastclick.js"></script>
	<script src="${cxt}/js/plugins/jQueryUI/jquery-weui.js"></script>
	<script src="${cxt}/js/plugins/My97DatePicker/WdatePicker.js"></script>
	
	<script>
	$(function(){
		var mydate = new Date().Format("yyyy-MM-dd hh:mm");
		$("#startPicker").val(mydate);
		$("#endPicker").val(mydate);
		$('#startPicker').datetimePicker();
		$('#endPicker').datetimePicker();
	});
	$(document).keyup(function() {
		var text = $("#reason").val();
		var counter = text.length;
		if(counter > 200){
			$.alert("超过可输入最大字符");
			$("#red").css("color","red");
			$("#reason").val(text.substring(0,200));
			$("#red").text(200);//每次重新显示
		}else{
			$("#red").css("color","");
			$("#red").text(counter);
		}
	});
		//select选项
			  $.ajax({
				    url: "${cxt}/leave/students",
				    type: "POST",
				    contentType: "application/json",
				    dataType:"json",
				    success: function(result) {
				    	var selectItems = [];
						for(var i = 0;i<result.length;i++){
							var jsonObj = result[i];
							var option = {"title":jsonObj.name,"value":jsonObj.id};
							selectItems.push(option);
						}
						//console.log(selectItems);
						$("#studentPicker").select({
							  title: "请选择学生",
							  items: selectItems,
							  onChange: function (d) {
						            console.log(this, d);
						        }
						});					
				    }
				});
	
		
	
	
	$('#starterForm').click(function(){
		$.ajax({
			asycn:false,
			url:"${cxt}/leave/starterRecords",
			type:"POST",
			contentType: "application/json",
		    dataType:"json",
		    success:function(result){
		    	console.log(result);
		    	if(result == null || result.length == 0){
		    		$("#starterData").html("暂无记录");
		    	}else{
		    		var str = '';
		    		$("#starterData").html('');
		    		for(var i = 0;i<result.length;i++){
		    			var obj=result[i];
		    			var status;//状态
		    			var type;//类型
		    			if(obj.confirmParentStatus == '1'){
		    				status = "未确认";
		    			}
		    			if(obj.confirmParentStatus == '0'){
		    				status = "已确认";
		    			}
		    			if(obj.type == '1'){
		    				type="事假";
		    			}
		    			if(obj.type == '2'){
		    				type="病假";
		    			}
		    			if(obj.type == '3'){
		    				type="其他";
		    			}
		  			  str+="<div class='weui-form-preview'>"
		  		      +"<div class='weui-form-preview__hd'>"
		  		      +"<div class='weui-form-preview__item'>"
		  		      +"<label class='weui-form-preview__label'>请假申请</label>"
		  		      +"<em class='weui-form-preview__value'>"+status+"</em>"
		  		      +"</div>"
		  		      +"</div>"
		  		      +"<div class='weui-form-preview__bd'>"
		  		      +"<div class='weui-form-preview__item'>"
		  		      +"<label class='weui-form-preview__label'>学生姓名</label>"
		  		      +"<span class='weui-form-preview__value'>"+obj.studentName+"</span>"
		  		      +"</div>"
		  		      +"<div class='weui-form-preview__item'>"
		  		      +"<label class='weui-form-preview__label'>请假类型</label>"
		  		      +"<span class='weui-form-preview__value'>"+type+"</span>"
		  		      +"</div>"
		  		      +"<div class='weui-form-preview__item'>"
		  		      +"<label class='weui-form-preview__label'>开始时间</label>"
		  		      +"<span class='weui-form-preview__value'>"+obj.startTimeStr+"</span>"
		  		      +"</div>"
		  		      +"<div class='weui-form-preview__item'>"
		  		      +"<label class='weui-form-preview__label'>结束时间</label>"
		  		      +"<span class='weui-form-preview__value'>"+obj.endTimeStr+"</span>"
		  		      +"</div>"
		  		      +"<div class='weui-form-preview__item'>"
		  		      +"<label class='weui-form-preview__label'>请假事由</label>"
		  		      +"<span class='weui-form-preview__value'>"+obj.reason+"</span></div>"
		  		      +"</div>";
		  			if(obj.confirmParentStatus == 1){
		  		    	  str+="<div class='weui-form-preview__ft'>"
				  		      +"<input type='hidden' class='leaId' value='"+obj.id+"' />"
				  		    +"<input type='hidden' class='stuId' value='"+obj.studentId+"'/>"
								+"<button onclick='deleteLeave(this)' class='weui-form-preview__btn weui-form-preview__btn_primary'>删除请假</button></div>";
		  		      }
		    		}
		    		$("#starterData").html(str);
		    	}
		    }
		 });
	});
	
	$('#confirmForm').click(function(){
		$.ajax({
			asycn:false,
			url:"${cxt}/leave/confirmRecords",
			type:"POST",
			contentType: "application/json",
		    dataType:"json",
		    success:function(result){
		    	console.log(result);
		    	if(result == null || result.length == 0){
		    		$("#confirmData").html("暂无记录");
		    	}else{
		    		var str = '';
		    		for(var i = 0;i<result.length;i++){
		    			var obj=result[i];
		    			var status = '';//状态
		    			var type = '';//类型
		    			if(obj.confirmTeacherStatus == 1){
		    				status = "未确认";
		    			}
		    			if(obj.confirmTeacherStatus == 0){
		    				status = "已确认";
		    			}
		    			if(obj.type == '1'){
		    				type="事假";
		    			}
		    			if(obj.type == '2'){
		    				type="病假";
		    			}
		    			if(obj.type == '3'){
		    				type="其他";
		    			}
		    			str+="<div class='weui-form-preview'>"
		  	  		      +"<div class='weui-form-preview__hd'>"
			  		      +"<div class='weui-form-preview__item'>"
			  		      +"<label class='weui-form-preview__label'>请假申请</label>"
			  		      +"<em class='weui-form-preview__value'>"+status+"</em>"
			  		      +"</div>"
			  		      +"</div>"
			  		      +"<div class='weui-form-preview__bd'>"
			  		      +"<div class='weui-form-preview__item'>"
			  		      +"<label class='weui-form-preview__label'>学生姓名</label>"
			  		      +"<span class='weui-form-preview__value'>"+obj.studentName+"</span>"
			  		      +"</div>"
			  		      +"<div class='weui-form-preview__item'>"
			  		      +"<label class='weui-form-preview__label'>请假类型</label>"
			  		      +"<span class='weui-form-preview__value'>"+type+"</span>"
			  		      +"</div>"
			  		      +"<div class='weui-form-preview__item'>"
			  		      +"<label class='weui-form-preview__label'>开始时间</label>"
			  		      +"<span class='weui-form-preview__value'>"+obj.startTimeStr+"</span>"
			  		      +"</div>"
			  		      +"<div class='weui-form-preview__item'>"
			  		      +"<label class='weui-form-preview__label'>结束时间</label>"
			  		      +"<span class='weui-form-preview__value'>"+obj.endTimeStr+"</span>"
			  		      +"</div>"
			  		      +"<div class='weui-form-preview__item'>"
			  		      +"<label class='weui-form-preview__label'>请假事由</label>"
			  		      +"<span class='weui-form-preview__value'>"+obj.reason+"</span></div>"
			  		      +"</div>";
			  		      if(obj.confirmTeacherStatus == 1){
			  		    	  str+="<div class='weui-form-preview__ft'>"
					  		      +"<input type='hidden' class='leaId' value='"+obj.id+"' />"
					  		      +"<input type='hidden' class='stuId' value='"+obj.studentId+"'/>"
									+"<button onclick='updateLeave(this)' class='weui-form-preview__btn weui-form-preview__btn_primary'>确认请假</button></div>";
			  		      }
			  		      
		    	}
		    	$('#confirmData').html(str);
		    }
		    }
		 });
	});
	function deleteLeave(obj){
		var leaveId = $(obj).siblings('.leaId').val();
		var stuId = $(obj).siblings('.stuId').val();
		var p = {};
		p["id"] = leaveId;
		p['studentId'] = stuId;
		$.showLoading("正在删除未确认请假");
		$.ajax({
			url:"${cxt}/leave/deleteRecord",
			type:"POST",
			contentType: "application/json",
		    dataType:"json",
		    data:JSON.stringify(p),
		    success: function(result) {
		        if('02'==result.code){
		        	$.hideLoading();
		        	$.alert("删除请假申请成功！");
		        	$('#starterForm').click();
		        } else {
		        	$.hideLoading();
		        	$.alert("删除请假申请失败！请稍后重试");
		        	
		        }
		    }
		});
	};
	
	
	
	function updateLeave(obj){
		var leaveId = $(obj).siblings('.leaId').val();
		var stuId = $(obj).siblings('.stuId').val();
		var p = {};
		p["id"] = leaveId;
		p['studentId'] = stuId;
		$.showLoading("正在确认请假");
		$.ajax({
			url:"${cxt}/leave/updateStatus",
			type:"POST",
			contentType: "application/json",
		    dataType:"json",
		    data:JSON.stringify(p),
		    success: function(result) {
		        if('02'==result.code){
		        	$.hideLoading();
		        	$.alert("确认请假申请成功！");
		        	$('#confirmForm').click();
		        } else {
		        	$.hideLoading();
		        	$.alert("确认请假申请失败！请稍后重试");
		        }
		    }
		});
	};
	
	
	/* $("#studentPicker").picker({
        title: "请选择学生",
        cols: [
          {
            textAlign: 'center',
            displayValues: v,
            values: disv
          }
        ],
        onChange: function(p, v, dv) {
          console.log(p, v, dv);
        },
        onClose: function(p, v, d) {
          console.log("close");
        }
      }); */
	
	 /* $("#startPicker").datetimePicker({
	        times: function () {
	          return [
	            {
	              values: (function () {
	                var hours = [];
	                for (var i=0; i<24; i++) hours.push(i > 9 ? i : '0'+i);
	                return hours;
	              })()
	            },
	            {
	              divider: true,  // 这是一个分隔符
	              content: '时'
	            }
	          ];
	        },
	        onChange: function (picker, values, displayValues) {
	          console.log(values);
	        }, 
	      }); */
	 
	 /* $("#endPicker").datetimePicker({
	         times: function () {
	          return [
	            {
	              values: (function () {
	                var hours = [];
	                for (var i=0; i<24; i++) hours.push(i > 9 ? i : '0'+i);
	                return hours;
	              })()
	            },
	            {
	              divider: true,  // 这是一个分隔符
	              content: '时'
	            }
	          ];
	        },
	        onChange: function (picker, values, displayValues) {
	          console.log(values);
	        }, 
	      }); */
	 
	
	
	$("#leaveTypePicker").select({
        title: "请选择请假类型",
		items: [
			{
				title:"事假",
				value:1
			},
			{
				title:"病假",
				value:2
			},
			{
				title:"其他",
				value:3
			}
		]
        /* onChange: function(p, v, dv) {
          console.log(p, v, dv);
        },
        onClose: function(p, v, d) {
          console.log("close");
        } */
      });
	/***** 获取当前时间并格式化 ******/
	Date.prototype.Format = function (fmt) { //author: meizz 
	    var o = {
	        "M+": this.getMonth() + 1, //月份 
	        "d+": this.getDate(), //日 
	        "h+": this.getHours(), //小时 
	        "m+": this.getMinutes(), //分 
	        "s+": this.getSeconds(), //秒 
	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	        "S": this.getMilliseconds() //毫秒 
	    };
	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    return fmt;
	}
		$('#commitLeave').click(function () { 
			var start = $("#startPicker").val();
			var end = $("#endPicker").val();
			var p = {};
			var mydate = new Date().Format("yyyy-MM-dd hh:mm");
			p["studentId"] = $('#studentPicker').attr("data-values");
			p["type"] = $("#leaveTypePicker").attr("data-values");
			p["start"] = start;
			p["end"] = end;
			p["reason"] = $("#reason").val();
			//console.log(p);
			if(p["studentId"]==null || p["studentId"]==''){
				$.alert("请选择请假学生！");
				return;
			}
			if(p["type"]==null || p["type"]==''){
				$.alert("请选择请假类型！");
				return;
			}
			if(start == null || start == ''){
				$.alert("请选择请假开始时间！");
				return;
			}
			if(end == null || end == ''){
				$.alert("请选择请假结束时间！");
				return;
			}
			if(mydate>start){
				$.alert("请假开始时间不能小于当前时间！");
				return;
			}
			if(end <= start){
				$.alert("请假结束时间必须大于开始时间！");
				return;
			}
			$.showLoading("正在提交请假");
			
			$.ajax({
			    url: "${cxt}/leave/save",
			    type: "POST",
			    contentType: "application/json",
			    dataType:"json",
			    data:JSON.stringify(p),
			    success: function(result) {
			        if('02'==result.code){
			        	$.hideLoading();
			        	$.alert("已成功提交请假申请");
			        	resetForm();
			        } else {
			        	$.hideLoading();
			        	$.alert("请假申请提交失败！请稍后重试");
			        }
			    }
			}); 
			
		}); 
		function resetForm(){
			var mydate = new Date().Format("yyyy-MM-dd hh:mm");
			$('#studentPicker').val('');
			$('#studentPicker').attr("data-values",'');
			$("#leaveTypePicker").val('');
			$("#leaveTypePicker").attr("data-values",'');
			$("#startPicker").val(mydate);
			$("#endPicker").val(mydate);
			$('#startPicker').datetimePicker();
			$('#endPicker').datetimePicker();
			$("#reason").val('');
		}
	</script>
</body>
</html>