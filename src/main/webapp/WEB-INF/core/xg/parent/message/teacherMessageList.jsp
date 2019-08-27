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
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="tableMessage" cellpadding="0" cellspacing="0"
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
    var tableMessage;
    $(document).ready(function () {
        tableMessage = $("#tableMessage").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/parent/getParentMessageListByTeacher',
            },
            "destroy": true,
            "columns": [
                {"data":"messageId", "visible": false},
                {"data":"title","title":"主题","width": "20%"},
                {"data":"message","title":"内容","width": "300px"},
                {"data":"typeShow","title":"类型","width": "10%"},
                {"data":"creatorShow","title":"填写人","width": "10%"},
                {"data":"readeFlag","title":"是否阅读","width": "10%"},
                {"data":"readeFlagShow","title":"是否阅读留言","width": "10%"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit-sign" title="查看" onclick=view("' + row.messageId + '")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.messageId + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/parent/toParentMessageAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/parent/toParentMessageEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function view(id) {
        $("#right").load("<%=request.getContextPath()%>/parent/toParentMessageView?id=" + id+"&identity=teacher");
    //    $("#dialog").modal("show")
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
            $.get("<%=request.getContextPath()%>/parent/delParentMessage?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#tableMessage').DataTable().ajax.reload();
                });
            })
        });
    }
</script>