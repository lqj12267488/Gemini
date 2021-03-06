<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block block-drop-shadow">
                <div class="content block-fill-white">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            姓名
                        </div>
                        <div class="col-md-2">
                            <input id="nameShow"/>
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
            </div>
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="toImportExcel();">导入
                        </button>
                        <br>
                    </div>
                    <div class="form-row block">
                        <table id="table" class="table table-bordered table-striped sortable_default">
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
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teach/getTeachClass',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "teacherId", "title": "姓名"},
                {"data": "classId", "title": "班级"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delData("' + row.id + '")></span>&nbsp;&nbsp;&nbsp;';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    });

    function searchclear() {
        $("#nameShow").val("");
        search()
    }

    function search() {
        var nameShow = $("#nameShow").val();
        table.ajax.url("<%=request.getContextPath()%>/teach/getTeachClass?nameShow=" + nameShow).load();
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/teach/toEditTeachClass");
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/teach/toEditTeachClass?id=" + id);
        $("#dialog").modal("show")
    }

    function delData(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/teach/deleteTeachClass?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#table').DataTable().ajax.reload();
                });
            })
        });
    }

    function toImportExcel() {
        $("#dialog").load("<%=request.getContextPath()%>/teach/toImportExcel?flag=1");
        $("#dialog").modal("show");
    }
</script>