var myChart;
var option;
$(function(){
    //myChart = echarts.init(document.getElementById('echart'));
    /*option = {
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross',
                crossStyle: {
                    color: '#999'
                }
            }
        },
        toolbox: {
        	orient: 'horizontal',
            itemGap: 20,
            right:25,
            feature: {
                dataView: {show: false, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        legend: {
            data:['订单量','交易额']
        },
        xAxis: [
            {
                type: 'category',
                data: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
                axisPointer: {
                    type: 'shadow'
                },
                nameTextStyle:{
                    color:'#999'
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
                name: '订单量',
                min: 0,
                max: 250,
                interval: 50,
                axisLabel: {
                    formatter: '{value}'
                }
            },
            {
                type: 'value',
                name: '交易额',
                min: 0,
                max: 25,
                interval: 5,
                axisLabel: {
                    formatter: '{value}'
                }
            }
        ],
        series: [
            {
                name:'订单量',
                type:'bar',
                data:[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3],
                itemStyle:{
                    normal:{
                        color:'#506e8e'
                    }
                }
                //barWidth:'50%'

            },
            {
                name:'交易额',
                type:'line',
                yAxisIndex: 1,
                data:[2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2],
                itemStyle:{
                    normal:{
                        color:'#378ae2',

                    }
                }
            }
        ]
    };*/
    //option.yAxis[0].max=250;//y轴左边最大值
    //option.yAxis[0].interval=50;//y轴左边间隔
    //option.yAxis[1].max=2500;//y轴右边最大值
    //option.yAxis[1].interval=500;//y轴右边间隔
    //option.xAxis[0].data=['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'];//x轴数据
    //option.series[0].data=[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3];//订单量数据
    //option.series[1].data=[2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2];//交易额数据

    /*//myChart.setOption(option);
    $(window).resize(function(){
        $('#echart>div:nth-child(1)').css('width','100%');
        $('.market canvas').css('width','100%');
    });*/
})