/**
 * Created by Administrator on 2017/8/22.
 */
// 教师个人空间
function jsgrkjCol(liListFlag,liList,liListAll,myCharts,myChartFlag,options,dataArray) {
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
    var jsinfo = null;//   1月,0,0,0,2月,0,0,0

    if(dataArray[0]  ==null ){
        jsinfo = ' , , , ';
    }else{
        jsinfo = dataArray[0].jsinfo;
    }
    jsinfo = ' , , , ';


    if(jsinfo == null || jsinfo == 'null')
        jsinfo = ' , , , ';
    jsinfo = jsinfo.split(',');//第一张表数据

    var jsinfoyear = new Array(jsinfo.length/4);//签到年份
    var jsinfomonth = new Array(jsinfo.length/4);//签到月份
    var jsinfoall = new Array(jsinfo.length/4);//签到月总次数
    var jsinfonone = new Array(jsinfo.length/4);//未签到次数
    for(var i = 0, j1 = 0, j2 = 0, j3 = 0, j4 = 0 ; i < jsinfo.length ; i ++ ){
        if(i%4 === 0){
            jsinfomonth[j1] = jsinfo[i];
            j1 ++;
        }else if(i%4 === 1){
            jsinfoyear[j2] = jsinfo[i];
            j2 ++;
        }else if(i%4 === 2){
            jsinfoall[j3] = jsinfo[i];
            j3 ++;
        }else{
            jsinfonone[j4] = jsinfo[i];
            j4 ++;
        }
    }
    var year = null;
    for(var i = 0 ; i < 12 ; i ++){
        if(jsinfoyear != null){
            year = jsinfoall[i] + '年';
            break;
        }
    }

    liListAll = '';
    // 指定图表的配置项和数据
    options[0] = {
        title: {
            text: year + '教师个人签到统计',
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
            data:['应签到次数','未签到次数'],
            textStyle:{
                color: '#fff'
            }
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
            data: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
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
                name:'应签到次数',
                type:'line',
                stack: '总量',
                data:jsinfoall
            },
            {
                name:'未签到次数',
                type:'line',
                stack: '总量',
                data:jsinfonone
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
