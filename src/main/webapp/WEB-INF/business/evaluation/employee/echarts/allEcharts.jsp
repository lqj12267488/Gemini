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
                            学期:
                        </div>
                        <div class="col-md-2">
                            <select id="f_term" class="js-example-basic-single" onchange="change()"></select>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content" style="height: 830px">

                    <div class="row">
                        <div class="row">
                            <div class="col-md-6">
                                <div id="searchLogECharts1"  style="height: 380px" ></div>
                            </div>
                            <div class="col-md-6">
                                <div id="searchLogECharts2" style="height: 380px"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div id="searchLogECharts3"  style="height: 380px" ></div>
                            </div>
                            <div class="col-md-6">
                                <div id="searchLogECharts4" style="height: 380px"></div>
                            </div>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'f_term','${term}');
        });
    })

    function xjydxxtjCol(path) {
        var searchLogECharts1 = echarts.init(document.getElementById("searchLogECharts1"));
        var searchLogECharts2 = echarts.init(document.getElementById("searchLogECharts2"));
        var searchLogECharts3 = echarts.init(document.getElementById("searchLogECharts3"));
        var searchLogECharts4 = echarts.init(document.getElementById("searchLogECharts4"));
        $.post(path+"/evaluation/echartsMenu/getAllEvaluationEcharts?term="+$("#f_term option:selected").val(), function (data) {
            var leaderEvaluation = null;
            if (data.leaderEcharts == null || data.leaderEcharts.leaderEvaluation == null) {
                leaderEvaluation = data.leaderEcharts;
            } else {
                leaderEvaluation = data.leaderEcharts.leaderEvaluation;

            }
            if (leaderEvaluation == null || leaderEvaluation == 'null') {
                leaderEvaluation = "0,0,0";
            }
            leaderEvaluation = leaderEvaluation.split(',');


            var studentEvaluation = null;
            if (data.studentEcharts == null || data.studentEcharts.studentEvaluation == null) {
                studentEvaluation = data.studentEcharts;
            } else {
                studentEvaluation = data.studentEcharts.studentEvaluation;

            }
            if (studentEvaluation == null || studentEvaluation == 'null') {
                studentEvaluation = "0,0,0";
            }
            studentEvaluation = studentEvaluation.split(',');

            var peerEvaluation = null;
            if (data.peerEcharts == null || data.peerEcharts.peerEvaluation == null) {
                peerEvaluation = data.peerEcharts;
            } else {
                peerEvaluation = data.peerEcharts.peerEvaluation;

            }
            if (peerEvaluation == null || peerEvaluation == 'null') {
                peerEvaluation = "0,0,0";
            }
            peerEvaluation = peerEvaluation.split(',');


            var teacherEvaluation = null;
            if (data.teacherEcharts == null || data.teacherEcharts.teacherEvaluation == null) {
                teacherEvaluation = data.teacherEcharts;
            } else {
                teacherEvaluation = data.teacherEcharts.teacherEvaluation;

            }
            if (teacherEvaluation == null || teacherEvaluation == 'null') {
                teacherEvaluation = "0,0,0";
            }
            teacherEvaluation = teacherEvaluation.split(',');
            searchLogECharts1.setOption ({
                color: ['#FFFF00', '#FF7F00', '#FF0000', '#00FF00', '#00FFFF', '#8B00FF', '#4542f7'],
                title: {
                    text: '学生评教参与度统计',
                    textStyle:{
                        color: '#fff'
                    },
                    x:'center',
                    y:'5%'
                },
                tooltip : {
                    trigger: 'axis',
                    axisPointer : {
                        type : 'shadow'
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
                        data : ["参与数（人）","总数（人）","学生参与比例（%）"],
                        axisTick: {
                            alignWithLabel: true
                        },
                        axisLabel: {
                            textStyle: {
                                color: '#fff'
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color:  '#fff'
                            }
                        },
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLine: {
                            lineStyle: {
                                color:  '#fff'
                            }
                        },
                    }
                ],
                series : [
                    {
                        type:'bar',
                        barWidth: '60%',
                        data: studentEvaluation
                    }
                ]
            });
            searchLogECharts2.setOption ({
                color: ['#FFFF00', '#FF7F00', '#FF0000', '#00FF00', '#00FFFF', '#8B00FF', '#4542f7'],
                title: {
                    text: '领导评教参与度统计',
                    textStyle:{
                        color: '#fff'
                    },
                    x:'center',
                    y:'5%'
                },
                tooltip : {
                    trigger: 'axis',
                    axisPointer : {
                        type : 'shadow'
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
                        data : ["参与数（人）","总数（人）","校领导参与比例（%）"],
                        axisTick: {
                            alignWithLabel: true
                        },
                        axisLabel: {
                            textStyle: {
                                color: '#fff'
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color:  '#fff'
                            }
                        },
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLine: {
                            lineStyle: {
                                color:  '#fff'
                            }
                        },
                    }
                ],
                series : [
                    {
                        type:'bar',
                        barWidth: '60%',
                        data: leaderEvaluation
                    }
                ]
            });
            searchLogECharts3.setOption ({
                color: ['#FFFF00', '#FF7F00', '#FF0000', '#00FF00', '#00FFFF', '#8B00FF', '#4542f7'],
                title: {
                    text: '教师评教参与度统计',
                    textStyle:{
                        color: '#fff'
                    },
                    x:'center',
                    y:'5%'
                },
                tooltip : {
                    trigger: 'axis',
                    axisPointer : {
                        type : 'shadow'
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
                        data : ["参与数（人）","总数（人）","教师参与比例（%）"],
                        axisTick: {
                            alignWithLabel: true
                        },
                        axisLabel: {
                            textStyle: {
                                color: '#fff'
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color:  '#fff'
                            }
                        },
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLine: {
                            lineStyle: {
                                color:  '#fff'
                            }
                        },
                    }
                ],
                series : [
                    {
                        type:'bar',
                        barWidth: '60%',
                        data: teacherEvaluation
                    }
                ]
            });
            searchLogECharts4.setOption ({
                color: ['#FFFF00', '#FF7F00', '#FF0000', '#00FF00', '#00FFFF', '#8B00FF', '#4542f7'],
                title: {
                    text: '同行评教参与度统计',
                    textStyle:{
                        color: '#fff'
                    },
                    x:'center',
                    y:'5%'
                },
                tooltip : {
                    trigger: 'axis',
                    axisPointer : {
                        type : 'shadow'
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
                        data : ["参与数（人）","总数（人）","同行参与比例（%）"],
                        axisTick: {
                            alignWithLabel: true
                        },
                        axisLabel: {
                            textStyle: {
                                color: '#fff'
                            }
                        },
                        axisLine: {
                            lineStyle: {
                                color:  '#fff'
                            }
                        },
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLine: {
                            lineStyle: {
                                color:  '#fff'
                            }
                        },
                    }
                ],
                series : [
                    {
                        type:'bar',
                        barWidth: '60%',
                        data: peerEvaluation
                    }
                ]
            });
        });
    }
</script>


