<%@ page import="com.goisan.system.bean.CommonBean" %><%--q申请新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/18
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        table {
            width: 98%;
            margin-top: 10%;
            border: solid 1px #000;
            margin-left: 1%;
        }

        td {
            height: 40px;
        }

        .left {
            text-align: right;
            background: #eeeeee!important;
        }

    </style>
</head>
<table border="1" cellpadding="0" cellspacing="0">
    <div>
        <h2 style="margin-left: 40%;">
            <%--<img src="<%=request.getContextPath()%>/libs/img/logodl.png" style="width: 50px; height: 50px;">&nbsp;&nbsp;--%><%=CommonBean.getParamValue("SZXXMC")%>
        </h2>
    </div>
    <div style="margin-left: 40%;margin-top: 5%;">
        <h2>${workflowName}</h2>
    </div>
    <tr>
        <td class="left"  align="center" style="padding-left: 2%;text-align:center; width: 140px;">授课开始时间：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.startTime}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center; width: 140px;">授课结束时间：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.endTime}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">系部名称：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.departmentsId}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">当前审批状态：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${state}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">计划名称：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.planName}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">专业名称：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.majorCode}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">课程名称：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.courseIdShow}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">课程类型：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.courseType}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">教材名称：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.textbookIdShow}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">创建年份：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.year}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">班级名称：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.className}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">学期：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.term}</td>
    </tr>
    <%--<tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">总学周：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.totalWeeks}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">总学时：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.totalHours}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">理论学周：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.theoreticalWeeks}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">实践教学学周：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.practiceWeeks}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">理论学时：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.theoreticalHours}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">实践教学学时：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.practiceHours}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">理论总学时：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.totalTheoreticalHours}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">实践教学总学时：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.totalPracticeHours}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">理实结合学时：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;" colspan="3">${teachingPlan.theoryPracticeHours}</td>

    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">周次：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.week}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">教学内容提要：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.content}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">实践上课地点：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.practicePlace}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">重点：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.focus}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">难点：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${teachingPlan.difficulty}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">作业：</td>
        <td align="center" class="left1"  align="center">${teachingPlan.homework}</td>
    </tr>--%>
</table>
<table border="1" cellpadding="0" cellspacing="0" style="margin-top: 0.13%;border-top:none;" >
    <tr>
        <td class="left"  align="center" rowspan="${size+1}"  style="padding-left: 1%;text-align:center;  width: 131px;">审批流程</td>
        <td class="left" style="padding-left: 1%;text-align:center;  width: 140px;">职务</td>
        <td class="left" style="padding-left: 1%;text-align:center;  width: 140px;">审批人</td>
        <td class="left" style="padding-left: 1%;text-align:center;  width: 140px;">审批意见</td>
        <td class="left" style="padding-left: 1%;text-align:center;  width: 140px;">审批时间</td>
    </tr>
    <c:forEach items="${handleList}" var="index">
        <tr>
            <td class="left1"  align="center">
                    ${index.handleRole}
            </td>
            <td class="left1" align="center">
                    ${index.handleName}
            </td>
            <td class="left1" align="center">
                    ${index.remark}
            </td>
            <td class="left1" align="center">
                    ${index.handleTime}
            </td>
        </tr>
    </c:forEach>
</table>
