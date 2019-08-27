<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
%>
<script type='text/javascript' src='<%=path%>/libs/js/plugins/jquery/jquery.min.js'></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/libs/css/resourcelibrary/style.css">
<%--
<script type="text/javascript" src="/libs/js/resourcelibrary/tween.js"></script>
--%>
<script type="text/javascript" src="<%=path%>/libs/js/resourcelibrary/event.js"></script>
<script type="text/javascript" src="<%=path%>/libs/js/resourcelibrary/resourceFilesAction.js"></script>
<script type="text/javascript" src="<%=path%>/libs/js/resourcelibrary/video-js/video-js.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/libs/css/resourcelibrary/video-js/video-js.css">
<div class="centent_zy_left">
    <h1>您当前的位置：<a href="<%=path%>/resourceLibrary/toIndex">首页</a>  &gt; ${resourcePublic.resourceSubjectIdShow} &gt; ${resourcePublic.resourceMajorIdShow} &gt; ${resourcePublic.resourceCourseIdShow}</h1>
    <h2>${resourcePublic.resourceName}
        <a class="xz" href="#"
           onclick="downResourceFiles('${resourceFiles.fileId}','${resourceFiles.fileUrl}','${resourceFiles.fileName}','<%=request.getContextPath()%>')">
            <img src="<%=path%>/libs/img/resourcelibrary/btn-1.jpg" width="80" height="26">
        </a>
        <a id="collectionDiv" class="xz" href="#"
           onclick="collectionResourceFiles('${resourcePublic.resourceId}','${resourcePublic.collection}','<%=request.getContextPath()%>')">
            <img src="<%=path%>/libs/img/resourcelibrary/collection-${resourcePublic.collection}.jpg" width="80" height="26">
        </a>
    </h2>
    <h3>  专业：${resourcePublic.resourceMajorIdShow}  ｜  格式：${resourcePublic.resourceFormatShow} <br>
        大小：${resourceFiles.fileSize} ｜  浏览量：<a id="view"></a>  ｜  下载量：<a id="down"></a>  ｜  上传时间：${resourcePublic.publicTime}</h3>
    <%-- <img src="${resourceFiles.fileUrl}">     --%>
    <%--<video src="${fileView}" />--%>
    <div class="cj">
<%--
        <video width="320"  src="${fileView}" height="240" controls="controls">

            Your browser does not support the video tag.
        </video>
--%>
<%--
    <video src="${resourceFiles.fileUrl}" controls="controls" width="320" height="240"></video>
--%>
    <video id="example_video_1" class="video-js" controls="controls"  preload="auto" width="auto" width="100%" height="480" data-setup="{}">
        <source src="<%=path%>${fileView}" type="video/mp4" />
        <track kind="captions" src="demo.captions.vtt" srclang="en" label="English"></track>
        <track kind="subtitles" src="demo.captions.vtt" srclang="en" label="English"></track>
    </video>
        <p class="lhj_xz_txt">
            <span>资源简介：</span>${resourcePublic.remark}
        </p>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#down").text( $("#downCount").val() );
        $("#view").text( $("#viewCount").val() );
        selectResourceAbout('${resourcePublic.resourceCourseId}','<%=path%>');
    })



</script>