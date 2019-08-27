<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div style="width: 100%;height: 100%;">
    <br/><br/><br/>
    <div id="saveLoadingHeight"></div>
    <img src="<%=request.getContextPath()%>/libs/img/app/loading.gif" style="width:100px;height: 100px;text-align: center"/>
    <br/><br/><br/>
    <h3  style="size: 20px;color: #bb1111;"><B>正在提交，请稍后……</B></h3>
</div>
<script>
    function showSaveLoading() {
        $('.modal-dialog').css('opacity','');
        $("#layout").css('display','block');
//        $(".modal-footer button").attr('disabled',"disabled");

        $('#saveBtn').attr('disabled',"disabled");
    }

    function hideSaveLoading() {
        $('.modal-dialog').remove('opacity');
        $('#saveBtn').removeAttr("disabled");
        $("#layout").css('display','none');
        //        $(".modal-footer button").removeAttr("disabled");

    }

    function showSaveLoadingByClass(butClass) {
        $("#layout").css('display','block');
//        $(".modal-footer button").attr('disabled',"disabled");

        $(butClass).attr('disabled',"disabled");
        $(".mainBodyClass").css('opacity','');
    }

    function hideSaveLoadingByClass(butClass) {
        $(butClass).removeAttr("disabled");
        $("#layout").css('display','none');
        //        $(".modal-footer button").removeAttr("disabled");
        $(".mainBodyClass").remove('opacity');
    }



</script>