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
                <%--<div class="header">
                </div>--%>
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
                                被评教人:
                            </div>
                            <div class="col-md-3">
                                <input id="empNameSel" type="text" />
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
                    <table id="empEvalTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var empEvalTable;
    var eType ='0';
    $(document).ready(function () {
        empEvalTable = $("#empEvalTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/evaluation/result/getlistePeerMenmbers?evaluationFlag=1&evaluationType='+eType
            },
            "destroy": true,
            "columns": [
                {"data": "taskId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "empPersonId", "visible": false},
                {"data": "empDeptId", "visible": false},
                {"data": "endTime", "visible": false},
                {"data": "planId", "visible": false},
                {"width": "25%", "data": "taskName", "title": "评教任务名称"},
                {"width": "10%", "data": "empName", "title": "被评教人"},
                {"width": "25%", "data": "empDeptShow", "title": "被评教人部门"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (date,type,row) {
                        return '<a class="icon-edit" title="查看" id="result" />';
                    }
                }
            ],
            'order' : [[1,'desc'],[7,'asc']],
            "dom": 'rtlip',
            language: language
        });

        empEvalTable.on('click', 'tr a', function () {
            var data = empEvalTable.row($(this).parent()).data();
            if (this.id == "result") {
                evalutionEmp(data.taskId ,data.empPersonId,data.empDeptId,data.endTime ,data.planId,data.taskName,data.empName);
            }
        });

        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#empNameSel").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#empNameSel").val(ui.item.label);
                    $("#empNameSel").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

    })

    function evalutionEmp(taskId,empPersonId,empDeptId,endTime,planId,taskName,empName) {
        $("#dialog").load("<%=request.getContextPath()%>/evaluation/result/searchListResult", {
            taskId: taskId,
            empPersonId: empPersonId,
            empDeptId: empDeptId,
            planId: planId,
            taskName: taskName,
            empName: empName,
        });
        $("#dialog").modal("show");
    }

    function updateEmpsMenmbers(taskId) {
        swal({title: "此评教已超期！", type: "error"});
        $.post("<%=request.getContextPath()%>/evaluation/result/updateEmpsMenmbers",
            {taskId:taskId},
            function (msg) {
                empEvalTable.ajax.reload();
            })
    }

    function search() {
        var taskNameSel = $("#taskNameSel").val();
        var empPersonId =$("#empNameSel").attr("keycode");
        empEvalTable.ajax.url("<%=request.getContextPath()%>/evaluation/result/getlistePeerMenmbers?"+
            "empPersonId="+empPersonId +"&" +
            "evaluationFlag=1" +"&" +
            "evaluationType=" +eType +"&" +
            "taskName=" + taskNameSel ).load()
    }

    function searchclear() {
        $("#taskNameSel").val("");
        $("#empNameSel").attr("keycode","");
        $("#empNameSel").val("");
        search();
    }

</script>