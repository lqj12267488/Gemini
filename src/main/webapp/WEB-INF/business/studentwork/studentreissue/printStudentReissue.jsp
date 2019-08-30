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
<table  border="1" cellpadding="0" cellspacing="0">
    <div>
        <h2 style="margin-left: 40%;">
            <%--<img src="<%=request.getContextPath()%>/libs/img/logodl.png" style="width: 50px; height: 50px;">&nbsp;&nbsp;--%><%=CommonBean.getParamValue("SZXXMC")%>
        </h2>
    </div>
    <div style="margin-left: 42%;margin-top: 5%;">
        <h2>${workflowName}</h2>
    </div>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;" >学籍号：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${studentReissue.studentNumber}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">系部：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${studentReissue.departmentsId}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;" >专业：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${studentReissue.majorCode}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">班级：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${studentReissue.classId}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;" >请假学生姓名：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${studentReissue.studentId}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">性别：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${studentReissue.sex}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;" >代申请部门：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${studentReissue.requestDept}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">代申请人：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${studentReissue.requester}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">申请时间：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${requestDate}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">请假开始时间：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${studentReissue.startTime}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">请假结束时间：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${studentReissue.endTime}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">请假天数：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${studentReissue.requestDays}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">请假类型：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${studentReissue.studentReissueType}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">请假原因：</td>
        <td align="center" colspan="3">${studentReissue.reason}</td>
    </tr>
</table>

