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
                "url": '<%=request.getContextPath()%>/resourceLibrary/files/getResourceFilesList',
            },
            "destroy": true,
            "columns": [
            {"data":"fileId","title":""},
{"data":"fileName","title":""},
{"data":"fileUrl","title":""},
{"data":"fileType","title":""},
{"data":"fileSize","title":""},
{"data":"coverUrl","title":""},
{"data":"coverType","title":""},
{"data":"tablename","title":""},
{"data":"businessId","title":""},
{"data":"businessType","title":""},
{"data":"sourceSystem","title":""},

                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.fileId + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.fileId + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/files/toResourceFilesAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/files/toResourceFilesEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id) {
        if (confirm("确定要删除这条记录？")) {
            $.get("<%=request.getContextPath()%>/resourceLibrary/files/delResourceFiles?id=" + id, function (data) {
                alert(data.msg);
                $('#table').DataTable().ajax.reload();
            })
        }
    }
</script>