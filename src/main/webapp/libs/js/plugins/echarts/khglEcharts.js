/**
 * Created by Administrator on 2017/8/8.
 */
// 考核管理
function khglCol(liListFlag,liList,liListAll,myCharts,myChartFlag,options,dataArray) {
    for (var i = 0; i < 3; i++) {
        var echartsIdDiv = '<div id="echartsId' + i + '" style="width: 90%;height: 90%;"></div>';
        if(i == 0)
            liListFlag = true;
        if (!liListFlag) {
            liList[i] = '<li class="echarts_li">' + echartsIdDiv + '</li>';
        } else {
            liList[i] = '<li class="echarts_li_bottom">' + echartsIdDiv + '</li>';
            liListFlag = false;
        }
        liListAll += liList[i];
    }
    $('#eCharts_ul').append(liListAll);
    for(var i = 0; i < 3 ; i ++){
        myCharts[i] = echarts.init(document.getElementById('echartsId'+i));
        myChartFlag[i] = true;
    }

    var alltask = null;//2017-01,0,0,0,0,2017-02,0,0,0,0
    var taskname = null;//教师评教,学生评教,家长评教,综合评教
    var score = null;// 100,2,2,90,0,1,80,1,0,70,0,1,60,1,0,10,0,0

    var date = new Date();
    var year = date.getFullYear();
    if(dataArray[0]  ==null ){
        alltask =year+"-01,0,0,0,0,"+year+"-02,0,0,0,0,"+year+"-03,0,0,0,0,"+year+"-04,0,0,0,0,"+year+"-05,0,0,0,0,"+year+"-06,0,0,0,0,"
                +year+"-07,0,0,0,0,"+year+"-08,0,0,0,0,"+year+"-09,0,0,0,0,"+year+"-10,0,0,0,0,"+year+"-11,0,0,0,0,"+year+"-12,0,0,0,0";
        taskname ="教师评教,学生评教,家长评教,综合评教";
        score ='100,0,0,90,0,0,80,0,0,70,0,0,60,0,0,10,0,0';
    }else{
        alltask = dataArray[0].alltask;
        taskname = dataArray[0].taskname;
        score = dataArray[0].score;
    }

    if(alltask == null || alltask == 'null'){
        alltask =year+"-01,0,0,0,0,"+year+"-02,0,0,0,0,"+year+"-03,0,0,0,0,"+year+"-04,0,0,0,0,"+year+"-05,0,0,0,0,"+year+"-06,0,0,0,0,"
            +year+"-07,0,0,0,0,"+year+"-08,0,0,0,0,"+year+"-09,0,0,0,0,"+year+"-10,0,0,0,0,"+year+"-11,0,0,0,0,"+year+"-12,0,0,0,0";
    }
    if(taskname == null || taskname == 'null'){
        taskname ="教师评教,学生评教,家长评教,综合评教";
    }
    if(score == null || score == 'null'){
        score ='100,0,0,90,0,0,80,0,0,70,0,0,60,0,0,10,0,0';
    }

    alltask = alltask.split(',');//第一张表数据
    taskname = taskname.split(',');//第一张表数据
    score = score.split(',');//第二三张表数据

    var taskdate = new Array(alltask.length/5);//评教时间
    var task0 = new Array(alltask.length/5);//字典项0的条数
    var task1 = new Array(alltask.length/5);//字典项1的条数
    var task2 = new Array(alltask.length/5);//字典项2的条数
    var task3 = new Array(alltask.length/5);//字典项3的条数

    for(var i = 0, j1 = 0, j2 = 0, j3 = 0 , j4 = 0 , j5 = 0 ; i < alltask.length ; i ++ ){
        if(i%5 === 0){
            taskdate[j1] = alltask[i];
            j1 ++;
        }else if(i%5 === 1){
            task0[j2] = alltask[i];
            j2 ++;
        }else if(i%5 === 2){
            task1[j2] = alltask[i];
            j3 ++;
        }else if(i%5 === 3){
            task2[j2] = alltask[i];
            j4 ++;
        }else{
            task3[j3] = alltask[i];
            j5 ++;
        }
    }

    var stuscore = new Array(score.length/3);//学生成绩
    var teascore = new Array(score.length/3);//教师成绩
    var sumteascore = 0;

    for(var i = 0, j1 = 0, j2 = 0; i < score.length ; i ++ ){
        if(i%3 === 1){
            stuscore[j1] = score[i];
            j1 ++;
        }else if(i%3 === 2){
            teascore[j2] = score[i];
            j2 ++;
        }
    }
    for(var i in teascore){
        sumteascore += parseInt(teascore[i]);
    }

    liListAll = '';
    // 指定图表的配置项和数据
    options[0] = {
        title: {
            text: '各评教统计',
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
            data:taskname
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
            data: taskdate
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
                name:taskname[0],
                type:'line',
                stack: taskname[0],
                data:task0
            },
            {
                name:taskname[1],
                type:'line',
                stack:taskname[1],
                data:task1
            },
            {
                name:taskname[2],
                type:'line',
                stack:taskname[2],
                data:task2
            },
            {
                name:taskname[3],
                type:'line',
                stack:taskname[3],
                data:task3
            }
        ]
    };
    options[1] = {
        title: {
            text: '学生综合成绩统计',
            x:'center',
            textStyle:{
                color: '#fff'
            }
        },
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            x : 'center',
            y : 'bottom',
            textStyle: {
                color:'#fff'
            },
            data:['100','90-99','80-89','70-79','60-69','<60']
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {
                    show: true,
                    type: ['pie', 'funnel']
                },
                restore : {show: true},
                saveAsImage : {show: true,backgroundColor:'#436885'}
            }
        },
        calculable : true,
        series: [
            {
                name:'成绩',
                type:'pie',
                radius : [30, 90],
                center : ['50%', '50%'],
                roseType : 'area',
                data:[
                    {value:stuscore[0], name:'100'},
                    {value:stuscore[1], name:'90-99'},
                    {value:stuscore[2], name:'80-89'},
                    {value:stuscore[3], name:'70-79'},
                    {value:stuscore[4], name:'60-69'},
                    {value:stuscore[5], name:'<60'}
                ]
            }
        ]
    };
    options[2] = {
        title: {
            text: '全校教师评教成绩统计',
            x:'center',
            textStyle:{
                color: '#fff'
            }
        },
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b}: {c} ({d}%)"
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {
                    show: true,
                    type: ['pie', 'funnel']
                },
                restore : {show: true},
                saveAsImage : {show: true,backgroundColor:'#436885'}
            }
        },
        legend: {
            x: 'center',
            y: 'bottom',
            textStyle: {
                color:'#fff'
            },
            data:['100','90-99','80-89','70-79','60-69','<60']
        },
        series: [
            {
                name:'成绩类别',
                type:'pie',
                selectedMode: 'single',
                radius: [0, '30%'],

                label: {
                    normal: {
                        position: 'inner'
                    }
                },
                labelLine: {
                    normal: {
                        show: false
                    }
                },
                data:[
                    {value:(teascore[0]+teascore[1]+teascore[2])/sumteascore, name:'优秀', selected:true},
                    {value:(teascore[3]+teascore[4])/sumteascore, name:'良好'},
                    {value:teascore[5]/sumteascore, name:'差评'}
                ]
            },
            {
                name:'评教成绩',
                type:'pie',
                radius: ['40%', '52%'],

                data:[
                    {value:teascore[0], name:'100'},
                    {value:teascore[1], name:'90-99'},
                    {value:teascore[2], name:'80-89'},
                    {value:teascore[3], name:'70-79'},
                    {value:teascore[4], name:'60-69'},
                    {value:teascore[5], name:'<60'}
                ]
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
