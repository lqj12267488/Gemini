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
<style>
    table tr th {
        text-align: center;
    }

    table tr td {
        text-align: center;
    }

    th, td {
        white-space: nowrap;
    }

</style>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${taskName} > 详情</span>
                </div>
                <div class="content" style="overflow-x:scroll;">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <br>
                    </div>
                    <div class="form-group">
                        <table id="taskDetailsTable"
                               class="table table-bordered table-striped sortable_default">
                            <thead>
                            <tr id="tr1">

                            </tr>
                            <tr id="tr2">

                            </tr>
                            <tr id="tr3">
                            </tr>
                            <tr>
                                <c:forEach items="${indices}" var="index">
                                    <c:if test="${index.leafFlag == '1'}">
                                        <th>
                                            评分
                                        </th>
                                        <th>
                                            评语
                                        </th>
                                    </c:if>
                                </c:forEach>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal" id="invalid" tabindex="-1" role="dialog"
             aria-labelledby="myModalLabel"
             aria-hidden="true">
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#dialog").modal("hide");

        <c:if test="${maxLevel == 1}">
            $("#tr2").remove()
        $("#tr3").remove()
        </c:if>
        <c:if test="${maxLevel == 2}">
        $("#tr3").remove()
        </c:if>
        var th1 = '<th rowspan="${maxLevel + 1}">评委</th><th rowspan="${maxLevel + 1}">评教状态</th>' +
            '<th rowspan="${maxLevel + 1}">得分</th><th rowspan="${maxLevel + 1}">是否废票</th>';
        var th2;
        var th3;
        <%--var th4 = '<th rowspan="${maxLevel + 1}">操作</th>';--%>
        <c:forEach items="${indices}" var="index">
            <c:if test="${index.leafFlag == '1' && index.indexLevel == '1'}">
                th1 += '<th rowspan="${(maxLevel - index.indexLevel) + 1}"colspan="${index.colspan * 2}">' +
                    '${index.indexName}' + '</th>';
            </c:if>
            <c:if test="${index.leafFlag != '1' && index.indexLevel == '1'}">
                th1 += '<th colspan="${index.colspan * 2}">${index.indexName}</th>';
                <c:forEach items="${indices}" var="index2">
                    <c:if test="${index2.parentIndexId == index.indexId && index2.leafFlag == '1'&& index2.indexLevel=='2'}">
                        th2 += '<th rowspan="${(maxLevel - index2.indexLevel) + 1}"colspan="${index2.colspan * 2}">' + '${index2.indexName}' + '</th>';
                    </c:if>
                    <c:if test="${index2.parentIndexId == index.indexId && index2.leafFlag != '1'&& index2.indexLevel=='2'}">
                        th2 += '<th colspan="${index2.colspan * 2}">${index2.indexName}</th>';
                        <c:forEach items="${indices}" var="index3">
                            <c:if test="${index3.parentIndexId == index2.indexId && index3.leafFlag=='1' && index3.indexLevel=='3'}">
                                th3 += '<th rowspan="${(maxLevel - index3.indexLevel) + 1}"colspan="${index3.colspan * 2}">'+ '${index3.indexName}' + '</th>';
                            </c:if>
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </c:if>
        </c:forEach>
        $("#tr1").html(th1);// + th4
        $("#tr2").html(th2);
        $("#tr3").html(th3);

        taskDetailsTable = $("#taskDetailsTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/evaluation/getDetails?id=' + '${id}' + '&taskId=' + '${taskId}',
            },
            "destroy": true,
            "order": [[ 1, 'asc' ]],
            "columns": [
                {"data":"score"},
                {"data": "evaluationFlag"},
                {"data": "score"},
                {"data": "invalidFlag"},
                <c:forEach items="${indices}" var="index">
                    <c:if test="${index.leafFlag == '1' && index.indexLevel == '1'}">
                    {"data": "${index.indexId}-score"},
                    {"data": "${index.indexId}-remark"},
                    </c:if>
                    <c:if test="${index.leafFlag != '1' && index.indexLevel == '1'}">
                    <c:forEach items="${indices}" var="index2">
                        <c:if test="${index2.parentIndexId == index.indexId &&
                                index2.leafFlag == '1'&& index2.indexLevel=='2'}">
                        {"data": "${index2.indexId}-score"},
                        {"data": "${index2.indexId}-remark"},
                        </c:if>
                        <c:if test="${index2.parentIndexId == index.indexId &&
                                index2.leafFlag != '1'&& index2.indexLevel=='2'}">
                            <c:forEach items="${indices}" var="index3">
                                <c:if test="${index3.parentIndexId == index2.indexId &&
                                            index3.leafFlag=='1' && index3.indexLevel=='3'}">
                                {"data": "${index3.indexId}-score"},
                                {"data": "${index3.indexId}-remark"},
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                    </c:if>
                </c:forEach>
            ],
            "dom": 'rtlip',
            "language": language
        })
        taskDetailsTable.on( 'order.dt search.dt', function () {
            taskDetailsTable.column(0, {search:'applied', order:'applied'}).nodes().each(
                function (cell, i) {
                    var count = i+1;
                    cell.innerHTML = '评委 '+count;
                });
        }).draw();
    })


    function back() {
        $("#right").load("<%=request.getContextPath()%>/evaluation/statistics/monitorBySelf");
    }

</script>