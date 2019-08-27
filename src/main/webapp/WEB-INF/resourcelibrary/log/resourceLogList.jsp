<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            操作人
                        </div>
                        <div class="col-md-2">
                            <input id="personId" >
                        </div>
                        <div class="col-md-1 tar">
                            操作类型
                        </div>
                        <div class="col-md-2">
                            <select id="operateType" />
                        </div>
                        <div class="col-md-3 tar">
                            <button type="button" class="btn btn-default btn-clean pull-right"
                                    onclick="searchclear()">清空
                            </button>

                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="searchResource()">查询
                            </button>

                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="tableLog" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var tableLog;
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_CZLX", function (data) {
            addOption(data, "operateType");
        })
        autoComplateOption("personId", "<%=request.getContextPath()%>/common/getPersonDeptByPname");

        tableLog = $("#tableLog").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourceLibrary/log/getResourceLogList',
            },
            "destroy": true,
            "columns": [
                {"data":"logId","visible": false},
                {"data":"resourceName","title":"资源名称"},
                {"data":"personIdShow","title":"操作人"},
                {"data":"operateTypeShow","title":"操作类型"},/*  使用ZYK_CZLX字典，1浏览，2上传，3下载，4删除  */
                {"data":"operateTime","title":"操作时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-trash" title="删除" onclick=del("' + row.logId + '","'+row.resourceName+'")></span>';
                    }
                }
            ],
            'order' : [4,'desc'],
            "dom": 'rtlip',
            language: language
        });
    })

    function del(id,resourceName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "资源名称：《 "+resourceName+" 》 ，   删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {

            $.post("<%=request.getContextPath()%>/resourceLibrary/log/delResourceLog", {
                id: id
            }, function (msg) {
                swal({title: msg.msg,type: msg.result});
                $('#tableLog').DataTable().ajax.reload();
            });
        })
    }

    function searchclear() {
        $("#personId").val("");
        $("#personId").attr("keycode","");
        $("#operateType").val("");
        searchResource();
    }

    function searchResource() {
        var personId = $("#personId").attr("keycode");
        if(personId!=undefined &&personId!="" && personId!="undefined"){
            personId = personId.split(",")[1];
        }else{
            $("#personId").val('');
            personId = "";
        }
        var operateType = $("#operateType option:selected").val();

        tableLog.ajax.url("<%=request.getContextPath()%>/resourceLibrary/log/getResourceLogList" +
            "?personId="+personId+ "&operateType="+operateType).load();
    }

</script>