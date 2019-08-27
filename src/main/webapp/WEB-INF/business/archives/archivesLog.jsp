<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">

                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                操作类型：
                            </div>
                            <div class="col-md-2">
                                <select id="typeSelect" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <%--<div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addComputer()">新增</button><br>
                    </div>--%>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="archivesLogGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var archivesLogTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_CZLX", function (data) {
            addOption(data, "typeSelect");
        })
        archivesLogTable = $("#archivesLogGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/archives/getArchivesLogList',
            },
            "destroy": true,
            "columns": [
                {"data": "logId", "visible": false},
                //{"width": "16%", "data": "archivesId", "title": "档案编码"},
                {"width": "16%","data": "operateType", "title": "操作类型"},
                {"width": "16%", "data": "deptId", "title": "操作部门"},
                {"width": "16%", "data": "personId", "title": "操作人"},
                {"width": "20%", "data": "remark", "title": "操作说明"},
                {"width": "16%", "data": "operateTime", "title": "操作时间"},
                // {
                //     "width": "10%",
                //     "title": "操作",
                //     "render": function () {
                //         return render;
                //     }
                // }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        archivesLogTable.on('click', 'tr a', function () {
            var data = archivesLogTable.row($(this).parent()).data();
            var id = data.id;
            var reason = data.reason;
            if (this.id == "uComputer") {
                $("#dialog").load("<%=request.getContextPath()%>/computer/getComputerById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delComputer") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "申请事由："+reason+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/computer/deleteComputerById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#archivesLogGrid').DataTable().ajax.reload();
                        }
                    })

                });

            }
        });
    })
    function searchclear() {
        $("#typeSelect").val("");
        $("#typeSelect option:selected").val("");
        search();
    }

    function search() {
        var seltype=$("#typeSelect option:selected").val();
        archivesLogTable.ajax.url("<%=request.getContextPath()%>/archives/getArchivesLogList?operateType="+seltype).load();
    }

</script>
