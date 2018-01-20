<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<link rel="icon" href="/logo/logo-icon-small.png">
<head>
    <title>教职工通讯录查询</title>
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
            <div class="weui-panel__hd">教职工通讯录查询</div>

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
                <a href="javascript:queryTeacherAdrrBooks();"
                   class="weui-tabbar__item weui-bar__item--on"
                   id="publish">
                    <div class="weui-tabbar__icon">
                        <img src="../img/commit.png" alt="">
                    </div>
                    <p class="weui-tabbar__label">查询</p>
                </a>
                <a href="../pageSkip/empPhoneListMain" class="weui-tabbar__item weui-bar__item--on"
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



</script>
</body>
</html>