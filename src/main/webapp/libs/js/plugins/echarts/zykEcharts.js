/**
 * Created by Administrator on 2017/8/8.
 */
//   资源库统计
function zykCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray) {
    for (var i = 0; i < 3; i++) {
        var echartsIdDiv = '<div id="echartsId' + i + '" style="width: 90%;height: 90%;"></div>';
        if (!liListFlag) {
            liList[i] = '<li class="echarts_li">' + echartsIdDiv + '</li>';
        } else {
            liList[i] = '<li class="echarts_li_bottom">' + echartsIdDiv + '</li>';
            liListFlag = false;
        }
        liListAll += liList[i];
    }
    $('#eCharts_ul').append(liListAll);
    for (var i = 0; i < 3; i++) {
        myCharts[i] = echarts.init(document.getElementById('echartsId' + i));
        myChartFlag[i] = true;
    }
    var countType = null;//8,2,3,2,2,0,0,0,0
    var countView = null;//964,0,40
    var countSubject = null;//学科二,2,学科一,15
    if(dataArray[0]  ==null ){
        countType = "0,0,0,0,0,0,0,0,0";
        countView = "0,0,0";
        countSubject = " ,0"
    }else{
        countType = dataArray[0].countType;
        countView = dataArray[0].countView;
        countSubject = dataArray[0].countSubject;
    }
    if(countType == null || countType == 'null'){
        countType = "0,0,0,0,0,0,0,0,0";
    }
    if(countView == null || countView == 'null'){
        countView = "0,0,0";
    }
    if(countSubject == null || countSubject == 'null'){
        countSubject = " ,0";
    }
    countType = countType.split(',');
    countView = countView.split(',');
    countSubject = countSubject.split(',');
    var countSubjectName = new Array(countSubject.length / 2);
    var countSubjectNum = new Array(countSubject.length / 2);

    for (var i = 0, j1 = 0, j2 = 0; i < countSubject.length; i++) {
        if (i % 2 === 0) {
            countSubjectName[j1] = countSubject[i];
            j1++;
        } else {
            countSubjectNum[j2] = countSubject[i];
            j2++;
        }
    }

    // 指定图表的配置项和数据
    options[0] = {
        title: {
            text: '学科统计',
            x: 'center',
            textStyle: {
                color: '#fff'
            }
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: {
            type: 'value',
            axisLabel: {
                textStyle: {
                    color: '#fff'
                }
            },
            boundaryGap: [0, 0.01],
        },
        yAxis: {
            type: 'category',
            axisLabel: {
                textStyle: {
                    color: '#fff'
                }
            },
            data: countSubjectName
        },
        series: [
            {
                name: '资源总数',
                type: 'bar',
                data: countSubjectNum
            }
        ]
    };
    options[1] = {
        title: {
            text: '资源类型统计',
            x: 'center',
            textStyle: {
                color: '#fff'
            }
        },
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            textStyle: {
                color: '#fff'
            },
            data: ['课件', '新闻', '教案', '素材', '习题', '学案', '档案', '微课', '其它']

        },
        series: [
            {
                name: '资源总量',
                type: 'pie',
                radius: '55%',
                center: ['50%', '60%'],
                data: [
                    {value: countType[0], name: '课件'},
                    {value: countType[1], name: '新闻'},
                    {value: countType[2], name: '教案'},
                    {value: countType[3], name: '素材'},
                    {value: countType[4], name: '习题'},
                    {value: countType[5], name: '学案'},
                    {value: countType[6], name: '档案'},
                    {value: countType[7], name: '微课'},
                    {value: countType[8], name: '其它'}
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 130, 195, 0.5)'
                    }
                }
            }
        ]
    };
    options[1] = {
        title: {
            text: '资源类型统计',
            x: 'center',
            textStyle: {
                color: '#fff'
            }
        },
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            textStyle: {
                color: '#fff'
            },
            data: ['课件', '新闻', '教案', '素材', '习题', '学案', '档案', '微课', '其它']

        },
        series: [
            {
                name: '资源总量',
                type: 'pie',
                radius: '55%',
                center: ['50%', '60%'],
                data: [
                    {value: countType[0], name: '课件'},
                    {value: countType[1], name: '新闻'},
                    {value: countType[2], name: '教案'},
                    {value: countType[3], name: '素材'},
                    {value: countType[4], name: '习题'},
                    {value: countType[5], name: '学案'},
                    {value: countType[6], name: '档案'},
                    {value: countType[7], name: '微课'},
                    {value: countType[8], name: '其它'}
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 130, 195, 0.5)'
                    }
                }
            }
        ]
    };
    /*options[2] = {
        color: ['#3398DB'],
        tooltip : {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'直接访问',
                type:'bar',
                barWidth: '60%',
                data:[10, 52, 200, 334, 390, 330, 220]
            }
        ]
    };*/
    options[2] = {
        title: {
            text: '资源使用统计',
            //x:'center',
            textStyle:{
                color: '#fff'
            }
        },/*
        legend: {
            orient: 'vertical',
            x : 'left',
            y : 'top',
            textStyle: {
                color:'#fff'
            },
            data:['浏览量','上传量','下载量']
        },*/
        tooltip : {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                /*axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                },*/
                axisTick: {
                    alignWithLabel: true
                },
                data : ['浏览量','上传量','下载量']
            }
        ],
        yAxis : [
            {
                /*axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                },*/
                type : 'value'
            }
        ],
        series : [
            {
                name:'浏览量',
                type:'bar',
                data:countView[0]
            },
            {
                name:'上传总量',
                type:'bar',
                data:countView[1]
            },
            {
                name:'下载总量',
                type:'bar',
                data:countView[2]
            }
        ]
    };


    for (var i = 0; i < 3; i++) {
        if (myChartFlag[i]) {
            myCharts[i].setOption(options[i]);
            myChartFlag[i] = false;
        }
    }
    window.onresize = function(){
        myCharts[0].resize();
        myCharts[1].resize();
        myCharts[2].resize();
    }
}

