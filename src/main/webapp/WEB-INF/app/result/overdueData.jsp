<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
</head>
<body>
<div class="mui-content">
    <header class="mui-bar mui-bar-nav">
        <span id="back" class="mui.back mui-icon mui-icon-left-nav mui-pull-left" onclick="backMain()" style="color:#fff;"></span>
        <h1 id="title" class="mui-title">当前任务已经超期</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <div class=""></div>
    <div id="pullrefresh" class="mui-scroll-wrapper">
        <div class="mui-scroll">
            <!--数据列表-->
            <div style="text-align: center">
                <a class="mui-icon mui-icon-info" style="font-size:6em;"></a><br/>
                当前任务已经超期
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/mui.js"></script>
<script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
<script type="text/javascript">
    var eType =  '${evaluationType}';

    $(document).ready(function () {
        window.setTimeout(backMain,5000);
    })

    function backMain() {
        window.location.href =
            "<%=request.getContextPath()%>/evaluationApp/result/listTask?evaluationType="+eType;
    }

</script>
</html>
