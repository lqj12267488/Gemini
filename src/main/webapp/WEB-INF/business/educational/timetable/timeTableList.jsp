<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content block-fill-white">

                    <input id="isDean" hidden value="${isDean}">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            课表名称:
                        </div>
                        <div class="col-md-2">
                            <input id="timeTableNameSearch" type="text"/>
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="search()">查询
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="searchclear()">清空
                            </button>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
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
    var table;
    var isDean = $("#isDean").val();
    console.error(isDean);
    $(document).ready(function () {
        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/timeTable/getTimetableList'
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "timeTableName", "title": "课程表名称"},
                {"data": "executionDate", "title": "执行日期"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        if (isDean == 1) {
                            return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                                '<span class="icon-eye-open" title="课程表管理" onclick=toTimeTableDepartment("' + row.id
                                + '","' + row.timeTableName + '")/>&ensp;&ensp;' +
                                '<a  href="<%=request.getContextPath()%>/timeTable/toExportTimeTable?id=' + row.id + '"><span class="icon-cloud-download" title="导出课程表" /></a>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.id + '","' + row.timeTableName + '")/>';
                        }


                        if (isDean == 0) {
                            return '<span class="icon-eye-open" title="课程表管理" onclick=toTimeTableDepartment("' + row.id + '","'
                                + row.timeTableName + '","' + row.sum + '","' + row.total + '")/>&ensp;&ensp;' +
                                '<a  href="<%=request.getContextPath()%>/timeTable/toExportTimeTable?id=' + row.id + '"><span class="icon-cloud-download" title="导出课程表" /></a>&ensp;&ensp;';
                        }


                    }
                }
            ],
            'order': [2, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/timeTable/toTimetableAdd", {});
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/timeTable/toTimetableAdd?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id, timeTableName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "课程表名称名称：" + timeTableName + "\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/timeTable/deleteTimeTable?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();
            })

        });
    }

    function toTimeTableDepartment(id, timeTableName, sum, total) {
        $("#right").load("<%=request.getContextPath()%>/timeTableDepartment/toTimeTableDepartment?timeTableName=" + timeTableName + "&id=" + id);
    }

    function search() {
        var timeTableNameSearch = $("#timeTableNameSearch").val();
        table.ajax.url("<%=request.getContextPath()%>/timeTable/getTimetableList?" + "timeTableName=" + timeTableNameSearch
        ).load();
    }

    function searchclear() {
        $("#timeTableNameSearch").val("");
        search();
    }


</script>
