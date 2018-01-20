<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<link rel="icon" href="/logo/logo-icon-small.png">
<head>
    <title>家长通讯录查询</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

    <meta name="description" content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.
">
    <link rel="stylesheet" href="../css/common/weui.min.css">
    <link rel="stylesheet" href="../css/common/jquery-weui.css">
    <link rel="stylesheet" href="../css/common/demos.css">
</head>

<body ontouchstart>
<div class="weui-tab">
    <div class="weui-tab__bd">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">家长通讯录查询</div>

            <div class="weui-cell">
                <div class="weui-cell__hd"><label for="queryWay" class="weui-label">查询方式</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" id="queryWay" type="text" value="">
                    <input type="hidden" id="wayVal" value="1" />
                </div>
            </div>

            <div class="weui-cell way1">
                <div class="weui-cell__hd"><label for="school" class="weui-label">学校</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" id="school" type="text" value="">
                </div>
            </div>
            <div class="weui-cell way1">
                <div class="weui-cell__hd"><label for="stage" class="weui-label">学部</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" id="stage" type="text" value="">
                </div>
            </div>
            <div class="weui-cell way1">
                <div class="weui-cell__hd"><label for="grade" class="weui-label">年级</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" id="grade" type="text" value="">
                </div>
            </div>
            <div class="weui-cell way1">
                <div class="weui-cell__hd"><label for="class" class="weui-label">班级</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" id="class" type="text" value="">
                </div>
            </div>

            <div class="weui-cell way2">
                <div class="weui-cell__hd"><label for="name" class="weui-label">姓名</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" id="name" type="text" value="">
                </div>
            </div>

            <div class="weui-cell way3">
                <div class="weui-cell__hd"><label for="phone" class="weui-label">手机号</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" id="phone" type="text" value="">
                </div>
            </div>

            <div class="weui-cell">
                <a href="javascript:queryParentAdrrBooks();" class="weui-tabbar__item weui-bar__item--on"
                   id="publish">
                    <div class="weui-tabbar__icon">
                        <img src="../img/commit.png" alt="">
                    </div>
                    <p class="weui-tabbar__label">查询</p>
                </a>
                <a href="../pageSkip/toParentAddressBook" class="weui-tabbar__item weui-bar__item--on"
                   id="cancel">

                    <div class="weui-tabbar__icon">
                        <img src="../img/return.png" alt="">
                    </div>
                    <p class="weui-tabbar__label">清空</p>
                </a>
            </div>

        </div>


        <div class="weui-panel weui-panel_access" id="phoneList"></div>
    </div>

</div>

<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../js/fastclick.js"></script>
<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>
<script src="../js/pages/parentAddressBook/empAddrBook.js"></script>


<script>

  $(function () {
    FastClick.attach(document.body);
    initData();
    decideQueryWay();
  });

  function initData() {
    loadData();
  }

  //加载数据
  function loadData() {
    //加载学校
    $.ajax({
      url: "../grade/querySchools",
      type: "GET",
      contentType: "application/json",
      dataType: "json",
      success: function (result) {
        if (result !== null && result !== "") {
          var data = result;
          console.log(data);
          $("#school").select({
            title: "选择学校",
            items: data,
            onChange: function (d) {
              var school = $("#school").attr("data-values");
              processSchool(school);
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

  $("#school").change(function () {
    var school = $("#school").attr("data-values");
    console.log(this, school);
    processSchool(school);
  });

  $("#stage").change(function () {
    var stage = $("#stage").attr("data-values");
    console.log(this, stage);
    processStage(stage);
  });

  $("#grade").change(function () {
    var grade = $("#grade").attr("data-values");
    console.log("grade = " + grade);
    processGrade(grade);
  });
  /**
   * 查询家长通讯录
   * @param school
   * @param stage
   * @param grade
   * @param classNo
   */
  function queryParentAdrrBooks() {
    var wayVal = $("#wayVal").val();
    var queryParams = "?" + assembleQueryStr();

    if(wayVal == 1){
      //高级查询
      queryAdrrBooksByVaries(queryParams);
    }else if(wayVal == 2){
      //按姓名查询
      queryParentAdrrBooksByName(queryParams);
    }else if(wayVal == 3){
      //按手机号查询
      queryParentAdrrBooksByPhone(queryParams);
    }

  }
  /**
   * 查询家长通讯录
   * @param school
   * @param stage
   * @param grade
   * @param classNo
   */
  function queryAdrrBooksByVaries() {
    var queryParams = "?" + assembleQueryStr();
    //查询通讯录
    $.ajax({
      url:"../grade/searchParentsPhone" + queryParams,
      type: "GET",
      contentType: "application/json",
      dataType: "json",
      success:function(data){
        buildDispContent(data);
      }
    });

  }
  /**
   * 根据手机号码查询家长通讯录
   */
  function queryParentAdrrBooksByPhone() {
    var phone = $("#phone").val();
    //查询通讯录
    $.ajax({
      url:"../grade/queryParentsByPhone?phone=" + phone,
      type: "GET",
      contentType: "application/json",
      dataType: "json",
      success:function(data){
        buildDispContent(data);
      }
    });

  }
  /**
   * 根据姓名查询家长通讯录
   */
  function queryParentAdrrBooksByName() {
    var name = $("#name").val();
    //查询通讯录
    $.ajax({
      url:"../grade/queryParentsByName?name=" + name,
      type: "GET",
      contentType: "application/json",
      dataType: "json",
      success:function(data){
        buildDispContent(data);
      }
    });
  }

  function buildDispContent(data){
    if("02" == data.code){
      $("#phoneList").html("");
      var list=data.data;
      if( list != null && list.length > 0) {
        var html="";
        for (var i = 0; i < list.length ; i++ ) {
          var cp = list[i];
          html+='<div class="weui-panel__hd" style="background-color:#E5E4E2;font-size:15px">' + cp.className+'</div>';
          console.log(cp);

          for (var j = 0; j < cp.parents.length; j++) {
            var pt=cp.parents[j];
            var parentName=pt.parentName;
            var studentName=pt.studentName;
            var phone=pt.phone;
            html+='<div class="weui-panel__bd"><a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg"><div class="weui-cell__bd"><span style="font-size:10px;color:#C0C0C0">学生:</span><span>'+studentName+'</span><span style="font-size:10px;color:#C0C0C0">家长:</span><span style="font-size:10px;color:#C0C0C0">'+parentName+'</span></div><span class="weui-cell__ft" style="color:#3cc51f">'+phone+'</span></a></div>';
          }
        }

        $("#phoneList").html(html);
      }else{
        $("#phoneList").html("");

      }
    }
  }

</script>
</body>
</html>