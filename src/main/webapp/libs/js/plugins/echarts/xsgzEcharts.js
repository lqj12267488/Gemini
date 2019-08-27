/**
 * Created by Administrator on 2017/8/8.
 */
//   学生工作
function xsgzCol(liListFlag,liList,liListAll,myCharts,myChartFlag,options,dataArray) {
    // for (var i = 0; i < 4; i++) {
    //     var echartsIdDiv = '<div id="echartsId' + i + '" style="width: 90%;height: 90%;"></div>';
    //     if (!liListFlag) {
    //         liList[i] = '<li class="echarts_li" style="width: 90%;">' + echartsIdDiv + '</li>';
    //     } else {
    //         liList[i] = '<li class="echarts_li_bottom">' + echartsIdDiv + '</li>';
    //         liListFlag = false;
    //     }
    //     liListAll += liList[i];
    // }
    liList[0] = '<li class="echarts_li" style="width: 60%;height: 50%;">' +
        '<div id="echartsId0" style="width: 95%;height: 95%;"></div>' +
        '</li>';
    liList[1] = '<li class="echarts_li" style="width: 40%;height: 50%;">' +
        '<div id="echartsId1" style="width: 95%;height: 95%;"></div>' +
        '</li>';
    liList[2] = '<li class="echarts_li" style="width: 60%;height: 50%;">' +
        '<div id="echartsId2" style="width: 95%;height: 95%;"></div>' +
        '</li>';
    liList[3] = '<li class="echarts_li" style="width: 40%;height: 50%;">' +
        '<div id="echartsId3" style="width: 95%;height: 95%;"></div>' +
        '</li>';
    for(var i = 0; i < 4; i++){
        liListAll += liList[i];
    }
    $('#eCharts_ul').append(liListAll);
    for(var i = 0; i < 4 ;i ++ ){
        myCharts[i] = echarts.init(document.getElementById('echartsId'+i));
        myChartFlag[i] = true;
    }
    var schoolCount = null;//各校区学生数量
    var sexCount=null;//各校区男女学生数量
    var nationCount=null;//民族
    var sxjy = null;//财会金融系,0,0,经济管理系,1,0
    var zzmmCount=null;//政治面貌

    if(dataArray[0]  ==null ){
        schoolCount=",0";
        sexCount =",0,0";
        nationCount=",0";
        sxjy =",0,0";
        zzmmCount=",0";
    }else{
        schoolCount = dataArray[0].schoolCount;
        sexCount = dataArray[0].sexCount;
        nationCount = dataArray[0].nationCount;
        sxjy = dataArray[0].sxjy;
        zzmmCount=dataArray[0].zzmmCount;
    }
    if(schoolCount == null || schoolCount == 'null'){
        schoolCount =",0";
    }
    if(sexCount == null || sexCount == 'null'){
        sexCount =",0,0";
    }
    if(nationCount == null || nationCount == 'null'){
        nationCount =",0";
    }
    if(sxjy == null || sxjy == 'null'){
        sxjy =",0,0";
    }
    if(zzmmCount == null || zzmmCount == 'null'){
        zzmmCount =",0";
    }
    //各校区学生数量取值
    schoolCount = schoolCount.split(',');//民族学生人数统计数据
    var schoolZone=new Array(schoolCount.length/2);
    var stuNum=new Array(schoolCount.length/2)
    for(var i = 0, j1 = 0, j2 = 0, j3 = 0 ; i < schoolCount.length ; i ++ ){
        if(i%2 === 0){
            schoolZone[j1] = schoolCount[i];
            j1 ++;
        }else{
            stuNum[j2] = schoolCount[i];
            j2 ++;
        }
    }
    //各校区男女学生数量取值
    sexCount = sexCount.split(',');//第一张表数据
    var manNum = new Array(sexCount.length/3);//各级男学生数量
    var womanNum = new Array(sexCount.length/3);//各级女男学生数量
    for(var i = 0, j1 = 0, j2 = 0, j3 = 0 ; i < sexCount.length ; i ++ ){
        if(i%3 === 0){
            j1 ++;
        }else if(i%3 === 1){
            manNum[j2] = sexCount[i];
            j2 ++;
        }else{
            womanNum[j3] = sexCount[i];
            j3 ++;
        }
    }
    //民族学生人数统计
    nationCount = nationCount.split(',');//民族学生人数统计数据
    var nation=new Array(nationCount.length/2);
    var nationNum=new Array(nationCount.length/2)
    var nationCountArray=new Array(nationCount.length/2);
    for(var i = 0, j1 = 0, j2 = 0 ; i < nationCount.length ; i ++ ){
        if(i%2 == 0){
            nationNum[j1]=nationCount[i];
            j1 ++;
        }else{
            nation[j2]=nationCount[i];
            j2 ++;
        }
    }
    for(var i = 0; i < nation.length ; i ++){
        nationCountArray[i] = {value: nationNum[i], name: nation[i]};
    }
    sxjy = sxjy.split(',');//第二张表数据
    var sxjyName = new Array(sxjy.length/3);//学生各级名称
    var sxNum = new Array(sxjy.length/3);//各级实习数量
    var jyNum = new Array(sxjy.length/3);//各级就业数量
    var jyRate = new Array(sxjy.length/3);//各级就业率
    for(var i = 0, j1 = 0, j2 = 0, j3 = 0 , j4 = 0 ; i < sxjy.length ; i ++ ){
        if(i%3 === 0){
            sxjyName[j1] = sxjy[i];
            j1 ++;
        }else if(i%3 === 1){
            sxNum[j2] = sxjy[i];
            j2 ++;
        }else{
            jyNum[j3] = sxjy[i];
            if( (jyNum[j3]+sxNum[j2-1]) == 0 )
                jyRate[j4] = 0;
            else
                jyRate[j4] = jyNum[j3]*100/(sxNum[j2-1]+jyNum[j3]);
            j4 ++;
            j3 ++;
        }
    }
    //政治面貌
    zzmmCount = zzmmCount.split(',');//第一张表数据
    var zzmmNum = new Array(zzmmCount.length/2);
    var zzmmName = new Array(zzmmCount.length/2);
    var zzmmCountArray = new Array(zzmmCount.length/2);
    for(var i = 0, j1 = 0, j2 = 0 ; i < zzmmCount.length ; i ++ ){
        if(i%2 === 0){
            zzmmNum[j1] = zzmmCount[i];
            j1 ++;
        }else{
            zzmmName[j2] = zzmmCount[i];
            j2 ++;
        }
    }
    for(var i = 0; i < zzmmName.length ; i ++){
        zzmmCountArray[i] = {value: zzmmNum[i], name: zzmmName[i]};
    }
    liListAll = '';
    colors = ['#5793f3', '#d14a61', '#675bba'];
    // 指定图表的配置项和数据
    options[0] = {
        title : {
            text: '全校学生统计',
            textStyle: {
                color:'#fff'
            }
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['学生总数','男生数量','女生数量'],
            textStyle: {
                color:'#fff'
            }
        },
        toolbox: {
            show : true,
            feature : {
                dataView : {show: true, readOnly: false},
                magicType : {show: true, type: ['line', 'bar']},
                restore : {show: true},
                saveAsImage : {show: true,backgroundColor:'#436885'}
            }
        },
        calculable : true,
        xAxis : [
            {
                type : 'category',
                data : schoolZone,
                textStyle: {
                    color:'#fff'
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
                name:'学生总数',
                type:'bar',
                data:stuNum,
                markPoint : {
                    data : [
                        {type : 'max', name: '最大值'},
                        {type : 'min', name: '最小值'}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name: '平均值'}
                    ]
                }
            },
            {
                name:'男生数量',
                type:'bar',
                data:manNum,
                markPoint : {
                    data : [
                        {type : 'max', name: '最大值'},
                        {type : 'min', name: '最小值'}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name: '平均值'}
                    ]
                }
            },
            {
                name:'女生数量',
                type:'bar',
                data:womanNum,
                markPoint : {
                    data : [
                        {type : 'max', name: '最大值'},
                        {type : 'min', name: '最小值'}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name: '平均值'}
                    ]
                }
            }
        ]
    };
    options[1]={
        title : {
            text: '各民族学生人数统计',
            x:'center',
            textStyle: {
                color:'#fff'
            },
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            textStyle: {
                color:'#fff'
            },
            data: nation
        },
        series : [
            {
                name: '学生人数',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:nationCountArray,
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };
    options[2] = {
        title: {
            text: '实习就业率',
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
            data:['实习','就业','就业率']
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
                data: sxjyName
            }
        ],
        yAxis: [
            {
                type: 'value',
                name: '实习',
                min: 0,
                max: 300,
                position: 'right',
                axisLine: {
                    lineStyle: {
                        color: colors[0]
                    }
                },
                axisLabel: {
                    formatter: '{value} 人数'
                }
            },
            {
                type: 'value',
                name: '就业',
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
                    formatter: '{value} 人数'
                }
            },
            {
                type: 'value',
                name: '就业率',
                min: 0,
                max: 25,
                position: 'left',
                axisLine: {
                    lineStyle: {
                        color: colors[2]
                    }
                },
                axisLabel: {
                    formatter: '{value} %'
                }
            }
        ],
        series: [
            {
                name:'实习',
                type:'bar',
                data:sxNum
            },
            {
                name:'就业',
                type:'bar',
                yAxisIndex: 1,
                data:jyNum
            },
            {
                name:'就业率',
                type:'line',
                yAxisIndex: 2,
                data:jyRate
            }
        ]
    };
    options[3]={
        title : {
            text: '学生政治面貌人数统计',
            x:'center',
            textStyle: {
                color:'#fff'
            },
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            y:22,
            orient: 'vertical',
            left: 'left',
            data:zzmmName,
            textStyle: {
                color:'#fff'
            }
        },
        series : [
            {
                name: '学生人数',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:zzmmCountArray,
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
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
function countDeptMajorEcharts(liListFlag,liList,liListAll,myCharts,myChartFlag,options,dataArray) {
    for (var i = 0; i < 1; i++) {
        var echartsIdDiv = '<div id="echartsId' + i + '" style="width: 90%;height: 90%;"></div>';
        if (!liListFlag) {
            liList[i] = '<li class="echarts_li" style="width: 100%;height: 100%;">' + echartsIdDiv + '</li>';
        } else {
            liList[i] = '<li class="echarts_li_bottom" style="width: 100%;height: 100%;">' + echartsIdDiv + '</li>';
            liListFlag = false;
        }
        liListAll += liList[i];
    }
    for(var i = 0; i < 1; i++){
        liListAll += liList[i];
    }
    $('#eCharts_ul').append(liListAll);
    for(var i = 0; i < 1 ;i ++){
        myCharts[i] = echarts.init(document.getElementById('echartsId'+i));
        myChartFlag[i] = true;
    }
    var zoneCount = null;//各校区学生数量
    var majorCount=null;//各年级学生数量


    if(dataArray[0]==null ){
        zoneCount=",0";
        majorCount =",0,0";
    }else{
        zoneCount = dataArray[0].zoneCount;
        majorCount = dataArray[0].majorCount;
    }
    if(zoneCount == null || zoneCount == 'null'){
        zoneCount =",0";
    }
    if(majorCount == null || majorCount == 'null'){
        majorCount =",0";
    }
    //校区人数统计
    zoneCount=zoneCount.split(',');
    var zoneNum=new Array(zoneCount.length/2);
    var zoneName=new Array(zoneCount.length/2);
    var zoneCountArray=new Array(zoneCount.length/2);
    for(var i = 0, j1 = 0, j2 = 0 ; i < zoneCount.length ; i ++ ){
        if(i%2 == 0){
            zoneNum[j1]=zoneCount[i];
            j1 ++;
        }else{
            zoneName[j2]=zoneCount[i];
            j2 ++;
        }
    }
    for(var i = 0; i < zoneName.length ; i ++ ){
        zoneCountArray[i] = {value: zoneNum[i], name: zoneName[i]};
    };
    //年级人数统计
    majorCount = majorCount.split(',');
    var majorNum=new Array(majorCount.length/2);
    var majorName=new Array(majorCount.length/2);
    var majorCountArray=new Array(majorCount.length/2);
    for(var i = 0, j1 = 0, j2 = 0 ; i < majorCount.length ; i ++ ){
        if(i%2 == 0){
            majorNum[j1]=majorCount[i];
            j1 ++;
        }else{
            majorName[j2]=majorCount[i];
            j2 ++;
        }
    }
    for(var i = 0; i < majorName.length ; i ++ ){
        majorCountArray[i] = {value: majorNum[i], name: majorName[i]};
    };
    var nameArray=new Array(zoneName.length+majorName.length);
    nameArray=zoneName.concat(majorName);
    liListAll = '';
    // 指定图表的配置项和数据
    options[0]={
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b}: {c} ({d}%)"
        },
        legend: {
            orient: 'horizontal',
            x: 'left',
            textStyle: {
                color:'black'
            },
            data:nameArray
        },
        grid:{
            X:100,
            right:'0',
            bottom:'10%',
            containLabel:true
        },
        series: [
            {
                name: '学生人数',
                type:'pie',
                selectedMode: 'single',
                radius: [0, '50%'],

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
                data:zoneCountArray
            },
            {
                name: '学生人数',
                type: 'pie',
                radius: ['55%', '70%'],
                label: {
                    normal: {
                        backgroundColor: '#eee',
                        borderColor: '#aaa',
                        borderWidth: 1,
                        borderRadius: 4,
                        rich: {
                            a: {
                                color: '#999',
                                lineHeight: 22,
                                align: 'center'
                            },
                            hr: {
                                borderColor: '#aaa',
                                width: '100%',
                                borderWidth: 0.5,
                                height: 0
                            },
                            b: {
                                fontSize: 16,
                                lineHeight: 33
                            },
                            per: {
                                color: '#eee',
                                backgroundColor: '#334455',
                                padding: [2, 4],
                                borderRadius: 2
                            }
                        }
                    }
                },
                data: majorCountArray
            }
        ]
    };
    colors = ['#5793f3', '#d14a61', '#60ba3f'];
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