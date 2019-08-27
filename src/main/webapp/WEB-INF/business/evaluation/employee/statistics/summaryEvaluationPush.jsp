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
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                评教任务:
                            </div>
                            <div class="col-md-3">
                                <input id="taskNameSel" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                评教方案:
                            </div>
                            <div class="col-md-3">
                                <input id="planNameSel" type="text"/>
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
                    <table id="taskResultTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var taskResultTable;
    var eType = '0';
    $(document).ready(function () {
        taskResultTable = $("#taskResultTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/evaluation/getEvaluationSummaryPushTask?evaluationType='+eType,
            },
            "destroy": true,
            "columns": [
                {
                    "width": "10%",
                    "title": '<input type="checkbox" class="checkall"/>',
                    "render": function (data, type, row) {
                        return '<input type="checkbox" name="checkbox" value="'+row.taskId+'"/>';
                    }
                },
                {"data": "taskId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "15%", "data": "taskName", "title": "评教任务"},
                {"width": "15%", "data": "planName", "title": "评教方案"},
                {"width": "10%", "data": "term", "title": "学期"},
                {"width": "10%", "data": "groupName", "title": "评委组"},
                {"width": "10%", "data": "taskType", "title": "类型"},
                {"width": "10%", "data": "startTime", "title": "开始时间"},
                {"width": "10%", "data": "endTime", "title": "结束时间"},
                {"width": "10%", "data": "schedule", "title": "进度"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="查看" onclick=toEmps("' + row.taskId +
                            '","' + row.taskName + '")/>';
                    }
                }
            ],
            'order' : [2,'desc'],
            "dom": 'rtlip',
            "language": language
        });
    })
    function toEmps(id, taskName) {
        $("#right").load("<%=request.getContextPath()%>/evaluation/statistics/resultEvaluationSummaryPush", {
            id: id,
            taskName: taskName,
            evaluationType:eType,
        });
    }

    function search() {
        var taskNameSel = $("#taskNameSel").val();
        var planNameSel = $("#planNameSel").val();
        taskResultTable.ajax.url("<%=request.getContextPath()%>/evaluation/getEvaluationSummaryPushTask"
            +"?taskname="+ taskNameSel +"&planName="+planNameSel+"&evaluationType="+eType
        ).load();
    }
    function searchclear() {
        $("#taskNameSel").val("");
        $("#planNameSel").val("");
        search();
    }



</script>