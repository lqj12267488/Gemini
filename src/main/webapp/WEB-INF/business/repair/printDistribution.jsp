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
            border-collapse: collapse;
            bgcolor:#fff;
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
<table border="1" bgcolor="#fff">
    <div>
        <h2 style="margin-left: 40%;">
            <%--<img src="<%=request.getContextPath()%>/libs/img/logodl.png" style="width: 50px; height: 50px;">&nbsp;&nbsp;--%><%=CommonBean.getParamValue("SZXXMC")%>
        </h2>
    </div>
    <div style="margin-left: 45%;margin-top: 5%;">
        <h2>维修派单信息</h2>
    </div>
    <tr >
        <td align="center"  class="left" style="padding-left: 2%;text-align:left; width: 140px;">报修人</td>
        <td style="text-align:center" colspan="3">${repair.creator}</td>
    </tr>

    <tr>
        <td align="center"  class="left" style="padding-left: 2%;text-align:left; width: 140px;">报修时间</td>
        <td style="text-align:center" colspan="3">${repair.submitTime}</td>
    </tr>

    <tr>
        <td class="left"   align="center" style="padding-left: 2%;text-align:left;  width: 140px;">报修物品名称</td>
        <td style="text-align:center" colspan="3">${repair.itemNameShow}</td>
    </tr>

    <tr>
        <td class="left"  align="center" style=" padding-left: 2%;text-align:left; width: 140px;">维修地址</td>
        <td style="text-align:center" colspan="3">${repair.repairAddress}</td>
    </tr>

    <tr>
        <td class="left"  align="center" style="padding-left: 2%;text-align:left;  width: 140px;">故障描述</td>
        <td style="text-align:center" colspan="3">${repair.faultDescription}</td>
    </tr>

    <tr>
        <td class="left"  align="center" style="padding-left: 2%;text-align:left;  width: 140px;">联系人电话</td>
        <td style="text-align:center" colspan="3">${repair.contactNumber}</td>
    </tr>

    <tr>
        <td class="left"  align="center" style="padding-left: 2%;text-align:left;  width: 140px;">派单人</td>
        <td style="text-align:center" colspan="3">${repair.sysName}</td>
    </tr>

    <tr>
        <td class="left"  align="center" style="padding-left: 2%;text-align:left;  width: 140px;">派单时间</td>
        <td style="text-align:center" colspan="3">${repair.assignTime}</td>
    </tr>

    <tr>
        <td class="left"  align="center" style="padding-left: 2%;text-align:left;  width: 140px;">维修人</td>
        <td style="text-align:center" colspan="3">${repair.personIdShow}</td>
    </tr>

</table>
