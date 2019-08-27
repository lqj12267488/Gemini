<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">  ${taskName} > 查看</span>
                </div>
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <a class="btn btn-default btn-clean"
                           href="<%=request.getContextPath()%>/evaluation/exportEvaluationResultList?taskIds=${id}&evaluationType=${evaluationType}">导出
                        </a>
                        <br>
                    </div>
                    <table id="taskTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
    <input id="eType" hidden value="${evaluationType}">
</div>
<script>
    var taskTable;
    $(document).ready(function () {
        taskTable = $("#taskTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/evaluation/getMonitoerEmpsByTaskId?id=' + '${id}'+'&evaluationType='+$("#eType").val(),
            },
            "destroy": true,
            "columns": [
                {"data": "empsId", "visible": false},
                {"data": "personId", "visible": false},
                {"data": "name", "title": "被评人"},
                {"data": "deptShow", "title": "被评人部门"},
                {"data": "schedule", "title": "进度"},
                {"data": "total", "title": "总分"}
            ],
            "dom": 'rtlip',
            "language": language
        });
    })

    function toEmpDetails(id, taskId, name) {
        $("#right").load("<%=request.getContextPath()%>/evaluation/toEmpDetails", {
            id: id,
            taskId: taskId,
            name: name,
            taskName: "${taskName}"
        });
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/evaluation/statistics/queryParentResult");
    }

</script>