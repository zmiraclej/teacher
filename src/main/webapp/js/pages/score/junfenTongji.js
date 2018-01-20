
var selectedClass;

function getTopOption(score_data){
	var option = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'shadow',
		            label: {
		                show: true
		            }
		        }
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType: {show: true, type: ['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    legend: {
		        data:['语文', '英语', '数学', '物理','化学'],
		        itemGap: 5,
		        left: 5
		    },
		    color : ['#87cefa', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3'],
		    grid: {
		        top: '12%',
		        left: '1%',
		        right: '1%',
		        containLabel: true
		    },
		    xAxis: [
		        {
		            type : 'category',
		            data : score_data.names
		        }
		    ],
		    yAxis: [
		        {
		            type : 'value',
		            name : '平均分',
		        }
		    ],
		    series : [
		        {
		            name: '语文',
		            type: 'bar',
		            barMaxWidth:60,
		            data: score_data.yuwen
		        },
		        {
		            name: '英语',
		            type: 'bar',
		            barMaxWidth:60,
		            data: score_data.yingyu
		        },
		        {
		            name: '数学',
		            type: 'bar',
		            barMaxWidth:60,
		             data: score_data.shuxue
		        },
		        {
		            name: '化学',
		            type: 'bar',
		            barMaxWidth:60,
		            data: score_data.huaxue
		        },
		        {
		            name: '物理',
		            type: 'bar',
		            barMaxWidth:60,
		            data: score_data.wuli
		        }
		    ]
		};
	
	return option
}

function getFirstOption(score_data){
	var option = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'shadow',
		            label: {
		                show: true
		            }
		        }
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType: {show: true, type: ['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    legend: {
		        data:['语文', '英语', '数学', '物理','化学'],
		        itemGap: 5
		    },
		    color : ['#87cefa', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3'],
		    grid: {
		        top: '12%',
		        left: '1%',
		        right: '1%',
		        containLabel: true
		    },
		    xAxis: [
		        {
		            type : 'category',
		            data : score_data.names
		        }
		    ],
		    yAxis: [
		        {
		            type : 'value',
		            name : '平均分',
		        }
		    ],
		    dataZoom: [
		        {
		            show: true,
		            start: 1,
		            end: 50,
		            xAxisIndex: [0]
		        },
		        {
		            type: 'inside',
		            start: 94,
		            end: 100
		        },
//		        {
//		            show: true,
//		            yAxisIndex: [0],
//		            filterMode: 'empty',
//		            width: 30,
//		            height: '80%',
//		            showDataShadow: false,
//		            left: '93%'
//		        }
		    ],
		    series : [
		        {
		            name: '语文',
		            type: 'bar',
		            barMaxWidth:60,
		            data: score_data.yuwen
		        },
		        {
		            name: '英语',
		            type: 'bar',
		            barMaxWidth:60,
		            data: score_data.yingyu
		        },
		        {
		            name: '数学',
		            type: 'bar',
		            barMaxWidth:60,
		             data: score_data.shuxue
		        },
		        {
		            name: '化学',
		            type: 'bar',
		            barMaxWidth:60,
		            data: score_data.huaxue
		        },
		        {
		            name: '物理',
		            type: 'bar',
		            barMaxWidth:60,
		            data: score_data.wuli
		        }
		    ]
		};
	
	return option
}

function getPersonRadarOption(studentName,subjectName, subjectValue){
	var option = {
		    title: {
		        text: studentName+'-'+subjectName+'('+subjectValue+')',
		        left : 'center',
		        top : 20
		    },
		    tooltip: {},
		    legend: {
		    	bottom:1,
		        data: ['满分', studentName, selectedClass, '锦江校区', '北城校区', '成华校区'],
		        selected:{'满分':false, '陈澎':true, selectedClass:true, '锦江校区':false, '北城校区':false, '成华校区':false}
		    },
		    color : ['#87cefa', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3'],
		    radar: {
		        // shape: 'circle',
		        indicator: [
		           { name: '语言知识', max: 25},
		           { name: '听力', max: 30},
		           { name: '阅读', max: 70},
		           { name: '写作', max: 25},
		           { name: '应用', max: 50},
		           { name: '理解掌握', max: 100}
		        ],
		        radius:'60%',
		    },
		    series: [{
		        name: studentName+'-'+subjectName+'('+subjectValue+')',
		        type: 'radar',
		        // areaStyle: {normal: {}},
		        data : [
		            {
		                value : [25, 30, 70, 25, 50, 100],
		                name : '满分'
		            },
		            {
		                value : [21, 15, 50, 20, 40, 85],
		                name : studentName
		            },
		            {
		                value : [16, 18, 46, 19, 43, 79],
		                name : selectedClass
		            },
		            {
		                value : [21, 20, 50, 18, 42, 76],
		                name : '锦江校区'
		            },
		            {
		                value : [21, 16, 49, 20, 40, 70],
		                name : '北城校区'
		            },
		            {
		                value : [19, 10, 46, 18, 39, 60],
		                name : '成华校区'
		            },
		        ]
		    }]
		};
	
	return option;
}


//定义的下钻函数
var drillDown = {

    initChartTop:function(){
    	var me = this;
		
		currentChartIndex = 0;
		$.get('../js/pages/score/data/xuexiaoTongji.json', function (scoreData) {
		    myChart.hideLoading();
		    myChart.setOption(getTopOption(scoreData));
		    
		    myChart.on('click', function(object) {
//				profit1_xkey2 = object.name;// 点击柱子的x轴
				me.initChart(myChart)
			});
		});
    },
    
	// 第一层初始化函数
	initChart : function(myChart) {
		var me = this;
		
		currentChartIndex = 1;
		
		$.get('../js/pages/score/data/junfenTongji.json', function (scoreData) {
		    myChart.hideLoading();
		    myChart.setOption(getFirstOption(scoreData));
		    
		    myChart.on('click', function(object) {
		    	selectedClass = object.name;
//				profit1_xkey2 = object.name;// 点击柱子的x轴
				me.initChart2(myChart)
			});
		});

	},
	
	// 第二层初始化
	initChart2 : function(myChart) {
		var me = this;
		echarts.dispose(dom);// 销毁dom
		myChart = echarts.init(dom);// 初始化demo
		
		currentChartIndex = 2;
		
		$.get('../js/pages/score/data/chengji.json', function (scoreData) {
		    myChart.hideLoading();
		    myChart.setOption(getFirstOption(scoreData));
		    
		    myChart.on('click', function(object) {
		    	console.log(object);
		    	var studentName = object.name;
		    	var subjectName = object.seriesName;
		    	var subjectValue = object.value; 
		    	
		    	var index = layer.open({
	           		  type: 1,
	           		  title: '试题得分分析',
	           		  area: ['350px', '460px'],
	           		  shadeClose: true, //点击遮罩关闭
	           		  maxmin: false,
	           		  content: $('#studentScore')
	         		});
		    	
		    	var radarDom = document.getElementById("personScoreRadar");
		    	var radarChart = echarts.init(radarDom);
		    	
		    	radarChart.setOption(getPersonRadarOption(studentName,subjectName, subjectValue));
		    	
		    	$("#studentName").html("<b>"+studentName+"</b>");
		    	$("#subjectName").html(subjectName);
//				profit1_xkey2 = object.name;// 点击柱子的x轴
//				me.initChart2(myChart, option)
			});
		});

	},
};


var dom = document.getElementById("junfenTongjiChart");
var myChart = echarts.init(dom);
var app = {};
myChart.showLoading();

// 首层构建
drillDown.initChartTop(myChart);

var currentChartIndex = 0;

$('#backParent').on('click', function() { // 返回按钮加载事件，重新初始化
	if (currentChartIndex == 0) {// 第一层无操作
		return;
	}
	echarts.dispose(dom);// 返回必须销毁销毁dom
	myChart = echarts.init(dom);// 初始化demo

	if(currentChartIndex == 2){
		drillDown.initChart(myChart);
	} else if (currentChartIndex == 1){
		drillDown.initChartTop(myChart);// 初始化第一层
	}
	

});

