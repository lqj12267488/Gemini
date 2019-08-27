<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/25
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
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
                            <div class="col-md-2 tar">
                                评教任务名称:
                            </div>
                            <div class="col-md-4">
                                <input id="taskNameSel"/>
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
                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="taskResultTable" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="studentId" value="${studentId}" hidden>
</div>
<script>
    var taskResultTable;
    $(document).ready(function () {
/*
        $.get("/common/getSysDict?name=XQ", function (data) {
            addOption(data, 's_term','$ {arrayClass.term}');
        });
*/

        taskResultTable = $("#taskResultTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/core/parent/getStudentTask?creator='+
                            $("#studentId").val()+'&evaluationType=1'
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
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return  '<span class="icon-tags" title="详细" ' +
                            'onclick=toEmps("' + row.taskId + '","' + row.taskName + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            "language": language
        });

    })

    function searchclear() {
        $("#taskNameSel").val("");
        search();
    }
    function search() {
        var taskNameSel = '%'+$("#taskNameSel").val() +'%';
        taskResultTable.ajax.url("<%=request.getContextPath()%>/core/parent/getStudentTask" +
            '?creator='+ $("#studentId").val()+'&evaluationType=1'+'&taskName='+$("#taskNameSel").val() ).load();
    }

    function toEmps(taskId, taskName) {
        $("#dialog").load("<%=request.getContextPath()%>/core/parent/resultEmps", {
            head: '学生考评结果查看',
            taskId: taskId,
            taskName: taskName,
            evaluationType:'1',
            personId:$("#studentId").val()
        });
        $("#dialog").modal("show");

    }

</script>
