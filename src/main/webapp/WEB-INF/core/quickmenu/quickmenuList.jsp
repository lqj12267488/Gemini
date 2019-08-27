<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add(0)">教职快捷菜单编辑
                        </button><br>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add(1)">学生快捷菜单编辑
                        </button><br>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add(2)">家长快捷菜单编辑
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
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/quickmenu/getQuickmenuListByUser',
            },
            "destroy": true,
            "columns": [
                {"data":"userId","visible": false},
                {"data":"userName","title":"账户"},
                {"data":"deptName","title":"部门/班级"},
                {"data":"count","title":"快捷菜单数"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add(userId) {
        $("#dialog").load("<%=request.getContextPath()%>/quickmenu/toQuickmenuAdd?userId="+userId);
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/quickmenu/toQuickmenuEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/quickmenu/delQuickmenu?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#table').DataTable().ajax.reload();
                });
            })
        });
    }
</script>