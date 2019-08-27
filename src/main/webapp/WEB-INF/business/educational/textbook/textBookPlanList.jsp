<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/26
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addTextBookPlan()">
                            新增教材计划
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="textBookGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        searchBranch();

        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.id;
            var planName = data.planName;
            if (this.id == "editTextBookPlan") {
                $("#dialog").load("<%=request.getContextPath()%>/textbook/editTextBookPlan?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delTextBookPlan") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "教材计划名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/textbook/deleteTextBookPlanById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: msg.result
                        });
                        table.ajax.reload();
                    });
                })
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();
            }
        });
    });

    function addTextBookPlan() {
        $("#dialog").load("<%=request.getContextPath()%>/textbook/addTextBookPlan");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#textbookName").val("");
        searchBranch();
    }
    function searchBranch() {
        table = $("#textBookGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/textbook/getTextBookPlanList',
                "data": {
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "25%", "data": "planName", "title": "计划名称"},
                {"width": "25%", "data": "termShow", "title": "学期"},
                {"width": "20%", "data": "startTime", "title": "计划开始时间"},
                {"width": "20%", "data": "endTime", "title": "计划结束时间"},
                {
                    "width": "10%", "title": "操作", "render": function () {
                    return "<a id='editTextBookPlan' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='delTextBookPlan' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            'order': [2, 'desc'],
            "dom": 'rtlip',
            language: language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.id;
            var planName = data.planName;
            if (this.id == "editTextBookPlan") {
                $("#dialog").load("<%=request.getContextPath()%>/editPartyBranch?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delTextBookPlan") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "教材计划名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/textbook/deleteTextBookPlanById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: msg.result
                        });
                        table.ajax.reload();
                    });
                })
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();
            }
        });
    }
</script>
