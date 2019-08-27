<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/jquery/jquery.min.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/app/echarts-all.js'></script>
<style>
    td {
        line-height: 12px !important;
    }
</style>
<div style="margin:auto;margin-bottom: 20px;">
    <%--  <input type="button" value="demo" onclick="window.print();"/>--%>
    <p style=";text-align:center;vertical-align:bottom;letter-spacing:18px;font-family: 宋体;font-size: 21px;font-weight: bold;">
        <span style="">试卷分析单</span>
    </p>
    <p style=";text-align:center;vertical-align:bottom">
        <strong style="font-family: 宋体;font-size: 21px">
                            <span>
                                <input readonly class="termInput" id="schoolYear" type="text"
                                       value="${data.schoolYearShow}"
                                       style="background: transparent;color: #000; border: none; border-bottom: 2px solid #000;font-size: 25px"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                                       maxlength="10">
                                <%--学年度--%>
                            </span>
            <%--<span style="margin-left: 20px;">第</span>--%>
        </strong>
        <%--<strong style="font-family: 宋体;font-size: 21px">--%>
                            <%--<span>--%>
                            <%--<input readonly class="termInput" type="text" id="term" value="${data.term}"--%>
                                   <%--style="background: transparent;color: #000; border: none; border-bottom: 2px solid #000;"--%>
                                   <%--onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "--%>
                                   <%--maxlength="1" placeholder="1位数字">--%>
                            <%--学期--%>
                            <%--</span>--%>
        <%--</strong>--%>
    </p>
    <p style="text-align:right;vertical-align:bottom">
        <strong style="font-family: 宋体;font-size: 16px">
                            <span>
                                <input readonly class="termInput" id="examYear" type="text" value="${data.examYear}"
                                       style="width: 80px;background: transparent;color: #000; border: none; border-bottom: 2px solid #000;"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                                       maxlength="4" placeholder="4位数字">
                                年
                            </span>
            <span>
                                <input readonly class="termInput" id="examMonth" type="text" value="${data.examMonth}"
                                       style="width: 40px;background: transparent;color: #000; border: none; border-bottom: 2px solid #000;"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                                       maxlength="2" placeholder="2位数字">
                                月
                            </span>
            <span>
                                <input readonly class="termInput" id="examDay" type="text" value="${data.examDay}"
                                       style="width: 40px;background: transparent;color: #000; border: none; border-bottom: 2px solid #000;"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                                       maxlength="2" placeholder="2位数字">
                                日
                            </span>
        </strong>
    </p>
</div>
<div style="text-align: center ">
    <table border="1" cellpadding="10" cellspacing="10"
           style="width:92%;text-align:center; border-color:#000000; border-collapse:collapse;border-width: 2px;">
        <tbody>
        <tr>
            <td style="border-color: rgb(0, 0, 0); width: 90px;">
                <p style="vertical-align: bottom; width: 90px;">
                    <strong><span style="font-family: 宋体;font-size: 16px">考试科目</span></strong>
                </p>
            </td>
            <td style="border-left: none; border-right-width: 1px; border-right-color: rgb(0, 0, 0); border-top-width: 1px;width: 133px; border-top-color: rgb(0, 0, 0); border-bottom-width: 1px; border-bottom-color: rgb(0, 0, 0);">
                ${data.courseIdShow}
            </td>
            <td style="width:90px; border-left: none; border-right-width: 1px; border-right-color: rgb(0, 0, 0); border-top-width: 1px; border-top-color: rgb(0, 0, 0); border-bottom-width: 1px; border-bottom-color: rgb(0, 0, 0);">
                <p style="vertical-align: bottom; width: 90px;">
                    <strong><span style="font-family: 宋体;font-size: 16px">考试班级</span></strong>
                </p>
            </td>
            <td style="width:133px; border-left: none; border-right-width: 1px; border-right-color: rgb(0, 0, 0); border-top-width: 1px; border-top-color: rgb(0, 0, 0); border-bottom-width: 1px; border-bottom-color: rgb(0, 0, 0);">
                <input readonly id="classId" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px; width: 133px"
                       value="${data.classIdShow}"></td>
            </td>
            <td style="width:90px; border-left: none; border-right-width: 1px; border-right-color: rgb(0, 0, 0); border-top-width: 1px; border-top-color: rgb(0, 0, 0); border-bottom-width: 1px; border-bottom-color: rgb(0, 0, 0);">
                <p style="vertical-align: bottom; width: 90px;">
                    <strong><span style="font-family: 宋体;font-size: 16px">任课教师</span></strong>
                </p>
            </td>
            <td style="width:133px; border-left: none; border-right-width: 1px; border-right-color: rgb(0, 0, 0); border-top-width: 1px; border-top-color: rgb(0, 0, 0); border-bottom-width: 1px; border-bottom-color: rgb(0, 0, 0);">
                <input readonly id="teacherId" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px; width: 133px"
                       value="${fn:split(data.teacherIdShow,' ---- ')[0]}"></td>
            </td>
            <td style="width:90px; border-left: none; border-right-width: 1px; border-right-color: rgb(0, 0, 0); border-top-width: 1px; border-top-color: rgb(0, 0, 0); border-bottom-width: 1px; border-bottom-color: rgb(0, 0, 0);">
                <p style="vertical-align: bottom; width: 90px;">
                    <strong><span style="font-family: 宋体;font-size: 16px">考核方式</span></strong>
                </p>
            </td>
            <td style="width:133px; border-left: none; border-right-width: 1px; border-right-color: rgb(0, 0, 0); border-top-width: 1px; border-top-color: rgb(0, 0, 0); border-bottom-width: 1px; border-bottom-color: rgb(0, 0, 0);">
                <input readonly id="examNature" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px; width: 133px"
                       value="考试"></td>
            </td>
        </tr>
        <tr>
            <td style=" border-left-width: 1px; border-left-color: rgb(0, 0, 0); border-right-width: 1px; border-right-color: rgb(0, 0, 0); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(0, 0, 0);">
                <p style="vertical-align: bottom">
                    <strong><span style="font-family: 宋体;font-size: 16px">考试类型</span></strong>
                </p>
            </td>
            <td>
                <input readonly id="examMode" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px; width: 133px"
                       value="笔试">
            </td>
            <td>
                <p style="vertical-align: bottom">
                    <strong><span style="font-family: 宋体;font-size: 16px">考试时间</span></strong>
                </p>
            </td>
            <td>
                <input readonly id="examTime" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px; width: 133px"
                       value="${data.examTime}">
            </td>
            <td>
                <p style="vertical-align: bottom">
                    <strong><span style="font-family: 宋体;font-size: 16px">考试人数</span></strong>
                </p>
            </td>
            <td>
                <input readonly id="examStunum" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px; width: 133px"
                       value="${data.examStunum}"
                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                       maxlength="3" placeholder="3位数字">
            </td>
            <td>
                <p style="vertical-align: bottom">
                    <strong><span style="font-family: 宋体;font-size: 16px">缺考人数</span></strong>
                </p>
            </td>
            <td>
                <input readonly id="missExamStunum" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px; width: 133px"
                       value="${data.missExamStunum}"
                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                       maxlength="3" placeholder="3位数字">
            </td>
        </tr>
        <tr>
            <td valign="middle" colspan="2" rowspan="7"
                style=" border-left-width: 1px; border-left-color: rgb(0, 0, 0); border-right-width: 1px; border-right-color: rgb(0, 0, 0); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(0, 0, 0);">

                <strong><span style="font-family: 宋体;font-size: 16px">个题得分率</span></strong>
                <br><br>
                <strong><span
                        style="font-family: 宋体;font-size: 14px;text-decoration:underline;">全班该题实得分数</span></strong>
                <br>
                <strong><span style="font-family: 宋体;font-size: 14px">该题满分值*参考人数</span></strong>

            </td>
            <td>
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">1</span>
                </p>
            </td>
            <td colspan="5">
                <input readonly id="grdfl1" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px;"
                       value="${data.grdfl1}">
            </td>
        </tr>
        <tr>
            <td>
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">2</span>
                </p>
            </td>
            <td colspan="5">
                <input readonly id="grdfl2" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px;"
                       value="${data.grdfl2}">
            </td>
        </tr>
        <tr>
            <td>
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">3</span>
                </p>
            </td>
            <td colspan="5">
                <input readonly id="grdfl3" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px;"
                       value="${data.grdfl3}">
            </td>
        </tr>
        <tr>
            <td>
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">4</span>
                </p>
            </td>
            <td colspan="5">
                <input readonly id="grdfl4" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px;"
                       value="${data.grdfl4}">
            </td>
        </tr>
        <tr>
            <td>
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">5</span>
                </p>
            </td>
            <td colspan="5">
                <input readonly id="grdfl5" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px;"
                       value="${data.grdfl5}">
            </td>
        </tr>
        <tr>
            <td>
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">6</span>
                </p>
            </td>
            <td colspan="5">
                <input readonly id="grdfl6" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px;"
                       value="${data.grdfl6}">
            </td>
        </tr>
        <tr>
            <td>
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">7</span>
                </p>
            </td>
            <td colspan="5">
                <input readonly id="grdfl7" type="text"
                       style="background: transparent;border: none;color: #000;font-size: 16px;"
                       value="${data.grdfl7}">
            </td>
        </tr>
        <tr>
            <td colspan="4">
                考分分段统计表
            </td>
            <td colspan="4" rowspan="8" valign="middle">
                <span style="color: red">考分分布曲线图</span>
                <div id="searchECharts" style="height: 380px ;width: 60%"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">分数段</span>
                </p>
            </td>
            <td>
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">人数</span>
                </p>
            </td>
            <td>
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">%</span>
                </p>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 15px; font-weight: bold;">90~100</span>
                </p>
            </td>
            <td>
                ${data.num90100}
            </td>
            <td>
                ${data.percent90100}
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">80~89</span>
                </p>
            </td>
            <td>
                ${data.num8089}
            </td>
            <td>
                ${data.percent8089}
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">70~79</span>
                </p>
            </td>
            <td>
                ${data.num7079}
            </td>
            <td>
                ${data.percent7079}
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">60~69</span>
                </p>
            </td>
            <td>
                ${data.num6069}
            </td>
            <td>
                ${data.percent6069}
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">59及以下</span>
                </p>
            </td>
            <td>
                ${data.num59}
            </td>
            <td>
                ${data.percent59}
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p style="vertical-align: bottom">
                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">平均分</span>
                </p>
            </td>
            <td>
                ${data.avgNum}
            </td>
            <td>
                ${data.avgPercent}
            </td>
        </tr>
        <tr>
            <td valign="middle" colspan="2" rowspan="8"
                style=" border-left-width: 1px; border-left-color: rgb(0, 0, 0); border-right-width: 1px; border-right-color: rgb(0, 0, 0); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(0, 0, 0);">
                <p style=";text-align:center;vertical-align:top">
                    <strong>
                        <span style="font-family: 宋体;font-size: 16px">卷面分析</span>
                        <br><br>
                        <span style="font-family: 宋体;font-size: 14px">（主要包括覆盖面，深广度、难度、效度、区分度、信度等方面）</span>
                    </strong>
                </p>
            </td>
            <td colspan="6" rowspan="8">
                ${data.surfaceAnalysis}
            </td>
        </tr>
        <tr></tr>
        <tr></tr>
        <tr></tr>
        <tr></tr>
        <tr></tr>
        <tr></tr>
        <tr></tr>
        <tr>
            <td valign="middle" colspan="2" rowspan="6">
                <p style=";text-align:center;vertical-align:top">
                    <strong><span style="font-family: 宋体;font-size: 16px">学生学习情况</span></strong>
                </p>
            </td>
            <td colspan="6" rowspan="6"
            >
                ${data.learningSituation}
            </td>
        </tr>
        <tr></tr>
        <tr></tr>
        <tr></tr>
        <tr></tr>
        <tr></tr>
        <td valign="middle" colspan="2" rowspan="6">
            <p style=";text-align:center;vertical-align:top">
                <strong><span style="font-family: 宋体;font-size: 16px">主要改进措施</span></strong>
            </p>
        </td>
        <td colspan="6" rowspan="6">
            ${data.improvementMeasures}
        </td>
        </tr>
        <tr></tr>
        <tr></tr>
        <tr></tr>
        <tr></tr>
        </tbody>
    </table>
</div>
<input type="hidden" id="number1" value="${data.num90100}">
<input type="hidden" id="number2" value="${data.num8089}">
<input type="hidden" id="number3" value="${data.num7079}">
<input type="hidden" id="number4" value="${data.num6069}">
<input type="hidden" id="number5" value="${data.num59}">
<script>
    $(document).ready(function () {
        xstb('<%=request.getContextPath()%>');
    })

    function printDate() {
        var print = "<%=request.getContextPath()%>/testPaperAnalysis/printTestPaperAnalysis?id=" + $("#id").val();
        var bdhtml = window.document.body.innerHTML;
        $.get(print, function (html) {
            window.document.body.innerHTML = html;
            window.print();
            window.document.body.innerHTML = bdhtml;
        })
    }

    function xstb() {
        var num1 = $("#number1").val();
        var num2 = $("#number2").val();
        var num3 = $("#number3").val();
        var num4 = $("#number4").val();
        var num5 = $("#number5").val();
        var searchECharts = echarts.init(document.getElementById("searchECharts"));

        searchECharts.setOption({
            xAxis: {
                textStyle: {
                    color: '#000'
                },
                axisLine: {
                    lineStyle: {
                        color: '#000'
                    }
                },
                type: 'category',
                data: ['90~100', '80~89', '70~79', '60~69', '59以下']
            },
            yAxis: {
                axisLine: {
                    lineStyle: {
                        color: '#000'
                    }
                },
                type: 'value'
            },
            series: [{
                data: [num1, num2, num3, num4, num5],
                type: 'line'
            }]
        });
        searchECharts.on('finished', function () {
            window.print()
        });
    }
</script>
</html>

