<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/9
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container" >
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="content block-fill-white">
                    <div class="form-row">
                        <div class="col-md-1 tar" style="width:120px">
                            系部:
                        </div>
                        <div class="col-md-2">
                            <select id="departmentsId"  class="js-example-basic-single" onchange="change()"></select>
                        </div>
                        <div class="col-md-1 tar" style="width:120px">
                            专业:
                        </div>
                        <div class="col-md-2">
                            <select id="majorShow" class="js-example-basic-single" onchange="change()"></select>
                        </div>
                        <div class="col-md-1 tar" style="width:120px">
                            班级:
                        </div>
                        <div class="col-md-2">
                            <select id="classId"  class="js-example-basic-single" onchange="change()"></select>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content" style="height: 840px">
                    <div class="row">
                        <div class="col-md-6">
                            <div id="searchLogECharts"  style="height: 340px" ></div>
                        </div>
                        <div class="col-md-6">
                            <div id="searchLogECharts2" style="height: 340px"></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div id="searchLogECharts3" style="height: 500px"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function  change() {
        xjydxxtjCol('<%=request.getContextPath()%>');
    }
    $(document).ready(function () {
        xjydxxtjCol('<%=request.getContextPath()%>');
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId');
        });
//通过系部id获取专业-方向-层次下拉列表
        $("#departmentsId").change(function(){
            $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId="+$("#departmentsId").val(),function (data) {
                addOption(data, "majorShow");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId="+$("#dept").val(),function (data) {
            addOption(data, "majorShow");
        })
//通过专业-方向-层次id获取班级下拉列表
        $("#majorShow").change(function(){
            $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow="+$("#majorShow").val(), function (data) {
                addOption(data, "classId");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow="+$("#major").val(), function (data) {
            addOption(data, "classId");
        })
    })
    function xjydxxtjCol(path) {
        var searchLogECharts = echarts.init(document.getElementById("searchLogECharts"));
        var searchLogECharts2 = echarts.init(document.getElementById("searchLogECharts2"));
        var searchLogECharts3 = echarts.init(document.getElementById("searchLogECharts3"));
        $.post(path+"/echartsMenu/getxjydxxtjEcharts?&departmentsId="+$("#departmentsId option:selected").val()+"&majorCode="+$("#majorShow option:selected").val()+"&classId="+$("#classId option:selected").val(), function (data) {
            var newContent = null;
            if (data.sjydEcharts == null || data.sjydEcharts.newContent == null) {
                newContent = data.sjydEcharts;
            } else {
                newContent = data.sjydEcharts.newContent;

            }
            if (newContent == null || newContent == 'null') {
                newContent = "0,0,0,0,0,0";
            }
            newContent = newContent.split(',');
            searchLogECharts.setOption ({
                color: ['#f845f1', '#ad46f3', '#5045f6', '#4777f5','#44aff0','#45dbf7'],
                title: {
                    text: '学籍异动信息统计',
                    x: 'center',
                    textStyle:{
                        color: '#fff'
                    }
                },
                grid: {
                    left: '5%',
                    right: '5%',
                    top:'5%',
                    bottom: '19%',
                    containLabel: true
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'vertical',
                    x: 'left',
                    data: ['毕业', '退学', '转学', '休学', '在籍', '其它'],
                    textStyle:{
                        color: '#fff'
                    }
                },
                calculable: true,
                series: [
                    {   name: '访问来源',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', 225],
                        data: [
                            {value: newContent[0], name: '毕业'},
                            {value: newContent[1], name: '退学'},
                            {value: newContent[2], name: '转学'},
                            {value: newContent[3], name: '休学'},
                            {value: newContent[4], name: '在籍'},
                            {value: newContent[5], name: '其它'}
                        ]
                    }
                ]
            });
            searchLogECharts2.setOption ({
                toolbox: {
                    show: true,
                    feature: {
                        mark: {
                            show: true
                        },
                        dataView: {
                            show: true,
                            readOnly: false
                        },
                        magicType: {
                            show: true,
                            type: ['pie', 'funnel']
                        },
                        restore: {
                            show: true
                        },
                        saveAsImage: {
                            show: true
                        }
                    }
                },
                calculable: true,
                "tooltip": {
                    "trigger": "item",
                    "formatter": "{a}<br/>{b}:{c}人"
                },
                "title": {
                    "text": "学籍异动信息统计",
                    "left": "center",
                    "top": 15,
                    "textStyle": {
                        "color": "#fff"
                    }
                },
                "calculable": true,
                "legend": {
                    "icon": "circle",
                    "x": "center",
                    "y": "15%",
                    "data": [
                        "毕业",
                        "退学",
                        "转学",
                        "休学",
                        "在籍",
                        "其它",
                    ],
                    "textStyle": {
                        "color": "#fff"
                    }
                },
                "series": [{
                    "name": "异动类型",
                    "type": "pie",
                    "radius": [
                        37,
                        155
                    ],
                    "avoidLabelOverlap": false,
                    "startAngle": 0,
                    "center": [
                        "50.1%",
                        "34%"
                    ],
                    "roseType": "area",
                    "selectedMode": "single",
                    "label": {
                        "normal": {
                            "show": true,
                            "formatter": "{c}人"
                        },
                        "emphasis": {
                            "show": true
                        }
                    },
                    "labelLine": {
                        "normal": {
                            "show": true,
                            "smooth": false,
                            "length": 20,
                            "length2": 10
                        },
                        "emphasis": {
                            "show": true
                        }
                    },
                    "data": [{
                        "value": newContent[0],
                        "name": "毕业",
                        "itemStyle": {
                            "normal": {
                                "color": "#f845f1"
                            }
                        }
                    },
                        {
                            "value": newContent[1],
                            "name": "退学",
                            "itemStyle": {
                                "normal": {
                                    "color": "#ad46f3"
                                }
                            }
                        },
                        {
                            "value": newContent[2],
                            "name": "转学",
                            "itemStyle": {
                                "normal": {
                                    "color": "#5045f6"
                                }
                            }
                        },
                        {
                            "value": newContent[3],
                            "name": "休学",
                            "itemStyle": {
                                "normal": {
                                    "color": "#4777f5"
                                }
                            }
                        },
                        {
                            "value": newContent[4],
                            "name": "在籍",
                            "itemStyle": {
                                "normal": {
                                    "color": "#44aff0"
                                }
                            }
                        },{
                            "value": newContent[5],
                            "name": "其它",
                            "itemStyle": {
                                "normal": {
                                    "color": "#45dbf7"
                                }
                            }
                        },
                        {
                            "value": "",
                            "name": "",
                            "itemStyle": {
                                "normal": {
                                    "label": {
                                        "show": false
                                    },
                                    "labelLine": {
                                        "show": false
                                    }
                                }
                            }
                        },
                        {
                            "value": "",
                            "name": "",
                            "itemStyle": {
                                "normal": {
                                    "label": {
                                        "show": false
                                    },
                                    "labelLine": {
                                        "show": false
                                    }
                                }
                            }
                        },
                        {
                            "value": "",
                            "name": "",
                            "itemStyle": {
                                "normal": {
                                    "label": {
                                        "show": false
                                    },
                                    "labelLine": {
                                        "show": false
                                    }
                                }
                            }
                        },
                        {
                            "value": "",
                            "name": "",
                            "itemStyle": {
                                "normal": {
                                    "label": {
                                        "show": false
                                    },
                                    "labelLine": {
                                        "show": false
                                    }
                                }
                            }
                        },
                        {
                            "value": "",
                            "name": "",
                            "itemStyle": {
                                "normal": {
                                    "label": {
                                        "show": false
                                    },
                                    "labelLine": {
                                        "show": false
                                    }
                                }
                            }
                        },
                        {
                            "value": "",
                            "name": "",
                            "itemStyle": {
                                "normal": {
                                    "label": {
                                        "show": false
                                    },
                                    "labelLine": {
                                        "show": false
                                    }
                                }
                            }
                        },
                        {
                            "value": "",
                            "name": "",
                            "itemStyle": {
                                "normal": {
                                    "label": {
                                        "show": false
                                    },
                                    "labelLine": {
                                        "show": false
                                    }
                                }
                            }
                        },
                        {
                            "value": "",
                            "name": "",
                            "itemStyle": {
                                "normal": {
                                    "label": {
                                        "show": false
                                    },
                                    "labelLine": {
                                        "show": false
                                    }
                                }
                            }
                        },
                        {
                            "value": "",
                            "name": "",
                            "itemStyle": {
                                "normal": {
                                    "label": {
                                        "show": false
                                    },
                                    "labelLine": {
                                        "show": false
                                    }
                                }
                            }
                        }
                    ]
                }]
            });
            var posList = [
                'left', 'right', 'top', 'bottom',
                'inside',
                'insideTop', 'insideLeft', 'insideRight', 'insideBottom',
                'insideTopLeft', 'insideTopRight', 'insideBottomLeft', 'insideBottomRight'
            ];

            searchLogECharts3.configParameters = {
                rotate: {
                    min: -90,
                    max: 90
                },
                align: {
                    options: {
                        left: 'left',
                        center: 'center',
                        right: 'right'
                    }
                },
                verticalAlign: {
                    options: {
                        top: 'top',
                        middle: 'middle',
                        bottom: 'bottom'
                    }
                },
                position: {
                    options: echarts.util.reduce(posList, function (map, pos) {
                        map[pos] = pos;
                        return map;
                    }, {})
                },
                distance: {
                    min: 0,
                    max: 100
                }
            };


            var labelOption = {
                normal: {
                    show: true,
                    position: 'insideBottom',
                    distance: '15',
                    align: 'left',
                    verticalAlign: 'middle',
                    rotate: '90',
                    fontSize: 16,
                    rich: {
                        name: {
                            textBorderColor: '#fff'
                        }
                    }
                }
            };

            var yearsList = new Array();
            var graduationtbList = new Array();
            var dropOuttbList = new Array();
            var transfertbList = new Array();
            var hughOuttbList = new Array();
            var inTheBooktbList = new Array();
            var othertbList = new Array();
            if(data.xjydtjEcharts == null || data.xjydtjEcharts == ''){
                yearsList = [' '];
                graduationtbList = [0];
                dropOuttbList =[0];
                transfertbList = [0];
                hughOuttbList=[0] ;
                inTheBooktbList = [0];
                othertbList =[0];
            }else{
                $.each(data.xjydtjEcharts, function (index, content) {
                    yearsList[index] = content.years;
                    graduationtbList[index] = content.graduationtb;
                    dropOuttbList[index] = content.dropOuttb;
                    transfertbList[index] = content.transfertb;
                    hughOuttbList[index] = content.hughOuttb;
                    inTheBooktbList[index] = content.inTheBooktb;
                    othertbList[index] = content.othertb;
                })
            }
            searchLogECharts3.setOption ({
                color: ['#f845f1', '#ad46f3', '#5045f6', '#4777f5','#44aff0','#45dbf7'],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                legend: {
                    data: ['毕业', '退学', '转学', '休学', '在籍', '其它']
                },
                toolbox: {
                    show: true,
                    orient: 'vertical',
                    left: 'right',
                    top: 'center',
                    feature: {
                        mark: {show: true},
                        dataView: {show: true, readOnly: false},
                        magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                        restore: {show: true},
                        saveAsImage: {show: true,backgroundColor:'#436885'}
                    }
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        axisTick: {show: false},
                        axisLabel: {
                            show: true,
                            textStyle: {
                                color: '#fff'
                            }
                        },
                        data: yearsList
                    }
                ],
                yAxis: [
                    {
                        type: 'value',
                        axisLabel : {
                            formatter: '{value}',
                            textStyle: {
                                color: '#fff'
                            }
                        }
                    }
                ],
                series: [
                    {
                        name: '毕业',
                        type: 'bar',
                        barGap: 0,
                        label: labelOption,
                        data: graduationtbList
                    },
                    {
                        name: '退学',
                        type: 'bar',
                        label: labelOption,
                        data: dropOuttbList
                    },
                    {
                        name: '转学',
                        type: 'bar',
                        label: labelOption,
                        data: transfertbList
                    },
                    {
                        name: '休学',
                        type: 'bar',
                        label: labelOption,
                        data: hughOuttbList
                    },
                    {
                        name: '在籍',
                        type: 'bar',
                        label: labelOption,
                        data: inTheBooktbList
                    },
                    {
                        name: '其它',
                        type: 'bar',
                        label: labelOption,
                        data: othertbList
                    }
                ]
            });
        });
    }
</script>


