<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description"
	content="Write an awesome description for your new site here. You can edit this line in _config.yml.
It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
<title>登记来访</title>
<link rel="stylesheet" href="../css/common/weui.min.css">
<link rel="stylesheet" href="../css/common/jquery-weui.css">
<link rel="stylesheet" href="../css/common/jquery-ui.min.css">
<link rel="stylesheet" href="../css/common/demos.css">
<!-- <link rel="stylesheet" href="../css/common/jquery.autocomplete.css" /> -->
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
	<div class="weui-tab">
		<div class="weui-navbar">
			<a class="weui-navbar__item weui-bar__item--on" href="#tab1">学生家长</a>
			<a class="weui-navbar__item" href="#tab2"> 校外访客 </a>
		</div>
		<div class="weui-tab__bd">
			<div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
				<form id="visit-form" name="visit-form"
					action="${pageContext.request.contextPath }/visitor/eldership"
					method="post">
					<input type="hidden" name="token" value="${token}" />
					<div class="weui-cells weui-cells_form">
						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label class="weui-label">查找学生</label>
							</div>
							<div class="weui-cell__bd">
								<input id="student" name="student" class="weui-input required"
									type="text" placeholder="请输入学生姓名">
							</div>
						</div>

						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label class="weui-label">选择家长</label>
							</div>
							<div class="weui-cell__bd">
								<input id="parent" name="parent" class="weui-input required"
									type="text" placeholder="请选择家长">
							</div>
						</div>

						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label class="weui-label">随行车牌</label>
							</div>
							<div class="weui-cell__bd">
								<input id="carNum" name="carNum" class="weui-input" type="text"
									placeholder="请输入车牌号">
							</div>
						</div>

						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label for="visitTime" class="weui-label">到访时间</label>
							</div>
							<div class="weui-cell__bd">
								<input id="visitTime" name="visitTime" type="text"
									class="weui-input required" placeholder="请选择到访时间" />
							</div>
						</div>

						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label for="leaveTime" class="weui-label">离校时间</label>
							</div>
							<div class="weui-cell__bd">
								<input id="leaveTime" name="leaveTime" type="text"
									class="weui-input required" placeholder="请选择离校时间"/>
							</div>
						</div>

						<div class="weui-cell">
							<div class="weui-cell__bd">
								<textarea id="visitRemark" name="visitRemark"
									class="weui-textarea" placeholder="请输入来访事由" rows="3"></textarea>
								<div class="weui-textarea-counter">
									<span>0</span>/200
								</div>
							</div>
						</div>
					</div>
					<input class="weui-btn weui-btn_primary" type="submit" value="提交登记">
				</form>
			</div>

			<div id="tab2" class="weui-tab__bd-item">
				<form id="stranger-visit-form" name="stranger-visit-form"
					action="${pageContext.request.contextPath }/visitor/stranger"
					method="post">
					<input type="hidden" name="token" value="${token}" />
					<div class="weui-cells weui-cells_form">
						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label class="weui-label">访客姓名</label>
							</div>
							<div class="weui-cell__bd">
								<input id="visitorName" name="visitorName"
									class="weui-input required" type="text" placeholder="请输入来访者姓名">
							</div>
						</div>

						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label class="weui-label">身份证号</label>
							</div>
							<div class="weui-cell__bd">
								<input id="cardNo" name="cardNo" class="weui-input required"
									type="text" placeholder="请输入来访者身份证号">
							</div>
						</div>

						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label class="weui-label">电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话</label>
							</div>
							<div class="weui-cell__bd">
								<input id="phone" name="phone" class="weui-input" type="text"
									placeholder="请输入来访者电话">
							</div>
						</div>

						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label class="weui-label">随行车牌</label>
							</div>
							<div class="weui-cell__bd">
								<input id="strCarNum" name="strCarNum" class="weui-input"
									type="text" placeholder="请输入车牌号">
							</div>
						</div>

						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label for="strVisitTime" class="weui-label">到访时间</label>
							</div>
							<div class="weui-cell__bd">
								<input id="strVisitTime" name="strVisitTime" type="text"
									class="weui-input required" placeholder="请选择到访时间"/>
							</div>
						</div>

						<div class="weui-cell">
							<div class="weui-cell__hd">
								<label for="strLeaveTime" class="weui-label">离校时间</label>
							</div>
							<div class="weui-cell__bd">
								<input id="strLeaveTime" name="strLeaveTime" type="text"
									class="weui-input required" placeholder="请选择离校时间" />
							</div>
						</div>

						<div class="weui-cell">
							<div class="weui-cell__bd">
								<textarea id="strVisitRemark" name="strVisitRemark"
									class="weui-textarea" placeholder="请输入来访事由" rows="3"></textarea>
								<div class="weui-textarea-counter">
									<span>0</span>/200
								</div>
							</div>
						</div>
					</div>
					<input class="weui-btn weui-btn_primary" type="submit" value="提交登记">
				</form>
			</div>
		</div>
	</div>

	<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="../js/plugins/jQuery/jquery.validate.js"></script>
	<script src="../js/plugins/jQuery/jquery.validate.extend.js"></script>
	<script src="../js/fastclick.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
	<script src="../js/plugins/jQueryUI/jquery-ui.min.js"></script>
	<script
		src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
	<script>
	    $("#visitTime").datetimePicker();
	    $("#leaveTime").datetimePicker();
	
	    $("#strVisitTime").datetimePicker();
	    $("#strLeaveTime").datetimePicker();
	    
		$(function() {
			FastClick.attach(document.body);
			$.ajaxSetup({
				async : false
			//取消异步  
			});

			$("#student").autocomplete(
					{
						source : function(request, response) {
							// request.term 是用户输入的字符串
							// 你可以在这里自行获取数据、自行处理
							//根据教师和用户输入获取匹配的学生数据
							var students = [];
							$.get("../visitor/list/students?param="
									+ request.term, function(data, status) {
								for (var i = 0; i < data.length; i++) {
									console.info(JSON.stringify(data[i].name));
									students.push(data[i].name);
									console.info(JSON.stringify(students));
								}
							})

							var dataArray = students; // 表示处理后的数组数据
							console.log(request.term)
							// 将数组数据交给Autocomplete显示为菜单
							// 如果情况特殊，你也可以不调用，从而不显示菜单
							response(dataArray);
						},
						select : function(event, ui) {
							parents = [];
							$.get("../visitor/list/parents?studentName="
									+ ui.item.value, function(data, status) {
								for (var i = 0; i < data.length; i++) {
									console.info(JSON.stringify(data[i].name));
									parents.push(data[i].name);
									console.info(JSON.stringify(parents));
								}
							});

							$("#parent").picker({
								cols : [ {
									textAlign : 'center',
									values : parents,//根据所选学生获取家长列表 
									onChange : function(p, v, dv) {
										console.info($(dv).attr("parentId"));
									}
								} ]
							});

							return false;
						}
					});

			$("#visit-form").validate({
				messages : {
					student : {
						required : "学生姓名不能为空",
					},
					parent : {
						required : "家长姓名不能为空"
					},
					visitTime : {
						required : "来访时间不能为空"
					},
					leaveTime : {
						required : "离校时间不能为空"
					}
				},
				errorPlacement : function(error, element) {
					if (element.is("input"))
						error.appendTo(element.parent().parent());
				}
			});

			$("#stranger-visit-form").validate({
				rules : {
					phone : {
						required : true,
						testPhone : true
					},
					cardNo : {
						testIdCard : true
					}
				},
				messages : {
					visitorName : {
						required : "来访者姓名不能为空"
					},
					cardNo : {
						required : "来访者身份证号不能为空"
					},
					phone : {
						required : "来访者电话不能为空"
					},
					strVisitTime : {
						required : "来访时间不能为空"
					},
					strLeaveTime : {
						required : "离校时间不能为空"
					}
				},
				errorPlacement : function(error, element) {
					if (element.is("input"))
						error.appendTo(element.parent().parent());
				}
			})
		})
	</script>
</body>
</html>