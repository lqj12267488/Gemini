<%--资产报废管理待办事项页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/4/14
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
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <input id="dept"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="jbr"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">
                                    查询</button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="softInstallGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var roleTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/slowExamination/selectDept", function (data) {
            $("#dept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#dept").val(ui.item.label);
                    $("#dept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/slowExamination/getPerson", function (data) {
            $("#jbr").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#jbr").val(ui.item.label);
                    $("#jbr").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        search();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            //办理
            if (this.id == "transact") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_JW_SLOW_EXAMINATION",
                    businessId: id,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: id,
                            tableName: "T_JW_SLOW_EXAMINATION",
                            url: "/slowExamination/auditEdit?id=" + id,
                            backUrl: "/slowExamination/requestProcess"
                        });
                    }
                })
            }
            //修改
            if (this.id == "update") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_JW_SLOW_EXAMINATION",
                    businessId: id,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: id,
                            tableName: "T_JW_SLOW_EXAMINATION",
                            url: "<%=request.getContextPath()%>/slowExamination/auditEditSlowExamination?id=" + id,
                            backUrl: "<%=request.getContextPath()%>/slowExamination/requestProcess"
                        });
                    }
                })
            }
        });
    });

    function searchclear() {
        $("#dept").val("");
        $("#jbr").val("");
        $("#date").val("");
        search();
    }

    function search() {
        var dept = $("#dept").val();
        if (dept != "")
            dept = '%' + dept + '%';
        var jbr = $("#jbr").val();
        if (jbr != "")
            jbr = '%' + jbr + '%';
        var date = $("#date").val();
        if (date != "") {
            date = '%' + date + '%';
        }
        roleTable = $("#softInstallGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/slowExamination/getSlowExaminationProcessList',
                "data": {
                    manager: jbr,
                    requestDate: date,
                    requestDept: dept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "12%", "data": "termId", "title": "学期"},
                {"width": "12%", "data": "requestDept", "title": "系部"},
                {"width": "12%", "data": "classId", "title": "班级"},
                {"width": "10%", "data": "manager", "title": "姓名"},
                {"width": "12%", "data": "courseId", "title": "缓考科目"},
                {"width": "12%", "data": "reason", "title": "缓考原因"},
                {"width": "12%", "data": "requestDate", "title": "申请日期"},
                {"width": "12%", "data": "remark", "title": "备注"},
                {
                    "width": "8%","title": "操作",
                    "render": function () {
                        return "<a id='transact' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='update' class='icon-edit' title='修改'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
</script>

