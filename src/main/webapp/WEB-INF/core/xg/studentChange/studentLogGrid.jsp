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
<div class="modal-dialog"  style="width: 1200px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">异动日志</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="form-row block" style="overflow-y:auto;">
                <table id="personLogGrid" cellpadding="0" cellspacing="0"
                       width="100%" style="max-height: 50%;min-height: 10%;"
                       class="table table-bordered table-striped sortable_default">
                </table>
            </div>
        </div>
    <input id="studentId" value="${studentId}" hidden>
    </div>
</div>
<script>

    $(document).ready(function () {
        var personLogGrid = $("#personLogGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/studentChangeLog/searchGrid',
                "data": {
                    studentId: $("#studentId").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"width": "15%","data": "changeTypeShow", "title": "异动类型"},
                {"width": "35%","data": "oldContent", "title": "修改前信息"},
                {"width": "35%","data": "newContent", "title": "修改后信息"},
                {"width": "15%","data": "logTime", "title": "异动时间" },
            ],
            'order' : [3,'desc'],
            "dom": 'rtlip',
            language: language
        })
    })
</script>