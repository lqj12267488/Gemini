<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- saved from url=(0064)http://www.jsyhzx.cn:8090/ziyuanku/hotrecommend/hotRecommendList -->
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" type="text/css" href="<%=path%>/libs/css/resourcelibrary/style.css">
    <script type='text/javascript' src='<%=path%>/libs/js/plugins/jquery/jquery.min.js'></script>
    <script type="text/javascript" src="<%=path%>/libs/js/resourcelibrary/tween.js"></script>
    <script type="text/javascript" src="<%=path%>/libs/js/resourcelibrary/event.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/libs/js/resourcelibrary/resourceFilesAction.js"></script>
    <title>最新上传</title>
</head>

<body>
<div id="topJsp"></div>
<!--内页内容 start-->
<div class="ss_ny">
    <div id="searchTxt" class="ss_ys_ny">
        <input name="keyword" type="text" class="searchTxt" id="keyword" placeholder="请输入..." value="${keyword}">
        <span class="searchBtn" id="myBtn" onclick="searchlist()"></span>
    </div>
    <p>
    </p>
</div>
<div class="centent_zy1">
    <h1>类型</h1>
    <div class="" id="type_id">
    </div>
    <div class="clearfix"></div>
    <%--   <div class="lx_xz">--%>
    <div class="xk2" id="subject_id" value="0">
        <%-- <span>学科类型：</span>--%>
    </div>
    <%--    </div>--%>
    <div class="xk3" id="major_id" value="0">
        <%--<span>专业类型：</span>--%>
    </div>
    <div class="xk3" id="course_id" value="0">
        <%--<span>课程类型：</span>--%>
    </div>
    <div class="xk" id="format_id" value="0">
        <%--<span>文件格式：</span>--%>
    </div>
    <div class="lx">
        <h1 id="listName"></h1>
    </div>
</div>
<div class="center1">
    <ul class="wd-img-xw clearfix" id="listID"></ul>
    <!--分页-->
    <div class="pages" id="pagesID" value="1"></div>
    <!--分页 end-->
</div>
<!--内页内容 end-->
<div class="clearfix"></div>
<div id="bottomJsp"></div>

<input type="hidden" value="${flag}" id="flag">

<script>
    var flag = $("#flag").val();

    //初始化联动列表
    $(document).ready(function () {
        $("#topJsp").load("<%=request.getContextPath()%>/resourcePublic/getPublicTop");
        allformat();
        allsubject();
        allmajor();
        allcourse();
        alltype();
        searchlist();
        if (flag == 1) {
            $("#listName").text("热点推荐——资源列表");
        } else if (flag == 2) {
            $("#listName").text("热门下载——资源列表");
        } else if (flag == 3) {
            $("#listName").text("热点推荐——资源列表");
        }

    })

    //学科联动专业
    function searchmajor(subject_id) {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " resource_major_id ",
                text: " resource_major_name ",
                tableName: " ZYK_TYPE_MAJOR ",
                where: " where resource_subject_id ='" + subject_id + "'",
                orderby: " order by resource_major_id "
            },
            function (data) {
                var data_type = "<a href='#' class='cur' onclick=allmajor()>全部</a>"
                $(data).each(function (key) {
                    data_type += "<a href='#' id='" + data[key].id + "' onclick=searchcourse('" + data[key].id + "');>" + data[key].text + "</a>";
                });
                $("#major_id").html('');
                $("#major_id").append(" <span> 专业类型：</span>" + data_type);
            });
        changecolor(subject_id);
    }

    //专业联动课程
    function searchcourse(major_id) {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " resource_course_id ",
                text: " resource_course_name ",
                tableName: " ZYK_TYPE_COURSE ",
                where: " where resource_major_id ='" + major_id + "'",
                orderby: " order by resource_course_id "
            },
            function (data) {
                var data_type = "<a href='#' class='cur' id='all' onclick=changecolor('all')>全部</a>"
                $(data).each(function (key) {
                    data_type += "<a href='#' id='" + data[key].id + "' onclick=changecolor('" + data[key].id + "');>" + data[key].text + "</a>";
                });
                $("#course_id").html('');
                $("#course_id").append(" <span> 课程类型：</span>" + data_type);
            })
        changecolor(major_id);
    }

    //初始化课程
    function allcourse() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " resource_course_id ",
                text: " resource_course_name ",
                tableName: " ZYK_TYPE_COURSE ",
                where: " where 1 = 1 ",
                orderby: " order by resource_course_id "
            },
            function (data) {
                var data_type = "<a href='#' class='cur' id ='all' onclick=changecolor('all')>全部</a>"
                $(data).each(function (key) {
                    data_type += "<a href='#' id='" + data[key].id + "' onclick=changecolor('" + data[key].id + "');>" + data[key].text + "</a>";
                });
                $("#course_id").html('');
                $("#course_id").append(" <span> 课程类型：</span>" + data_type);
            })
    }

    //初始化专业
    function allmajor() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " resource_major_id ",
                text: " resource_major_name ",
                tableName: " ZYK_TYPE_MAJOR ",
                where: " where 1 = 1 ",
                orderby: " order by resource_major_id "
            },
            function (data) {
                var data_type = "<a href='#' class='cur' onclick=allmajor();allcourse();>全部</a>"
                $(data).each(function (key) {
                    data_type += "<a href='#' id='" + data[key].id + "' onclick=searchcourse('" + data[key].id + "');>" + data[key].text + "</a>";
                });
                $("#major_id").html("");
                $("#major_id").append(" <span>专业类型：</span>" + data_type);
            });
    }

    //初始化学科
    function allsubject() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " resource_subject_id ",
                text: " resource_subject_name ",
                tableName: " zyk_type_subject ",
                where: " where 1 = 1 ",
                orderby: " order by resource_subject_id "
            },
            function (data) {
                var data_type = "<a href='#' class='cur' onclick=allsubject();allmajor();allcourse();>全部</a>"
                $(data).each(function (key) {
                    data_type += "<a href='#' id='" + data[key].id + "' onclick=searchmajor('" + data[key].id + "');>" + data[key].text + "</a>";
                });
                $("#subject_id").html("");
                $("#subject_id").append("<span>学科类型：</span>" + data_type);
            })
    }

    //初始化类型
    function alltype() {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYLX", function (data) {
            var data_type = "<li class='cur mr10b'><a href='#' onclick=alltype()>全部</a></li>"
            $(data).each(function (key) {
                data_type += "<li class='mr10b' id='" + "type_" + data[key].id + "'><a href='#' id='" + data[key].id + "' onclick=changetypecolor('" + "type_" + data[key].id + "');>" + data[key].text + "</a></li>";
            });

            $("#type_id").html("");
            $("#type_id").append("<ul class='kc'>" + data_type + "</ul>");
        });
    }

    //初始化格式
    function allformat() {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYGS", function (data) {
            var data_type = "<a href='#' class='cur' onclick=allformat()>全部</a>"
            $(data).each(function (key) {
                data_type += "<a href='#' id='" + "format_" + data[key].id + "' onclick=changecolor('" + "format_" + data[key].id + "');>" + data[key].text + "</a>";
            });
            $("#format_id").html("");
            $("#format_id").append("<span>文件格式：</span>" + data_type);
        });
    }

    //学科、专业、课程、格式样式的变化
    function changecolor(color_id) {
        $("#" + color_id).siblings().removeAttr("class");
        $('#' + color_id).attr("class", "cur");
        searchlist();
    }

    //类型样式变化
    function changetypecolor(color_id) {
        $("#" + color_id).siblings().remove("class");
        $("#" + color_id).siblings().attr("class", "mr10b");
        $('#' + color_id).attr("class", "cur mr10b");
        searchlist();
    }

    function searchlist(page, countEnd) {
        var type_id = $(".cur").children("a:first").attr("id");
        var search_id = $("#keyword").val();
        var subject_id = $("div#subject_id .cur").attr("id");
        var major_id = $("div#major_id .cur").attr("id");
        var course_id = $("div#course_id .cur").attr("id");
        var format_id = $("div#format_id .cur").attr("id");
        var format;

        var startCount = "";
        var endCount = "";
        if (page == undefined || page == 'undefined') {
            startCount = "1";
            endCount = "12";
            page = 1;
        } else {
            startCount = (page - 1) * 12 + 1;    ///   13
            endCount = page * 12;          // 24
            if (countEnd != undefined && countEnd != 'undefined') {  // 15
                if (endCount > countEnd) {
                    endCount = countEnd;
                }
            }
        }

        $.post("<%=path%>/IndexSearch/SearchResource", {
                resourceName: search_id,
                resourceType: type_id,
                resourceSubjectId: subject_id,
                resourceMajorId: major_id,
                resourceCourseId: course_id,
                resourceFormat: format_id,
                flag: flag,
                startCount: startCount,
                endCount: endCount,
            },
            function (data) {
                var dataHtml = "";
                $.each(data.listData, function (index, content) { //        title="weichat_icon"
                    dataHtml = '<li class="mr5b">' +
                        '<a class="xz" href="#" ' +
                        'onclick="downResourceFiles(\'' + content.resourceId + '\',\'' + content.fileUrl + '\',\'' + content.fileName + '\',\'<%=path%>\')">下载</a>' +
                        '<a class="nr_a_lhj" target="_blank" href="<%=path%>/resourcePublic/getPublicResourceViewMain?resourceId=' + content.resourceId + '&publicPersonId=' + content.publicPersonId + '">' +
                        '<img src="<%=path%>' + content.coverUrl + '" style="height: 80px;width: 60px;"><p class="conner"></p><p class="qt-high-rank"></p>' +
                        '</a>' +
                        '<div class="wz">' +
                        '<a title="weichat_icon" target="_blank"  href="<%=path%>/resourcePublic/getPublicResourceViewMain?resourceId=' + content.resourceId + '&publicPersonId=' + content.publicPersonId + '"><h2>' + content.resourceName + '</h2></a>' +
                        '<p>' +
                        '<span class="lhj_gxz">贡献者：' + content.publicPersonShow + '</span>' +
                        '上传时间：<span class="green">' + content.publicTime + '</span>' +
                        '<br>浏览量：<span class="orange">' + content.viewCount + '</span> 次 &nbsp;&nbsp;格式：' + content.resourceFormatShow +
                        '</p>' +
                        '</div>' +
                        '</li>' + dataHtml;
                })
                $("#listID").html(dataHtml);
                var pageCount = data.countNum;
                var pageMax = Math.ceil(pageCount / 12);
                var pagesHtml = "";
                // page 本页
                pagesHtml = '<span class="cur"><a href="javascript:void(0);">' + page + '</a></span>';
                // 如果 有前一页
                if (page > 1) {
                    pagesHtml = '<span><a href="javascript:void(0);" onclick="searchlist(' + (page - 1) + ',' + pageCount + ')">' + (page - 1) + '</a></span>' + pagesHtml;
                }
                // 如果 有前两页
                if (page > 2) {
                    pagesHtml = '<span><a href="javascript:void(0);" onclick="searchlist(' + (page - 2) + ',' + pageCount + ')">' + (page - 2) + '</a></span>' + pagesHtml;
                }
                // 如果 有前三页
                if (page > 3) {
                    pagesHtml = '<span><a href="javascript:void(0);" onclick="searchlist(' + (page - 3) + ',' + pageCount + ')">' + (page - 3) + '</a></span>' + pagesHtml;
                }

                // 如果 有下一页
                if ((page + 1) <= pageMax) {
                    pagesHtml = pagesHtml + '<span><a href="javascript:void(0);" onclick="searchlist(' + (page + 1) + ',' + pageCount + ')">' + (page + 1) + '</a></span>';
                }
                // 如果 有下两页
                if ((page + 2) <= pageMax) {
                    pagesHtml = pagesHtml + '<span><a href="javascript:void(0);" onclick="searchlist(' + (page + 2) + ',' + pageCount + ')">' + (page + 2) + '</a></span>';
                }
                // 如果 有下三页
                if ((page + 3) <= pageMax) {
                    pagesHtml = pagesHtml + '<span><a href="javascript:void(0);" onclick="searchlist(' + (page + 3) + ',' + pageCount + ')">' + (page + 3) + '</a></span>';
                }

                pagesHtml = '<span><a href="javascript:void(0);" onclick="searchlist(1,' + pageCount + ')">首页</a></span>'
                    + pagesHtml +
                    '<span><a href="javascript:void(0);" onclick="searchlist(' + pageMax + ',' + pageCount + ')">尾页</a></span>';
                $("#pagesID").html(pagesHtml);

            })
    }

    //list方法
</script>
</body>
</html>