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
    <div style="margin-left: 42%;margin-top: 5%;">
        <h2>${workflowName}</h2>
    </div>
    <tr>
        <td class="left"  align="center" style="padding-left: 2%;text-align:center; width: 140px;">申请部门：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${stamp.requestDept}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center; width: 140px;">申请人：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${stamp.manager}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">申请日期：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${requestDate}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">当前审批状态：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${state}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">合同类型：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${stamp.stampFlagShow}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">合同内容：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${stamp.contractDetails}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">备注：</td>
        <td colspan="3" align="center">${stamp.remark}</td>
    </tr>
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

