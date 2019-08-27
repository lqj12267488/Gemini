<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/jquery/jquery.min.js'></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/libs/css/resourcelibrary/style.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/libs/css/resourcelibrary/tableStyle.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/libs/css/resourcelibrary/dialogStyle.css">

<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/Commons.js'></script>

<%--
<script type="text/javascript" src="/libs/js/resourcelibrary/tween.js"></script>
--%>
<link rel="icon" type="image/ico" href="favicon.ico"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/jquery.mousewheel.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/resourcelibrary/event.js"></script>
<body>
<div id="topJsp"></div>
<div class="clearfix"></div>

<div class="banner1">
    <div class="tabmain">
        <ul class="tabGroup" style="margin-top:0px">
            <li class="tabOption selectedTab" onclick="checkModle('myResourceLibrary')" id="myResourceLibrary"><p>我的资源库</p></li>
            <li class="tabOption" onclick="checkModle('myCollection')" id="myCollection"><p>我的收藏</p></li>
            <li class="tabOption" onclick="checkModle('myApply')" id="myApply"><p>我的申请</p></li>
            <li class="tabOption" onclick="checkModle('myCustom')" id="myCustom"><p>我的资源分类</p></li>
            <li class="tabOption" onclick="checkModle('myRecyclebin')" id="myRecyclebin"><p>我的回收站</p></li>
            <li class="tabOption" onclick="checkModle('myFootprint')" id="myFootprint"><p>我的足迹</p></li>
            <li class="tabOption" onclick="checkModle('myRankingList')" id="myRankingList"><p>排行榜</p></li>
        </ul>
        <div id="container1" style="overflow:hidden; margin:0px auto; min-height:480px; padding:20px 2%">
        </div>
    </div>
</div>
<div class="modal modal-draggable" id="audit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
</div>
<div class="modal modal-draggable" id="dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
</div>
<div class="modal modal-draggable" id="dialogFile" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
</div>
<script>
    $(document).ready(function () {
        $("#topJsp").load("<%=request.getContextPath()%>/resourcePublic/getPublicTop");
    })

    $(document).ready(function () {
        checkModle( "myResourceLibrary" );
    })

    var content=document.getElementById('content');

    function checkModle(type) {
        $("li").removeClass("selectedTab");
        $("#"+type).addClass("selectedTab");

        var url ="";
        if(type == "myResourceLibrary"){//我的资源库
            url ="<%=request.getContextPath()%>/resourcePrivate/myResourceLibrary";
        }else if(type == "myCollection"){//我的收藏
            url ="<%=request.getContextPath()%>/resourceLibrary/collection/myResourceCollectionList";
        }else if(type == "myApply"){//我的申请
            url ="<%=request.getContextPath()%>/resourceLibrary/approval/myApprovalList";
        }else if(type == "myCustom"){//我的资源分类
            url ="<%=request.getContextPath()%>/resourceLibrary/typeCustom/myReasourceClassify";
        }else if(type == "myRecyclebin"){//我的回收站
            url ="<%=request.getContextPath()%>/resourcePrivate/toMyResourceRecycle";
        }else if(type == "myFootprint"){//我的足迹
            url ="<%=request.getContextPath()%>/resourcePrivate/toMyLogList";
        }else if(type == "myRankingList"){//排行榜
            url ="<%=request.getContextPath()%>/building";
        }

        $("#container1").load(url);
    }

    function closeDialog() {
        $("#dialog").css('display','none');
    }

</script>
</div>
<!-- 专区部分 -->
<!-- footer -->

<div class="clearfix"></div>

<div id="bottomJsp"></div>
</body>
</html>
<style>
    .logindivclass {

    }
    .logindivclass2{
        display:none;
    }

    .logoutdivclass {
        display:none;
    }
    .logoutdivclass2{
        display:block;
    }
</style>
