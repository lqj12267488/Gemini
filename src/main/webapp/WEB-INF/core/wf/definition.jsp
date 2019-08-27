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
                    <span style="font-size: 15px;margin-left: 20px">${workflowName} > ${nodeName} > 走向配置</span>
                </div>
                <div class="content">
                    <table id="definitionTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="definitionWorkflowId" hidden value="${workflowId}">
<script>
    var definitionTable;
    $(document).ready(function () {
        definitionTable = $("#definitionTable").DataTable({
            "ajax": {
                "url": "<%=request.getContextPath()%>/getDefinitionListByNodeIdAndWorkflowId?nodeId=${nodeId}&workflowId=" +
                $("#definitionWorkflowId").val(),
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "nodeId", "visible": false},
                {"data": "nextNodeId", "visible": false},
                {"data": "operationName", "title": "操作名称"},
                {"data": "nextNodeName", "title": "下行节点名称"},
                {"data": "term", "title": "操作条件"},
                {
                    "title": "操作",
                    "render": function () {
                        return "<span id='deleteDefinition' title='删除' class='icon-trash'></span>&ensp;";
                    }
                }
            ],

            "dom": '<"toolbar">rtlip',
            "language": language
        });
        $("div.toolbar").html('<button class="btn btn-info btn-clean" onclick="returnNode()">返回</button>' +
            '<button class="btn btn-info btn-clean" onclick="addDefinition()">新增</button>');
        definitionTable.on('click', 'tr span', function () {
            var data = definitionTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "deleteDefinition") {
            swal({
                title: "您确定要删除本条信息?",
                text: "操作名称："+data.operationName+"\n\n删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                closeOnConfirm: false
            }, function () {
                //if (confirm("确定要删除" + data.operationName + "?")) {
                    $.post("<%=request.getContextPath()%>/deleteDefinition", {
                        definitionId: id,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            definitionTable.ajax.reload();
                        }
                    })
                })
            }
        });
    })
    function addDefinition() {
        $("#dialog").load("<%=request.getContextPath()%>/addDefinition", {
            nodeId: '${nodeId}'
        });
        $("#dialog").modal("show");
    }
    function returnNode() {
        $("#right").load("<%=request.getContextPath()%>/node", {
            workflowId: $("#definitionWorkflowId").val(),
            nodeId: '${nodeId}'
        });
    }
</script>