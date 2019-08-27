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
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${workflowName} > 节点管理</span>
                </div>
                <div class="content">
                    <table id="nodeTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="nodeWorkflowId" hidden value="${workflowId}">
<input id="workflowName" hidden value="${workflowName}">
<script>
    var nodeTable;

    $(document).ready(function () {
        var workflowName = $("#workflowName").val();
        nodeTable = $("#nodeTable").DataTable({
            "ajax": {
                "url": "<%=request.getContextPath()%>/getNodeListByWorkflowId?workflowId=" + '${workflowId}',
            },
            "destroy": true,
            "columns": [
                {"data": "nodeId", "visible": false},
                {"data": "nodeName", "title": "流程名称"},
                {"data": "handleRole", "title": "操作角色"},
                {"data": "startFlag", "title": "是否是起始节点"},
                {
                    "title": "操作",
                    "render": function () {
                        return "<span id='editNode' title='修改' class='icon-edit'></span>&ensp;" +
                            "<span id='deleteNode' title='删除' class='icon-trash'></span>&ensp;" +
                            "<span id='definition' title='走向配置' class='icon-wrench'></span>&ensp;";
                    }
                }
            ],

            "order": [],
            "language": language,
            "dom": '<"toolbar">rtlip',
        });
        $("div.toolbar").html('<button class="btn btn-info btn-clean" onclick="returnWorkflow()">返回</button>' +
            '<button class="btn btn-info btn-clean" onclick="addNode()">新增</button>');
        nodeTable.on('click', 'tr span', function () {
            var data = nodeTable.row($(this).parent()).data();
            var nodeId = data.nodeId;
            if (this.id == "editNode") {
                $("#dialog").load("<%=request.getContextPath()%>/editNode?nodeId=" + nodeId);
                $("#dialog").modal("show");
            }
            if (this.id == "deleteNode") {
                //if (confirm("确定要删除" + data.nodeName + "?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "流程名称：" + data.nodeName + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/deleteNode", {
                        nodeId: nodeId,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            nodeTable.ajax.reload();
                        } else {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                        }
                    })
                });
            }
            if (this.id == "definition") {
                $("#right").load("<%=request.getContextPath()%>/definition", {
                    nodeId: nodeId,
                    workflowId: $("#nodeWorkflowId").val(),
                    workflowName: workflowName
                });
            }
        });
    })

    function addNode() {
        $("#dialog").load("<%=request.getContextPath()%>/addNode?workflowId=" + $("#nodeWorkflowId").val());
        $("#dialog").modal("show");
    }

    function returnWorkflow() {
        $("#right").load("<%=request.getContextPath()%>/workflow");
    }
</script>