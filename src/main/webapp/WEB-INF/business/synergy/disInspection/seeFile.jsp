<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/9/5
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="<%=request.getContextPath()%>/libs/js/plugins/ssi-uploader/css/ssi-uploader.css">
<script src="<%=request.getContextPath()%>/libs/js/plugins/ssi-uploader/js/ssi-uploader.js"></script>
<div class="modal-dialog">
    <input id="tableName" hidden value="${tableName}">
    <input id="businessId" hidden value="${businessId}">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <span style="font-size: 14px">${head}</span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <table id="filesTable" cellpadding="0" cellspacing="0"
                   width="100%" style="max-height: 50%;min-height: 10%;"
                   class="table table-bordered table-striped sortable_default">
            </table>

        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#filesTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/files/getFilesByBusinessId?businessId=${businessId}',
            },
            "destroy": true,
            "columns": [
                {
                    "title": "文件名称",
                    "render": function (data, type, row) {
                        return '<a href="<%=request.getContextPath()%>/files/downloadFiles?id=' + row.fileId + '">' + row.fileName + '</a>';
                    }
                }
            ],
            "dom": 'rt',
            language: language
        });
    });
</script>
