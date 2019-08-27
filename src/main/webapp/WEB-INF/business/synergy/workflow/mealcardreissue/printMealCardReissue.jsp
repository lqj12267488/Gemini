<%@ page import="com.goisan.system.bean.CommonBean" %><%--q申请新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/18
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css">
        table {
            width: 100%;
            margin-top: 15%;
            border: 2px;
        }

        td {
            height: 40px;
        }

        .left {
            text-align: right;
        }

    </style>
</head>
<table>
    <h2 style="margin-left: 25%;"><%=CommonBean.getParamValue("SZXXMC")%>数字校园管理平台</h2>
    <div style="margin-left: 53%;margin-top: 10%;">
        <h3>饭卡补办证明</h3>
    </div>
    <div>
        <h5>&nbsp;&nbsp;</h5><br>
        <h5>&nbsp;&nbsp;</h5>
    </div>
    <div style="margin-left: 15%;">
        <h5>食堂管理员 ：</h5>
    </div>
    <div style="margin-left: 15%;">
        <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${data.deptId}   &nbsp;&nbsp;部门  &nbsp;&nbsp;
            ${data.teacherId}&nbsp;&nbsp;  老师由于饭卡遗失/损坏，需补办新卡，请协助补办。</h5>
    </div>
    <div style="margin-left: 15%;">
        <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;原卡待遇不变。请将原卡信息转移至新卡，原卡注销。</h5>
    </div>
    <div style="margin-left: 15%;">
        <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;谢谢。</h5>
    </div>
    <div>
        <h5>&nbsp;&nbsp;</h5>
    </div>
    <div style="margin-left: 60%">
        <h5>领导签字 ：${handleName}</h5>
    </div>
    <div>
        <h5>&nbsp;&nbsp;</h5><br>
        <h5>&nbsp;&nbsp;</h5>
    </div>
    <div style="margin-left: 73%;">
        <h5>${dept}</h5>
    </div>
    <div style="margin-left: 68%;">
        <h5>${mealCardDate}</h5>
    </div>
</table>

