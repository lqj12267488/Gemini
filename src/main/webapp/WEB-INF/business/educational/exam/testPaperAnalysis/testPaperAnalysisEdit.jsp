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
<div class="modal-dialog" style="width: 1000px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" style="background: rgba(0,0,0,.1);padding: 40px;">
                <div style="margin:auto;margin-bottom: 20px;">
                    <p style=";text-align:center;vertical-align:bottom;letter-spacing:18px;font-family: 宋体;font-size: 21px;font-weight: bold;">
                        <span style="">试卷分析单</span>
                    </p>
                    <p style=";text-align:center;vertical-align:bottom">
                        <strong style="font-family: 宋体;font-size: 21px">
                            <span>
                                <%--<input class="termInput" id="schoolYear" type="text" value="${data.schoolYear}"--%>
                                       <%--style="background: transparent;color: #fff; border: none; border-bottom: 2px solid #fff;"--%>
                                       <%--onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "--%>
                                       <%--maxlength="10">--%>
                                    <div class="form-row">
                                    <div class="col-md-1 tar">
                        学期
                    </div>
                    <div class="col-md-4">
                                    <select id="schoolYear"/>
                                    </div>

                                <%--学年度--%>
                            </span>
                            <%--<span style="margin-left: 20px;">第</span>--%>
                        </strong>
                        <%--<strong style="font-family: 宋体;font-size: 21px">--%>
                        <%--<span>--%>
                        <%--<input class="termInput" type="text" id="term" value="${data.term}"--%>
                        <%--style="background: transparent;color: #fff; border: none; border-bottom: 2px solid #fff;"--%>
                        <%--onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "--%>
                        <%--maxlength="1" placeholder="1位数字">--%>
                        <%--学期--%>
                        <%--</span>--%>
                        <%--</strong>--%>
                    </p>
                    <p style=";text-align:right;vertical-align:bottom">
                        <strong style="font-family: 宋体;font-size: 16px">
                            <span>
                                <input class="termInput" id="examYear" type="text" value="${data.examYear}"
                                       style="width: 80px;background: transparent;color: #fff; border: none; border-bottom: 2px solid #fff;"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                                       maxlength="4" placeholder="4位数字">
                                年
                            </span>
                            <span>
                                <input class="termInput" id="examMonth" type="text" value="${data.examMonth}"
                                       style="width: 40px;background: transparent;color: #fff; border: none; border-bottom: 2px solid #fff;"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                                       maxlength="2" placeholder="2位数字">
                                月
                            </span>
                            <span>
                                <input class="termInput" id="examDay" type="text" value="${data.examDay}"
                                       style="width: 40px;background: transparent;color: #fff; border: none; border-bottom: 2px solid #fff;"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "
                                       maxlength="2" placeholder="2位数字">
                                日
                            </span>
                        </strong>
                    </p>
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
                        <td width="20" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <%--<input id="courseId" type="text"--%>
                            <%--style="background: transparent;border: none;color: #fff;font-size: 16px;"--%>
                            <%--value="${data.courseId}">--%>
                            <select id="courseId"/>
                        </td>
                        <td width="20" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <p style="vertical-align: bottom">
                                <strong><span style="font-family: 宋体;font-size: 16px">考试班级</span></strong>
                            </p>
                        </td>
                        <td width="20" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <%--<input id="classId" type="text"--%>
                            <%--style="background: transparent;border: none;color: #fff;font-size: 16px;"--%>
                            <%--value="${data.classId}"></td>--%>
                            <select id="classId"/>
                        </td>
                        <td width="121" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <p style="vertical-align: bottom">
                                <strong><span style="font-family: 宋体;font-size: 16px">任课教师</span></strong>
                            </p>
                        </td>
                        <td width="121" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <c:if test="${data.id == null}">
                            <input id="teacherId" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.teacherIdShow}"></td>
                        </c:if>
                        <c:if test="${data.id != null}">
                            <input id="teacherId" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;" readonly
                                   value="${fn:split(data.teacherIdShow,' ---- ')[0]}"></td>
                        </c:if>
                        <input id="ter" hidden value="${data.teacherId}"/>
                        <input id="dep" hidden value="${data.teacherDeptId}"/>
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <p style="vertical-align: bottom">
                                <strong><span style="font-family: 宋体;font-size: 16px">考核方式</span></strong>
                            </p>
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <%--<input id="examNature" type="text" disabled--%>
                            <%--style="background: transparent;border: none;color: #fff;font-size: 16px;"--%>
                            <%--value="考试">--%>
                            <input id="examNature" readonly value="考试"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"/>
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
                            <%--<input id="examMode" type="text" disabled--%>
                            <%--style="background: transparent;border: none;color: #fff;font-size: 16px;"--%>
                            <%--value="笔试">--%>
                            <input id="examMode" readonly value="笔试"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"/>
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <p style="vertical-align: bottom">
                                <strong><span style="font-family: 宋体;font-size: 16px">考试时间</span></strong>
                            </p>
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="examTime" type="date"
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
                            <input id="examStunum" type="text"
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
                            <input id="missExamStunum" type="text"
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
                        <td width="142" valign="bottom" colspan="5"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="grdfl1" type="text"
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
                        <td width="142" valign="bottom" colspan="5"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="grdfl2" type="text"
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
                        <td width="142" valign="bottom" colspan="5"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="grdfl3" type="text"
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
                        <td width="142" valign="bottom" colspan="5"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="grdfl4" type="text"
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
                        <td width="142" valign="bottom" colspan="5"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="grdfl5" type="text"
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
                        <td width="142" valign="bottom" colspan="5"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="grdfl6" type="text"
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
                        <td width="142" valign="bottom" colspan="5"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="grdfl7" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.grdfl7}">
                        </td>
                    </tr>
                    <tr style="height:27px">
                        <td width="71" valign="bottom"
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
                        <td width="156" valign="middle" colspan="2" rowspan="7"
                            style="padding: 1px; border-left-width: 1px; border-left-color: rgb(255, 255, 255); border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <p style=";text-align:center;vertical-align:top">
                                <strong>
                                    <span style="font-family: 宋体;font-size: 16px">卷面分析</span>
                                    <br><br>
                                    <span style="font-family: 宋体;font-size: 14px">（主要包括覆盖面，深广度、难度、效度、区分度、信度等方面）</span>
                                </strong>
                            </p>
                        </td>
                        <td width="427" valign="bottom" colspan="6" rowspan="7"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <textarea id="surfaceAnalysis"
                                          style="height: 292px;background: transparent;border: none;color: #fff;font-size: 16px;">${data.surfaceAnalysis}</textarea>
                        </td>
                    </tr>
                    <tr style="height:27px">
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <p style="vertical-align: bottom">
                                <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">90~100</span>
                            </p>
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="num90_100" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.num90100}">
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="percent90_100" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.percent90100}">
                        </td>
                    </tr>
                    <tr style="height:27px">
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <p style="vertical-align: bottom">
                                <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">80~89</span>
                            </p>
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="num80_89" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.num8089}">
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="percent80_89" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.percent8089}">
                        </td>
                    </tr>
                    <tr style="height:27px">
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <p style="vertical-align: bottom">
                                <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">70~79</span>
                            </p>
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="num70_79" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.num7079}">
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="percent70_79" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.percent7079}">
                        </td>
                    </tr>
                    <tr style="height:27px">
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <p style="vertical-align: bottom">
                                <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">60~69</span>
                            </p>
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="num60_69" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.num6069}">
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="percent60_69" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.percent6069}">
                        </td>
                    </tr>
                    <tr style="height:27px">
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <p style="vertical-align: bottom">
                                <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">59及以下</span>
                            </p>
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="num59" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.num59}">
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="percent59" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.percent59}">
                        </td>
                    </tr>
                    <tr style="height:27px">
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <p style="vertical-align: bottom">
                                <span style="font-family: 宋体;font-size: 16px; font-weight: bold;">平均分</span>
                            </p>
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="avgNum" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.avgNum}">
                        </td>
                        <td width="71" valign="bottom"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <input id="avgPercent" type="text"
                                   style="background: transparent;border: none;color: #fff;font-size: 16px;"
                                   value="${data.avgPercent}">
                        </td>
                    </tr>
                    <tr style="height:27px">
                        <td width="156" valign="middle" colspan="2" rowspan="6"
                            style="padding: 1px; border-left-width: 1px; border-left-color: rgb(255, 255, 255); border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                            <p style=";text-align:center;vertical-align:top">
                                <strong><span style="font-family: 宋体;font-size: 16px">学生学习情况</span></strong>
                            </p>
                        </td>
                        <td width="427" valign="bottom" colspan="6" rowspan="6"
                            style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
                                <textarea id="learningSituation"
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
                                <textarea id="improvementMeasures"
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
    <div class="modal-footer">
        <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
        </button>
        <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
        </button>
    </div>
</div>
</div>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#teacherId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherId").val(ui.item.label.split(" ---- ")[0]);
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
        <%--$.post("<%=request.getContextPath()%>/common/getSysDict", {--%>
        <%--name: 'KHFS',--%>
        <%--where: " dic_name in ('考试','考查')"--%>
        <%--}, function (data) {--%>
        <%--addOption(data, 'examNature', '${data.examNature}');--%>
        <%--});--%>
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JBKSLX", function (data) {
            addOption(data, 'examMode', '${data.examMode}');
        });
    });


    function save() {
        var id = $("#id").val();
        var schoolYear = $("#schoolYear").val();
        // var term = $("#term").val();
        var examYear = $("#examYear").val();
        var examMonth = $("#examMonth").val();
        var examDay = $("#examDay").val();
        var courseId = $("#courseId").val();
        var classId = $("#classId").val();
        var teacher = $("#teacherId").val();
        var teacherId = "";
        var teacherDeptId = "";
        if (id == null || id == undefined || id == '') {
            var teacherIds = $("#teacherId").attr("keycode");
            if (teacherIds != null && teacherIds != "") {
                teacherId = teacherIds.split(",")[1];
                teacherDeptId = teacherIds.split(",")[0];
            }
        } else {
            teacherId = $("#ter").val();
            teacherDeptId = $("#dep").val();
        }

        var examNature = $("#examNature").val();
        var examMode = $("#examMode").val();
        var examTime = $("#examTime").val();
        var examStunum = $("#examStunum").val();
        var missExamStunum = $("#missExamStunum").val();
        var grdfl1 = $("#grdfl1").val();
        var grdfl2 = $("#grdfl2").val();
        var grdfl3 = $("#grdfl3").val();
        var grdfl4 = $("#grdfl4").val();
        var grdfl5 = $("#grdfl5").val();
        var grdfl6 = $("#grdfl6").val();
        var grdfl7 = $("#grdfl7").val();
        var surfaceAnalysis = $("#surfaceAnalysis").val();
        var learningSituation = $("#learningSituation").val();
        var improvementMeasures = $("#improvementMeasures").val();
        var num90_100 = $("#num90_100").val();
        var percent90_100 = $("#percent90_100").val();
        var num80_89 = $("#num80_89").val();
        var percent80_89 = $("#percent80_89").val();
        var num70_79 = $("#num70_79").val();
        var percent70_79 = $("#percent70_79").val();
        var num60_69 = $("#num60_69").val();
        var percent60_69 = $("#percent60_69").val();
        var num59 = $("#num59").val();
        var percent59 = $("#percent59").val();
        var avgNum = $("#avgNum").val();
        var avgPercent = $("#avgPercent").val();
        if (schoolYear == "" || schoolYear == undefined || schoolYear == null) {
            swal({
                title: "请填写学年！",
                type: "info"
            });
            return;
        }
        // if (term == "" || term == undefined || term == null) {
        //     swal({
        //         title: "请填写学期！",
        //         type: "info"
        //     });
        //     return;
        // }
        if (examYear == "" || examYear == undefined || examYear == null) {
            swal({
                title: "请填写年！",
                type: "info"
            });
            return;
        }
        if (examMonth == "" || examMonth == undefined || examMonth == null) {
            swal({
                title: "请填写月！",
                type: "info"
            });
            return;
        }
        if (examDay == "" || examDay == undefined || examDay == null) {
            swal({
                title: "请填写日！",
                type: "info"
            });
            return;
        }
        if (courseId == "" || courseId == undefined || courseId == null) {
            swal({
                title: "请填写考试学科！",
                type: "info"
            });
            return;
        }
        if (classId == "" || classId == undefined || classId == null) {
            swal({
                title: "请填写考试班级！",
                type: "info"
            });
            return;
        }
        if (id == null || id == undefined || id == '') {
            if (teacherIds == "" || teacherIds == undefined || teacherIds == null) {
                swal({
                    title: "请填写授课教师！",
                    type: "info"
                });
                return;
            }
        } else {
            if (teacher == "" || teacher == undefined || teacher == null) {
                swal({
                    title: "请填写授课教师！",
                    type: "info"
                });
                return;
            }
        }

        if (examNature == "" || examNature == undefined || examNature == null) {
            swal({
                title: "请填写考试性质！",
                type: "info"
            });
            return;
        }
        if (examMode == "" || examMode == undefined || examMode == null) {
            swal({
                title: "请填写考试形式！",
                type: "info"
            });
            return;
        }
        if (examTime == "" || examTime == undefined || examTime == null) {
            swal({
                title: "请选择考试时间！",
                type: "info"
            });
            return;
        }
        if (examStunum == "" || examStunum == undefined || examStunum == null) {
            swal({
                title: "请填写考试人数！",
                type: "info"
            });
            return;
        }
        if (missExamStunum == "" || missExamStunum == undefined || missExamStunum == null) {
            swal({
                title: "请填写缺考人数！",
                type: "info"
            });
            return;
        }
        if(surfaceAnalysis == "" || surfaceAnalysis == undefined || surfaceAnalysis == null){
            swal({
                title: "请填写卷面分析！",
                type: "info"
            });
            return;
        }
        if (learningSituation == "" || learningSituation == undefined || learningSituation == null) {
            swal({
                title: "请填写学生学习情况！",
                type: "info"
            });
            return;
        }
        if (improvementMeasures == "" || improvementMeasures == undefined || improvementMeasures == null) {
            swal({
                title: "请填写主要改进措施！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/testPaperAnalysis/saveTestPaperAnalysis", {
            id: id,
            schoolYear: schoolYear,
            examYear: examYear,
            examMonth: examMonth,
            examDay: examDay,
            // term: term,
            courseId: courseId,
            classId: classId,
            teacherId: teacherId,
            teacherDeptId: teacherDeptId,
            examNature: examNature,
            examMode: examMode,
            examTime: examTime,
            examStunum: examStunum,
            missExamStunum: missExamStunum,
            grdfl1: grdfl1,
            grdfl2: grdfl2,
            grdfl3: grdfl3,
            grdfl4: grdfl4,
            grdfl5: grdfl5,
            grdfl6: grdfl6,
            grdfl7: grdfl7,
            surfaceAnalysis: surfaceAnalysis,
            learningSituation: learningSituation,
            improvementMeasures: improvementMeasures,
            num90100: num90_100,
            percent90100: percent90_100,
            num8089: num80_89,
            percent8089: percent80_89,
            num7079: num70_79,
            percent7079: percent70_79,
            num6069: num60_69,
            percent6069: percent60_69,
            num59: num59,
            percent59: percent59,
            avgNum: avgNum,
            avgPercent: avgPercent
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            });
        })
    }
</script>


