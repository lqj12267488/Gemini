<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="middleCss" style="width: 100%">
    <br/>
    <div id="saveLoadingHeight"></div>
    <img src="<%=request.getContextPath()%>/libs/img/app/loading.gif" style="height: 50px;text-align: center"/>
    <br/>
    <h3  style="size: 20px;color: #98989d;"><B>正在提交，请稍后……</B></h3>

</div>
<script>
    function showSaveLoading(buttonId) {
        $('.mainBodyClass').css('opacity','0.2');
        $("#layout").css('display','block');

        $(buttonId).attr('disabled',"disabled");
    }

    function hideSaveLoading(buttonId) {
        $('.mainBodyClass').css('opacity','');
        $(buttonId).removeAttr("disabled");
        $("#layout").css('display','none');
    }

    function showSaveLoadingByClass(buttonId) {
        $('.mainBodyClass').css('opacity','0.2');
        $("#layout").css('display','block');

        $(buttonId).attr('disabled',"disabled");
    }

    function hideSaveLoadingByClass(buttonId) {
        $('.mainBodyClass').css('opacity','');
        $(buttonId).removeAttr("disabled");
        $("#layout").css('display','none');
    }

</script>
<style>
    .middleCss{
        position: fixed;
        /*position: absolute;*/
        top: 25%;
/*
        left: 50%;
        -webkit-transform: translate(-50%, -50%);
        -moz-transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        -o-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
*/
    }
</style>