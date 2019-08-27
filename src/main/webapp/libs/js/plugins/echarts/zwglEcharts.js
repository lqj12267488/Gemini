/**
 * Created by Administrator on 2017/8/8.
 */
// 总务管理
function zwglCol(liListFlag,liList,liListAll,myCharts,myChartFlag,options,dataArray) {
    for (var i = 0; i < 3; i++) {
        var echartsIdDiv = '<div id="echartsId' + i + '" style="width: 90%;height: 90%;"></div>';
        if (i === 2)
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

    var assets = null;// 测试类别1,12,
    var assetsstatus = null;// 报废,0,丢失,0,
    var repairs = null;// 信息技术中心,1

    if(dataArray[0]  ==null ){
        assets =",0";
        assetsstatus =",0,";
        repairs =",0";
    }else{
        assets = dataArray[0].assets;
        assetsstatus = dataArray[0].assetsstatus;
        repairs = dataArray[0].repairs;
    }

    if(assets == null){
        assets =",0";
    }
    if(assetsstatus == null){
        assetsstatus =",0";
    }
    if(repairs == null){
        repairs =",0";
    }

    assets = assets.split(',');//第一张表数据
    assetsstatus = assetsstatus.split(',');//第二张表数据
    repairs = repairs.split(',');//第三张表数据

    var assetsName = new Array(assets.length/2);//校产类别
    var assetsNum = new Array(assets.length/2);//校产数量

    for(var i = 0, j1 = 0, j2 = 0 ; i < assets.length ; i ++ ){
        if(i%2 === 0){
            assetsName[j1] = assets[i];
            j1 ++;
        }else{
            assetsNum[j2] = {value:assets[i],name:assetsName[j1-1]};
            j2 ++;
        }
    }

    var assetsstatusName = new Array(assetsstatus.length/2);//校产状态名称
    var assetsstatusNum = new Array(assetsstatus.length/2);//校产状态数量

    for(var i = 0, j1 = 0, j2 = 0 ; i < assetsstatus.length ; i ++ ){
        if(i%2 === 0){
            assetsstatusName[j1] = assetsstatus[i];
            j1 ++;
        }else{
            assetsstatusNum[j2] = {value:assetsstatus[i],name:assetsstatusName[j1-1]};
            j2 ++;
        }
    }

    var repairsName = new Array(repairs.length/2);//部门维修名称
    var repairsNum = new Array(repairs.length/2);//部门维修数量

    for(var i = 0, j1 = 0, j2 = 0 ; i < repairs.length ; i ++ ){
        if(i%2 === 0){
            repairsName[j1] = repairs[i];
            j1 ++;
        }else{
            repairsNum[j2] = repairs[i];
            j2 ++;
        }
    }


    liListAll = '';
    // 指定图表的配置项和数据
    options[0] = {
        title: {
            text: '校产类别比例',
            /*subtext: '协同办公',*/
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
            orient: 'vertical',
            x : 'left',
            y : 'top',
            textStyle: {
                color:'#fff'
            },
            data:assetsName
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
        /*//example
         xAxis: {
         data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
         },
         yAxis: {},
         */
        series: [
            {
                name:'校产数量',
                type:'pie',
                radius : [20, 90],
                center : ['50%', '50%'],
                roseType : 'radius',
                label: {
                    normal: {
                        show: false
                    },
                    emphasis: {
                        show: true
                    }
                },
                lableLine: {
                    normal: {
                        show: false
                    },
                    emphasis: {
                        show: true
                    }
                },
                data:assetsNum
            }
            /*{
             name:'面积模式',
             type:'pie',
             radius : [30, 110],
             center : ['75%', '50%'],
             roseType : 'area',
             data:[
             {value:10, name:'rose1'},
             {value:5, name:'rose2'},
             {value:15, name:'rose3'},
             {value:25, name:'rose4'},
             {value:20, name:'rose5'},
             {value:35, name:'rose6'},
             {value:30, name:'rose7'},
             {value:40, name:'rose8'}
             ]
             }*/
        ]
    };
    options[1] = {
        title : {
            text: '校产状态情况',
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
            orient: 'vertical',
            left: 'left',
            textStyle: {
                color:'#fff'
            },
            data: assetsstatusName

        },
        series : [
            {
                name: '状态数量',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:assetsstatusNum,
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
            text: '部门报修数量统计',
            x:'center',
            textStyle:{
                color: '#fff'
            }
        },
        color: ['#3398DB'],
        legend: {
            orient: 'vertical',
            x : 'left',
            y : 'top',
            textStyle: {
                color:'#fff'
            },
            data:['报修量']
        },
        tooltip : {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
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
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                },
                data : repairsName,
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis : [
            {
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                },
                type : 'value'
            }
        ],
        series : [
            {
                name:'报修量',
                type:'bar',
                barWidth: '60%',
                data:repairsNum
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
