<%--
  Created by IntelliJ IDEA.
  User: hanyue
  Date: 2018/10/31
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
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
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                教师名称:
                            </div>
                            <div class="col-md-3">
                                <input id="teacherNameSel" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                教师编号:
                            </div>
                            <div class="col-md-3">
                                <input id="teacherNumberSel" type="text"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
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
                "url": '<%=request.getContextPath()%>/evaluation/getMonitoerSummaryByTaskId?id=' + '${id}'+'&evaluationType='+$("#eType").val(),
            },
            "destroy": true,
            "columns": [
                {"data": "empsId", "visible": false},
                {"data": "personId", "visible": false},
                {"data": "name", "title": "被评人"},
                {"data": "staffId", "title": "教师编号"},
                {"data": "deptShow", "title": "被评人部门"},
                {"data": "schedule", "title": "进度"},
                {"data": "total", "title": "总分"}
            ],
            "dom": 'rtlip',
            "language": language
        });
    })

    function search() {
        var taskNameSel = $("#teacherNameSel").val();
        var planNameSel = $("#teacherNumberSel").val();
        taskTable.ajax.url("<%=request.getContextPath()%>/evaluation/getMonitoerSummaryByTaskId"
            +"?id=" + '${id}'+"&name="+ taskNameSel +"&staffId="+planNameSel+"&evaluationType="+$("#eType").val()
        ).load();
    }
    function searchclear() {
        $("#teacherNameSel").val("");
        $("#teacherNumberSel").val("");
        search();
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/evaluation/result/summaryEvaluationPush");
    }

</script>