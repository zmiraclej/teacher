
var selectedClass;

var chengjiData = {
    "fenshu": [
		118,
		119,
		117.5,
		124.5,
		113.5,
		122,
		124,
		116,
		113,
		122,
		111,
		119.5,
		121.5,
		122,
		115,
		122,
		121.5,
		125,
		127.5,
		120,
		116.5,
		118,
		126.5,
		120,
		129,
		113,
		118.5,
		113,
		118,
		120,
		120,
		114.5,
		122,
		130.5,
		119.5,
		121.5,
		120.5,
		125,
		113,
		125.5,
		126.5,
		123.5,
		121.5,
		125.5,
		126.5,
		126,
		120
    ],
    
    "yingyu": [
		134.5,
		137,
		136.5,
		122,
		108,
		135,
		144,
		135.75,
		123.75,
		129.5,
		126.5,
		119,
		132.75,
		131.25,
		128.5,
		131.25,
		137.75,
		122.75,
		136.75,
		135,
		135.25,
		136.75,
		136.25,
		133.5,
		136.25,
		107.75,
		129.75,
		134,
		142.5,
		137.25,
		132.75,
		55,
		131.5,
		139.25,
		134.75,
		138.75,
		119.5,
		142.5,
		125.25,
		134.5,
		136.75,
		130,
		120.75,
		141.5,
		131.25,
		135,
		119.25
    ],
    
    "shuxue": [
		134,
		132,
		136,
		112,
		130,
		111,
		136,
		125,
		110,
		118,
		116,
		125,
		136,
		144,
		116,
		122,
		121,
		121,
		132,
		141,
		138,
		137,
		120,
		123,
		116,
		127,
		108,
		134,
		130,
		137,
		126,
		91,
		122,
		134,
		119,
		127,
		100,
		126,
		110,
		120,
		118,
		116,
		119,
		126,
		121,
		138,
		128
    ],
    
    
    "huaxue": [
		64.5,
		77.5,
		77.5,
		63,
		64.5,
		63.5,
		73.5,
		83.5,
		49,
		73,
		66.5,
		82,
		67,
		75,
		71.5,
		56.5,
		76,
		70.5,
		79,
		70,
		78.5,
		80,
		74.5,
		68,
		66,
		57,
		47,
		68,
		86.5,
		85,
		78,
		58.5,
		78,
		84,
		69,
		69,
		53.5,
		64.5,
		71,
		74.5,
		69,
		77,
		59.5,
		83.5,
		67,
		77,
		77
    ],
    
    "wuli": [
	    101.81,
		109,
		100,
		111,
		99,
		116,
		93,
		114,
		104,
		87,
		112,
		88,
		111,
		109,
		101,
		104,
		100,
		109,
		91,
		111,
		113,
		108,
		118,
		109,
		100,
		113,
		92,
		75,
		101,
		114,
		115,
		103,
		71,
		112,
		118,
		84,
		102,
		74,
		104,
		88,
		102,
		107,
		102,
		83,
		104,
		99,
		110,
		95
    ],
    
    "delta": [               
    ],
    "names": [
		"陈澎",
		"陈思宇",
		"冯琳森",
		"甘迪文",
		"苟良洲",
		"胡珈维",
		"黄瑞",
		"李汉加",
		"李乐屹",
		"李昕然",
		"李延祺",
		"李周道",
		"刘峤木",
		"刘仁行",
		"刘书畅",
		"刘一潇",
		"梅小桐",
		"潘思存",
		"彭鑫懿",
		"蒲光宇",
		"汪金卓",
		"王驰宇",
		"王一涵",
		"胥备",
		"许恩华",
		"杨京达",
		"杨沐凡",
		"岳永健",
		"张睿杰",
		"章书恒",
		"赵安宁",
		"郑文欣浩",
		"周蜀宜",
		"甘雨幽",
		"龚怡佳",
		"胡泽阳",
		"黄诗雨",
		"梁善晴",
		"孟珂妤",
		"卿若希",
		"孙艺嘉",
		"吴雨圃",
		"张珂睿",
		"张萌萌",
		"赵虹璇",
		"周若雨",
		"李明锴"
     ]
};

var xuexiaoTongjiData = {
    "person": [
		121,
		118,
		116,
		89,
		83
    ],
    
    "junfen": [
		102,
		100,
		101,
		71,
		95
    ],
    
    "youxiu": [
		120,
		113,
		108,
		 92,
		 100
    ],
    
    "jige": [
		90,
		88,
		77,
		66,
		71
    ],
	
    "delta": [               
    ],
    "names": [
    	"初一一班",
		"初一二班",
		"初一三班",
		"初一四班",
		"初一五班"
	]
};

var junfentongjiData = {
    "fenshu": [
		110,
		124,
		126,
		117,
		118,
		119,
    ],
    
    "jige": [
		90,
		92,
		95,
		93,
		88,
		87
    ],
    
    "junfen": [
		95,
		97,
		98,
		99,
		93,
		92
    ],
    
    
    "youxiu": [
		120,
		114,
		120,
		107,
		108,
		113,
    ],
    
    "wuli": [
	    101.81,
		96.67,
		99.44,
		102.04,
		99.62,
		100.8,
		99.02,
		99.4,
		106.43,
		100.02,
		103.41,
		110.67,
		107.68,
		110.93,
		98,
		85.62,
		96.82,
		99.47,
		100.4,
		95.33,
		99.21,
		96.95,
		106.31,
		107.72
    ],
    
    "delta": [               
    ],
    "names": [
		"3月月考",
		"4月月考",
		"期中统考",
		"5月月考",
		"6月月考",
		"期末统考",
     ]
};

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
		    
		    calculable : true,
		    legend: {
		        data:['授课班级', '及格线', '班级平均线', '班级优秀线'],
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
		            name : '得分',
		        }
		    ],
		    series : [
		        {
		            name: '授课班级',
		            type: 'bar',
		            barMaxWidth:60,
		            data: score_data.person
		        },
		        {
		            name: '及格线',
		            type: 'line',
		            barMaxWidth:60,
		            data: score_data.jige
		        },{
		            name: '班级平均线',
		            type: 'line',
		            barMaxWidth:60,
		            data: score_data.junfen
		        },
		        {
		            name: '班级优秀线',
		            type: 'line',
		            barMaxWidth:60,
		            data: score_data.youxiu
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
		    calculable : true,
		    legend: {
		        data:['授课班级', '及格线', '班级平均线', '班级优秀线'],
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
		            name : '分数',
		        }
		    ],
		    series : [
		        {
		            name: '授课班级',
		            type: 'bar',
		            barMaxWidth:60,
		            data: score_data.fenshu
		        },
		        {
		            name: '及格线',
		            type: 'line',
		            barMaxWidth:60,
		            data: score_data.jige
		        },{
		            name: '班级平均线',
		            type: 'line',
		            barMaxWidth:60,
		            data: score_data.junfen
		        },
		        {
		            name: '班级优秀线',
		            type: 'line',
		            barMaxWidth:60,
		            data: score_data.youxiu
		        }
		       
		    ]
		};
	
	return option
}

//定义的下钻函数
var drillDown = {

    initChartTop:function(){
    	var me = this;
		
		currentChartIndex = 0;
		myChart.hideLoading();
		myChart.setOption(getTopOption(xuexiaoTongjiData));
		
//		myChart.on('click', function(object) {
////				profit1_xkey2 = object.name;// 点击柱子的x轴
//			me.initChart(myChart)
//			$('#returnBtn').removeClass("weui-btn_disabled");
//		});
		
    },
    
	// 第一层初始化函数
	initChart : function(myChart) {
		var me = this;
		
		currentChartIndex = 1;
		echarts.dispose(dom);// 销毁dom
		
		myChart = echarts.init(dom);// 初始化demo
		myChart.hideLoading();
		myChart.setOption(getFirstOption(junfentongjiData));
		
	},
	
	// 第二层初始化
	initChart2 : function(myChart) {
		var me = this;
		echarts.dispose(dom);// 销毁dom
		myChart = echarts.init(dom);// 初始化demo
		
		currentChartIndex = 2;
		
		
		myChart.hideLoading();
		myChart.setOption(getFirstOption(chengjiData));
		

	},
};


var dom = document.getElementById("junfenTongjiChart");
var myChart = echarts.init(dom);
var app = {};
myChart.showLoading();

// 首层构建
drillDown.initChartTop(myChart);

var currentChartIndex = 0;

$('#returnBtn').on('click', function() { // 返回按钮加载事件，重新初始化
	if (currentChartIndex == 0) {// 第一层无操作
		return;
	}
	echarts.dispose(dom);// 返回必须销毁销毁dom
	myChart = echarts.init(dom);// 初始化demo

	if(currentChartIndex == 2){
		drillDown.initChart(myChart);
	} else if (currentChartIndex == 1){
		drillDown.initChartTop(myChart);// 初始化第一层
		$('#returnBtn').addClass("weui-btn_disabled");
	}
	

});

