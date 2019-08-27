<%@ page import="com.goisan.system.bean.CommonBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
%>
<html>
<script type='text/javascript' src='<%=path%>/libs/js/plugins/jquery/jquery.min.js'></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/libs/css/resourcelibrary/style.css">
<script type="text/javascript" src="<%=path%>/libs/js/resourcelibrary/tween.js"></script>
<script type="text/javascript" src="<%=path%>/libs/js/resourcelibrary/event.js"></script>
<body>

<div id="topJsp"></div>

<div class="banner">
    <!-- 搜索部分 -->
    <div class="banner-c">
        <div class="banner-c-left">
            <i class="h1"><%=CommonBean.getParamValue("SZXXMC")%>资源库</i>
            <i class="h2">校训价值观人生观</i>
            <div class="lhj_ss">
                <div id="searchTxt">
                    <input name="keyword" class="searchTxt" type="text" id="keyword">
                </div>
                <div class="searchBtn">
                    <button id="myBtn" onclick="search_function();">搜索</button>
                </div>
            </div>
            <div class="clearfix"></div>
            <b class="h3">已有 <span class="big">${countResource.numCount}</span> 个资源，共 <span
                    class="big">${countResource.fileSize}</span> </b>
        </div>
        <div class="banner-c-right"><img src="<%=path%>/libs/img/resourcelibrary/img_2.png"></div>
    </div>
    <!-- 搜索部分 -->
    <!-- 链接部分 -->
    <div class="clearfix"></div>
    <div class="icon3">
        <ul>
            <li><a href="<%=path%>/IndexSearch/skip?flag=1"><img src="<%=path%>/libs/img/resourcelibrary/ico-1.png"></a>
                <h1>热点推荐</h1>
                <p>根据用户学科智能推送相关最热资源</p></li>
            <li><a href="<%=path%>/IndexSearch/skip?flag=2"><img src="<%=path%>/libs/img/resourcelibrary/ico-2.png"></a>
                <h1>热门下载</h1>
                <p>按照时间顺序最新上传资源</p></li>
            <li><a href="<%=path%>/IndexSearch/skip?flag=3"><img src="<%=path%>/libs/img/resourcelibrary/ico-3.png"></a>
                <h1>最新上传</h1>
                <p>课件 教案 素材 习题</p></li>
            <li><a href="<%=path%>/IndexSearch/skip?flag=1"><img src="<%=path%>/libs/img/resourcelibrary/ico-4.png"></a>
                <h1>精品课程资源</h1>
                <p>最热门精品课同步推送</p></li>
        </ul>
    </div>
    <!-- 链接部分 -->
</div>
<div class="clearfix"></div>
<!-- 专区部分 -->
<div class="center">
    <div class="tabmain1">
        <div id="outerWrap">
            <div id="sliderParent"></div>
            <div class="blueline" id="blueline" style="top: 0px; "></div>
            <ul class="tabGroup">
                <li class="tabOption selectedTab"><p>文档资源</p></li>
                <li class="tabOption"><p>视频资源</p></li>
                <li class="tabOption"><p>教育专区</p></li>
                <li class="tabOption"><p>用户贡献</p></li>
                <li class="tabOption"><p>排行榜</p></li>
            </ul>
            <div id="container">
                <div id="content">
                    <div class="tabContent  selectedContent"><!-- 文档资源 -->
                        <ul class="wd-img clearfix" id="wdzy" style="height:400px"></ul>
                    </div>
                    <div class="tabContent">
                        <div style=" height: 30px;">视频资源</div>
                        <ul class="sp-img clearfix" style="padding-bottom:20%; height:400px" id="spzy"></ul>
                    </div>
                    <div class="tabContent" style=" height:300px;">
                        <div style="height: 30px;">教育专区</div>
                        <div class="list_fd">
                            <div class="list1_lhj pl">
                                <h1><a href="#">课件</a></h1>
                                <ul id="kjzy"></ul>
                            </div>
                            <div class="list1_lhj pr">
                                <h1><a href="#">教案</a></h1>
                                <ul id="jazy"></ul>
                            </div>
                        </div>
                        <div class="list_fd">
                            <div class="list1_lhj pl">
                                <h1><a href="#">素材</a></h1>
                                <ul id="sczy"></ul>
                            </div>
                            <div class="list1_lhj pr">
                                <h1><a href="#">习题</a></h1>
                                <ul id="xtzy"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="tabContent">
                        <div style="height: 30px;">用户贡献</div>
                        <div class="list_fd" style="padding-bottom:40%;">
                            <div class="list1_lhj pl">
                                <h1><a href="#" id="personGx1Name"></a></h1>
                                <ul id="personGx1"></ul>
                            </div>
                            <div class="list1_lhj pr">
                                <h1><a href="#" id="personGx2Name"></a></h1>
                                <ul id="personGx2"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="tabContent">
                        <div style="height: 30px;">排行榜</div>
                        <div class="list_fd" style="padding-bottom:40%;">
                            <div class="list1_lhj pl">
                                <h1><a href="#">用户贡献排行</a></h1>
                                <ul id="yhgx"></ul>
                            </div>
                            <div class="list1_lhj pr">
                                <h1><a href="#">专业贡献排行</a></h1>
                                <ul id="zygx"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $("#topJsp").load("<%=path%>/resourcePublic/getPublicTop");


            $.post("<%=path%>/resourceLibrary/loginList", {},
                function (data) {
                    //  wdzy   文档资源
                    // <li><a target="_blank" href="http://yuan"><img src="..//wd.jpg"><p class="conner"></p><p class="qt-high-rank"></p></a><em>测试问题</em></li>
                    var wdzyList = data.wdzy;
                    var wdzyhtml = "";
                    $.each(wdzyList, function (index, content) {
                        var srcurl = "<%=path%>/libs/img/resourcelibrary/wd.jpg";
                        if (null != content.coverUrl && content.coverUrl != "") {
                            srcurl = "<%=path%>" + content.coverUrl;
                        } //
                        wdzyhtml = wdzyhtml + '<li><a target="_blank" href="<%=path%>/resourcePublic/getPublicResourceViewMain?resourceId=' + content.resourceId + '&publicPersonId=' + content.publicPersonId + '">' +
                            '<img style="width: 160px;height: 200px" src="' + srcurl + '">' +
                            '<p class="conner"></p><p class="qt-high-rank"></p>' +
                            '</a><em>' + content.resourceName + '</em></li>';
                    })
                    $("#wdzy").html(wdzyhtml);


                    // spzy   视频资源 163 82
                    //  <li><a target="_blank" href="http://www.=ziyuan"><img src="../libs/img/resourcelibrary/img_1.png"><p class="conner"></p><p class="qt-high-rank"></p></a><em>12英语：in（the）front of</em></li>
                    var spzyList = data.spzy;
                    var spzyhtml = "";
                    $.each(spzyList, function (index, content) {
                        var srcurl = "<%=path%>/libs/img/resourcelibrary/img_1.png";
                        if (null != content.coverUrl && content.coverUrl != "") {
                            srcurl = "<%=path%>" + content.coverUrl;
                        }
                        spzyhtml = spzyhtml +
                            '<li><a target="_blank" href="<%=path%>/resourcePublic/getPublicResourceViewMain?resourceId=' + content.resourceId + '&publicPersonId=' + content.publicPersonId + '">' +
                            '<img style="text-align: center;width:120px;height:90px" src="' + srcurl + '"><p class="conner"></p>' +
                            '<p class="qt-high-rank"></p></a><em>' + content.resourceName + '</em></li>'
                    })
                    $("#spzy").html(spzyhtml);


                    // kjzy   课件
                    // <li><a target="_blank" href="http:// = =ziyuan">12英语：in（the）front of</a></li>
                    var kjzyList = data.kjzy;
                    var kjzyhtml = "";
                    $.each(kjzyList, function (index, content) {
                        kjzyhtml = kjzyhtml + '<li><a target="_blank" href="<%=path%>/resourcePublic/getPublicResourceViewMain?resourceId=' + content.resourceId + '&publicPersonId=' + content.publicPersonId + '">' + content.resourceName + '</a></li>'
                    })
                    $("#kjzy").html(kjzyhtml);

                    // jazy   教案
                    var jazyList = data.jazy;
                    var jazyhtml = "";
                    $.each(jazyList, function (index, content) {
                        jazyhtml = jazyhtml + '<li><a target="_blank" href="<%=path%>/resourcePublic/getPublicResourceViewMain?resourceId=' + content.resourceId + '&publicPersonId=' + content.publicPersonId + '">' + content.resourceName + '</a></li>'
                    })
                    $("#jazy").html(jazyhtml);

                    // sczy   素材
                    // <li><a target="_blank" href="http:// =20170803185311_1.jpg&amp;sourceFolder=ziyuan">weichat_icon</a></li>
                    var sczyList = data.sczy;
                    var sczyhtml = "";
                    $.each(sczyList, function (index, content) {
                        sczyhtml = sczyhtml + '<li><a target="_blank" href="<%=path%>/resourcePublic/getPublicResourceViewMain?resourceId=' + content.resourceId + '&publicPersonId=' + content.publicPersonId + '">' + content.resourceName + '</a></li>'
                    })
                    $("#sczy").html(sczyhtml);

                    // xtzy   习题
                    var xtzyList = data.xtzy;
                    var xtzyhtml = "";
                    $.each(xtzyList, function (index, content) {
                        xtzyhtml = xtzyhtml + '<li><a target="_blank" href="<%=path%>/resourcePublic/getPublicResourceViewMain?resourceId=' + content.resourceId + '&publicPersonId=' + content.publicPersonId + '">' + content.resourceName + '</a></li>'
                    })
                    $("#xtzy").html(xtzyhtml);

                    //  yhgx  用户贡献排行
                    var yhgxList = data.yhgx;
                    var yhgxhtml = "";
                    $.each(yhgxList, function (index, content) {
                        yhgxhtml = '<li><a href="#">' + content.resourceName + '</a>' +
                            '<em>贡献资源：<span>' + content.viewCount + '</span></em></li>' + yhgxhtml;
                        if (index == (yhgxList.length - 1)) {
                            $("#personGx1Name").text(content.resourceName);
                        }
                        if (index == (yhgxList.length - 2)) {
                            $("#personGx2Name").text(content.resourceName);
                        }
                    })
                    $("#yhgx").html(yhgxhtml);

                    //  zygx  专业贡献排行
                    var zygxList = data.zygx;
                    var zygxhtml = "";
                    $.each(zygxList, function (index, content) {
                        zygxhtml = '<li><a href="#">' + content.resourceName + '</a>' +
                            '<em>贡献资源：<span>' + content.numCount + '</span></em></li>' + zygxhtml;
                    })
                    $("#zygx").html(zygxhtml);

                    //  personGx1  用户贡献1
                    var personGx1List = data.personGx1;
                    var personGx1html = "";
                    $.each(personGx1List, function (index, content) {
                        personGx1html = personGx1html + '<li><a target="_blank" href="<%=path%>/resourcePublic/getPublicResourceViewMain?resourceId=' + content.resourceId + '&publicPersonId=' + content.publicPersonId + '">' + content.resourceName + '</a></li>';
                    })
                    $("#personGx1").html(personGx1html);

                    //  personGx2  用户贡献2
                    var personGx2List = data.personGx2;
                    var personGx2html = "";
                    $.each(personGx2List, function (index, content) {
                        personGx2html = personGx2html + '<li><a target="_blank" href="<%=path%>/resourcePublic/getPublicResourceViewMain?resourceId=' + content.resourceId + '&publicPersonId=' + content.publicPersonId + '">' + content.resourceName + '</a></li>';
                    })
                    $("#personGx2").html(personGx2html);

                })
        })
        var container = document.getElementById('container');
        var content = document.getElementById('content');
        var oDivs = DOM.children(content, "div");
        oDivs[0].st = 0;
        for (var i = 1; i < oDivs.length; i++) {
            oDivs[i].st = oDivs[i].offsetTop;
        }
        var oLis = DOM.getElesByClass("tabOption");
        var flag = 0;
        var upFlag = oLis.length;
        (function () {
            function fn(e) {
                e = e || window.event;
                if (e.wheelDelta) {
                    var n = e.wheelDelta;
                } else if (e.detail) {
                    var n = e.detail * -1;
                }
                if (n > 0) {
                    container.scrollTop -= 12;
                } else if (n < 0) {
                    container.scrollTop += 12;
                }
                slider.style.top = container.scrollTop * container.offsetHeight / content.offsetHeight + "px";
                slider.offsetTop * (content.offsetHeight / container.offsetHeight);
                var st = container.scrollTop;
                if (st > this.preSt) {
                    for (var j = 0; j < oLis.length; j++) {
                        if (st < oDivs[j].st)
                            break;
                    }
                    if (oLis[j - 2] && this.preLi !== j) {
                        if ((j) > (flag + 1)) {
                            DOM.removeClass(oLis[j - 2], "selectedTab");
                            DOM.addClass(oLis[j - 1], "selectedTab");
                            animate(blueline, {top: (j - 1) * 53}, 500, 2);
                        }
                    }
                    flag = j - 1;
                } else if (st < this.preSt) {
                    for (var j = oLis.length - 1; j >= 0; j--) {
                        if (st > oDivs[j].st)
                            break;
                    }
                    if (oLis[j + 2] && this.preLi !== j) {
                        if (flag === undefined) return;
                        if ((j) < (flag)) {
                            for (var k = 0; k < oLis.length; k++) {
                                DOM.removeClass(oLis[k], "selectedTab");
                            }
                            ;
                            DOM.addClass(oLis[j + 1], "selectedTab");
                            animate(blueline, {top: (j + 1) * 53}, 500, 2);
                            upFlag = j + 1;
                        }
                    }
                }
                this.preSt = st;
                if (e.preventDefault) e.preventDefault();
                return false;
            }

            container.onmousewheel = fn;
            if (container.addEventListener) container.addEventListener("DOMMouseScroll", fn, false);
            slider = document.createElement('span');
            slider.id = "slider";
            slider.style.height = container.offsetHeight * (container.offsetHeight / content.offsetHeight) + "px";
            sliderParent.appendChild(slider);
            on(slider, "mousedown", down);
            var blueline = document.getElementById("blueline");

            function changeTab() {
                var index = DOM.getIndex(this);
                for (var i = 0; i < oLis.length; i++) {
                    DOM.removeClass(oLis[i], "selectedTab");
                }
                DOM.addClass(this, "selectedTab");
                animate(container, {scrollTop: oDivs[index].st}, 500, 1);
                var t = oDivs[index].st * container.offsetHeight / content.offsetHeight;
                animate(slider, {top: t}, 500);
                animate(blueline, {top: index * 53}, 500, 2);
            }

            var tabPannel1 = document.getElementById("outerWrap");
            var oLis = DOM.children(DOM.children(tabPannel1, "ul")[0], "li");
            for (var i = 0; i < oLis.length; i++) {
                oLis[i].onclick = changeTab;
            }
            ;
        })();
    </script>
    <script>
        var downurl = "http://www.jsyhzx.cn:8090/ziyuanku/download/download?id=" + 33;//下载地址
        var downloadSize;//资源大小

        function search_function() {
            var keywords = $("#keyword").val();
            window.location.href = "<%=path%>/IndexSearch/skip?keyword=" + encodeURI(encodeURI(keywords));
            /*$.get("/resourcePrivate/backResourceRecycle?resourceId=" + resourceId, function (data) {
             })*/
        }

    </script>
</div>
<!-- 专区部分 -->
<!-- footer -->
<div class="clearfix"></div>

<div id="bottomJsp"></div>


</body>
<script>

    $(function () {
        //载入搜索按钮事件
        $(".searchBtn").click(function () {
            search_function();
        });
        //搜索栏，回车事件
        $("#keyword").bind("keypress", function (event) {
            if (event.keyCode == "13") {
                search_function();
            }
        });
    });

</script>
</html>
<style>
    .logindivclass {

    }

    .logindivclass2 {
        display: none;
    }

    .logoutdivclass {
        display: none;
    }

    .logoutdivclass2 {
        display: block;
    }
</style>
