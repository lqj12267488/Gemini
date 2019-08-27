<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
%>
<script type='text/javascript' src='<%=path%>/libs/js/plugins/jquery/jquery.min.js'></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/libs/css/resourcelibrary/style.css">
<script type="text/javascript" src="<%=path%>/libs/js/resourcelibrary/tween.js"></script>
<script type="text/javascript" src="<%=path%>/libs/js/resourcelibrary/event.js"></script>
<script type="text/javascript" src="<%=path%>/libs/js/resourcelibrary/resourceFilesAction.js"></script>
<div class="centent_zy_left">
    <h1>您当前的位置：<a href="<%=path%>/resourceLibrary/toIndex">首页</a> &gt; ${resourcePublic.resourceSubjectIdShow}
        &gt; ${resourcePublic.resourceMajorIdShow} &gt; ${resourcePublic.resourceCourseIdShow}</h1>
    <h2>${resourcePublic.resourceName}
        <a class="xz" href="#"
           onclick="downResourceFiles('${resourceFiles.fileId}','${resourceFiles.fileUrl}','${resourceFiles.fileName}','<%=path%>')">
            <img src="<%=path%>/libs/img/resourcelibrary/btn-1.jpg" width="80" height="26">
        </a>
        <a id="collectionDiv" class="xz" href="#"
           onclick="collectionResourceFiles('${resourcePublic.resourceId}','${resourcePublic.collection}','<%=path%>')">
            <img style="max-width: 800px"
                 src="<%=path%>/libs/img/resourcelibrary/collection-${resourcePublic.collection}.jpg" width="80"
                 height="26">
        </a>
    </h2>
    <h3> 专业：${resourcePublic.resourceMajorIdShow} ｜ 格式：${resourcePublic.resourceFormatShow} <br>
        大小：${resourceFiles.fileSize} ｜ 浏览量：<a id="view"></a> ｜ 下载量：<a id="down"></a> ｜ 上传时间：${resourcePublic.publicTime}
    </h3>
    <div class="cj">
        <img  width="70%" height="350px"   src="<%=path%>${resourceFiles.fileUrl}">
        <p class="lhj_xz_txt">
            <span>资源简介：</span>${resourcePublic.remark}
        </p>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#down").text($("#downCount").val());
        $("#view").text($("#viewCount").val());
        selectResourceAbout('${resourcePublic.resourceCourseId}', '<%=path%>');
    })

</script>

