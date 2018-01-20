

function queryStage(schoolCode) {
  var queryParams = "?" + assembleQueryStr();
  //加载学部
  $.ajax({
    url: "../grade/queryStages" + queryParams,
    type: "GET",
    contentType: "application/json",
    dataType: "json",
    success: function (result) {
      if (result !== null && result !== "") {
        var data = result;
        console.log(data);
        $("#stage").select("update", {
          title: "选择学部",
          items: data,
          onChange: function (d) {
            var stage = $("#stage").attr("data-values");
            console.log(this, stage);
            var stageArr = stage.split("_");
            queryGrades(stageArr[0], stageArr[1]);
          },
          onClose: function () {
            console.log("close");
          },
          onOpen: function () {
            console.log("open");
          },
        });
      } else {
        console.log("no school data");
      }
    }
  });

}

/**
 *
 * @param schoolCode
 * @param stage
 */
function queryGrades(schoolCode, stage) {
  var queryParams = "?" + assembleQueryStr();
  //加载年级
  $.ajax({
    url: "../grade/queryGradesByEmp" + queryParams,
    type: "GET",
    contentType: "application/json",
    dataType: "json",
    success: function (result) {
      if (isNotEmpty(result)) {
        var data = result;
        //console.log(data);
        $("#grade").select("update", {
          title: "选择年级",
          items: data,
          onChange: function (d) {
            var grade = $("#grade").attr("data-values");
            var gradeArr = grade.split("_");
            //console.log("grade = " + grade);
            queryClasses(gradeArr[0], gradeArr[1], gradeArr[2]);
          },
          onClose: function () {
            //console.log("close");
          },
          onOpen: function () {
            //console.log("open");
          },
        });
      } else {
        console.log("no grade data");
      }
    }
  });

}

function queryClasses(school, stage, grade) {
  console.log("school = " + school + "| stage = " + stage + " grade=" + grade);
  var queryParams = "?" + assembleQueryStr();
  //加载班级
  $.ajax({
    url: "../grade/queryClasses" + queryParams,
    type: "GET",
    contentType: "application/json",
    dataType: "json",
    success: function (result) {
      if (result !== null && result !== "") {
        var data = result;
        console.log(data);
        $("#class").select("update", {
          title: "选择班级",
          items: data,
          onChange: function (d) {
            var class1 = $("#class").attr("data-values");
            console.log("class1 = " + class1);
          },
          onClose: function () {
            console.log("close");
          },
          onOpen: function () {
            console.log("open");
          },
        });
      } else {
        console.log("no class data");
      }
    }
  });
}

/**
 * 查询教师通讯录
 * @param school
 * @param stage
 * @param grade
 * @param classNo
 */
function queryTeacherAdrrBooks() {
  var wayVal = $("#wayVal").val();
  var queryParams = "?" + assembleQueryStr();

  if(wayVal == 1){
    //高级查询教师
    queryTeacherByVaries(queryParams);
  }else if(wayVal == 2){
    //按姓名查询
    queryTeacherByName(queryParams);
  }else if(wayVal == 3){
    //按手机号查询
    queryTeacherByPhone(queryParams);
  }

}

/**
 * 根据姓名查询
 * @param queryParams
 */
function queryTeacherByName(queryParams){
  var name = $("#name").val();
  $.ajax({
    url: "../grade/queryTeacherByName?name=" + name,
    type: "get",
    contentType: "application/json",
    dataType: "json",
    success: function (data) {
      if (data !== null && data !== "") {
        console.log(data);
        $("#phoneList").html("");
        var list = data;
        if (list != null) {
          var html = "";
          html += '<div class="weui-panel__hd" style="background-color:#E5E4E2;font-size:15px"> 查询结果：</div>';
          for (var i = 0; i < list.length; i++) {
            var cp = list[i];
            var teacherName = cp.title;
            var phone = cp.value;
            html += '<div class="weui-panel__bd"><a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg"><div class="weui-cell__bd"><span style="font-size:10px;color:#C0C0C0">姓名:</span><span>'
                + teacherName + '</span></div><span class="weui-cell__ft" style="color:#3cc51f">'
                + phone + '</span></a></div>';

          }

          $("#phoneList").html(html);
        } else {
          $("#phoneList").html("");

        }
      }
    }
  });
}

/**
 * 根据手机查询
 * @param queryParams
 */
function queryTeacherByPhone(queryParams){
  var phone = $("#phone").val();
  //根据手机查询
  $.ajax({
    url: "../grade/queryTeacherByPhone?phone=" + phone,
    type: "get",
    contentType: "application/json",
    dataType: "json",
    success: function (data) {
      if (data !== null && data !== "") {
        console.log(data);
        $("#phoneList").html("");
        var list = data;
        if (list != null) {
          var html = "";
          html += '<div class="weui-panel__hd" style="background-color:#E5E4E2;font-size:15px"> 查询结果：</div>';
          for (var i = 0; i < list.length; i++) {
            var cp = list[i];
            var teacherName = cp.title;
            var phone = cp.value;
            html += '<div class="weui-panel__bd"><a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg"><div class="weui-cell__bd"><span style="font-size:10px;color:#C0C0C0">姓名:</span><span>'
                + teacherName + '</span></div><span class="weui-cell__ft" style="color:#3cc51f">'
                + phone + '</span></a></div>';

          }

          $("#phoneList").html(html);
        } else {
          $("#phoneList").html("");

        }
      }
    }
  });
}
/**
 * 高级查询教师
 * @param queryParams 查询参数
 */
function queryTeacherByVaries(queryParams){
  //高级查询
  $.ajax({
    url: "../grade/searchTeachers" + queryParams,
    type: "get",
    contentType: "application/json",
    dataType: "json",
    success: function (data) {
      if (data !== null && data !== "") {
        console.log(data);
        $("#phoneList").html("");
        var list = data;
        if (list != null) {
          var html = "";
          html += '<div class="weui-panel__hd" style="background-color:#E5E4E2;font-size:15px"> 查询结果：</div>';
          for (var i = 0; i < list.length; i++) {
            var cp = list[i];
            var teacherName = cp.title;
            var phone = cp.value;
            html += '<div class="weui-panel__bd"><a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg"><div class="weui-cell__bd"><span style="font-size:10px;color:#C0C0C0">姓名:</span><span>'
                + teacherName + '</span></div><span class="weui-cell__ft" style="color:#3cc51f">'
                + phone + '</span></a></div>';

          }

          $("#phoneList").html(html);
        } else {
          $("#phoneList").html("");

        }
      }
    }
  });
}

/**
 * Assemble query String
 */
function assembleQueryStr(){
  var queryParams = "1=1";
  var school = $("#school").attr("data-values");
  if (isNotEmpty(school)) {
    queryParams = queryParams + "&schoolCode=" + school;
  }

  var stageStr = $("#stage").attr("data-values");
  if (isNotEmpty(stageStr)) {
    var stageArr = stageStr.split("_");
    var stage = stageArr[0];
    queryParams = queryParams + "&stage=" + stage;
  }

  var gradeStr = $("#grade").attr("data-values");
  if (isNotEmpty(gradeStr)) {
    var gradeArr = gradeStr.split("_");
    var grade = gradeArr[2];
    queryParams = queryParams + "&grade=" + grade;
  }

  var classStr = $("#class").attr("data-values");
  if (isNotEmpty(classStr)) {
    var classArr = classStr.split("_");
    var classNo = classArr[3];
    queryParams = queryParams + "&classNo=" + classNo;
  }
  console.log("school = " + school + "| stage = " + stageStr + " grade=" + gradeStr);
  return queryParams;
}
/**
 * 清除数据，重新初始化select对象
 * @param obj
 */
function clear(obj){
  var ids = obj.split(",");
 /* console.log("清除" + ids);
  for (var i = 0; i < ids.length; i++) {
    $("#"+ids[i]).select("update", {
      title: "选择",
      items: [
        {
          title: "ALL",
          value: "",
        }],
    });
    console.log("清除" + ids[i]);
  }*/
}

/**
 * 处理学校，发送请求，绑定选择器数据
 * @param school
 */
function processSchool(school){
  if (isNotEmpty(school)) {
    queryStage(school);
  } else {
    clear("stage,grade,class");
  }
}

/**
 * 处理学部，发送请求，绑定选择器数据
 * @param stage
 */
function processStage(stage){
  if (isNotEmpty(stage)) {
    var stageArr = stage.split("_");
    queryGrades(stageArr[0], stageArr[1]);
  } else {
    clear("grade,class");
  }
}

/**
 * 处理班级，发送请求，绑定选择器数据
 * @param grade
 */
function processGrade(grade){
  if (isNotEmpty(grade)) {
    var gradeArr = grade.split("_");
    queryClasses(gradeArr[0], gradeArr[1], gradeArr[2]);
  } else {
    clear("class");
  }
}

/**
 * 判断obj 是否非空，非空为true
 * @param obj
 * @returns {boolean}
 */
function isNotEmpty(obj){
  if(obj != null && obj != undefined && obj != "")
    return true;
  else
    return false;
}

function decideQueryWay(){
  $("#queryWay").select("update", {
    title: "选择查询方式",
    items:   [
      {
        title: "高级查询",
        value: "1",
      },{
        title: "按姓名查询",
        value: "2",
      },{
        title: "按手机号查询",
        value: "3",
      }],
    onChange: function (d) {
      var queryWay = $("#queryWay").attr("data-values");
      console.log("grade = " + queryWay);
      if(queryWay == 1){
        $(".way2").hide();
        $(".way3").hide();
        $(".way1").show();
        $("#wayVal").val("1");
      }else if(queryWay ==2){
        $(".way1").hide();
        $(".way3").hide();
        $(".way2").show();
        $("#wayVal").val("2");
      }else if( queryWay == 3){
        $(".way2").hide();
        $(".way1").hide();
        $(".way3").show();
        $("#wayVal").val("3");
      }else{
        //
      }
    },
    onClose: function () {
      //console.log("close");
    },
    onOpen: function () {
      //console.log("open");
    },
  });
  $("#queryWay").attr("value","高级查询");
  $("#queryWay").attr("data-values","1");
  $(".way2").hide();
  $(".way3").hide();
}