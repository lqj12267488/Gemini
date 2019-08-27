/**
 * Created by Administrator on 2017/8/9.
 */
function yqglCol(liListFlag,liList,liListAll,myCharts,myChartFlag,options){
    for (var i = 0; i < 2; i++) {
        var echartsIdDiv = '<div id="echartsId' + i + '" style="width: 90%;height: 90%;"></div>';
        if (!liListFlag) {
            liList[i] = '<li class="echarts_li" style="height: 700px;">' + echartsIdDiv + '</li>';
        } else {
            liList[i] = '<li class="echarts_li_bottom">' + echartsIdDiv + '</li>';
            liListFlag = false;
        }
        liListAll += liList[i];
    }
    $('#eCharts_ul').append(liListAll);
    for(var i = 0; i < 2 ;i ++ ){
        myCharts[i] = echarts.init(document.getElementById('echartsId'+i));
        myChartFlag[i] = true;
    }
    liListAll = '';
    // 指定图表的配置项和数据
    options[0] = {
        title: {
            text: '最近12周抓取数量',
            textStyle:{
                color: '#fff'
            },
            x:'center',
            y:'5%'
        },
        tooltip: {
            trigger: 'item',
            backgroundColor : 'rgba(0,0,250,0.2)'
        },
        legend: {
            textStyle:{
                color: '#fff'
            },
            y: '10.5%',
            data: (function (){
                var list = [];
                for (var i = 1; i <=12; i++) {
                    list.push('第'+ i + '周');
                }
                return list;
            })()
        },
        visualMap: {
            color: ['red', 'yellow']
        },
        radar: {
            indicator : [
                { text: '新浪', max: 400},
                { text: '腾讯', max: 400},
                { text: '百度', max: 400},
                { text: '谷歌', max: 400},
                { text: '凤凰网', max: 400}
            ],
            center: ['50%','52%']
        },
        series : (function (){
            var series = [];
            for (var i = 1; i <= 12; i++) {
                series.push({
                    name:'最近12周抓取数量',
                    type: 'radar',
                    textStyle:{
                        color: '#fff'
                    },
                    symbol: 'none',
                    itemStyle: {
                        normal: {
                            lineStyle: {
                                width:1
                            }
                        },
                        emphasis : {
                            areaStyle: {color:'rgba(0,250,0,0.3)'}
                        }
                    },
                    data:[
                        {
                            value:[
                                (40 - i) * 10,
                                (38 - i) * 4 + 60,
                                i * 5 + 10,
                                i * 9,
                                i * i /2
                            ],
                            name: '第'+ i + '周'
                        }
                    ]
                });
            }
            return series;
        })()
    };
    options[1] = {
        title: {
            text: '最近12周敏感词抓取数量',
            x : 'center',
            y : '5%',
            textStyle:{
                color: '#fff'
            }
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            x: 'left',
            y: '10.5%',
            textStyle:{
                color: '#fff'
            },
            data:['抓取数量']
        },
        radar: [
            {
                indicator: (function (){
                    var res = [];
                    for (var i = 1; i <= 12; i++) {
                        res.push({text:'第'+i+'周',max:100});
                    }
                    return res;
                })(),
                center: ['50%','50%'],
                radius: 180
            }
        ],
        series: [
            {
                type: 'radar',
                tooltip: {
                    trigger: 'item'
                },
                textStyle:{
                    color: '#fff'
                },
                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                data: [
                    {
                        name:'抓取数量',
                        value:[2.0, 54.9, 77.0, 23.2, 25.6, 76.7, 35.6, 62.2, 32.6, 20.0, 66.4, 93.3]
                    }
                ]
            }
        ]
    };

    for (var i = 0; i < 2; i++) {
        if (myChartFlag[i]) {
            myCharts[i].setOption(options[i]);
            myChartFlag[i] = false;
        }
    }
    window.onresize = function(){
        myCharts[0].resize();
        myCharts[1].resize();
    }
}