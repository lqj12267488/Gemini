/**
 * Created by Administrator on 2017/8/8.
 */
//   人事管理
function rsglCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray) {
    for (var i = 0; i < 4; i++) {
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
    for (var i = 0; i < 4; i++) {
        myCharts[i] = echarts.init(document.getElementById('echartsId' + i));
        myChartFlag[i] = true;
    }
    var sex = null;//97,183
    var age = null;//257,22,110,63,55
    var jzgzt = null;//暂未在本单位任职,借出到机关,借出到事业单位,长病假,进修,交流轮岗,企业实践,因公出国,离岗创业,待退休,待岗,下落不明,其他,在本单位任职
    var jzgztstatus = null;//0,1,3,0,0,0,0,0,0,0,0,0,0,247
    var deptsex = null;//财会金融系,7,25,财务处,0,6,大专教务处,2,5,大专学生处,2,4
    if(dataArray[0]  ==null ){
        sex = "0,0";
        age = "0,0,0,0,0";
        jzgzt = " ";
        jzgztstatus = "0";
        deptsex = " ,0,0";
    }else{
        sex = dataArray[0].sex;
        age = dataArray[0].age;
        jzgzt = dataArray[0].jzgzt;
        jzgztstatus = dataArray[0].jzgztstatus;
        deptsex = dataArray[0].deptsex;
    }

    if(sex == null || sex == 'null'){
        sex = "0,0";
    }
    if(age == null || age == 'null'){
        age = "0,0,0,0,0";
    }
    if(jzgzt == null || jzgzt == 'null'){
        jzgzt = " ";
    }
    if(jzgztstatus == null || jzgztstatus == 'null'){
        jzgztstatus = "0";
    }
    if(deptsex == null || deptsex == 'null'){
        deptsex = " ,0,0";
    }
    sex = sex.split(',');//第一张表数据
    age = age.split(',');//第二张表数据
    jzgzt = jzgzt.split(',');//第三张表数据
    jzgztstatus = jzgztstatus.split(',');//第三张表数据
    deptsex = deptsex.split(',');//第四张表数据
    var jzgztValue = new Array(jzgzt.length);
    var deptsexName = new Array(deptsex.length / 3);//教职工部门
    var deptmanNum = new Array(deptsex.length / 3);//按部门分的男职工
    var deptwomanNum = new Array(deptsex.length / 3);//按部门分的女职工
    for (var i = 0; i < jzgzt.length; i++) {
        jzgztValue[i] = {value: jzgztstatus[i], name: jzgzt[i]};
    }
    for (var i = 0, j1 = 0, j2 = 0, j3 = 0; i < deptsex.length; i++) {
        if (i % 3 === 0) {
            deptsexName[j1] = deptsex[i];
            j1++;
        } else if (i % 3 === 1) {
            deptmanNum[j2] = deptsex[i];
            j2++;
        } else {
            deptwomanNum[j3] = deptsex[i];
            j3++;
        }
    }

    liListAll = '';

    // 指定图表的配置项和数据
    options[0] = {
        title: {
            text: '男女教师统计',
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
            data: ['男', '女']

        },
        series: [
            {
                name: '教师人数',
                type: 'pie',
                radius: '55%',
                center: ['50%', '60%'],
                data: [
                    {value: sex[0], name: '男'},
                    {value: sex[1], name: '女'}
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
            text: '教师年龄统计',
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
            x: 'center',
            y: 'bottom',
            textStyle: {
                color: '#fff'
            },
            data: ['20-30', '31-40', '41-50', '>50']
        },
        toolbox: {
            show: true,
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                magicType: {
                    show: true,
                    type: ['pie', 'funnel']
                },
                restore: {show: true},
                saveAsImage: {show: true,backgroundColor:'#436885'}
            }
        },
        calculable: true,
        series: [
            {
                name: '年龄',
                type: 'pie',
                radius: [30, 90],
                center: ['50%', '50%'],
                roseType: 'area',
                data: [
                    {value: age[1], name: '20-30'},
                    {value: age[2], name: '31-40'},
                    {value: age[3], name: '41-50'},
                    {value: age[4], name: '>50'}
                ]
            }
        ]
    };
    options[2] = {
        title: {
            text: '在职状态统计',
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
            //orient: 'vertical',
            left: 'left',
            y: 'bottom',
            textStyle: {
                color: '#fff'
            },
            data: jzgzt

        },
        series: [
            {
                name: '教师人数',
                type: 'pie',
                radius: ['48%', '65%'],
                center: ['50%', '44%'],
                avoidLabelOverlap: false,
                label: {
                    normal: {
                        show: false,
                        position: 'center'
                    },
                    emphasis: {
                        show: true,
                        textStyle: {
                            fontSize: '26',
                            fontWeight: 'bold'
                        }
                    }
                },
                labelLine: {
                    normal: {
                        show: false
                    }
                },
                data: jzgztValue
            }
        ]
    };
    options[3] = {
        title: {
            text: '各系部男女教职工人数',
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
        legend: {
            x: 'left',
            y: '8%',
            textStyle: {
                color: '#fff'
            },
            data: ['男教师', '女教师']
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
            boundaryGap: [0, 0.01]
        },
        yAxis: {
            type: 'category',
            axisLabel: {
                textStyle: {
                    color: '#fff'
                }
            },
            data: deptsexName
        },
        series: [
            {
                name: '男教师',
                type: 'bar',
                data: deptmanNum
            },
            {
                name: '女教师',
                type: 'bar',
                data: deptwomanNum
            }
        ]
    };

    for (var i = 0; i < 4; i++) {
        if (myChartFlag[i]) {
            myCharts[i].setOption(options[i]);
            myChartFlag[i] = false;
        }
    }
    window.onresize = function(){
        myCharts[0].resize();
        myCharts[1].resize();
        myCharts[2].resize();
        myCharts[3].resize();
    }
}

