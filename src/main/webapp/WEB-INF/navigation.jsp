<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/9/29
  Time: 16:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>勾陈数字校园管理平台</title>
    <link href="<%=request.getContextPath()%>/libs/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath()%>/libs/css/stylesheets.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath()%>/libs/css/sweetalert.css" rel="stylesheet">
    <script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/jquery/jquery.min.js'></script>
    <script type='text/javascript' src="<%=request.getContextPath()%>/libs/js/sweetalert.min.js"></script>
</head>
<body>
<div class="ind">
    <div class="logo">
        <img src="<%=request.getContextPath()%>/libs/img/login/ind_pic_basic2.png"/>
    </div>
    <div style="float: right;margin-right: 20px;margin-top: 20px">
        <div style="position: absolute;top: 0;right: 0;margin-right: 20px;margin-top: 20px">
            <%--<c:if test="${sessionScope.casFlag=='true'}">--%>
                <%--<a class="icon-off" title="退出"--%>
                   <%--style="font-size: 21px;line-height: 32px;margin-right: 10px;"--%>
                   <%--href="http://localhost:8443/cas/logout">--%>
                <%--</a>--%>
            <%--</c:if>--%>
            <%--<c:if test="${sessionScope.casFlag=='false'}">--%>
                <a class="icon-off" title="退出"
                   style="font-size: 21px;line-height: 32px;margin-right: 10px;"
                   href="<%=request.getContextPath()%>/logout">
                </a>
            <%--</c:if>--%>
    </div>
    <div class="nr">
        <div class="earth">
            <img src="<%=request.getContextPath()%>/libs/img/login/ind_pic_08.png"/>
            <ul class="dnd">
                <li>
                    <a href=""></a>
                </li>
                <li><a href=""></a></li>
                <li><a href="http://www.bcvit.cn">门户网站平台</a></li>
                <li><a href=""></a></li>
                <li><a href=""></a></li>
                <li>
                    <shiro:hasPermission name="SYS:GLPT">
                        <a href="<%=request.getContextPath()%>/index?system=GLPT&id=001">管理平台</a>
                    </shiro:hasPermission>
                </li>
                <%--<li><a href="<%=request.getContextPath()%>/resourceLibrary/toIndex">资源平台</a></li>--%>
                <li><a href=""></a></li>
                <li><a href=""></a></li>
            </ul>
        </div>
    </div>
    <div class="foot">Copyright © 吉林省勾陈科技有限公司版权所有 .com All rights reserved</div>
</div>

<script>
    function message() {
        swal({
            title: "系统正在接入中……",
            type: "info"
        });
    }
</script>
<%--<div class="sj">
    <div class="logo1">
        <img src="/libs/img/login/logo1_03.png" />
    </div>
    <div class="nr1">
        <div class="earth">
            <ul class="mob">
                <li><a href="">门户平台</a></li>
                <li><a href="/index">数据交换平台</a></li>
                <li><a href="">辅助决策平台</a></li>
                <li><a href="">掌上校园</a></li>
                <li><a href="">资产管理系统</a></li>
                <li><a href="">财务管理系统</a></li>
                <li><a href="">办公OA系统</a></li>
                <li><a href="">教务管理系统</a></li>
            </ul>
        </div>
    </div>
    <div class="foot1">Copyright © 吉林省勾陈科技有限公司版权所有 .com All rights reserved</div>
</div>--%>
</body>
</html>
