//综合素质评价
$(function(){
	var params = {
			stuIdCard:stu123 
        };
        var url = '';
        jQuery.ajax({
            type: 'GET',
            contentType: 'application/x-www-form-urlencoded',
            url: url,
            data: params,
            dataType: 'json',
            success: function (result) {
            	if ("02" == result.code){
					for (var i = 0; i < result.data.length; i++) {//循环赋值
						var dailyActivities=result.data[i];
						var activityDate=dailyActivities.activityDate;
						var content=dailyActivities.content;
				
						
						
						
					}
				}else if ("01" == result.code) {
					
				}		


            },
            error: function (result) {
                alert("失败啦");
            }
        });
})
