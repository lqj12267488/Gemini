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
<input id="approval" hidden value="${approval}"/>
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
    <style>
        .printBox {
            width: 300px;
            height: 300px;
            border: 1px solid blue;
        }
    </style>
    <!-- 打印的样式-->
    <style media="print">
        @page {
            size: auto;
            margin: 0mm;
        }
    </style>
</head>
<table border="1" cellpadding="0" cellspacing="0">
    <div>
        <h2 style="margin-left: 40%;">
            <%--<img src="<%=request.getContextPath()%>/libs/img/logodl.png" style="width: 50px; height: 50px;">&nbsp;&nbsp;--%><%=CommonBean.getParamValue("SZXXMC")%>
        </h2>
    </div>
    <div style="margin-left: 44%;margin-top: 5%;">
        <h3>${workflowName}</h3>
    </div>
    <tr>
        <td align="center" class="left" style="padding-left: 2%;text-align:center; width: 140px;" >申请部门：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${message.requestDept}</td>
        <td align="center" class="left" style="padding-left: 2%;text-align:center; width: 140px;" >申请人：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${message.requester}</td>
    </tr>
    <tr>
        <td align="center" class="left" style="padding-left: 2%;text-align:center; width: 140px;" >申请日期：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${message.publicTime}</td>
        <td align="center" class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">当前审批状态：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${state}</td>
    </tr>
    <tr>
        <td align="center" class="left" style="padding-left: 2%;text-align:center; width: 140px;" >类型：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${message.typeShow}</td>
        <td align="center" class="left" style="padding-left: 2%;text-align:center; width: 140px;" >标题：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${message.title}</td>

    </tr>
    <tr>
        <td align="center" class="left" style="padding-left: 2%;text-align:center; width: 140px;" >发送人员：</td>
        <td align="center" colspan="3">${message.empIdShow}</td>
    </tr>
    <tr>
        <td align="center" class="left" style="padding-left: 2%;text-align:center; width: 140px;" >发送部门：</td>
        <td align="center" colspan="3">${message.deptIdShow}</td>
    </tr>
    <tr>
        <td align="center" class="left" style="padding-left: 2%;text-align:center; width: 140px;" >内容：</td>
        <td align="center" colspan="3">${message.content}</td>
    </tr>
</table>
<c:if test="${approval == 0}">

  <table border="1" cellpadding="0" cellspacing="0" style="margin-top: 0.13%;border-top:none;"  >

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
            <td class="left1"  align="center">
                    ${index.handleName}
            </td>
            <td class="left1" align="center">
                    ${index.remark}
            </td>
            <td class="left1"  align="center">
                    ${index.handleTime}
            </td>
        </tr>
    </c:forEach>

</table>


</c:if>