<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>

<div class="modal-dialog" style="width: 800px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <input type="hidden" name="id" id="id" value="${id}">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <table id="table" cellpadding="0" cellspacing="0" width="100%"
                       class="table table-bordered table-striped sortable_default">
                    <thead>
                    <tr>
                        <th width="20%">班级</th>
                        <th width="20%">学生姓名</th>
                        <th width="20%">日志类型</th>
                        <th width="50%">日志内容</th>
                        <th width="20%">时间</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
        <div class="modal-footer"><%--新增页尾部--%>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        var id= $("#id").val();
        table = $("#table").DataTable({
            "ajax": {
                "url": "<%=request.getContextPath()%>/dorm/getLogList?id="+id ,
            },
            "columns": [
                {"data": "classShow"},
                {"data": "studentName"},
                {"data": "logTypeShow"},
                {"data": "content"},
                {"data": "logTime"},
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [4, 'desc'],
            "dom": 'rt',
            language: language
        });
    });
</script>





