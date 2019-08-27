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
    <img src="<%=path%>/libs/img/resourcelibrary/fileLose.png" style="height: 100%">
</div>
<script>
    $(document).ready(function () {
        $("#down").text( $("#downCount").val() );
        $("#view").text( $("#viewCount").val() );
    })

</script>

