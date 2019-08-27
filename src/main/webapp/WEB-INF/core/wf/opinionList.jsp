<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <%--<div class="block block-drop-shadow content block-fill-white">

                </div>--%>
                <div class="block block-drop-shadow content">
                    <div>
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
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/opinion/getOpinionList',
            },
            "destroy": true,
            "columns": [
                {"data": "opinionContent", "title": "意见"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.opinionId +'")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.opinionId + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
        var data = table.row($(this).parent()).data();
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/opinion/toOpinionAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/opinion/toOpinionEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id,opinionContent) {
        //if (confirm("确定要删除这条记录？")) {
        swal({
            title: "您确定要删除本条信息?",
            //text: "意见："+opinionContent+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/opinion/delOpinion?id=" + id, function (data) {
                swal({
                    title: data.msg,
                    type: "success"
                });
                //alert(data.msg);
                $('#table').DataTable().ajax.reload();
            })
        })
    }
</script>