<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="block block-drop-shadow content">
    <div class="form-row1 tk1" style="padding:0">
        <div style="overflow:hidden; display:block; float:left">
            <div style="overflow:hidden; display:block; width:280px; height:44px; padding:7px 10px; float:left">
                <div style="width: 100px; padding:0px 10px; display:block; float:left">操作类型：</div>
                <select id="operateTypeSel"  style="width: 160px;"/>
            </div>
        </div>
        <div style="overflow:hidden; width:140px; display:block;  padding:7px 10px; float:left">
            <button  type="button" class="btn btn-success" onclick="searchResource()">查询</button>
            <button  type="button" class="btn btn-success" onclick="searchclear()">清空</button>
        </div>
    </div>
    <div class="form-row block" style="overflow-y:auto;">
        <table id="tableLog" cellpadding="0" cellspacing="0"
               width="100%" style="max-height: 50%;min-height: 10%; margin:0px auto; margin-bottom:20px"
               class="table table-bordered table-striped sortable_default">
        </table>
    </div>

    <input hidden id="personId" value="${personId}">
</div>
<script>
    var tableLog;
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_CZLX", function (data) {
            addOption(data, "operateTypeSel");
        })

        tableLog = $("#tableLog").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourceLibrary/log/getPrivateResourceLogList?personId='+$("#personId").val(),
            },
            "destroy": true,
            "columns": [
                {"data":"logId","visible": false},
                {"data":"resourceName","title":"资源名称"},
                {"data":"operateTypeShow","title":"操作类型"},/*  使用ZYK_CZLX字典，1浏览，2上传，3下载，4删除  */
                {"data":"operateTime","title":"操作时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-eye-open" title="查看" onclick=view("' + row.resourceId + '","'+row.personId+'")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function view(resourceId,personId) {
        window.open("<%=request.getContextPath()%>/resourcePublic/getPublicResourceViewMain?resourceId="+resourceId+"&publicPersonId="+personId);
    }

    function searchclear() {
        $("#operateTypeSel").val("");
        searchResource();
    }

    function searchResource() {
        var operateType = $("#operateTypeSel option:selected").val();

        tableLog.ajax.url("<%=request.getContextPath()%>/resourceLibrary/log/getPrivateResourceLogList" +
            "?personId="+$("#personId").val()+ "&operateType="+operateType).load();
    }

</script>