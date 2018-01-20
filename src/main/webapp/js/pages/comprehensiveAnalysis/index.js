navQualityChartOption = {
    tooltip: {
        trigger: 'item',
        formatter: "{a} <br/>{b}: {c} ({d}%)"
    },
	title : {
		text:"1242",
		subtext:"合计分值",
		x:"center",
		y:"center"
	},
	color : ['#87cefa', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3'],
    series: [
        {
            name:'访问来源',
            type:'pie',
            radius: ['30%', '55%'],
            avoidLabelOverlap: false,
            labelLine: {
                normal: {
                    show: true
                }
            },
			label: {
				normal: {
					show:true,
					postion:'outside',
					formatter: '{b}\n{c}'
				}
			},
            data:[
                {value:115, name:'道德品质'},
                {value:110, name:'公民素养'},
                {value:234, name:'学习能力'},
                {value:135, name:'交流与合作'},
                {value:648, name:'运动与健康'}
            ]
        }
    ]
};

var dom = document.getElementById("navQualityChart");
var navQualityChart = echarts.init(dom);
navQualityChart.setOption(navQualityChartOption);

window.onresize = navQualityChart.resize;

