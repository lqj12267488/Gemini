<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="content">
        <div class="col-md-12">
            <div class="block">
                <%--<div class="header">
                    <span style="font-size: 15px;margin-left: 20px">流程管理</span>
                </div>--%>
                <div class="content block-fill-white">
                <div class="form-row">
                    <div class="col-md-1 tar">
                        流程名称：
                    </div>
                    <div class="col-md-2">
                        <input id="wname" type="text"
                               class="validate[required,maxSize[100]] form-control" />
                    </div>
                    <div class="col-md-1 tar">
                        流程标识：
                    </div>
                    <div class="col-md-2">
                        <input id="wcode" type="text"
                               class="validate[required,maxSize[100]] form-control" />
                    </div>
                    <div class="col-md-2">
                        <button  type="button" class="btn btn-default btn-clean" onclick="searchWname()">查询</button>
                        <button  type="button" class="btn btn-default btn-clean" onclick="searchclearWname()">清空</button>
                    </div>
                </div>
                </div>
                <div class="content">
                    <table id="workflowTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var workflowTable;
    $(document).ready(function () {
        workflowTable = $("#workflowTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/getWorkflowList',
            },
            "destroy": true,
            "columns": [
                {"data": "workflowId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "workflowName", "title": "流程名称"},
                {"data": "workflowCode", "title": "流程标识"},
                {"data": "workflowRemark", "title": "备注"},
                {"data": "openFlag", "title": "是否启用"},
                {
                    "title": "操作",
                    "render": function () {
                        return "<span id='toUpdateWorkflow' title='修改' class='icon-edit'></span>&ensp;" +
                            "<span id='delWorkflow' title='删除' class='icon-trash'></span>&ensp;" +
                            "<span id='node' title='节点管理' class='icon-wrench'></span>&ensp;";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": '<"toolbar">rtlip',
            "language": language
        });
        $("div.toolbar").html('<button class="btn btn-info btn-clean" onclick="addWorkflow()">新增</button>');
        workflowTable.on('click', 'tr span', function () {
            var data = workflowTable.row($(this).parent()).data();
            var workflowId = data.workflowId;
            if (this.id == "toUpdateWorkflow") {
                $("#dialog").load("<%=request.getContextPath()%>/toUpdateWorkflow?workflowId=" + workflowId);
                $("#dialog").modal("show");
            }
            if (this.id == "delWorkflow") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "流程名称："+data.workflowName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                //if (confirm("确定要删除" + data.workflowName + "?")) {
                    $.post("<%=request.getContextPath()%>/delWorkflow?", {
                        workflowId: workflowId,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"});
                            //alert(msg.msg);
                            workflowTable.ajax.reload();
                        }
                    })
                })
            }
            if (this.id == "node") {
                $("#right").load("<%=request.getContextPath()%>/node?workflowId=" + workflowId);
            }
        });
    })

    function addWorkflow() {
        $("#dialog").load("<%=request.getContextPath()%>/toAddWorkflow");
        $("#dialog").modal("show");
    }

    function searchclearWname() {
        $("#wname").val("");
        $("#wcode").val("");
        searchWname();
    }

    function searchWname() {
        var workflowName = $("#wname").val();
        var workflowCode=$("#wcode").val();
        workflowTable.ajax.url("<%=request.getContextPath()%>/getWorkflowList?workflowName="+workflowName+"&workflowCode="+workflowCode).load();
    }
</script>