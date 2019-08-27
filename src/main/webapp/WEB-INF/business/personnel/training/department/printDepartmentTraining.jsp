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
    <div style="margin-left: 41%;margin-top: 5%;">
        <h3>${workflowName}</h3>
    </div>
    <tr>
        <td align="center"  class="left"  style="padding-left: 2%;text-align:center; width: 140px;">申请部门：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.requestDept}</td>
        <td align="center" class="left"  style="padding-left: 2%;text-align:center; width: 140px;">经办人：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.requester}</td>
    </tr>
    <tr>
        <td align="center" class="left"  style="padding-left: 2%;text-align:center; width: 140px;">申请日期：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.requestDate}</td>
        <td align="center" class="left" align="center"  style="padding-left: 2%;text-align:center; width: 140px;">当前审批状态：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${state}</td>

    </tr>
    <tr>
        <td align="center" class="left"  style="padding-left: 2%;text-align:center; width: 140px;">培训日期：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.trainingDate}</td>
        <td align="center"  class="left"  style="padding-left: 2%;text-align:center; width: 140px;">培训周期(天)：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.trainingDays}</td>
    </tr>
    <tr>
        <td align="center"  class="left"  style="padding-left: 2%;text-align:center; width: 140px;">培训地点：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.trainingPlace}</td>
        <td align="center"  class="left"  style="padding-left: 2%;text-align:center; width: 140px;">主办方：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.trainingOrganizers}</td>
    </tr>
    <tr>
        <td align="center" class="left"  style="padding-left: 2%;text-align:center; width: 140px;">项目/专业：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.trainingProject}</td>
        <td align="center"  class="left"  style="padding-left: 2%;text-align:center; width: 140px;">培训项目名称：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.trainingProjectName}</td>
    </tr>
    <tr>
        <td align="center"  class="left"  style="padding-left: 2%;text-align:center; width: 140px;">培训人数：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.trainingPeopleNumber}</td>
        <td align="center"  class="left"  style="padding-left: 2%;text-align:center; width: 140px;">费用(天/人)：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.trainingFee}</td>
    </tr>
    <tr>
        <td align="center"  class="left"  style="padding-left: 2%;text-align:center; width: 140px;">培训类别：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.trainingTypeShow}</td>
        <td align="center"  class="left"  style="padding-left: 2%;text-align:center; width: 140px;">培训目的：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${departmentTraining.trainingPurpose}</td>
    </tr>
</table>
<table border="1" cellpadding="0" cellspacing="0" style="margin-top: 0.13%;border-top:none;"   >
    <tr>
        <td class="left"  align="center" rowspan="${size+1}" style="padding-left: 1%;text-align:center;  width: 131px;">审<br>批<br>流<br>程</td>
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

