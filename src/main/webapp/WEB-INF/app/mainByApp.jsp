<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.goisan.system.bean.CommonBean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title><%=CommonBean.getParamValue("SZXXMC")%>&nbsp;&nbsp;</title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <!--标准mui.css-->
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.min.css" rel="stylesheet"/>
    <!--App自定义的css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/libs/css/app/app.css"/>
    <style>
        .mui-android header.mui-bar {
            display: block;
        }
    </style>
</head>
<body>
<header class="mui-bar mui-bar-nav">
    <h1 class="mui-title"><%=CommonBean.getParamValue("SZXXMC")%>&nbsp;&nbsp;</h1>
    <a href="<%=request.getContextPath()%>/logout"><span class="mui-icon  mui-pull-right"
                            style="font-size:13px;line-height:30px;color:#fff;font-family:'Microsoft YaHei'">退出</span></a>
</header>
<div id="slider" class="mui-slider">
    <div class="mui-slider-group mui-slider-loop">
        <!-- 额外增加的一个节点(循环轮播：第一个节点是最后一张轮播) -->
        <div class="mui-slider-item mui-slider-item-duplicate">
            <a href="#">
                <img src="<%=request.getContextPath()%>/libs/img/app/bg.jpg">
            </a>
        </div>
        <!-- 第一张 -->
        <div class="mui-slider-item">
            <a href="#">
                <img src="<%=request.getContextPath()%>/libs/img/app/item1.jpg">
            </a>
        </div>
        <!-- 第二张 -->
        <div class="mui-slider-item">
            <a href="#">
                <img src="<%=request.getContextPath()%>/libs/img/app/item2.jpg">
            </a>
        </div>
        <!-- 第三张 -->
        <div class="mui-slider-item">
            <a href="#">
                <img src="<%=request.getContextPath()%>/libs/img/app/item3.jpg">
            </a>
        </div>
        <!-- 第四张 -->
        <div class="mui-slider-item">
            <a href="#">
                <img src="<%=request.getContextPath()%>/libs/img/app/item4.jpg">
            </a>
        </div>
        <!-- 额外增加的一个节点(循环轮播：最后一个节点是第一张轮播) -->
        <%--<div class="mui-slider-item mui-slider-item-duplicate">
            <a href="#">
                <img src="./images/shuijiao.jpg">
            </a>
        </div>--%>
    </div>
    <div class="mui-slider-indicator"></div>
</div>
<div>
    <h5><b>&nbsp;&nbsp;&nbsp;${name}</b></h5>
</div>
<div id="Gallery" class="mui-slider">
    <div class="mui-slider-group">
        <div class="mui-slider-item">
            <ul class="mui-table-view mui-grid-view mui-grid-9">
                <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <a href="<%=request.getContextPath()%>/notice/messageApp">
                        <span class="mui-icon mui-icon-home">
                            <span style="display: none" id="notDoCountSpan" class="mui-badge">${notDoCount}</span>
                        </span>
                        <div class="mui-media-body">查通知</div>
                    </a>
                </li>
                <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <a href="<%=request.getContextPath()%>/notice/bulletinApp">
                        <span class="mui-icon mui-icon-chatbubble">
                            <span style="display: none" id="bulDoCountSpan" class="mui-badge">${bulDoCount}</span>
                        </span>
                        <div class="mui-media-body">查公告</div>
                    </a>
                </li>
                <c:if test="${userType == '0'}">
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                        <a href="<%=request.getContextPath()%>/salaryApp/result/listUnDo?type=0">
                            <span class="mui-icon mui-icon-bars"></span>
                            <div class="mui-media-body">工资单查看</div>
                        </a>
                    </li>
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                        <a href="<%=request.getContextPath()%>/workflowApp/result/listStart">
							<span class="mui-icon mui-icon-star">
								<span style="display: none" id="application" class="mui-badge">${application}</span>
							</span>
                            <div class="mui-media-body">业务申请</div>
                        </a>
                    </li>
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                        <a href="<%=request.getContextPath()%>/workflowApp/result/listUnDo?type=0">
							<span class="mui-icon mui-icon-undo">
								<span style="display: none" id="unDoCountSpan" class="mui-badge">${unDoCount}</span>
							</span>
                            <div class="mui-media-body">审批待办</div>
                        </a>
                    </li>
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                        <a href="<%=request.getContextPath()%>/workflowApp/result/listUnDo?type=1">
							<span class="mui-icon mui-icon-redo">
								<span style="display: none"  class="mui-badge"></span>
							</span>
                            <div class="mui-media-body">审批已办</div>
                        </a>
                    </li>
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                        <a href="<%=request.getContextPath()%>/txl/result/listResult">
							<span class="mui-icon mui-icon-phone">
								<span style="display: none" id="txlSpan" class="mui-badge"></span>
							</span>
                            <div class="mui-media-body">通讯录</div>
                        </a>
                    </li>
                </c:if>
                <%--<li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    &lt;%&ndash;<a href="/evaluationApp/result/listEmpsMenmbers">&ndash;%&gt;
                    <a href="<%=request.getContextPath()%>/evaluationApp/result/listTask?evaluationType=0">
									<span class="mui-icon mui-icon-loop">
										<span style="display: none" id="emCountSpan" class="mui-badge">${emCount}</span>
									</span>
                        <div class="mui-media-body">教师考核</div>
                    </a>
                </li>--%>
               <%-- <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <a href="<%=request.getContextPath()%>/evaluationApp/result/listTask?evaluationType=1">
									<span class="mui-icon mui-icon-spinner mui-spin">
										<span style="display: none" id="smCountSpan" class="mui-badge">${smCount}</span>
									</span>
                        <div class="mui-media-body">学生考核</div>
                    </a>
                </li>--%>

                <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <a href="<%=request.getContextPath()%>/repair/toAddRepairApp">
							<span class="mui-icon mui-icon-gear">
								<span style="display: none" class="mui-badge"></span>
							</span>
                        <div class="mui-media-body">设备报修</div>
                    </a>
                </li>
                <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <a href="<%=request.getContextPath()%>/repairTaskApp/result">
                        <span class="mui-icon mui-icon-list"></span>
                        <div class="mui-media-body">维修任务分配</div>
                    </a>
                </li>
                <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <a href="<%=request.getContextPath()%>/repair/repairApp2?flag=1">
                        <span class="mui-icon mui-icon-list"></span>
                        <div class="mui-media-body">后勤维修</div>
                    </a>
                </li>
                <c:if test="${userType == '0'}">
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                        <a href="<%=request.getContextPath()%>/repair/repairApp">
                            <span class="mui-icon mui-icon-info"></span>
                            <div class="mui-media-body">报修查询</div>
                        </a>
                    </li>
                </c:if>
               <%-- <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <a href="<%=request.getContextPath()%>/enrollmentApp/index">
                        <span class="mui-icon mui-icon-info"></span>
                        <div class="mui-media-body">招生管理</div>
                    </a>
                </li>
                <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <a href="<%=request.getContextPath()%>/attendanceApp/result/listAttendance?type=0">
                        <span class="mui-icon mui-icon-list"></span>
                        <div class="mui-media-body">考勤信息查看</div>
                    </a>
                </li>--%>

                <%--微信主页面--%>
                <%--考勤--%>
                <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <a href="<%=request.getContextPath()%>/app/studentAttendance/index">
                        <span class="mui-icon mui-icon-chatbubble">
                            <span style="display: none" class="mui-badge">${bulDoCount}</span>
                        </span>
                        <div class="mui-media-body">学生考勤</div>
                    </a>
                </li>

                <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <a id="scanCode">
                        <span class="mui-icon mui-icon-chatbubble">
                            <span style="display: none" class="mui-badge">${bulDoCount}</span>
                        </span>
                        <div class="mui-media-body">签到</div>
                    </a>
                </li>
               <%-- <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">
                    <a href="<%=request.getContextPath()%>/archives/appArchivesList">
                        <span class="mui-icon mui-icon-chatbubble">
                            <span style="display: none" id="archivesCountSpan" class="mui-badge">${archivesCount}</span>
                        </span>
                        <div class="mui-media-body">电子档案</div>
                    </a>
                </li>--%>
            </ul>
        </div>
    </div>
</div>

<%--<div class="mui-content">
    <div class="mui-content-padded">
        <h5>最新公告</h5>
    </div>
    <ul id="list1" class="mui-table-view mui-table-view-striped mui-table-view-condensed">
    </ul>

</div>

<div class="mui-content">
    <div class="mui-content-padded">
        <h5>最新通知</h5>
    </div>
    <ul id="list2" class="mui-table-view mui-table-view-striped mui-table-view-condensed">
    </ul>
</div>--%>
<script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
<script src="<%=request.getContextPath()%>/libs/js/app/jquery.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.4.0.js"></script>
</body>

</html>
<script type="text/javascript" charset="utf-8">
    var emCount =${emCount};
    if (emCount != "0") {
        document.getElementById('emCountSpan').style.display = "block";
    }
    var smCount =${smCount};
    if (smCount != "0") {
        document.getElementById('smCountSpan').style.display = "block";
    }
    var unDoCount ='${unDoCount}';
    if (unDoCount != "0") {
        document.getElementById('unDoCountSpan').style.display = "block";
    }
    var unDoCount =${unDoCount};
    if (unDoCount != "0") {
        document.getElementById('unDoCountSpan').style.display = "block";
    }
    /*通知*/
    var notDoCount ='${notDoCount}';
    if (notDoCount != "0") {
        document.getElementById('notDoCountSpan').style.display = "block";
    }
    /*公告*/
    var bulDoCount ='${bulDoCount}';
    if (bulDoCount != "0") {
        document.getElementById('bulDoCountSpan').style.display = "block";
    }

    mui.init({
        swipeBack: false//启用右滑关闭功能

    });
    $(document).ready(function () {
        mui("#slider").slider({
            interval: 5000
        });

        $.get("<%=request.getContextPath()%>/teach/getConfig", function (data) {
            wx.config(data);
        });

        // wx.error(function (res) {
        //     alert("出错了：" + res.errMsg);//这个地方的好处就是wx.config配置错误，会弹出窗口哪里错误，然后根据微信文档查询即可。
        // });
        $("#scanCode").bind("click", function () {
            wx.scanQRCode({
                needResult: 1,
                scanType: ['qrCode'],
                success: function (res) {
                    $.post("<%=request.getContextPath()%>/teach/saveTaskLog", {resultStr: res.resultStr}, function (data) {
                        alert(data.msg)
                    });
                },
                fail: function (res) {
                    alert("签到失败！")
                }
            });
        })

    });

    /*var x =${gglist};

    $(document).ready(function () {
        var table = document.getElementById("list1");
        $.each(arrays, function (key, map) {
            var li = document.createElement('li');
            li.className = 'mui-table-view-cell';
            li.innerHTML = '<a open-type="common" href="./gg/viewggdetail?tzid=' + map.ID + '"><div class="mui-table">' +
                '<div class="mui-table-cell mui-col-xs-10">' +
                '<h4 class="mui-ellipsis">' + map.BT + '</h4><h5>发布人：' + map.FBR + '</h5>' +
                '<p class="mui-h6 mui-ellipsis">' + map.XXNR + '</p>' +
                '</div>' +
                '<div class="mui-table-cell mui-col-xs-2 mui-text-right">' +
                '<span class="mui-h5">' + map.FBSJ + '</span>' +
                '</div>' +
                '</div></a>';
            table.appendChild(li);
        });
        var table2 = document.getElementById("list2");
        $.each(arrays2, function (key, map) {
            var li = document.createElement('li');
            li.className = 'mui-table-view-cell';
            li.innerHTML = '<a open-type="common" href="./tz/viewtzdetail?tzid=' + map.ID + '"><div class="mui-table">' +
                '<div class="mui-table-cell mui-col-xs-10">' +
                '<h4 class="mui-ellipsis">' + map.NOTICE_TITLE + '</h4><h5>发布人：' + map.RYXM + '</h5>' +
                '<p class="mui-h6 mui-ellipsis">' + map.XXNR + '</p>' +
                '</div>' +
                '<div class="mui-table-cell mui-col-xs-2 mui-text-right">' +
                '<span class="mui-h5">' + map.FBSJ + '</span>' +
                '</div>' +
                '</div></a>';
            table2.appendChild(li);
        });
    })*/
</script>
