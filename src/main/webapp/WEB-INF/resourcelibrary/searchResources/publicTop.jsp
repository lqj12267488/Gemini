<%@ page import="com.goisan.system.bean.CommonBean" %>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
%>
<script type='text/javascript' src='<%=path%>/libs/js/sweetalert.min.js'></script>
<link href="<%=path%>/libs/css/sweetalert.css" rel="stylesheet">
<div class="top-main">
    <ul class="type">
        <li>欢迎访问<%=CommonBean.getParamValue("SZXXMC")%>资源平台！</li>
    </ul>
    <ul class="more">
        <li><a href="<%=path%>/navigation">返回导航页</a> </li>
        <li>|</li>
        <li><a href="<%=path%>/resourceLibrary/toIndex">资源平台首页</a></li>
    </ul>
</div>
<div class="logo-area">
    <img src="<%=path%>/libs/img/resourcelibrary/logo.png" class="img-logo">
    <div class="photo-img" style="width: 940px;!important;">
        <ul class="nav-txt">
            <li>&nbsp;&nbsp;&nbsp;&nbsp;</li>
            <li>&nbsp;&nbsp;&nbsp;&nbsp;</li>
            <li><a href="<%=path%>/resourceLibrary/toIndex">首页</a></li>
            <li><a href="<%=path%>/IndexSearch/skip?flag=1" >热点推荐</a></li>
            <li><a href="<%=path%>/IndexSearch/skip?flag=2" >热门下载</a></li>
            <li><a href="<%=path%>/IndexSearch/skip?flag=3" >最新上传</a></li>
            <li>|</li>
            <!-- 根据loginusername的request，判断显隐-->
            <li>
                <img class="img-1" src="<%=path%>/userImg/${photoUrl}">
                <span class="orange">${userName}</span><a class="quit" href="<%=path%>/logout"><img src="<%=path%>/libs/img/resourcelibrary/icon1.png">退出</a><%--   ../libs/img/resourcelibrary/icon1.png --%>
            </li>
        </ul>
        <ul class="nav-txt1">
            <li>
                <img class="img-1" src="<%=path%>/userImg/${photoUrl}">
                <span class="orange">${userName}</span><a class="quit" href="<%=path%>/logout"><img src="<%=path%>/libs/img/resourcelibrary/icon1.png">退出</a>
            </li>
            <li>
            </li>
        </ul>
    </div>
</div>
<script>
    $(document).ready(function () {
        var bottomhtml =
            '<div class="copyright">' +
                '<div class="ico-g"><img src="<%=path%>/libs/img/resourcelibrary/ico-8.png" width="45" height="45"></div>' +
                '<p>' +
                    '<a href="#">网站地图</a>  ｜  <a href="#">关于我们</a> ｜  <a href="#">网站通告</a> ｜ <a href="#">友情链接</a><br>Copyright © 2005-2012 吉林省勾陈科技有限公司 .com All rights reserved' +
                '</p>' +
                '<ul class="clearfix">' +
                    '<li><a href="#">' +
                        '<img src="<%=path%>/libs/img/resourcelibrary/icon6.png" alt=""><div>微博</div>' +
                    '</a></li>' +
                    '<li><a href="#">' +
                        '<img src="<%=path%>/libs/img/resourcelibrary/icon7.png" alt=""><div>微信</div>' +
                        '</a></li>' +
                '</ul>' +
            '</div>';
        $("#bottomJsp").html(bottomhtml);
    })

</script>