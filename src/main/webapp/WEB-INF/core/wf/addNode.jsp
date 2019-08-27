<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">新增</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        节点名称
                    </div>
                    <div class="col-md-9">
                        <input id="nodeName" type="text"
                               class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        操作角色
                    </div>
                    <div class="col-md-9">
                        <select id="handleRole"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        操作范围
                    </div>
                    <div class="col-md-9">
                        <select id="roleRange"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        节点类型
                    </div>
                    <div class="col-md-9">
                        <select id="nodeType"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        节点排序
                    </div>
                    <div class="col-md-9">
                        <input id="nodeOrder" type="number"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        是否是起始节点
                    </div>
                    <div class="col-md-9">
                        <div class="checkbox-inline">
                            <label>
                                <input type="radio" class="validate[required]"
                                       name="startFlag" value="1"/> 是
                            </label>
                        </div>
                        <div class="checkbox-inline">
                            <label>
                                <input type="radio" checked class="validate[required]"
                                       name="startFlag"
                                       value="0"/> 否
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveNode()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="addNodeWorkflowId" hidden value="${workflowId}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getRoleSelect", function (data) {
            addOption(data, "handleRole")
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JDJSFW", function (data) {
            addOption(data, "roleRange");
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JDLX", function (data) {
            addOption(data, "nodeType");
        });
    })

    function saveNode() {
        var workflowId = $("#addNodeWorkflowId").val();
        var nodeName = $("#nodeName").val();
        var handleRole = $("#handleRole  option:selected").val();
        var roleRange = $("#roleRange  option:selected").val();
        var startFlag = $("input[type='radio']:checked").val();
        var nodeOrder = $("#nodeOrder").val();
        var nodeType = $("#nodeType").val();
        if (nodeName == '' || nodeName == undefined || nodeName == null) {
            swal({
                title: "请填写节点名称！",
                type: "info"
            });
            //alert("请填写节点名称！")
            return
        }
        if (roleRange == '' || roleRange == undefined || roleRange == null) {
            swal({
                title: "请填选择角色范围！",
                type: "info"
            });
            //alert("请填选择角色范围！")
            return
        }
        if (handleRole == '' || handleRole == undefined || handleRole == null) {
            swal({
                title: "请填选择操作角色！",
                type: "info"
            });
            //alert("请填选择操作角色！")
            return
        }
        if (nodeType == '' || nodeType == undefined || nodeType == null) {
            swal({
                title: "请填写节点类型！",
                type: "info"
            });
            //alert("请填写节点类型！")
            return
        }
        if (nodeOrder == '' || nodeOrder == undefined || nodeOrder == null) {
            swal({
                title: "请填写节点排序！",
                type: "info"
            });
            //alert("请填写节点排序！")
            return
        }

        $.post("<%=request.getContextPath()%>/saveNode", {
            handleRole: handleRole,
            workflowId: workflowId,
            nodeName: nodeName,
            nodeType: nodeType,
            nodeOrder: nodeOrder,
            startFlag: startFlag,
            roleRange: roleRange
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg)
                $("#dialog").modal("hide");
                nodeTable.ajax.reload();
            }
        })
    }
</script>