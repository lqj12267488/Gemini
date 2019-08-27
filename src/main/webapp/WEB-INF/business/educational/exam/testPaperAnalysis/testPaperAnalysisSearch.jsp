<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }

        .termInput {
            width: 168px;
            display: inline-block;
            background: rgba(0, 0, 0, .1);
            border: none;
            border-bottom: 2px solid #fff;
            outline: none;
            padding: 0 10px;
            color: #fff;
            box-shadow: none;
            font-size: 21px;
            line-height: 32px;
        }
    </style>
</head>
<div class="modal-dialog" style="width: 1200px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input readonly id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" onclick="printDate()">打印
            </button>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" style="background: rgba(0,0,0,.1);padding: 40px;">
                <div style="margin:auto;margin-bottom: 20px;">
                    <p style=";text-align:center;vertical-align:bottom;letter-spacing:18px;font-family: 宋体;font-size: 21px;font-weight: bold;">
                        <span style="">试卷分析单</span>
                    </p>
                    <div class="form-row">
                        <div class="col-md-4">

                        </div >
                        <div class="col-md-4">
                            <p style=";text-align:center;vertical-align:bottom">
                                <strong style="font-family: 宋体;font-size: 21px">
                            <span>
                                <%--<input class="termInput" id="schoolYear" type="text" value="${data.schoolYear}"--%>
                                       <%--style="background: transparent;color: #fff; border: none; border-bottom: 2px solid #fff;"--%>
                                       <%--onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "--%>
                                       <%--maxlength="10">--%>

                                    <%--<div class="col-md-2 tar">--%>
                        <%--学期--%>
                    <%--</div>--%>


                                    <%--<select id="schoolYear"/>--%>
                        <input type="text" id="schoolYear" readonly
                               style="background: transparent;color: #fff; border: none; font-size: 25px"
                               value="${data.schoolYearShow}">


                                <%--学年度--%>
                            </span>

                                    <%--<span style="margin-left: 20px;">第</span>--%>
                                    <%--<strong style="font-family: 宋体;font-size: 21px">--%>
                                    <%--<span>--%>
                                    <%--<input class="termInput" type="text" id="term" value="${data.term}"--%>
                                    <%--style="background: transparent;color: #fff; border: none; border-bottom: 2px solid #fff;"--%>
                                    <%--onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "--%>
                                    <%--maxlength="1" placeholder="1位数字">--%>
                                    <%--学期--%>
                                    <%--</span>--%>
                                    <%--</strong>--%>
                                </strong>
                            </p>
                        </div>
                        <div class="col-md-4">
                            <p style=";text-align:right;vertical-align:bottom">
                                <strong style="font-family: 宋体;font-size: 16px">
                            <span>
                                <input class="termInput" id="examYear" readonly type="text" value="${data.examYear}"
                                       style="width: 80px;background: transparent;color: #fff; border: none; border-bottom: 2px solid #fff;"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                                       maxlength="4" placeholder="4位数字">
                                年
                            </span>
                                    <span>
                                <input class="termInput" id="examMonth" type="text" readonly value="${data.examMonth}"
                                       style="width: 40px;background: transparent;color: #fff; border: none; border-bottom: 2px solid #fff;"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                                       maxlength="2" placeholder="2位数字">
                                月
                            </span>
                                    <span>
                                <input class="termInput" id="examDay" type="text" readonly value="${data.examDay}"
                                       style="width: 40px;background: transparent;color: #fff; border: none; border-bottom: 2px solid #fff;"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                                       maxlength="2" placeholder="2位数字">
                                日
                            </span>
                                </strong>
                            </p>
                        </div>
                    </div>
                </div>
                <div style="text-align: center ">
                    <table border="1" cellpadding="10" cellspacing="10"
                           style="width:100%;text-align:center; border-color:#ffffff; border-collapse:collapse;border-width: 2px;padding: 2px;margin:auto;">
                        <tbody>
                        <tr style="height:27px" class="firstRow">
                            <td width="20" valign="bottom"
                                style="padding: 1px; border-width: 1px; border-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <strong><span style="font-family: 宋体;font-size: 16px">考试科目</span></strong>
                                </p>
                            </td>
                            <td width="150" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="courseId" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.courseIdShow}">
                                <%--<select id="courseId"/>--%>
                            </td>
                            <td width="20" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <strong><span style="font-family: 宋体;font-size: 16px">考试班级</span></strong>
                                </p>
                            </td>
                            <td width="150" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="classId" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.classIdShow}"></td>
                            <%--<select id="classId"/>--%>
                            </td>
                            <td width="101" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <strong><span style="font-family: 宋体;font-size: 16px">任课教师</span></strong>
                                </p>
                            </td>
                            <td width="101" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="teacherId" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${fn:split(data.teacherIdShow,' ---- ')[0]}"></td>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <strong><span style="font-family: 宋体;font-size: 16px">考核方式</span></strong>
                                </p>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="examNature" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="考试">
                                <%--<select id="examNature"/>--%>
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="78" valign="bottom"
                                style="padding: 1px; border-left-width: 1px; border-left-color: rgb(255, 255, 255); border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <strong><span style="font-family: 宋体;font-size: 16px">考试类型</span></strong>
                                </p>
                            </td>
                            <td width="78" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="examMode" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="笔试">
                                <%--<select id="examMode"/>--%>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <strong><span style="font-family: 宋体;font-size: 16px">考试时间</span></strong>
                                </p>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input readonly id="examTime" type="text"
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.examTime}">
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <strong><span style="font-family: 宋体;font-size: 16px">考试人数</span></strong>
                                </p>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input readonly id="examStunum" type="text"
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.examStunum}"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                                       maxlength="3" placeholder="3位数字">
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <strong><span style="font-family: 宋体;font-size: 16px">缺考人数</span></strong>
                                </p>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input readonly id="missExamStunum" type="text"
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.missExamStunum}"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                                       maxlength="3" placeholder="3位数字">
                            </td>
                        </tr>
                        <tr style="height:31px">
                            <td width="156" valign="middle" colspan="2" rowspan="7"
                                style="padding: 1px; border-left-width: 1px; border-left-color: rgb(255, 255, 255); border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">

                                <strong><span style="font-family: 宋体;font-size: 16px">个题得分率</span></strong>
                                <br><br>
                                <strong><span
                                        style="font-family: 宋体;font-size: 14px;text-decoration:underline;">全班该题实得分数</span></strong>
                                <br>
                                <strong><span style="font-family: 宋体;font-size: 14px">该题满分值*参考人数</span></strong>

                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">1</span>
                                </p>
                            </td>
                            <td width="355" valign="bottom" colspan="5"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input readonly id="grdfl1" type="text"
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.grdfl1}">
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">2</span>
                                </p>
                            </td>
                            <td width="355" valign="bottom" colspan="5"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input readonly id="grdfl2" type="text"
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.grdfl2}">
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">3</span>
                                </p>
                            </td>
                            <td width="355" valign="bottom" colspan="5"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input readonly id="grdfl3" type="text"
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.grdfl3}">
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">4</span>
                                </p>
                            </td>
                            <td width="355" valign="bottom" colspan="5"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input readonly id="grdfl4" type="text"
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.grdfl4}">
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">5</span>
                                </p>
                            </td>
                            <td width="355" valign="bottom" colspan="5"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input readonly id="grdfl5" type="text"
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.grdfl5}">
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">6</span>
                                </p>
                            </td>
                            <td width="355" valign="bottom" colspan="5"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input readonly id="grdfl6" type="text"
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.grdfl6}">
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">7</span>
                                </p>
                            </td>
                            <td width="355" valign="bottom" colspan="5"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input readonly id="grdfl7" type="text"
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.grdfl7}">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height:27px">
                                考分分段统计表
                            </td>
                            <td width="427" valign="bottom" colspan="4" rowspan="8"
                                style=" padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <span style="color: red">考分分布曲线图</span>
                                <div id="searchLogECharts" style="height: 380px"></div>
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom" colspan="2"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">分数段</span>
                                </p>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">人数</span>
                                </p>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">%</span>
                                </p>
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom" colspan="2"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">90~100</span>
                                </p>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="num90_100" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.num90100}">
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="percent90_100" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.percent90100}">
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom" colspan="2"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">80~89</span>
                                </p>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="num80_89" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.num8089}">
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="percent80_89" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.percent8089}">
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom" colspan="2"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">70~79</span>
                                </p>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="num70_79" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.num7079}">
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="percent70_79" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.percent7079}">
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom" colspan="2"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">60~69</span>
                                </p>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="num60_69" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.num6069}">
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="percent60_69" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.percent6069}">
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom" colspan="2"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">59及以下</span>
                                </p>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="num59" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.num59}">
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="percent59" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.percent59}">
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="71" valign="bottom" colspan="2"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style="vertical-align: bottom">
                                    <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">平均分</span>
                                </p>
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="avgNum" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.avgNum}">
                            </td>
                            <td width="71" valign="bottom"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <input id="avgPercent" type="text" readonly
                                       style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                       value="${data.avgPercent}">
                            </td>
                        </tr>
                        <tr style="height:27px">
                            <td width="156" valign="middle" colspan="2" rowspan="6"
                                style="padding: 1px; border-left-width: 1px; border-left-color: rgb(255, 255, 255); border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style=";text-align:center;vertical-align:top">
                                    <strong>
                                        <span style="font-family: 宋体;font-size: 16px">卷面分析</span>
                                        <br><br>
                                        <span style="font-family: 宋体;font-size: 14px">（主要包括覆盖面，深广度、难度、效度、区分度、信度等方面）</span>
                                    </strong>
                                </p>
                            </td>
                            <td colspan="6" rowspan="6">
                                <textarea id="surfaceAnalysis" readonly
                                          style="height: 150px;background: transparent;border: none;color: #fff;font-size: 16px;">${data.surfaceAnalysis}</textarea>
                            </td>
                        </tr>
                        <tr style="height:27px"></tr>
                        <tr style="height:27px"></tr>
                        <tr style="height:27px"></tr>
                        <tr style="height:38px"></tr>
                        <tr style="height:4px"></tr>
                        <tr style="height:27px">
                            <td width="156" valign="middle" colspan="2" rowspan="6"
                                style="padding: 1px; border-left-width: 1px; border-left-color: rgb(255, 255, 255); border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style=";text-align:center;vertical-align:top">
                                    <strong><span style="font-family: 宋体;font-size: 16px">学生学习情况</span></strong>
                                </p>
                            </td>
                            <td width="427" valign="bottom" colspan="6" rowspan="6"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <textarea id="learningSituation" readonly
                                          style="height: 150px;background: transparent;border: none;color: #fff;font-size: 16px;">${data.learningSituation}</textarea>
                            </td>
                        </tr>
                        <tr style="height:27px"></tr>
                        <tr style="height:27px"></tr>
                        <tr style="height:27px"></tr>
                        <tr style="height:38px"></tr>
                        <tr style="height:4px"></tr>
                        <tr style="height:27px">
                            <td width="156" valign="middle" colspan="2" rowspan="6"
                                style="padding: 1px; border-left-width: 1px; border-left-color: rgb(255, 255, 255); border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <p style=";text-align:center;vertical-align:top">
                                    <strong><span style="font-family: 宋体;font-size: 16px">主要改进措施</span></strong>
                                </p>
                            </td>
                            <td width="427" valign="bottom" colspan="6" rowspan="6"
                                style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <textarea id="improvementMeasures" readonly
                                          style="height: 150px;background: transparent;border: none;color: #fff;font-size: 16px;">${data.improvementMeasures}</textarea>
                            </td>
                        </tr>
                        <tr style="height:27px"></tr>
                        <tr style="height:27px"></tr>
                        <tr style="height:27px"></tr>
                        <tr style="height:27px"></tr>
                        <tr style="height:27px"></tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="num1" value="${data.num90100}">
<input type="hidden" id="num2" value="${data.num8089}">
<input type="hidden" id="num3" value="${data.num7079}">
<input type="hidden" id="num4" value="${data.num6069}">
<input type="hidden" id="num5" value="${data.num59}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#teacherId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherId").val(ui.item.label);
                    $("#teacherId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'schoolYear', '${data.schoolYear}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " COURSE_ID",
                text: " COURSE_NAME ",
                tableName: "T_JW_COURSE",
                where: "  ",
                orderby: " "
            },
            function (data) {
                addOption(data, "courseId", '${data.courseId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " CLASS_ID",
                text: "CLASS_NAME",
                tableName: "T_XG_CLASS",
                where: "  ",
                orderby: " "
            },
            function (data) {
                addOption(data, "classId", '${data.classId}');
            });
        $.post("<%=request.getContextPath()%>/common/getSysDict", {
            name: 'KHFS',
            where: " dic_name in ('考试','考查')"
        }, function (data) {
            addOption(data, 'examNature', '${data.examNature}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JBKSLX", function (data) {
            addOption(data, 'examMode', '${data.examMode}');
        });
        xstb('<%=request.getContextPath()%>');
    })

    function printDate() {
        /*var print = "




        <%=request.getContextPath()%>/testPaperAnalysis/printTestPaperAnalysis?id=" + $("#id").val();
        var bdhtml = window.document.body.innerHTML;
        $.get(print, function (html) {
            window.document.body.innerHTML = html;
            window.print();
            window.document.body.innerHTML = bdhtml;
        })*/
        newWin = window.open("<%=request.getContextPath()%>/testPaperAnalysis/printTestPaperAnalysis?id=" + $("#id").val());
        newWin.document.body.innerHTML = html;
        newWin.print();
        window.close();
    }

    function xstb() {
        var num1 = $("#num1").val();
        var num2 = $("#num2").val();
        var num3 = $("#num3").val();
        var num4 = $("#num4").val();
        var num5 = $("#num5").val();
        var searchLogECharts = echarts.init(document.getElementById("searchLogECharts"));

        searchLogECharts.setOption({
            xAxis: {
                textStyle: {
                    color: '#fff'
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
                type: 'category',
                data: ['90~100', '80~89', '70~79', '60~69', '59以下']
            },
            yAxis: {
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
                type: 'value'
            },
            series: [{
                data: [num1, num2, num3, num4, num5],
                type: 'line'
            }]
        });
    }

</script>

