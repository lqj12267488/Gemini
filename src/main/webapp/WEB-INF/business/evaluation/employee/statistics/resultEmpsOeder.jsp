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
                    <span style="font-size: 15px;margin-left: 20px"> ${taskName} > 查看</span>
                </div>
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <a class="btn btn-default btn-clean"
                           href="<%=request.getContextPath()%>/evaluation/exportEvaluationResult?id=${id}&name=${taskName}&flag=0&evaluationType=${evaluationType}">导出
                        </a>
                        <br>
                    </div>
                    <table id="taskOrderTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
    <input id="eType" hidden value="${evaluationType}">
</div>
<script>
    var eType = $("#eType").val();
    var taskOrderTable;
    $(document).ready(function () {
        taskOrderTable = $("#taskOrderTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/evaluation/statistics/getMonitoerEmpsOeder?taskId=' + '${id}'+'&evaluationType='+eType,
            },
            "destroy": true,
            "columns": [
                {"data": "totalOrder","title": "排名"},
                {"data": "name", "title": "被评人"},
                {"data": "deptShow", "title": "被评人部门"},
                {"data": "schedule", "title": "进度"},
                {"data": "total", "title": "总分"},
                {"data": "empsId", "visible": false},
                {"data": "personId", "visible": false}
            ],
            "dom": 'rtlip',
            "language": language,
            "order" : [[0,"asc"],[1,"desc"]]
        });
    })

    function back() {
        $("#right").load("<%=request.getContextPath()%>/evaluation/statistics/order");
    }

</script>