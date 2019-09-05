<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/mui.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
</head>
<body>
<header class="mui-bar mui-bar-nav">
    <span id="back" class=" mui-icon mui-icon-left-nav mui-pull-left" onclick="mui.back()" style="color:#fff;"></span>
    <h1 id="title" class="mui-title">电子档案信息管理</h1>
    <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>

</header>
<div class="mui-content"></div>
<div id="pullrefresh" class="mui-content mui-scroll-wrapper">
    <div class="mui-scroll">
        <%--  普通用户 --%>
        <%--<c:if test="${ptyh == 'true' && bmzr == 'false' && dagl == 'false' && xld == 'false'}">--%>
        <c:if test="${ptyh == 'true' || dagl=='true'}">
            <a href="<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType=11&ptyh=${ptyh}&bmzr=${bmzr}&dagl=${dagl}&xld=${xld}&dxz=${dxz}">
                <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
                    <li class="mui-table-view-cell ">
                        <h3 class="mui-ellipsis">
                            电子档案信息(普通用户)
                        </h3>
                    </li>
                </ul>
            </a>
        </c:if>
        <%--  部门主任  --%>
        <%--<c:if test="${(bmzr == 'true' || dagl == 'true') && xld == 'false' }">--%>
        <c:if test="${bmzr == 'true'}">
            <a href="<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType=12&ptyh=${ptyh}&bmzr=${bmzr}&dagl=${dagl}&xld=${xld}&dxz=${dxz}">
                <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
                    <li class="mui-table-view-cell ">
                        <h3 class="mui-ellipsis">
                            电子档案信息(部门主任)
                        </h3>
                    </li>
                </ul>
            </a>
        </c:if>
        <c:if test="${xld == 'true' || dxz=='true'}"><%--  校领导 大校长 --%>
            <a href="<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType=13&ptyh=${ptyh}&bmzr=${bmzr}&dagl=${dagl}&xld=${xld}&dxz=${dxz}">
            <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
                <li class="mui-table-view-cell ">
                    <h3 class="mui-ellipsis">
                        电子档案信息(校领导)
                    </h3>
                </li>
            </ul>
            </a>
        </c:if>
        <a href="<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType=14&ptyh=${ptyh}&bmzr=${bmzr}&dagl=${dagl}&xld=${xld}&dxz=${dxz}">
            <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
                <li class="mui-table-view-cell ">
                    <h3 class="mui-ellipsis">
                        个人电子档案回收站
                    </h3>
                </li>
            </ul>
        </a>
    </div>
</div>
</body>
</html>
<script>
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>