/**
 * Created by Administrator on 2017/8/7.
 */
// 教师首页 图表
function empsIndexCharts(path) {
    // 就业总人数比
    var graduatingECharts = echarts.init(document.getElementById("graduatingECharts"));
    var graduatingYearECharts = echarts.init(document.getElementById("graduatingYearECharts"));
    var achievementECharts = echarts.init(document.getElementById("achievementECharts"));
    var taskScoreECharts = echarts.init(document.getElementById("taskScoreECharts"));

    $.post(path+"/echartsMenu/getSxrsEcharts", function (data) {

        if (data.eChartSel != null) {
            addOption(data.eChartSel, "eChartSel");
        }

        var jyrs ;
        var wjyrs ;
        if (data.sxrsEcharts == null || data.sxrsEcharts == "") {
            jyrs = 0 ;
            wjyrs = 0 ;
        }else{
            if(data.sxrsEcharts.countView == null || data.sxrsEcharts.countView == "" ){
                jyrs = 0;
            }else{
                jyrs = data.sxrsEcharts.countView ;
            }
            if(data.sxrsEcharts.countType == null || data.sxrsEcharts.countType == "" ){
                wjyrs = 0 ;
            }else{
                wjyrs = data.sxrsEcharts.countType ;
            }
        }
        graduatingECharts.setOption({
            title: {
                text: '就业总人数比',
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
                x: 'left',
                y: '10%',
                textStyle: {
                    color: '#fff'
                },
                data: ['就业人数', '未就业人数']
            },
            series: [
                {
                    name: '就业总人数比',
                    type: 'pie',
                    radius: ['48%', '65%'],
                    center: ['50%', '60%'],
                    avoidLabelOverlap: false,
                    label: {
                        normal: {
                            show: false,
                            position: 'center'
                        },
                        emphasis: {
                            show: true,
                            textStyle: {
                                fontSize: '15',
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
                        {value: jyrs , name: '就业人数'},
                        {value: wjyrs , name: '未就业人数'}
                    ]
                }
            ]
        });

        var yearList = new Array();
        var yjyList = new Array();
        var wjyList = new Array();

        if(data.sxlEcharts == null || data.sxlEcharts == "" ){
            yearList[0] = '';
            yjyList[0] = '0';
            wjyList[0] ='0';
        }else{
            $.each(data.sxlEcharts, function (index, content) {
                yearList[index] = content.countSubject;
                yjyList[index] = content.countView;
                wjyList[index] = content.countDownload;
            })
        }

        graduatingYearECharts.setOption({
            title: {
                text: '历史就业人数',
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
                y: '10%',
                textStyle:{
                    color: '#fff'
                },
                data:['就业人数','非就业人数']
            },
            grid: {
                left: '1%',
                right: '4%',
                top:'21%',
                bottom: '3%',
                containLabel: true
            },
/*
            toolbox: {
                feature: {
                    saveAsImage: {}
                }
            },
*/
            xAxis: {
                type: 'category',
                boundaryGap: false,
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                },
                data: yearList
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
                    name:'就业人数',
                    type:'line',
                    stack: '',
                    data:yjyList
                },
                {
                    name:'非就业人数',
                    type:'line',
                    stack: '',
                    data:wjyList
                }
            ]
        });


        var achievementNum1  = new Array();
        var achievementNum  = new Array();
        if(data.achievement == null || data.achievement == "" ){
            achievementNum = ["0","0","0","0","0"];
        }else{
            var list = data.achievement.split(',');
            $.each(list, function (index, content) {
                achievementNum1[index] = content.split('@')[1];
            })
            var j = 0 ;
            for(var i = achievementNum1.length;i >0 ; i--) {
                achievementNum[j] = achievementNum1[i-1];
                j++;
            }
        }

        var achievementName =["不及格","及格","一般","良好","优秀"];

        achievementECharts.setOption({
            title: {
                text: '近期学生考试成绩',
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
                boundaryGap: [0, 1]
            },
            yAxis: {
                type: 'category',
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                },
                data: achievementName
            },
            series: [
                {
                    name: '人数',
                    type: 'bar',
                    data: achievementNum
                }
            ]
        });

        var taskNameList = new Array();
        var avgscoreList = new Array();
        var scoreList = new Array();

        if(data.sxlEcharts == null || data.sxlEcharts == "" ){
            taskNameList[0] = '';
            avgscoreList[0] = '0';
            scoreList[0] ='0';
        }else{
            $.each(data.taskScore, function (index, content) {
                taskNameList[index] = content.taskname;
                avgscoreList[index] = content.alltask;
                scoreList[index] = content.score;
            })
        }

        taskScoreECharts.setOption({
            title: {
                text: '教师评教评分',
                x:'center',
                textStyle:{
                    color: '#fff'
                }
            },
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                type: 'scroll',
                orient: 'vertical',
                right: 10,
                top: 50,
                bottom: 20,
                x: 'left',
                y: '10%',
                textStyle:{
                    color: '#fff'
                },
                data:['平均分','得分数']
            },
            grid: {
                left: '15%',
                right: '4%',
                top:'18%',
                bottom: '30%',
                containLabel: true
            },
            /*
             toolbox: {
             feature: {
             saveAsImage: {}
             }
             },
             */
            xAxis: {
                type: 'category',
                boundaryGap: false,
                axisLabel: {
                    interval: 0,
                    rotate: 30,//倾斜度 -90 至 90 默认为0
                    margin: 2,
                    textStyle: {
                        color: '#fff'
                    }
                },
                data: taskNameList
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
                    name:'平均分',
                    type:'line',
                    stack: '',
                    data:avgscoreList
                },
                {
                    name:'得分数',
                    type:'line',
                    stack: '',
                    data:scoreList
                }
            ]
        });

    });

}

// 校领导首页图表
function leaderIndexCharts(path) {
    // 就业总人数比
    var graduatingECharts = echarts.init(document.getElementById("graduatingECharts"));

    var studentNumberECharts = echarts.init(document.getElementById("studentNumberECharts"));

    var graduationNumberByYear = echarts.init(document.getElementById("graduationNumberByYear"));

    var graduatioByDept = echarts.init(document.getElementById("graduatioByDept"));

    var teacherProportion = echarts.init(document.getElementById("teacherProportion"));

    $.post(path+"/echartsMenu/getLeaderEcharts", function (data) {
        var jyrs ;
        var wjyrs ;
        if (data.sxrsEcharts == null || data.sxrsEcharts == "" ) {
            jyrs = 0 ;
            wjyrs = 0 ;
        }else{
            if(data.sxrsEcharts.countView == null || data.sxrsEcharts.countView == "" ){
                jyrs = 0;
            }else{
                jyrs = data.sxrsEcharts.countView ;
            }
            if(data.sxrsEcharts.countType == null || data.sxrsEcharts.countType == "" ){
                wjyrs = 0 ;
            }else{
                wjyrs = data.sxrsEcharts.countType ;
            }
        }
        graduatingECharts.setOption({
            title: {
                text: '就业总人数比',
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
                x: 'left',
                y: '10%',
                textStyle: {
                    color: '#fff'
                },
                data: ['就业人数', '未就业人数']
            },
            series: [
                {
                    name: '就业总人数比',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    avoidLabelOverlap: false,
                    label: {
                        normal: {
                            show: false,
                            position: 'center'
                        },
                        emphasis: {
                            show: true,
                            textStyle: {
                                fontSize: '15',
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
                        {value: jyrs , name: '就业人数'},
                        {value: wjyrs , name: '未就业人数'}
                    ]
                }
            ]
        });

        var stuNum = new Array();
        var zyname = new Array();
        if (data.studentNumber == null || data.studentNumber == "") {
            stuNum = { value:0 , name:[""] } ;
            zyname = [0] ;
        }else{
            $.each(data.studentNumber, function (index, content) {
                zyname[index] = content.countSubject ;
                stuNum.push( { value:content.countView , name:content.countSubject } );
            })
        }
        studentNumberECharts.setOption({
            title: {
                text: '各系人数比例',
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
                x: 'left',
                y: '10%',
                textStyle: {
                    color: '#fff'
                },
                data: zyname
            },
            series: [
                {
                    name: '各系人数比例',
                    type: 'pie',
                    radius: '55%',
                    center: ['70%', '60%'],
                    avoidLabelOverlap: false,
                    label: {
                        normal: {
                            show: false,
                            position: 'center'
                        },
                        emphasis: {
                            show: true,
                            textStyle: {
                                fontSize: '15',
                                fontWeight: 'bold'
                            }
                        }
                    },
                    labelLine: {
                        normal: {
                            show: false
                        }
                    },
                    data: stuNum
                }
            ]
        });

        var stuGNum = new Array();
        var gYear = new Array();
        if (data.getGraduationNumberByYear == null || data.getGraduationNumberByYear == ""  ) {
            stuGNum = [0] ;
            gYear = [""] ;
        }else{
            $.each(data.getGraduationNumberByYear, function (index, content) {
                gYear[index] = content.countView ;
                stuGNum[index] = content.countType ;
            })
        }
        graduationNumberByYear.setOption({
            title: {
                text: '近五年的学生就业人数',
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
                boundaryGap: [0, 1]
            },
            yAxis: {
                type: 'category',
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                },
                data: gYear
            },
            series: [
                {
                    name: '人数',
                    type: 'bar',
                    data: stuGNum
                }
            ]
        });

        var deptList = data.deptList ;
        var stuRate  = new Array();
        var gByYear = new Array();
        var mode = new Array();
        if (data.getgraduatioByDept == null || data.getgraduatioByDept == "" ) {
            gByYear = [""] ;
            $.each(deptList, function (deptIndex, deptContent) {
                stuRate.push(
                    {
                        name:''+deptContent+'',
                        type:'line',
                        stack: '人数',
                        data:[0]
                    });
            })
        }else{
            $.each(data.getgraduatioByDept, function (index, content) {
                gByYear[index] = content.countView ;
                var cType = content.countSubject.split(',');
                $.each(cType, function (countIndex, countContent) {
                    var obj = countContent.split(';');
                    mode[content.countView+obj[0]]= obj[1];
                })
            })
            $.each(deptList, function (deptIndex, deptContent) {
                var dateList = new Array();
                $.each(gByYear, function (yearIndex, yearContent) {
                    var jyNum = mode[yearContent+deptContent] ;
                    if(undefined == jyNum ||jyNum == null || jyNum ==""){
                        jyNum = 0 ;
                    }else {
                        jyNum = parseInt(jyNum);
                    }
                    dateList.push(jyNum );
                })
                stuRate.push(
                    {
                        name:''+deptContent+'',
                        type:'line',
                        stack: deptIndex,
                        data:dateList
                    });
            })
        }

        graduatioByDept.setOption({
            title: {
                text: '全校各系就业率',
                x: 'center',
                textStyle: {
                    color: '#fff'
                }
            },
            tooltip: {
                trigger: 'axis',
            },
            legend: {
                y: '12%',
                data:deptList
            },
            grid: {
                y: '30%',
                left: '4%',
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
                data: gByYear
            },
            yAxis: {
                type: 'value'
            },
            series: stuRate
        });

        var tNum = new Array();
        var tName = new Array();
        if (data.teacherProportion == null) {
            tNum = [0] ;
            tName = [""] ;
        }else{
            $.each(data.teacherProportion, function (index, content) {
                tNum.push( {value: content.countView , name: content.countType});
                tName[index] = content.countType ;
            })
        }

        teacherProportion.setOption({
            title: {
                text: '各系部教师人数',
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
                x: 'left',
                y: '10%',
                textStyle: {
                    color: '#fff'
                },
                data: tName
            },
            series: [
                {
                    name: '各系部教师人数',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    avoidLabelOverlap: false,
                    label: {
                        normal: {
                            show: false,
                            position: 'center'
                        },
                        emphasis: {
                            show: true,
                            textStyle: {
                                fontSize: '15',
                                fontWeight: 'bold'
                            }
                        }
                    },
                    labelLine: {
                        normal: {
                            show: false
                        }
                    },
                    data: tNum
                }
            ]

        });
    })
}

//  学生首页图表
function studentCharts(path) {
    var studentScoreECharts = echarts.init(document.getElementById("studentScoreECharts"));

    var graduatingByMajorECharts = echarts.init(document.getElementById("graduatingByMajorECharts"));

    var classAvgScoreECharts = echarts.init(document.getElementById("classAvgScoreECharts"));

    $.post(path+"/echartsMenu/getStudentEcharts", function (data){
        var avgscoreList = new Array();
        var scoreList = new Array();
        var countName = new Array();
        if (data.studentScore == null || data.studentScore == "" ) {
            avgscoreList = [0] ;
            scoreList = [0] ;
            countName = [""] ;
        }else{      // countType   countView
            $.each(data.studentScore, function (index, content) {
                countName[index] = content.countSubject ;
                avgscoreList[index] = content.countType ;
                scoreList[index] = content.countView ;
            })
        }

        studentScoreECharts.setOption({
            title : {
                text: '考试成绩',
                x: 'center',
                textStyle: {
                    color: '#fff'
                }
            },
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
                data:['平均成绩','个人成绩']
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
                    data: countName
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series: [
                {
                    name:'平均成绩',
                    type:'bar',
                    data:avgscoreList
                },{
                    name:'个人成绩',
                    type:'bar',
                    data:scoreList
                }
            ]

        });

        var jyrs = new Array();
        var zrs = new Array();
        var yearList = new Array();
        if (data.graduatingByMajorECharts == null || data.graduatingByMajorECharts == "" ) {
            jyrs = 0 ;
            zrs = 0 ;
        }else{
            $.each(data.graduatingByMajorECharts, function (index, content) {
                yearList[index] = content.countSubject ;
                jyrs[index] = content.countType ;
                zrs[index] = content.countView ;
            })
        }
        graduatingByMajorECharts.setOption({
            title: {
                text: '本专业历史就业人数',
                x:'center',
                textStyle:{
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
                boundaryGap: [0, 1]
            },
            yAxis: {
                type: 'category',
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                },
                data: yearList
            },
            series: [
                {
                    name: '人数',
                    type: 'bar',
                    data: jyrs
                }
            ]
        });

        var scoreName = new Array();
        var classAvgScore = new Array();
        var otherClassAvgScore = new Array();
        if (data.classAvgScoreECharts == null ||  data.classAvgScoreECharts == "" ) {
            scoreName =[""]  ;
            classAvgScore = [0] ;
            otherClassAvgScore = [0] ;
        }else{
            $.each(data.classAvgScoreECharts, function (index, content) {
                scoreName[index] = content.countSubject ;
                otherClassAvgScore[index] = content.countType ;
                classAvgScore[index] = content.countView ;
            })
        }
        classAvgScoreECharts.setOption({
            title : {
                text: '班级平均成绩',
                x: 'center',
                textStyle: {
                    color: '#fff'
                }
            },
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
                data:['本班平均成绩','其他班平均成绩']
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
                    data: scoreName
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series: [
                {
                    name:'本班平均成绩',
                    type:'bar',
                    data:classAvgScore
                },{
                    name:'其他班平均成绩',
                    type:'bar',
                    data:otherClassAvgScore
                }
            ]


        });
    });


}