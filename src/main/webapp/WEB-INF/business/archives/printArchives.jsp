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
        <h2>电子档案信息</h2>
    </div>
    <tr >
        <td align="center"  class="left" style="padding-left: 2%;text-align:center; width: 140px;">创建部门</td>
        <td align="center"  class="left" style="padding-left: 2%;text-align:center; width: 140px;">创建人</td>
        <td class="left"   align="center" style="padding-left: 2%;text-align:center;  width: 140px;">档案编码</td>
        <td class="left"  align="center" style=" padding-left: 2%;text-align:center; width: 140px;">一级类别</td>
        <td class="left"  align="center" style="padding-left: 2%;text-align:center;  width: 140px;">二级类别</td>
        <td class="left"  align="center" style="padding-left: 2%;text-align:center;  width: 140px;">档案类型</td>
        <td class="left"  align="center" style="padding-left: 2%;text-align:center;  width: 140px;">档案说明</td>
    </tr>
    <c:forEach items="${list}" var="index">
        <tr>
            <td class="left1"  align="center">
                    ${index.createDept}
            </td>
            <td class="left1"  align="center">
                    ${index.creator}
            </td>
            <td class="left1"  align="center">
                    ${index.archivesCode}
            </td>
            <td  class="left1" align="center">
                    ${index.oneLevel}
            </td>
            <td  class="left1" align="center">
                    ${index.twoLevel}
            </td>
            <td  class="left1" align="center">
                    ${index.fileType}
            </td>
            <td  class="left1" align="center">
                    ${index.remark}
            </td>
        </tr>
    </c:forEach>
</table>
<script>
    var listTable;
    $(document).ready(function () {
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/archives/getLeaderArchivesList'
            },
            "destroy": true,
            "columns": [
                {"data": "archivesId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "createDept", "title": "创建部门"},
                {"width": "10%", "data": "creator", "title": "创建人"},
                {"width": "10%", "data": "archivesCode", "title": "档案编码"},
                {"width": "10%", "data": "oneLevel", "title": "一级类别"},
                {"width": "10%", "data": "twoLevel", "title": "二级类别"},
                {"width": "10%", "data": "fileType", "title": "档案类型"},
                {"width": "10%", "data": "remark", "title": "档案说明"},
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    })
</script>
