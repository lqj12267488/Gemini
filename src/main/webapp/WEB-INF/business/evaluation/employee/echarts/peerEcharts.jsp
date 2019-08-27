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
                <div class="block block-drop-shadow content" style="height: 830px">
                    <div class="row">
                        <div class="col-md-12">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="back()">返回
                            </button>
                            <div id="searchLogECharts3" style="height: 500px"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        xjydxxtjCol('<%=request.getContextPath()%>');

    })

    function xjydxxtjCol(path) {
        var searchLogECharts3 = echarts.init(document.getElementById("searchLogECharts3"));
        $.post(path+"/evaluation/echartsMenu/getPeerEcharts?&id="+'${id}'+"&taskName="+'${taskName}'+"&evaluationType="+'${evaluationType}', function (data) {
            var newContent = null;
            if (data.nameEcharts == null || data.nameEcharts.newContent == null) {
                newContent = data.nameEcharts;
            } else {
                newContent = data.nameEcharts.newContent;

            }
            newContent = newContent.split(',');
            var newContent1 = null;
            if (data.sorceEcharts == null || data.sorceEcharts.newContent1 == null) {
                newContent1 = data.sorceEcharts;
            } else {
                newContent1 = data.sorceEcharts.newContent1;

            }
            var  tempStr='"0';
            if (newContent1 == null || newContent1 == 'null') {
                for(var i=1;i<newContent.length;i++){
                    tempStr +=',0';
                }
                tempStr=tempStr+'"';
                newContent1 = tempStr.split(',');
            }else{
                newContent1 = newContent1.split(',');
            }

            /*newContent1 = [ {
                value : 56,
                //自定义标签样式，仅对该数据项有效
                label: {},
                //自定义特殊 itemStyle，仅对该数据项有效
                itemStyle:{
                    normal:{
                        color:'#111'
                    }

                }
            },
                {
                    value : 56,
                    //自定义标签样式，仅对该数据项有效
                    label: {},
                    //自定义特殊 itemStyle，仅对该数据项有效
                    itemStyle:{
                        normal:{
                            color:'#FFF'
                        }
                    }
                },]*/
            searchLogECharts3.setOption ({
                color: ['#FFFF00', '#FF7F00', '#FF0000', '#00FF00', '#00FFFF', '#8B00FF', '#4542f7'],
                title: {
                    text: '同行评教分数统计',
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
                        data : newContent,
                        axisTick: {
                            alignWithLabel: true
                        },
                        axisLabel: {
                            textStyle: {
                                color: '#fff'
                            }
                        }
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
                        name:'分数',
                        type:'bar',
                        barWidth: '60%',
                        data: newContent1
                    }
                ]
            });
        });
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/evaluation/statistics/queryPeerResult");
    }
</script>


