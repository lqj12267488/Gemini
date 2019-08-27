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
            <h4 class="modal-title">签课人员</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="form-row block" style="overflow-y:auto;">
                <table id="signGrid" cellpadding="0" cellspacing="0"
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
    <input id="termId" hidden value="${termId}">
    <input id="signId" hidden value="${signId}">
</div>
<script>

    $(document).ready(function () {
        var signGrid = $("#signGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/coursesign/viewSignList',
                "data": {
                    termId: $("#termId").val(),
                    signId: $("#signId").val()
                }
            },
            "destroy": true,
            "columns": [
                {"width": "16.6%","data": "courseName", "title": "课程名称" },
                {"width": "16.6%","data": "personId", "title": "签课教师"},
                {"width": "16.6%","data": "deptId", "title": "教师部门"},
                {"width": "16.6%","data": "planId", "title": "教学计划"},
                {"width": "16.6%","data": "term", "title": "签课学期"},
                {"width": "16.7%","data": "classId", "title": "签课班级"}
            ],
            "dom": 'rtlip',
            language: language
        })
    })
</script>