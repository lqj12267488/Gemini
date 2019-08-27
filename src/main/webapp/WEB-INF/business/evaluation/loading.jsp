<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">请稍后</h4>
        </div>
        <div class="modal-body clearfix" style="height: 350px;text-align: center">
            <div  id="layout" class="loading" style="z-index:999;position:absolute;width: 100%;height: 100%;text-align: center">
                <br/><br/><br/>
                <img src="<%=request.getContextPath()%>/libs/img/app/loading2.gif" style="width:100px;height: 100px;text-align: center"/>
                <br/><br/><br/>
                <h3  style="size: 20px;color: #bb1111;"><B>正在加载，请稍后……</B></h3>
            </div>
        </div>
    </div>
</div>
<script>
</script>