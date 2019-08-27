<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
        </div>
        <div class="modal-body clearfix">
            <div class="form-row block" style="overflow-y:auto;">
                <table id="taskResult" cellpadding="0" cellspacing="0"
                       width="100%" style="max-height: 50%;min-height: 10%;"
                       class="table table-bordered table-striped sortable_default">
                </table>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    var taskResult;
    var ti = '${title}';
    $(document).ready(function () {
        taskResult = $("#taskResult").DataTable({
            "data": ${data},
            "destroy": true,
            "columns": [
                {"data": "name", "title": "被评人"},
                {"data": "deptShow", "title": ti},
                {"data": "schedule", "title": "进度"},
                {"data": "total", "title": "总分"},
            ],
            "dom": 'rtlip',
            "language": language
        });
    });


</script>