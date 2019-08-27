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
                    <table id="taskTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var taskTable;
    var eType = '0';
    $(document).ready(function () {
        taskTable = $("#taskTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/evaluation/getMonitoerLeaderTask?evaluationType='+eType,
            },
            "destroy": true,
            "columns": [
                {"data": "taskId", "visible": false},
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
                        return '<span class="icon-edit" title="审核" onclick=toEmps("' + row.taskId +
                            '","' + row.taskName + '")/>';
                    },
                    "width": "8%"
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
        /* taskTable.on('click', '#edit', function () {
             var data = taskTable.row($(this).parent()).data();
             data.taskId = 1
             console.log(data)
         });*/
    })

    function toEmps(id, taskName) {
        $("#right").load("<%=request.getContextPath()%>/evaluation/toLeaders", {
            id: id,
            taskName: taskName,
            evaluationType:eType,
        });
    }

    function search() {
        var taskNameSel = $("#taskNameSel").val();
        var planNameSel = $("#planNameSel").val();
        taskTable.ajax.url("<%=request.getContextPath()%>/evaluation/getMonitoerLeaderTask"
            +"?taskname=" + taskNameSel +"&planName="+planNameSel +"&evaluationType="+eType
        ).load();
    }

    function searchclear() {
        $("#taskNameSel").val("");
        $("#planNameSel").val("");
        search();
    }

</script>