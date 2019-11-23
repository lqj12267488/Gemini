<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <jsp:include page='include.jsp'/>
    <script type='text/javascript'
            src='<%=request.getContextPath()%>/libs/js/plugins/echarts/myIndex_echarts.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/Commons.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/jquery.mousewheel.min.js"></script>
</head>
<body class="${siteBackground}" style="margin: 6px 0 0 0">
<div class="${empty siteContainer?'container':siteContainer}" style="height: 100%">
    <div class="row">
        <div class="col-md-12">
            <nav class="navbar brb" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse"
                            data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-reorder"></span>
                    </button>
                    <a class="navbar-brand" href="<%=request.getContextPath()%>/index?system=${system}&id=${systemId}">
                        <img src="<%=request.getContextPath()%>/libs/img/logo.png"/>
                    </a>
                </div>
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav">
                        <li class="dropdown">
                            <a href="#" style="font-size: 12px"
                               onclick="changeMenu('0','<%=request.getContextPath()%>/index?system=${system}&id=${systemId}')"><span
                                    class="icon-home"></span>首页</a>
                        </li>
                    </ul>
                    <div class="collapse navbar-collapse navbar-ex1-collapse">
                        <div class="img-scroll">
                            <button class="prev"><span class="icon-chevron-left"></span></button>
                            <button class="next"><span class="icon-chevron-right"></span></button>
                            <div class="img-list">
                                <ul class="nav navbar-nav">
                                    <c:forEach items="${menus}" var="menu">
                                        <li class="dropdown">
                                            <a href="#" style="font-size: 12px"
                                               onclick="changeMenu('${menu.resourceid}','${menu.resourceurl}')"><span
                                                    class="icon-home"></span>${menu.resourcename}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    <div class="navbar-form navbar-right">
                        <div class="form-group">
                            <c:if test="${loginFlag == '1'}">
                                <a class="icon-off" title="退出"
                                   style="font-size: 21px;line-height: 32px;margin-right: 10px;"
                                   href="<%=request.getContextPath()%>/navigation"></a>
                            </c:if>
                            <c:if test="${loginFlag != '1'}">
                                <a class="icon-off" title="退出"
                                   style="font-size: 21px;line-height: 32px;margin-right: 10px;"
                                   href="<%=request.getContextPath()%>/logout"></a>
                            </c:if>
                        </div>
                    </div>
                </div>
                </div>

            </nav>


        </div>
    </div>
    <div id="main">
        <div class="row">
            <div class="col-md-2">
                <!--设置背景开始-->
                <div class="site-settings">
                    <div class="site-settings-button"><span class="icon-cog"></span></div>
                    <div class="site-settings-content">
                        <div class="block block-transparent nm">
                            <div class="header">
                                <h2>Themes</h2>
                            </div>
                            <div class="content controls">
                                <div class="form-row">
                                    <div class="col-md-12">
                                        <a class="ss_theme bg-default" data-value="default"></a>
                                        <a class="ss_theme theme-black" data-value="theme-black"></a>
                                        <a class="ss_theme theme-white" data-value="theme-white"></a>
                                        <a class="ss_theme theme-dark" data-value="theme-dark"></a>
                                        <a class="ss_theme theme-green" data-value="theme-green"></a>
                                    </div>
                                </div>
                            </div>
                            <div class="header">
                                <h2>Backgrounds</h2>
                            </div>
                            <div class="content controls">
                                <div class="form-row">
                                    <div class="col-md-12" id="ss_backgrounds"></div>
                                </div>
                            </div>
                            <div class="header">
                                <h2>Wallpapers</h2>
                            </div>
                            <div class="content controls">
                                <div class="form-row">
                                    <div class="col-md-12">
                                        <a class="ss_background wall-num1" data-value="wall-num1"></a>
                                        <a class="ss_background wall-num2" data-value="wall-num2"></a>
                                        <a class="ss_background wall-num3" data-value="wall-num3"></a>
                                        <a class="ss_background wall-num4" data-value="wall-num4"></a>
                                        <a class="ss_background wall-num5" data-value="wall-num5"></a>
                                        <a class="ss_background wall-num6" data-value="wall-num6"></a>
                                        <a class="ss_background wall-num7" data-value="wall-num7"></a>
                                        <a class="ss_background wall-num8" data-value="wall-num8"></a>
                                        <a class="ss_background wall-num9" data-value="wall-num9"></a>
                                        <a class="ss_background wall-num10" data-value="wall-num10"></a>
                                        <a class="ss_background wall-num11" data-value="wall-num11"></a>
                                        <a class="ss_background wall-num12" data-value="wall-num12"></a>
                                        <a class="ss_background wall-num13" data-value="wall-num13"></a>
                                        <a class="ss_background wall-num14" data-value="wall-num14"></a>
                                        <a class="ss_background wall-num15" data-value="wall-num15"></a>
                                        <a class="ss_background wall-num16" data-value="wall-num16"></a>
                                    </div>
                                </div>
                            </div>
                            <div class="header">
                                <h2>Layout</h2>
                            </div>
                            <div class="content controls">
                                <div class="form-row">
                                    <div class="col-md-6">
                                        <div class="checkbox">
                                            <label><input type="radio" name="layout" value="liquid" class="ss_layout"/>
                                                Liquid</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="checkbox">
                                            <label><input type="radio" name="layout" value="fixed" class="ss_layout"/>
                                                Fixed</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--设置背景结束-->
                <div class="block block-drop-shadow"><%--/showPhotoByPersonid?personid=${personId}--%>
                    <div class="user bg-default bg-light-rtl">
                        <div class="info">
                            <input id="loginpersonId" type="hidden" value="${personId}"/>
                            <img src="<%=request.getContextPath()%>/userImg/${photoUrl}" height="200"
                                 width="200"
                                 class="img-circle img-thumbnail" onclick="chengePhoto()"/>
                        </div>
                    </div>
                    <div class="head bg-dot20">
                        <div id="hello" class="head-subtitle"></div>
                        <div id="thisdapt" class="head-subtitle"></div>
                        <div id="staffId" class="head-subtitle"></div>
                        <div id="deptvalue" class="head-subtitle"></div>
                    </div>
                </div>
                <div class="block block-drop-shadow">
                    <div class="content list-group list-group-icons">
                        <a href="#" class="list-group-item" onclick="chengeEmpEdit()" id="EmpEdit">
                            <span class="icon-user"></span>个人基本信息管理
                        </a>
                        <a href="#" class="list-group-item" onclick="chengeLoginPwd()">
                            <span class="icon-key"></span>登录密码修改
                        </a>
                        <a href="#" class="list-group-item" onclick="changeDept()"
                           id="loginDeptList">
                            <span class="icon-sitemap"></span>
                            部门切换
                        </a>
                        <div id="menuList"></div>
                        <a class="list-group-item" href="<%=request.getContextPath()%>/logout">
                            <span class="icon-off"></span>退出系统
                        </a>
                    </div>
                </div>
                <div class="block block-drop-shadow">
                    <div class="header">
                        <h2>天气预报</h2>
                    </div>
                    <div class="head bg-dot20 content">
                        <iframe allowtransparency="true" frameborder="0" width="200" height="270" scrolling="no" src="//tianqi.2345.com/plugin/widget/index.htm?s=1&z=1&t=1&v=1&d=3&bd=0&k=000000&f=ffffff&ltf=009944&htf=cc0000&q=1&e=1&a=1&c=54511&w=200&h=270&align=center"></iframe>
                    </div>
                    <%--
                                        <div class="header">
                                            <div class="side pull-right">
                                                <ul class="buttons">
                                                    <li><a href="#" onclick="LoginOrder()"><span
                                                            class="icon-refresh"></span></a></li>
                                      getList          </ul>
                                            </div>
                                        </div>
                                        <div class="head bg-dot20 content">
                                            <div class="messages-item" id="usrslog" >
                                            </div>
                                        </div>
                    --%>
                </div>
            </div>
            <div id="mainRight">
                <div class="col-md-5">
                    <div class="block block-drop-shadow">
                        <div class="header">
                            <h2>通知公告</h2>
                            <div class="side pull-right">
                                <ul class="buttons">
                                    <%--<li><a href="#"><span class="icon-cogs"></span></a></li>--%>
                                    <li><a href="#" onclick="loadnotice()"><span class="icon-refresh"></span></a></li>
                                </ul>
                            </div>
                            <div class="side pull-right">
                                <ul class="buttons">
                                    <li><a href="#" onclick="loadMoreNotice()">更多</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="head bg-dot30" id="indexNList" style="width: 100%;height:300px;">
                        </div>
                    </div>
                    <div class="block block-drop-shadow">
                        <div class="head bg-dot20">
                            <div id="eChartsP" style="width: 100%;height:330px;"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-5">
                    <div class="block block-drop-shadow">
                        <div class="header">
                            <h2>待办事项</h2>
                            <div class="side pull-right">
                                <ul class="buttons">
                                    <li><a href="#" onclick="loadunAudit()"><span
                                            class="icon-refresh"></span></a></li>
                                </ul>
                            </div>
                            <div class="side pull-right">
                                <ul class="buttons">
                                    <%--<li><a href="#"><span class="icon-cogs"></span></a></li>--%>
                                    <li><a href="#" onclick="loadMoreAudit()">更多</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="head bg-dot30" id="unAudit" style="width: 100%;height:300px;">
                        </div>
                    </div>

                    <div class="block block-drop-shadow">
                        <div class="head bg-dot20">
                            <div class="head-panel nm" style="width: 100%;height:330px;"
                                 id="dateCalendar">
                            </div>
                        </div>
                    </div>
                    <%--
                                    <div class="block block-drop-shadow">
                                        <div class="head bg-dot30" style="height: 70px;">
                                            <iframe allowtransparency="true" frameborder="0" width="550" height="64"
                                                    scrolling="no"
                                                    src="//tianqi.2345.com/plugin/widget/index.htm?s=2&z=1&t=1&v=2&d=3&bd=0&k=&f=ffffff&q=1&e=1&a=1&c=54662&w=565&h=64&align=center"></iframe>
                                        </div>
                                    </div>
                    --%>
                </div>
            </div>
            <%--<div id="right" class="col-md-10">--%>
            <%--</div>--%>
        </div>
    </div>
</div>
<div class="foot" style="text-align: center">技术支持：天眼（深圳）光学技术发展有限公司</div>
<div class="modal modal-draggable" id="audit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
</div>
<div class="modal modal-draggable" id="dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
</div>
<div class="modal modal-draggable" id="dialogFile" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true" style="top:40px;left: 60px">
</div>
<div class="modal modal-draggable" id="dialogMoreAudit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
</div>

</body>
<script>
    var qtip_num = 7;
    var notid;
    var menuCharsName;
    var loginID = '${loginID}';
    $(document).ready(function () {
        if ($("#loginDeptListSize").val() < 2)
            $("#loginDeptList").hide();
        if ($("#loginUserAccount").val() == "sa") {
            $("#EmpEdit").css('display', 'none');
            $("#hello").html('<h6><a><b>sa</b>&nbsp;&nbsp;，欢迎您！</a></h6>');
        } else {
            setlogohello();
        }
        $("#dateCalendar").load("calendar.html", "");
        getChartData();
//        LoginOrder();
        loadunAudit();
        loadnotice();
//        getSchedule();
//        getMenuList();
//        empsIndexCharts('<%=request.getContextPath()%>');
        DY_scroll('.img-scroll','.prev','.next','.img-list',3,false);// true为自动播放，不加此参数或false就默认不自动
    });

    function loadunAudit() {
        $("#unAudit").load("<%=request.getContextPath()%>/loadIndexUnAudit");
    }

    function loadMoreNotice() {
        $("#dialog").load("<%=request.getContextPath()%>/loadMoreNotices");
        $("#dialog").modal("show");
    }

    function loadMoreAudit() {
        $("#dialog").load("<%=request.getContextPath()%>/loadMoreAudit");
        $("#dialog").modal("show");
    }

    function getMenuList() {
        $.post("<%=request.getContextPath()%>/quickmenu/getMenuListIndex", function (data) {
            var htval = "";
            $.each(data.data, function (index, content) {
                htval += '<a href="#" class="list-group-item" onclick="setRight(\'' + content.resourceUrl + '\')">' +
                    '<span class="' + listclass[index] + '"></span>' + content.resourceName + '</a>';
            })
            htval += '<a href="#" class="list-group-item" onclick="editMenuList()">' +
                '<span class="icon-edit"></span>修改快捷菜单</a>';
            $("#menuList").html(htval);
        });
    }

    function setRight(url) {
        $('#mainRight').css('display', 'none');
        $("#right").load("<%=request.getContextPath()%>" + url);
    }

    function editMenuList() {
        $("#dialog").load("<%=request.getContextPath()%>/quickmenu/toEditByUser");
        $("#dialog").modal("show")
    }

    function LoginOrder() {
        $.post("<%=request.getContextPath()%>/loginLog/getLoginLogOederEmp", function (data) {
            var datalist = data.loginLogs;
            if (data != null) {
                var htval = "";
                $.each(datalist, function (index, content) {
                    htval += '<div class="form-row" style="height: 28px;!important;"><div class="col-md-7"><h7>' + content.id + '&nbsp;' + content.userAccount + '</h7></div><div class="col-md-5 tar"> ' + content.num + ' 次 </div></div>';
                })
                $("#usrslog").html(htval);
            }
        });
    }

    function getSchedule() {
        $.post("<%=request.getContextPath()%>/login/getSchedule", function (data) {
            var datalist = data.scheduleList;
            if (data != null) {
                var htval = "";
                $.each(datalist, function (index, content) {
                    htval += '<div class="form-row" style="height: 28px;!important;"><div class="col-md-4"><h7>' + content.weekHours + '</h7></div><div class="col-md-8 tar"> ' + content.courseShow + ' </div></div>';
                })
                $("#ScheduleList").html(htval);
            }
        });
    }

    function loadAudit(url, tableName, businessId, flag, abc, state, editUrl) {
        if (state == "3" && tableName != 'T_ZW_REPAIR') {
            var url = editUrl + "?id=" + businessId;
            $.post("<%=request.getContextPath()%>/toEditBusiness", {
                businessId: businessId,
                tableName: tableName,
                url: '<%=request.getContextPath()%>' + url,
                backUrl: "0",
                type: "1"
            }, function (html) {
                var s = "<div class=\"modal-dialog\">\n" +
                    "        <div class=\"modal-content\">\n" +
                    "            <div class=\"modal-header\">\n" +
                    "                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\" onclick=\"backIndex()\">\n" +
                    "                    &times;\n" +
                    "                </button>\n" +
                    "                <h3 class=\"modal-title\">修改</h3>\n" +
                    "            </div>\n" +
                    "            <div id=\"editBuis\" class=\"modal-body clearfix\">";
                var e = "        <div class=\"modal-footer\">\n" +
                    "                <button type=\"button\" class=\"btn btn-default btn-clean\" data-dismiss=\"modal\" onclick=\"backIndex()\">关闭\n" +
                    "                </button>\n" +
                    "            </div>\n" +
                    "        </div>\n" +
                    "    </div>"
                $("#audit").html(s + html + e);
            })
        } else {
            var url = url + "?id=" + businessId;
            if (abc == '1') {
                $.get("<%=request.getContextPath()%>/getTask?id=" + businessId, function (data) {
                    $("#audit").load("<%=request.getContextPath()%>/getIndexWorkflowLog", {
                        url: data.taskUrl,
                        tableName: data.taskTable,
                        businessId: data.taskBusinessId,
                        taskId: businessId
                    })
                })
            } else if (tableName == "T_ZW_REPAIR") {
                $("#audit").load("<%=request.getContextPath()%>/repair/repairIndexInfo", {
                    businessId: businessId,
                    flag: abc
                })
            } else {
                if (tableName == "T_SYS_TASK") {
                    $("#audit").load("<%=request.getContextPath()%>/training/searchTrainAudit", {
                        businessId: businessId,
                    })
                } else {
                    $("#audit").load("<%=request.getContextPath()%>/toIndexAudit", {
                        url: url,
                        tableName: tableName,
                        businessId: businessId,
                        flag: flag
                    })

                }
            }
        }
        $("#audit").modal("show")

    }

    function viewNotice(id, type, abc) {
        if ("3" == abc) {
            $("#dialog").load("<%=request.getContextPath()%>/meetingInfo?id=" + id + "&type=" + '0')
        }else if ("2" == abc) {
            $("#dialog").load("<%=request.getContextPath()%>/messageInfo?id=" + id + "&type=" + '0')
        } else if ("1" == abc) {
            $("#dialog").load("<%=request.getContextPath()%>/indexGetNoticeById?id=" + id + "&type=" + '0')
        } else {
            if ("3" != type) {
                $("#dialog").load("<%=request.getContextPath()%>/indexGetNoticeById?id=" + id + "&type=" + '0')
            } else {
                $.get("<%=request.getContextPath()%>/getTask?id=" + id, function (data) {
                    $("#dialog").load("<%=request.getContextPath()%>/getIndexWotkflowLog", {
                        url: data.taskUrl,
                        tableName: data.taskTable,
                        businessId: data.taskBusinessId,
                        taskId: id
                    })
                })
            }
        }


        $("#dialog").modal("show");
    }

    function loadnotice() {
        $("#indexNList").load("<%=request.getContextPath()%>/noticeListIndexNotice?loginID=${loginID}");
    }

    function setlogohello() {
        $.post("<%=request.getContextPath()%>/getLoginEmp", function (data) {
            if (data != null) {
                $("#hello").html('<br><h6><b>' + data.name + '</b>&nbsp;&nbsp;，欢迎您！</h6>');
                $("#thisdapt").html('<h6>当前部门：<b>' + data.deptName + '</b></h6>');
                /*$("#staffId").html('<a><h6>学工号：<b>' + data.staffId + '</b></h6></a>');*/
            }
        });
    }

    function changeMenu(id, url) {
        if (url == "<%=request.getContextPath()%>/index?system=${system}&id=${systemId}") {
            window.location.href = "<%=request.getContextPath()%>/index?system=${system}&id=${systemId}";
        } else {
            $("#audit").html("")
            $("#main").load("<%=request.getContextPath()%>/main", {id: id});
        }
    }

    $('.dropdown a').click(function () {
        menuCharsName = $(this).text();
    });

    function changeDept() {
        $("#dialog").load("<%=request.getContextPath()%>/toChangeDept");
        $("#dialog").modal("show");
    }

    function chengeLoginPwd() {
        $("#dialog").load("<%=request.getContextPath()%>/toChangeLoginPwd");
        $("#dialog").modal("show");
    }

    function chengeEmpEdit() {
        $("#dialog").load("<%=request.getContextPath()%>/emp/toEditEmp");
        $("#dialog").modal("show");
    }

    function chengePhoto() {
        if ($("#loginUserAccount").val() != "sa") {
//            $("#dialog").load("/toEditEmpBySelf");
            $("#dialog").load("<%=request.getContextPath()%>/login/toEditEmpBySelf");
            $("#dialog").modal("show");
        }
    }

    var titlename = '各部门人员数量';

    function getChartData() {
        $.post("<%=request.getContextPath()%>/getDeptEmpChartData", function (data) {
            if (data != null) {
                myChart.setOption({
                    title: {
                        text: titlename,
                        subtext: '',
                        x: 'center',
                        textStyle: {
                            color: '#FAFAFC',
                        }
                    },
                    color: ['#3398DB'],
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: [
                        {
                            type: 'category',
                            data: data.nameList,
                            axisLabel: {
                                interval: 0,
                                rotate: 45,//倾斜度 -90 至 90 默认为0
                                margin: 2,
                                textStyle: {
                                    color: "#ffffff"
                                }
                            }
                        }
                    ],
                    grid: { // 控制图的大小，调整下面这些值就可以，
                        x: 25,
                        x2: 25,
                        y: 40,
                        y2: 60,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
                    },
                    yAxis: [
                        {
                            type: 'value',
                            axisLabel: {
                                textStyle: {
                                    color: "#ffffff",
                                }
                            }
                        }
                    ],
                    series: [
                        {
                            name: '直接访问',
                            type: 'bar',
                            barWidth: '30%',
                            data: data.empsList
                        }
                    ]
                });
            }
        });
    }

    // dark  shine  vintage  roma  macarons  infographic
    var myChart = echarts.init(document.getElementById("eChartsP"));

    function getMenuList() {
        $.post("<%=request.getContextPath()%>/quickmenu/getMenuListIndex", function (data) {
            var htval = "";
            $.each(data.data, function (index, content) {
                htval += '<a href="#" class="list-group-item" onclick="setRight(\'' + content.resourceUrl + '\')">' +
                    '<span class="' + listclass[index] + '"></span>' + content.resourceName + '</a>';
            })
            htval += '<a href="#" class="list-group-item" onclick="editMenuList()">' +
                '<span class="icon-edit"></span>修改快捷菜单</a>';
            $("#menuList").html(htval);
        });
    }

    function setRight(url) {
        $('#mainRight').css('display', 'none');

        $("#right").load("<%=request.getContextPath()%>" + url);
    }

    function editMenuList() {
        $("#dialog").load("<%=request.getContextPath()%>/quickmenu/toEditByUser");
        $("#dialog").modal("show")
    }

</script>
<script type="text/javascript">
    $(document).ready(
        function () {
            <c:if test="${norole==1}">
            swal({
                title: "当前所在默认部门没有设置角色！",
                type: "warning"
            })
            </c:if>
            document.onkeydown = function () {
                var oEvent = window.event;
                if (oEvent.altKey && oEvent.keyCode == 81) {
                    search()

                }
            }
        });
</script>

<script>
    <c:if test="${tid!=\"null\" and tid!=null}">
    viewNotice("${tid}","${type}","${abc}")
    </c:if>

    <c:if test="${businessId!=\"null\" and tid!=null}">
    loadAudit("${url}","${tableName}","${businessId}","${flag}","${abc}","${state}","${editUrl}");
    </c:if>
</script>

</html>
