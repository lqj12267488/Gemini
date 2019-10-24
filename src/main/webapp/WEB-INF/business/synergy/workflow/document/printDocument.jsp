<%--q申请新增和修改界面
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
            background: #eeeeee !important;
        }

    </style>
</head>
<table border="1" cellpadding="0" cellspacing="0">
    <%--<div>
        <h2 style="margin-left: 40%;">
            &lt;%&ndash;<img src="<%=request.getContextPath()%>/libs/img/logodl.png" style="width: 50px; height: 50px;">&nbsp;&nbsp;白城职业技术学院&ndash;%&gt;
        </h2>
    </div>--%>
    <div style="margin-left: 30%;margin-top: 5%;">
        <h2>新疆现代职业技术学院发文单</h2>
    </div>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center; width: 140px;">签发：</td>
        <td align="center" class="left1" colspan="3"
            style="padding-left: 2%;text-align:center; width: 140px;">${remark}</td>
    </tr>
    <tr>
        <td class="left" style="padding-left: 2%;text-align:center; width: 140px;">会签：</td>
        <td align="center" class="left1" colspan="3" style="padding-left: 2%;text-align:center; width: 140px;">
            <c:forEach items="${handleList}" var="index">
                ${index.handleName}
                <br>
            </c:forEach>
        </td>

    </tr>
    <tr>
        <td class="left" style="padding-left: 2%;text-align:center; width: 140px;">文件标题：</td>
        <td align="center" class="left1" colspan="3"
            style="padding-left: 2%;text-align:center; width: 140px;">${document.fileTitle}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">主送：</td>
        <td align="center" class="left1" colspan="3"
            style="padding-left: 2%;text-align:center; width: 140px;">${document.deliveryEmpIdShow}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">抄送：</td>
        <td align="center" class="left1" colspan="3"
            style="padding-left: 2%;text-align:center; width: 140px;">${document.makeEmpIdShow}</td>
    </tr>
    <tr>
        <td class="left1" align="center" colspan="2" style="padding-left: 2%;text-align:center;  width: 140px;">
            新现代${document.symbol}号
        </td>
        <td class="left1" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">${handleTime}印发</td>
        <td class="left1" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">
            共印${document.printingNumber}份
        </td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">密级：</td>
        <td align="center" class="left1" colspan="3"
            style="padding-left: 2%;text-align:center; width: 140px;">${document.secretClassShow}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">拟稿：</td>
        <td align="center" class="left1"
            style="padding-left: 2%;text-align:center; width: 140px;">${document.requester}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">缓急程度：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center; width: 140px;"></td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">核稿：</td>
        <td align="center" class="left1"
            style="padding-left: 2%;text-align:center; width: 140px;">${heGao}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 140px;">校对：</td>
        <td align="center" class="left1"
            style="padding-left: 2%;text-align:center; width: 140px;">${jiaoDui}</td>
    </tr>
</table>

