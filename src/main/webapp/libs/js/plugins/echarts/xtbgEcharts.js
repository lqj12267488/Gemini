/**
 * Created by Administrator on 2017/8/8.
 */
//  协同办公
function xtbgCol(liListFlag,liList,liListAll,myCharts,myChartFlag,options,dataArray) {
    for (var i = 0; i < 2; i++) {
        var echartsIdDiv = '<div id="echartsId' + i + '" style="width: 90%;height: 90%;"></div>';
        if (!liListFlag) {
            liList[i] = '<li class="echarts_li" style="width: 90%;">' + echartsIdDiv + '</li>';
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
    var notice = null;//后勤安全处,1,0,继教院,1,0
    var oldnotice = null;//2017-01,0,1,2017-02,0,1,2017-03,0,1,2017-06,0,2

    if(dataArray[0]  ==null ){
        notice = " ,0,0";
        oldnotice = " ,0,0";
    }else{
        notice = dataArray[0].notice;
        oldnotice = dataArray[0].oldnotice;
    }

    if(notice == null){
        notice = " ,0,0";
    }
    if(oldnotice == null){
        oldnotice = " ,0,0";
    }
    notice = notice.split(',');//第一张表数据
    oldnotice = oldnotice.split(',');//第二张表数据

    var deptNoticeName = new Array(notice.length/3);//各部门
    var deptType1 = new Array(notice.length/3);//按部门分的通知
    var deptType2 = new Array(notice.length/3);//按部门分的公告
    var deptType3 = new Array(notice.length/3);//通知公告平均值
    for(var i = 0, j1 = 0, j2 = 0, j3 = 0 ; i < notice.length ; i ++ ){
        if(i%3 === 0){
            deptNoticeName[j1] = notice[i];
            j1 ++;
        }else if(i%3 === 1){
            deptType1[j2] = notice[i];
            deptType3[j2] = parseInt(deptType1[j2]);
            j2 ++;
        }else{
            deptType2[j3] = notice[i];
            deptType3[j3] += parseInt(deptType2[j3]);
            deptType3[j3] /= 2;
            j3 ++;
        }
    }

    var olddate = new Array(oldnotice.length/3);//月份
    var oldType1 = new Array(oldnotice.length/3);//当前月通知
    var oldType2 = new Array(oldnotice.length/3);//当前月公告
    for(var i = 0, j1 = 0, j2 = 0, j3 = 0 ; i < oldnotice.length ; i ++ ){
        if(i%3 === 0){
            olddate[j1] = oldnotice[i];
            j1 ++;
        }else if(i%3 === 1){
            oldType1[j2] = oldnotice[i];
            j2 ++;
        }else{
            oldType2[j3] = oldnotice[i];
            j3 ++;
        }
    }

    liListAll = '';
    // 指定图表的配置项和数据
    colors = ['#5793f3', '#d14a61', '#675bba'];
    options[0] = {
        title: {
            text: '各部门通知、公告统计',
            x:'center',
            textStyle:{
                color: '#fff'
            }
        },
        color: colors,

        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross'
            }
        },
        grid: {
            top: '28%',
            right: '20%'
        },
        toolbox: {
            feature: {
                dataView: {show: true, readOnly: false},
                restore: {show: true},
                saveAsImage: {show: true,backgroundColor:'#436885'}
            }
        },
        legend: {
            x: 'left',
            y: '9%',
            textStyle: {
                color:'#fff'
            },
            data:['通知','公告','通知公告平均值']
        },
        xAxis: [
            {
                type: 'category',
                axisTick: {
                    alignWithLabel: true
                },
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                },
                data: deptNoticeName
            }
        ],
        yAxis: [
            {
                type: 'value',
                name: '通知',
                min: 0,
                max: 300,
                position: 'right',
                axisLine: {
                    lineStyle: {
                        color: colors[0]
                    }
                },
                axisLabel: {
                    formatter: '{value} 条'
                }
            },
            {
                type: 'value',
                name: '公告',
                min: 0,
                max: 250,
                position: 'right',
                offset: 80,
                axisLine: {
                    lineStyle: {
                        color: colors[1]
                    }
                },
                axisLabel: {
                    formatter: '{value} 个'
                }
            },
            {
                type: 'value',
                name: '通知公告平均值',
                min: 0,
                max: 25,
                position: 'left',
                axisLine: {
                    lineStyle: {
                        color: colors[2]
                    }
                },
                axisLabel: {
                    formatter: '{value} 条'
                }
            }
        ],
        series: [
            {
                name:'通知',
                type:'bar',
                data:deptType1
            },
            {
                name:'公告',
                type:'bar',
                yAxisIndex: 1,
                data:deptType2
            },
            {
                name:'通知公告平均值',
                type:'line',
                yAxisIndex: 2,
                data:deptType3
            }
        ]
    };
    options[1] = {
        title: {
            text: '当前年份通知、公告数量统计',
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
            data:['通知数量','公告数量']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        toolbox: {
            feature: {
                saveAsImage: {show: true,backgroundColor:'#436885'}
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
            data: olddate
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
                name:'通知数量',
                type:'line',
                stack: '总量',
                data:oldType1
            },
            {
                name:'公告数量',
                type:'line',
                stack: '总量',
                data:oldType2
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
