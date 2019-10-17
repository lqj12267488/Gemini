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
                                评教任务：
                            </div>
                            <div class="col-md-2">
                                <input id="taskNameSea" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
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
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
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
    var eType = '2';
    $(document).ready(function () {
        taskTable = $("#taskTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/evaluation/getInterviewersTasks?evaluationType=' + eType,
            },
            "destroy": true,
            "columns": [
                {"data": "taskId", "visible": false},
                {"data": "taskName", "title": "评教任务名称"},
                {"data": "planName", "title": "评教方案"},
                {"data": "term", "title": "学期"},
                {"data": "startTime", "title": "开始时间"},
                {"data": "endTime", "title": "结束时间"},
                {"data": "startFlagShow", "title": "启动<br>状态"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        var html = '<span class="icon-edit" title="修改" ' +
                            'onclick="edit(\'' + row.taskId + '\')"/>&ensp;' +
                            '<span class="icon-copy" title="复制评教任务" ' + ' ' +
                            'onclick="editCopy(\'' + row.taskId + '\')"/>&ensp;'+
                            ' <span class="icon-user" title="查看被评人" ' +
                            'onclick="toSelectEmps(\'' + row.taskId + '\',\'' + row.startFlag + '\')"/>&ensp;'+
                            ' <span class="icon-sitemap" title="查看评委组列表" ' +
                            'onclick="toSelectMembers(\'' + row.taskId + '\',\'' + row.startFlag + '\')"/>&ensp;' +
                            '<span class="icon-trash" title="删除" ' +
                            'onclick="del(\'' + row.taskId + '\',\'' + row.taskName + '\')"/>&ensp;';
                        if (row.startFlag == '0') {
                            html += '<span class="icon-cogs" title="启动评教" ' +
                                'onclick="start(\'' + row.taskId + '\',\'' + row.taskName + '\')"/>&ensp;';
                            html += '<span class="icon-cut" title="设置不计分比例" ' +
                                'onclick="SetProportion(\'' + row.taskId + '\',\'' + row.taskName + '\')"/>&ensp;';
                        }
                        if (row.startFlag == '1'){
                            html += '<span class="icon-pause" title="手动结束评教" ' +
                                'onclick="setStartFlag(\'' + row.taskId + '\',\'2\')"/>&ensp;' ;
                        }else if (row.startFlag == '2'){
                            html += '<span class="icon-cut" title="设置不计分比例" ' +
                                'onclick="SetProportion(\'' + row.taskId + '\',\'' + row.taskName + '\')"/>&ensp;';
                            html += '<span class="icon-play" title="重新启动评教" ' +
                                'onclick="setStartFlag(\'' + row.taskId + '\',\'1\')"/>&ensp;' ;
                        }

                        return html;
                    },
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
    })

    function SetProportion(id,taskName) {
        $("#dialog").load("<%=request.getContextPath()%>/evaluation/setProportion?id=" + id+"&taskName"+taskName);
        $("#dialog").modal("show");
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/evaluation/toAddTaskInterviewers?evaluationType=" + eType +"&taskType=6");
        $("#dialog").modal("show");
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/evaluation/toEditTaskInterviewers", {
            id: id,
            evaluationType : eType
        });
        $("#dialog").modal("show");
    }

    function setStartFlag(id,startFlag) {
        var flag ="";
        if(startFlag == '1'){
            flag ='重新启动';
        }else  if(startFlag == '2'){
            flag ='手动结束评教';
        }
        swal({
            title: "您确定要"+flag+"本条评教？ ",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "确定",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/evaluation/setStartFlagByTaskId", {
                taskId: id,
                startFlag: startFlag
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                taskTable.ajax.reload();
            });

        });

    }

    function editCopy(id) {
        swal({
            title: "您确定要复制本条信息？ ",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "复制",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/evaluation/editCopyTask", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                taskTable.ajax.reload();
            });

        });

    }

    function del(id, taskName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "评教任务名称：" + taskName + "\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/evaluation/delTask", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                taskTable.ajax.reload();

            });

        });
    }


    function toSelectEmps(id, startFlag) {
        $("#dialog").load("<%=request.getContextPath()%>/evaluation/toTaskInterviewersSelectEmps", {
            id: id,
            startFlag: startFlag,
            evaluationType: eType,
        });
        $("#dialog").modal("show");
    }

    function toSelectMembers(id, startFlag) {
        $("#dialog").load("<%=request.getContextPath()%>/evaluation/toTaskSelectMembers", {
            id: id,
            startFlag: startFlag,
            evaluationType: eType,
        });
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#taskNameSea").val("");
        taskTable.ajax.url("<%=request.getContextPath()%>/evaluation/getInterviewersTasks?evaluationType=" + eType).load();
    }

    function search() {
        var taskName = $("#taskNameSea").val();
        taskTable.ajax.url("<%=request.getContextPath()%>/evaluation/getInterviewersTasks?name=" + taskName + "&evaluationType=" + eType).load();
    }

    function start(id, taskName) {
        swal({
            title: "请确认是否启动任务？",
            text: "评教任务名称：" + taskName + "\n\n启动任务后评委可以开始进行评分！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/evaluation/startTask", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                taskTable.ajax.reload();

            });

        });
    }
</script>