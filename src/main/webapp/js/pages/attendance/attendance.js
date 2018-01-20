var childrenList = null;
var currentStudent = null;
// 学生选择控件内容,初始时默认为无数据状态
var selectStudentActions = [ {
	text : "暂无数据",
	className : "color-primary"
}];

// 切换学生事件
var selectStudent = function(index) {
	return function() {
		//清除学生切换之前的节点
		$("#detail-item").children().remove();
		$("#detail-title").html("今日暂无考勤记录");
		
		var student = childrenList[index];
		var studentInfo = student.schoolName + "、" + student.gradeNo + "年级"
				+ student.classNo + "班";
		$("#studentName").text(student.name);
		$("#studentInfo").text(studentInfo);
		
		if (student.photo != null) {
			$("#photo").attr("src", student.photo);
		} else {
			$("#photo").attr("src", "../img/stu.png");
		}
				
		loadCalendar(student);
	}
}

var getAttDetail = function(studentNo,date) {
		$.get("../attendance/detail?studentNo="
				+ studentNo
				+ "&attendanceTime="
				+ date,function(data, status) {
					if ('success' == status && '' != data) {
						$("#detail-title").html(date.substring(0,4)+"年"
								+date.substring(5,7)
								+"月"+date.substring(8,date.length)
								+"日 刷卡记录明细");
						for(var i=0;i<data.length;i++){
							$("#detail-item").append('<div class="weui-cell">'
									+'<div class="weui-cell__hd">'
									+'<img src="../img/damen.png"></div>'
									+'<div class="weui-cell__bd">'
									+'<p>'+data[i].attendancePlace+'</p></div>'
									+'<div class="weui-cell__bd">'
									+'<p>'+data[i].attendanceTime.substring(11)+'</p></div>'
									+'<div class="weui-cell__bd">'
									+'<p>'+data[i].attendanceKind+'</p></div>'
									+'<div class="weui-cell__ft">'+data[i].attendanceStatus+'</div></div>')
						}
						
					} else {
						$("#detail-title").html("今日暂无考勤记录");
						$("#detail-item").children().remove();
					}
				});
}

var loadCalendar = function(student){
	currentStudent = student;
	//加载日历
	$("#inline-calendar").remove(); 
	$("#date3").remove();
	$("#detail-title").before("<div id='inline-calendar'></div>")
	$("#date3-container").append("<input class='weui-input' id='date3' type='text'>");
	
	$("#date3").calendar(
			{
				container : "#inline-calendar",
				onChange : function(p, values, displayValues) {
					$("#detail-item").children().remove();
					var studentno = null;
					
					if(currentStudent != null) {
						studentno = currentStudent.studentNo;
					}
					//加载考勤详情
					getAttDetail(studentno,values[0]);
				}
			});
}

$(function() {
	FastClick.attach(document.body);
	// 初始化加载数据
	$.ajax({
		url : "../common/initStudentInfo",
		type : "get",
		success : function(data) {
			var student = null;
			if(!(data == null || ''==data)){
				student = data.currentStudent;
				
				// 有勾选加载顶部学生信息
				var studentInfo = student.schoolName + "、" + student.gradeNo + "年级"
						+ student.classNo + "班";
				$("#studentName").text(student.name);
				$("#studentInfo").text(studentInfo);
				if (student.photo != null) {
					$("#photo").attr("src", student.photo);
				} else {
					$("#photo").attr("src", "../img/stu.png");
				}
	
				// 把后台传来的学生集合放在页面中保存起来
				childrenList = data.childrenList;
				// 如果有学生列表，加载可选学生列表
				if (childrenList != null && childrenList.length != 0) {
					// 设置可选学生
					for (var i = 0; i < childrenList.length; i++) {
						selectStudentActions[i] = {
							// 点击时触发选择学生的方法，传入索引，直接从children获取学生信息
							text : childrenList[i].name,
							className : "color-primary",
							// 使用闭包解决循环内绑定事件问题
							onClick : selectStudent(i)
						}
					}
				}
				
				//加载日历控件
				loadCalendar(student)
			}
			
			
			// 加载学生选择控件
			$(document).on("click", "#changeStudent", function() {
				$.actions({
					title : "选择学生",
					onClose : function() {
						console.info("close")
					},
					actions : selectStudentActions
				});
			});
		}
	})
});