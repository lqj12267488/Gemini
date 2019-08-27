/**
 * Created by Administrator on 2017/8/8.
 */
// 党团管理
function dtglCol(liListFlag,liList,liListAll,myCharts,myChartFlag,options,dataArray) {
    for (var i = 0; i < 2; i++) {
        var echartsIdDiv = '<div id="echartsId' + i + '" style="width: 90%;height: 90%;"></div>';
        if (!liListFlag) {
            if( i === 1 )
                liList[i] = '<li class="echarts_li" style="height: 600px;width: 55%;">' + echartsIdDiv + '</li>';
            else
                liList[i] = '<li class="echarts_li" style="height: 600px;width: 45%;">' + echartsIdDiv + '</li>';
        } else {
            liList[i] = '<li class="echarts_li_bottom">' + echartsIdDiv + '</li>';
            liListFlag = false;
        }
        liListAll += liList[i];
    }
    $('#eCharts_ul').append(liListAll);
    for(var i = 0; i < 2 ; i ++){
        myCharts[i] = echarts.init(document.getElementById('echartsId'+i));
        myChartFlag[i] = true;
    }

    var party = null;//  入党申请人,0,积极分子,0,
    var partydept = null;// 校领导,0,财会金融系,0

    if(dataArray[0]  ==null ){
        party = " ,0";
        partydept = " ,0";
    }else{
        party = dataArray[0].party;
        partydept = dataArray[0].partydept;
    }

    if(party == null || party == 'null'){
        party = " ,0";
    }
    if(partydept == null || partydept == 'null'){
        partydept = " ,0";
    }

    party = party.split(',');//第一张表数据
    partydept = partydept.split(',');//第二张表数据

    var partyName = new Array(party.length/2);//各党建类型
    var partyNum = new Array(party.length/2);//各党建类型数量

    for(var i = 0, j1 = 0, j2 = 0 ; i < party.length ; i ++ ){
        if(i%2 === 0){
            partyName[j1] = party[i];
            j1 ++;
        }else{
            partyNum[j2] = {value:party[i],name:partyName[j1-1]};
            j2 ++;
        }
    }

    var partydeptName = new Array(partydept.length/2);//部门党员部门名称
    var partydeptNum = new Array(partydept.length/2);//部门党员数量

    for(var i = 0, j1 = 0, j2 = 0 ; i < partydept.length ; i ++ ){
        if(i%2 === 0){
            partydeptName[j1] = partydept[i];
            j1 ++;
        }else{
            partydeptNum[j2] = partydept[i];
            j2 ++;
        }
    }


    liListAll = '';

    // 指定图表的配置项和数据
    options[0] = {
        title : {
            text: '教师党建身份统计',
            x:'center',
            textStyle:{
                color: '#fff'
            }
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            y:'6%',
            orient: 'vertical',
            left: 'left',
            textStyle: {
                color:'#fff'
            },
            data: partyName

        },
        series : [
            {
                name: '教师人数',
                type: 'pie',
                radius : '55%',
                center: ['50%', '55%'],
                data:partyNum,
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
    options[1] = {
        title: {
            text: '各部门党员分布统计',
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
            data:['党员人数']
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
            data: partydeptName
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
                name:'党员人数',
                type:'line',
                stack: '总量',
                data:partydeptNum
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
