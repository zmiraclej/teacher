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
				
	}
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
		
			}
			
			
			// 加载学生选择控件
			$(document).on("click", "#changeStudent", function() {
				$.actions({
					title : "选择学生",
					onClose : function() {
						console.info("close")
					},
					actions : selectStudentActions
						/*[{
						    text: "编辑",
						    onClick: function() {
						      //do something
						    	alert("hi");
						    }
						  },{
						    text: "删除",
						    onClick: function() {
						      //do something
						    	alert("gg");
						    }
						  }]*/
				});
			});
		}
	})
});