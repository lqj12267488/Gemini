<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/jquery/jquery.min.js'></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/libs/css/resourcelibrary/style.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/resourcelibrary/tween.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/resourcelibrary/event.js"></script>
<body>
<div id="topJsp"></div>

<div class="clearfix"></div>
<div class="ss_ny">
    <div id="searchTxt" class="ss_ys_ny">
        <input name="w" class="searchTxt" id="keyword" placeholder="请输入..." type="text">
        <div class="searchBtn">
            <button id="myBtn" onclick="search_function();">搜索</button>
        </div>
    </div>
    <%--<p>关键字：<a href="#">机电</a><a href="#">农业</a><a href="#">计算机</a></p>
    <p></p>--%>
</div>
<div class="centent_zy" style="height: 500px!important;">
    <div class="centent_zy_left">
        <h1>您当前的位置：<a href="<%=request.getContextPath()%>/resourceLibrary/toIndex">首页</a></h1>
        <h2>${resourceName}
            <a class="xz"
               href="<%=request.getContextPath()%>/resourcePublic/downResource?resourceId=${resourceFiles.fileId}&fileUrl=${resourceFiles.fileUrl}&fileName=${resourceFiles.fileName}">
                <img src="<%=request.getContextPath()%>/libs/img/resourcelibrary/btn-1.jpg" width="80" height="26">
            </a>
        </h2>
        <h3> 大小：${resourceFiles.fileSize} ｜ 上传时间：${resourcePublic.publicTime}</h3>
        <%-- <img src="${resourceFiles.fileUrl}">     --%>
        <%--<video src="${fileView}" />--%>
        <div class="cj" id="cj">
        </div>
    </div>
    <div class="centent_zy_right">
        <div class="gxz">
            <p>
                <img src="<%=request.getContextPath()%>/userImg/${publicPerson.photoUrl}" class="img-1"/>
                贡献者
                <span class="orange">${publicPerson.name}</span>
            </p>
            <ul>
                <li><a href="#" class="y1">${countPublic}</a><span>上传资源</span></li>
            </ul>
        </div>
        <div class="link">
            <div class="news">
                <h1>热门下载</h1>
                <ul id="listhtml"></ul>
            </div>
        </div>
    </div>
</div>
<!--内页内容 end-->
<div class="clearfix"></div>
<div id="bottomJsp"></div>
<input type="hidden" id="resourceId" value="${resourceId}">
</body>
</html>
<script>
    var resourceFormat = '${resourceFormat}';
    $(document).ready(function () {
        $("#topJsp").load("<%=request.getContextPath()%>/resourcePublic/getPublicTop");

        $.get("<%=request.getContextPath()%>/IndexSearch/SearchResource?flag=2&endCount=10", function (data) {
            var listhtml = "";
            $.each(data.listData, function (index, content) {
                listhtml = '<li><a target="_blank" ' +
                    'href="<%=request.getContextPath()%>/resourcePublic/getPublicResourceViewMain?resourceId=' + content.resourceId
                    + '&publicPersonId=' + content.publicPersonId + '">' + content.resourceName + '</a></li>' + listhtml;
            })
            $("#listhtml").html(listhtml);
        })
        var cjhtml = "";
        if (resourceFormat == 1 || resourceFormat == 9) {
            cjhtml = '<iframe frameborder="0" marginheight="0" class="media"' +
                ' style="position:absolute; height:760px;width:66%; overflow-y:auto!important;"' +
                '  marginwidth="0" scrolling="no" src="<%=request.getContextPath()%>/libs/js/resourcelibrary/generic/web/viewer.html?file=${fileView}"></iframe>';
        } else if (resourceFormat == 2) {
            cjhtml = '<img style="max-width: 800px" src="<%=request.getContextPath()%>${fileView}">';
        } else if (resourceFormat == 3) {
            cjhtml = '<audio src="<%=request.getContextPath()%>${fileView}" controls="controls"></audio>';
        } else if (resourceFormat == 4) {
            cjhtml = '<video id="example_video_1" class="video-js" controls  width="100%"  preload="auto" width="auto"   height="480" data-setup="{}">' +
                '<source src="<%=request.getContextPath()%>${fileView}" type="video/mp4" />' +
                '<track kind="captions" src="demo.captions.vtt" srclang="en" label="English"></track>' +
                '<track kind="subtitles" src="demo.captions.vtt" srclang="en" label="English"></track>' +
                '</video>';
        }
        //cjhtml = cjhtml+'<p class="lhj_xz_txt"><span>资源简介：</span>${resourcePrivate.remark}</p>';
        cjhtml = '<div style="height:760px">' + cjhtml + '</div>' + '<p class="lhj_xz_txt"><span>资源简介：</span>${resourcePrivate.remark}</p>';
        $("#cj").html(cjhtml);
    })

    function search_function() {
        var keywords = $("#keyword").val();
        window.location.href = "<%=request.getContextPath()%>/IndexSearch/skip?keyword=" + encodeURI(encodeURI(keywords));
    }


</script>