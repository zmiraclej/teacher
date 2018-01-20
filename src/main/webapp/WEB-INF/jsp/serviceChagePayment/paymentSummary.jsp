<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>班级年费缴纳状况一览</title>
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
    <div class="weui-panel weui-panel_access">
			<div class="weui-panel__hd">2017年度缴费统计数据</div>
			<div class="weui-panel__bd">
					<div  class="weui-grid js_grid">
						 <div class="weui-grid__label">
							 <span style="font-size:24px" id="paidNumber"></span>
						 </div>
						 <p class="weui-grid__label">
							 已缴费
						 </p>
					</div>
					<div  class="weui-grid js_grid">
						 <div class="weui-grid__label">
							 <span style="font-size:24px" id="unpaidNumber"></span>
						 </div>
						 <p class="weui-grid__label">
							 未缴费
						 </p>
					</div>
					<div  class="weui-grid js_grid">
						 <div class="weui-grid__label">
							 <span style="font-size:24px" id="totalNumber"></span>
						 </div>
						 <p class="weui-grid__label">
							 合计人数
						 </p>
					</div>
				</div>
		</div>
	
    <div class="bd">
      <div class="page__bd">
        <div class="weui-cells__title">教育社区缴费状况</div>
         <div class="weui-cells">
           <div class="weui-cell">
			<div class="weui-cell__bd">
			   <p>请选择缴费状况</p>
			</div>
			<div class="weui-cell__ft">
				<input class="weui-input" id="statusPicker" type="text" value="" placeholder="缴费状况" style="color:#3cc51f">
			</div>
		</div>
         </div>

       <div class="weui-cells" id="infoContainer">
          <!-- <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>李晓明</p>
            </div>
            <div class="weui-cell__ft">2017-07-08 已缴费</div>
          </div> -->
        </div> 
      </div>
    </div>


<script src="../js/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../js/fastclick.js"></script>
<script src="../js/plugins/jQueryUI/jquery-weui.js"></script>



<script>
  $(function() {
    FastClick.attach(document.body);
    initData();
  });

    function initData(){
    	//初始默认选中已缴状态
    	$("#statusPicker").val("全部");
    	//生成状态选择控件
		$("#statusPicker").picker({
			  title: "请选择缴费状态",
			  cols: [
				{
				  textAlign: 'center',
				  values: ['全部','已缴', '未缴', ]
				}
			  ],
			  onClose:function(){
				  loadData();
			  }
			});
    	loadData();
    }

//加载数据
function loadData(){
	var status=$("#statusPicker").val();
	$.showLoading("数据加载中...");
	$.get("../pay/serachClassPaymentInfo?status="+status,function(info){
		$.hideLoading();
		//alert(JSON.stringify(info));
		if(info.code=='01'){
			$.alert(data.msg)
		}if(info.code=='02'){
				//刷新数据
				$("#totalNumber").text(info.data.totalNumber);
				$("#paidNumber").text(info.data.paidNumber);
				$("#unpaidNumber").text(info.data.unpaidNumber);
				var str="";
				var records=info.data.records;
				for(var i=0;i<records.length;i++){
					var obj=records[i];
					str+="<div class='weui-cell'><div class='weui-cell__bd'>"
		              +"<p>"+obj.studentName+"</p></div><div class='weui-cell__ft'>";
		              if(obj.payTime!=null&&obj.payTime!="null"){//缴费时间不为空，则拼接缴费时间，否则不显示时间
		            	 str+=obj.payTime;
		              }
		              str+="&nbsp"+obj.payStatus+"</div></div>";
				}
				$("#infoContainer").html(str);
				if(records.length==0){
					$.alert("暂无数据");
				}
		}			
	})
}

	  
    </script>
  </body>
</html>