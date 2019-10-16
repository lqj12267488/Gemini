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
        .left {
            font-size: 14pt;
            padding-left: 2%;
            text-align: left;
            float: left;
        }

        .right {
            background: #fff !important;
            font-size: 14pt;
            width: 280px;
            text-align: center;
            float: left;
            padding-left: 2%;
            display: inline-block;
            text-align: center;
            width: 140px;
            height: 25px;
            border-bottom: solid 2px #333
        }

        .clearBoth {
            clear: both;
            margin-bottom: 10px
        }

        .footTxt {
            float: right;
            padding-right: 3%;
            text-align: center;
        }
    </style>
</head>
<span class="left">编 号：${number}</span><br>
<div style="margin-left: 36%;margin-top: 5%;font-size:18pt">
    在读证明（存根）
</div>
<br>
<br>
<div class="clearBoth">
    <span class="left">学生姓名：</span>
    <span class="right" style="width:360px">${studentProve.studentId}</span>
    <span class="left">学号：</span>
    <span class="right" style="width:360px">${studentProve.studentNumber}</span>
</div>
<br>
<div class="clearBoth">
    <span class="left">就读专业：</span>
    <span class="right" style="width:360px">${studentProve.majorCode}</span>
    <span class="left">班级：</span>
    <span class="right" style="width:360px">${studentProve.classId}</span>
</div>
<br>
<div class="clearBoth">
    <span class="left">证明原因：</span>
    <span class="right" style="width:817px">${studentProve.proveReason}</span>
</div>
<br>
<div class="clearBoth">
    <span class="left">班主任签字：</span>
    <span class="right" style="width:320px">${departmentName}</span>
    <span class="left">经办人签字：</span>
    <span class="right" style="width:320px">${agent}</span>
</div>
<br>
<div class="clearBoth">
    <span class="left">学生处负责人签字：</span>
    <span class="right" style="width:500px">${departmentNameStudent}</span>
    <span class="left">日 期：</span>
    <span>${requestDate}</span>
</div>
<br>
<br>
<br>
<br>
<span class="left">编 号：${number}</span>
<br>
<div class="clearBoth">
    <div style="margin-left: 42%;font-size:24pt">
        证明
    </div>
    <br>
    <span class="right" style="margin-left:2%">${studentProve.receiveCompany}</span>:
</div>
<div class="clearBoth">
    <span class="left">该学生</span>
    <span class="right" style="width:500px">${studentProve.studentId}</span>
    <span class="left">，性别（${studentProve.sex}），现我院（${studentProve.classType}）</span>
</div>
<br>
<div class="clearBoth">
    <span class="right" style="margin-left:2%;width:400px">${grade}</span>
    <span class="left">级</span>
    <span class="right" style="width:360px">${studentProve.classId}</span>
    <span class="left">班学生</span>
</div>
<br>
<div class="clearBoth">
    <span class="left">学号：</span>
    <span class="right" style="width:340px">${studentProve.studentNumber}</span>
    <span class="left">，身份证号：</span>
    <span class="right" style="width:340px">${studentProve.idcard}</span>,
</div>
<br>
<div class="clearBoth">
    <span class="left">  学制${studentProve.maxYear}，学习期限从${studentProve.years}年 月至${studentProve.year}年 月。</span>
</div>
<br>
<div class="clearBoth">
    <span class="left" > 班主任：</span>
    <span class="right" style="border-bottom:none;width:360px">${studentProve.headTeacher}</span>
    <span class="left">  联系电话：</span>
    <span class="right" style="border-bottom:none;width:360px">${studentProve.tels}</span>
</div>
<br>
<div class="clearBoth">
    <span class="left"> 特此证明</span>
</div>
<div class="clearBoth footTxt" style="width: 220px;">
    <span align="right">新疆现代职业技术学院</span>
</div>
<div class="clearBoth footTxt" style="width: 220px;">
    <span align="right">学 生 处</span>
</div>
<div class="clearBoth footTxt" style="width: 220px;">
    <span align="right">${newDate}</span>
</div>