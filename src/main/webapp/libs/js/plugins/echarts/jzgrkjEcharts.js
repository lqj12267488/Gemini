/**
 * Created by Administrator on 2017/8/22.
 */

function jzgrkjCol(liListFlag,liList,liListAll,myCharts,myChartFlag,options) {
    for (var i = 0; i < 1; i++) {
        var echartsIdDiv = '<div id="echartsId' + i + '" style="width: 90%;height: 90%;"></div>';
        if (!liListFlag) {
            liList[i] = '<li class="echarts_li" style="width: 99%;height: 700px;">' + echartsIdDiv + '</li>';
        } else {
            liList[i] = '<li class="echarts_li_bottom">' + echartsIdDiv + '</li>';
            liListFlag = false;
        }
        liListAll += liList[i];
    }
    $('#eCharts_ul').append(liListAll);
    for(var i = 0; i < 1 ; i ++){
        myCharts[i] = echarts.init(document.getElementById('echartsId'+i));
        myChartFlag[i] = true;
    }
    liListAll = '';
    // 指定图表的配置项和数据
    options[0] = {
        title: {
            text: '学生个人成绩统计',
            x:'center',
            textStyle:{
                color: '#fff'
            }
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            x: 'left',
            y: '4%',
            textStyle:{
                color: '#fff'
            },
            data:['总科目','不及格科目','及格科目']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        toolbox: {
            feature: {
                saveAsImage:{show: true,backgroundColor:'#436885'}
            }
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            axisLabel: {
                textStyle: {
                    color: '#fff'
                }
            },
            data: ['一模','二模','三模','四模','五模','六模','七模']
        },
        yAxis: {
            axisLabel: {
                textStyle: {
                    color: '#fff'
                }
            },
            type: 'value'
        },
        series: [
            {
                name:'总科目',
                type:'line',
                stack: '总量',
                data:[120, 132, 101, 134, 90, 230, 210]
            },
            {
                name:'不及格科目',
                type:'line',
                stack: '总量',
                data:[220, 182, 191, 234, 290, 330, 310]
            },
            {
                name:'及格科目',
                type:'line',
                stack: '总量',
                data:[150, 232, 201, 154, 190, 330, 410]
            }
        ]
    };
    for (var i = 0; i < 1; i++) {
        if (myChartFlag[i]) {
            myCharts[i].setOption(options[i]);
            myChartFlag[i] = false;
        }
    }
    window.onresize = function(){
        myCharts[0].resize();
    }
}

