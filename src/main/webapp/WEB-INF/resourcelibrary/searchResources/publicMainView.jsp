<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<%
    String path = request.getContextPath();
%>
<script type='text/javascript' src='<%=path%>/libs/js/plugins/jquery/jquery.min.js'></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/libs/css/resourcelibrary/style.css">
<script type="text/javascript" src="<%=path%>/libs/js/resourcelibrary/tween.js"></script>
<script type="text/javascript" src="<%=path%>/libs/js/resourcelibrary/event.js"></script>
<body>
<div id="topJsp"></div>

<div class="clearfix"></div>
<div class="ss_ny">
    <div id="searchTxt" class="ss_ys_ny">
        <input name="w" class="searchTxt" id="keyword" placeholder="请输入..." type="text">
        <span class="searchBtn" id="myBtn" onclick="search_function()">
        </span>
    </div>
    <%--<p>关键字：<a href="#">机电</a><a href="#">农业</a><a href="#">计算机</a></p>
    <p></p>--%>
</div>
<div class="centent_zy" style="height: 500px!important;">
    <div id="centent_zy_left"></div>


    <div class="centent_zy_right">
        <div class="gxz">
            <p>
                <img src="<%=path%>/userImg/${publicPerson.photoUrl}" class="img-1"/>
                贡献者
                <span class="orange">${publicPerson.name}</span>
            </p>
            <ul>
                <li><a href="#" class="y1">${countPublic}</a><span>上传资源</span></li>
                <li><a href="#" class="y2">${downCount}</a><span>下载资源</span></li>
                <li><a href="#" class="y3">${viewCount}</a><span>浏览总量</span></li>
            </ul>
        </div>
        <div class="link">
            <div class="news">
                <h1>相关资源</h1>
                <ul id="courseAbouthtml"></ul>
            </div>
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
<input type="hidden" id="downCount" value="${downCount}">
<input type="hidden" id="viewCount" value="${viewCount}">
</body>
</html>
<script>
    var path = '<%=path%>';
    $(document).ready(function () {
        $("#topJsp").load(path + "/resourcePublic/getPublicTop");
        $("#centent_zy_left").load(path + "/resourcePublic/getPublicResourceView?resourceId=" + $("#resourceId").val());

        $.get(path + "/IndexSearch/SearchResource?flag=2&endCount=5", function (data) {
            var listhtml = "";
            $.each(data.listData, function (index, content) {
                listhtml = '<li><a target="_blank" ' +
                    'href="' + path + '/resourcePublic/getPublicResourceViewMain?resourceId=' + content.resourceId
                    + '&publicPersonId=' + content.publicPersonId + '">' + content.resourceName + '</a></li>' + listhtml;
            })
            $("#listhtml").html(listhtml);

        })

    })

    function search_function() {
        var keywords = $("#keyword").val();
        window.location.href = path + "/IndexSearch/skip?keyword=" + encodeURI(encodeURI(keywords));
        /*$.get("/resourcePrivate/backResourceRecycle?resourceId=" + resourceId, function (data) {
         })*/
    }


</script>