<%@ page import="com.goisan.system.bean.CommonBean" %>
<%@ page import="com.goisan.logistics.assets.bean.AssetsDetails" %><%--q申请新增和修改界面
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
        <h2 align="center">${workflowName}</h2>
    </div>
    <tr>
        <td class="left"  align="center" style="padding-left: 2%;text-align:center; width: 140px;">资产购买时间：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${assetsDetails.buyTimeStr}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center; width: 140px;">资产分配时间：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${assetsDetails.useTimeStr}</td>
    </tr>
    <table border="1" cellpadding="0" cellspacing="0" style="margin-top: 0.13%;border-top:none;">
        <tr>
            <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">使用部门/使用人：</td>
            <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;">${deptName}</td>
        </tr>
    </table>


</table>

