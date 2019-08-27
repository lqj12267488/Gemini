/**
 * Created by Administrator on 2017/8/8.
 */
//  教务管理
function jwglCol(liListFlag, liList, liListAll, myCharts, myChartFlag, options, dataArray) {
    liList[0] = '<li class="echarts_li" style="width: 30%;height: 50%; ">' +
        '<div id="echartsId0" style="width: 90%;height: 80%; margin-top:20px "></div>' +
        '</li>';
    liList[1] = '<li class="echarts_li" style="width: 40%;height: 50%;">' +
        '<div id="echartsId1" style="width: 95%;height: 95%;"></div>' +
        '</li>';
    liList[2] = '<li class="echarts_li" style="width: 30%;height: 50%;">' +
        '<div id="echartsId2" style="width: 95%;height: 95%;"></div>' +
        '</li>';
    liList[3] = '<li class="echarts_li" style="width: 25%;height: 45%;">' +
        '<div id="echartsId3" style="width: 95%;height: 95%;"></div>' +
        '</li>';
    liList[4] = '<li class="echarts_li" style="width: 25%;height: 45%;">' +
        '<div id="echartsId4" style="width: 95%;height: 95%;"></div>' +
        '</li>';
    liList[5] = '<li class="echarts_li" style="width: 25%;height: 45%;">' +
        '<div id="echartsId5" style="width: 95%;height: 95%;"></div>' +
        '</li>';
    liList[6] = '<li class="echarts_li" style="width: 25%;height: 45%;">' +
        '<div id="echartsId6" style="width: 95%;height: 95%;"></div>' +
        '</li>';


    for (var i = 0; i < 7; i++) {
        liListAll += liList[i];
    }

    $('#eCharts_ul').append(liListAll);
    for (var i = 0; i < 7; i++) {
        myCharts[i] = echarts.init(document.getElementById('echartsId' + i));
        myChartFlag[i] = true;
    }
    var zycourse = null;// 专业数统计
    var scresult = null;// 项目（课题）,4,
    var deptnames = null;
    var deptcount = null;
    var sextypes = null;
    var finalEducations = null;
    var technical = null;
    var doubleteacher = null;
    var agecount = null;

    if (dataArray[0] == null) {
        zycourse = ",0";
        scresult = "项目（课题）,0,论文,0,著作,0";
        deptnames = "学前教育系,机电工程系";
        deptcount = "26,26";
        sextypes = "40,50";
        finalEducations = "大专,本科";
        technical = "牛,羊";
        doubleteacher = "10,199";
        agecount = "22,66,88";
    } else {
        zycourse = dataArray[0].majorCount;
        scresult = dataArray[0].studentCount;
        deptnames = dataArray[0].deptnames;
        deptcount = dataArray[0].deptcount;
        sextypes = dataArray[0].sextypes;
        finalEducations = dataArray[0].finalEducations;
        technical = dataArray[0].technical;
        doubleteacher = dataArray[0].doubleteacher;
        agecount = dataArray[0].agecount;

    }

    if (zycourse == null || zycourse == 'null') {
        zycourse = ",0";
    }
    if (scresult == null || scresult == 'null') {
        scresult = "项目（课题）,0,论文,0,著作,0";
    }
    if (deptnames == null || deptnames == 'null') {
        deptnames = ",0";
    }
    if (deptcount == null || deptcount == 'null') {
        deptcount = "项目（课题）,0,论文,0,著作,0";
    }
    if (sextypes == null || sextypes == 'null') {
        sextypes = ",0";
    }
    if (finalEducations == null || finalEducations == 'null') {
        finalEducations = "项目（课题）,0,论文,0,著作,0";
    }
    if (doubleteacher == null || doubleteacher == 'null') {
        doubleteacher = ",0";
    }
    if (agecount == null || agecount == 'null') {
        agecount = "项目（课题）,0,论文,0,著作,0";
    }

    zycourse = zycourse.split(',');//第一张表数据
    scresult = scresult.split(',');//第二张表数据
    deptnames = deptnames.split(',');
    deptcount = deptcount.split(',');
    sextypes = sextypes.split(',');
    finalEducations = finalEducations.split(',');
    technical = technical.split(',');
    doubleteacher = doubleteacher.split(',');
    agecount = agecount.split(',');


    var majorName = new Array(zycourse.length / 2);//专业
    var courseNum = new Array(zycourse.length / 2);//课程数
    var courseNums = new Array(zycourse.length / 2);


    for (var i = 0, j1 = 0, j2 = 0; i < zycourse.length; i++) {
        if (i % 2 === 0) {
            majorName[j1] = zycourse[i];
            j1++;
        } else {
            courseNum[j2] = zycourse[i];
            j2++;
        }
    }

    for (var i = 0; i < courseNums.length; i++) {
        courseNums[i] = {value: courseNum[i], name: majorName[i]};
    }

    var scresultName = new Array(scresult.length / 2);//成果名称
    var scresultNum = new Array(scresult.length / 2);//成果数量
    var scresultNums = new Array(scresult.length / 2);
    var inscresultNum = new Array(3);//内层饼图数据

    for (var i = 0, j1 = 0, j2 = 0; i < scresult.length; i++) {
        if (i % 2 === 0) {
            scresultName[j1] = scresult[i];
            j1++;
        } else {
            scresultNum[j2] = scresult[i];
            j2++;
        }
    }


    var manCount = new Array(sextypes.length / 2);//专业
    var womanCount = new Array(sextypes.length / 2);//课程数
    var sexType = new Array(sextypes.length / 2);

    /*  console.error("s:测试数据::"+s);*/


    for (var i = 0, j1 = 0, j2 = 0; i < sextypes.length; i++) {
        if (i % 2 === 0) {
            manCount[j1] = sextypes[i];
            j1++;
        } else {
            womanCount[j2] = sextypes[i];
            j2++;
        }
    }

    for (var i = 0; i < sextypes.length; i++) {
        sexType[i] = {value: manCount[i], name: womanCount[i]};
    }


    var sex = new Array(2);

    sex.push("女", "男")

    var education = new Array(finalEducations.length / 2);//专业
    var educationCount = new Array(finalEducations.length / 2);//课程数
    var educations = new Array(finalEducations.length / 2);

    /*  console.error("s:测试数据::"+s);*/


    for (var i = 0, j1 = 0, j2 = 0; i < finalEducations.length; i++) {
        if (i % 2 === 0) {
            education[j1] = finalEducations[i];
            j1++;
        } else {
            educationCount[j2] = finalEducations[i];
            j2++;
        }
    }

    for (var i = 0; i < sextypes.length; i++) {
        educations[i] = {value: education[i], name: educationCount[i]};
    }


    var technica = new Array(technical.length / 2);//专业
    var technicalCount = new Array(technical.length / 2);//课程数

    /*  console.error("s:测试数据::"+s);*/


    for (var i = 0, j1 = 0, j2 = 0; i < technical.length; i++) {
        if (i % 2 === 0) {
            technica[j1] = technical[i];
            j1++;
        } else {
            technicalCount[j2] = technical[i];
            j2++;
        }
    }


    var personCount = parseInt(manCount) + parseInt(womanCount);

    liListAll = '';

    // 指定图表的配置项和数据
    options[0] = {
        title: {
            text: '专业数在校学生数统计',
            subtext: '统计',
            textStyle: {
                color: '#fff'
            }
        },
        grid: {
            x: 0,
            y: 70,
            x2: 50,
            y2: 50,
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: []   //'专业数', '在校生数'
        },
        toolbox: {
            show: false,
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        calculable: true,
        xAxis: [
            {
                type: 'category',
                data: majorName,
                axisLabel: {
                    interval: 0,//横轴信息全部显示
                    rotate: -45,//-45度角倾斜显示
                }
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '专业数',
                type: 'bar',
                data: courseNum,
                markPoint: {
                    data: [
                        {value: courseNum[0], xAxis: 0, yAxis: courseNum[0]},
                        {value: courseNum[1], xAxis: 1, yAxis: courseNum[1]},
                        {value: courseNum[2], xAxis: 2, yAxis: courseNum[2]},
                        {value: courseNum[3], xAxis: 3, yAxis: courseNum[3]},
                        {value: courseNum[4], xAxis: 4, yAxis: courseNum[4]},
                        {value: courseNum[5], xAxis: 5, yAxis: courseNum[5]},
                        {value: courseNum[6], xAxis: 6, yAxis: courseNum[6]},
                        {value: courseNum[7], xAxis: 7, yAxis: courseNum[7]},
                        {value: courseNum[8], xAxis: 8, yAxis: courseNum[8]},
                        {value: courseNum[9], xAxis: 9, yAxis: courseNum[9]},
                    ]
                },
                markLine: {
                    data: []
                }
            },
            {
                name: '在校生数',
                type: 'bar',
                data: scresultNum,
                markPoint: {
                    data: []
                },
                markLine: {
                    data: []
                }
            }
        ]

    };


    //年龄统计
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
            show: false,
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                magicType: {
                    show: true,
                    type: ['pie', 'funnel']
                },
                restore: {show: true},
                saveAsImage: {show: true, backgroundColor: '#436885'}
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
                    {value: agecount[0], name: '20-30'},
                    {value: agecount[1], name: '31-40'},
                    {value: agecount[2], name: '41-50'},
                    {value: agecount[3], name: '>50'}
                ]
            }
        ]
    };

    //部门数以及教师数
    options[2] = {
        title: {
            text: '各系部以及教师数',
            subtext: '统计',
            textStyle: {
                color: '#fff'
            }
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['系部数以及教师数']
        },
        toolbox: {
            show: false,
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        calculable: true,
        xAxis: [
            {
                type: 'category',
                data: deptnames,
                axisLabel: {
                    interval: 0,//横轴信息全部显示
                    rotate: -45,//-35度角倾斜显示
                }
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '在校生数',
                type: 'bar',
                data: deptcount,
                markPoint: {
                    data: []
                },
                markLine: {
                    data: []
                }
            }
        ]

    };

    options[3] = {
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
            left: 'left',
            y: 'bottom',
            textStyle: {
                color: '#fff'
            },
            data: ['女教师', '男教师'],

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
                data: [
                    {value: sextypes[0], name: '男教师'},
                    {value: sextypes[1], name: '女教师'}
                ]

            }
        ]
    };

    options[4] = {
        title: {
            text: '学历统计',
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
            left: 'left',
            y: 'bottom',
            textStyle: {
                color: '#fff'
            },
            data: education,

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
                data: [
                    {value: educationCount[0], name: education[0]},
                    {value: educationCount[1], name: education[1]},
                    {value: educationCount[2], name: education[2]},
                    {value: educationCount[3], name: education[3]}

                ]
            }
        ]
    };

    options[5] = {
        title: {
            text: '职称统计',
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
            left: 'left',
            y: 'bottom',
            textStyle: {
                color: '#fff'
            },
            data: technica,

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
                data:
                    [
                        {value: technicalCount[0], name: technica[0]},
                        {value: technicalCount[1], name: technica[1]},
                        {value: technicalCount[2], name: technica[2]},
                        {value: technicalCount[3], name: technica[3]},
                        {value: technicalCount[4], name: technica[4]}

                    ]
            }
        ]
    };

    options[6] = {
        title: {
            text: '双学型教师统计',
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
            left: 'left',
            y: 'bottom',
            textStyle: {
                color: '#fff'
            },
            data: ['双师型教师', '非双师型教师'],

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
                data: [
                    {value: doubleteacher, name: "双师型教师"},
                    {value: personCount, name: "非双师型教师"},

                ]
            }
        ]
    };


    for (var i = 0; i < 7; i++) {
        if (myChartFlag[i]) {
            myCharts[i].setOption(options[i]);
            myChartFlag[i] = false;
        }
    }
    window.onresize = function () {
        myCharts[0].resize();
        myCharts[1].resize();
        myCharts[2].resize();
        myCharts[3].resize();
        myCharts[4].resize();
        myCharts[5].resize();
        myCharts[6].resize();
    }

    $("#right").append("<a class=\"btn\" href=\"http://www.moe.gov.cn/\">中华人民共和国教育部</a>\n" +
        "        <a class=\"btn\" href=\"http://www.moe.gov.cn/s78/A07/\">教育部职业教育与成人教育司</a>\n" +
        "        <a class=\"btn\" href=\"https://www.tech.net.cn/web/index.aspx\">中国高职高专网</a>\n" +
        "        <a class=\"btn\" href=\"http://www.zyjyzg.org/\">职业教育诊改网</a>\n" +
        "        <a class=\"btn\" href=\"http://www.jledu.gov.cn/jyt/\">吉林省教育厅</a>\n" +
        "        <a class=\"btn\" href=\"http://www.bcvit.cn/\">白城职业技术学院</a>")
}
