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
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            学期:
                        </div>
                        <div class="col-md-2">
                            <select id="searchTerm"></select>
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
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'searchTerm');
        });
        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/courseconstruction/getTeachingCalendarList',
            },
            "destroy": true,
            "columns": [
                {"data": "term", "title": "学期"},
                {"data": "deptId", "title": "系部"},
                {"data": "creator", "title": "上传人"},
                {"data": "time", "title": "上传时间"},
                {"data": "fileNumber", "title": "附件数量"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-search" onclick=details("' + row.id + '")  title="详情"></span>&nbsp;&nbsp;&nbsp;';
                    }
                }
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    });

    function details(id) {
        $("#right").load("<%=request.getContextPath()%>/courseconstruction/details?id=" + id);
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/courseconstruction/editTeachingCalendar");
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/courseconstruction/editTeachingCalendar?id=" + id);
        $("#dialog").modal("show")
    }

    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            //text: "计划名称：" + planName + "\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/courseconstruction/deleteTeachingCalendar?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();
            })
        });
    }

    function search() {
        var term = $("#searchTerm").val();
        table.ajax.url("<%=request.getContextPath()%>/courseconstruction/getTeachingCalendarList?term=" + term).load();
    }

    function searchclear() {
        $("#searchTerm").val("");
        search();
    }

</script>