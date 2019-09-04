<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <h1 id="title" class="mui-title">电子档案管理</h1>
    <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>

</header>
<div class="mui-content"></div>
<div id="pullrefresh" class="mui-content mui-scroll-wrapper">
    <div class="mui-scroll">
        <a href="<%=request.getContextPath()%>/archives/appArchivesInfo?menuType=1&ptyh=${ptyh}&bmzr=${bmzr}&dagl=${dagl}&xld=${xld}&dxz=${dxz}">
            <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
                <li class="mui-table-view-cell ">
                    <h3 class="mui-ellipsis">
                        电子档案信息管理
                    </h3>
                </li>
            </ul>
        </a>
        <c:if test="${bmzr == 'true' }">
            <a href="<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType=2&ptyh=${ptyh}&bmzr=${bmzr}&dagl=${dagl}&xld=${xld}&dxz=${dxz}">
                <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
                    <li class="mui-table-view-cell ">
                        <h3 class="mui-ellipsis">
                            电子档案变更审核
                        </h3>
                    </li>
                </ul>
            </a>
        </c:if>
        <a href="<%=request.getContextPath()%>/archives/searchArchives?ptyh=${ptyh}&bmzr=${bmzr}&dagl=${dagl}&xld=${xld}&dxz=${dxz}">
            <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
                <li class="mui-table-view-cell ">
                    <h3 class="mui-ellipsis">
                        电子档案查询管理
                    </h3>
                </li>
            </ul>
        </a>
        <c:if test="${dagl == 'true'}">
            <a href="<%=request.getContextPath()%>/archives/appArchivesLogList?menuType=4&ptyh=${ptyh}&bmzr=${bmzr}&dagl=${dagl}&xld=${xld}&dxz=${dxz}">
                <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
                    <li class="mui-table-view-cell ">
                        <h3 class="mui-ellipsis">
                            电子档案操作日志
                        </h3>
                    </li>
                </ul>
            </a>
        </c:if>
    </div>
</div>
</body>
</html>
<script>
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>