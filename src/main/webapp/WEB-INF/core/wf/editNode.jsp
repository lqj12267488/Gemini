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
                        <input id="nodeName" type="text" value="${node.nodeName}"/>
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
                        <input id="nodeOrder" type="number" value="${node.nodeOrder}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        是否是起始节点
                    </div>
                    <div class="col-md-9">
                        <div class="checkbox-inline">
                            <label>
                                <input type="radio" ${node.startFlag=="1"? 'checked':""}
                                       name="startFlag" value="1"/> 是
                            </label>
                        </div>
                        <div class="checkbox-inline">
                            <label>
                                <input type="radio"
                                       name="startFlag" ${node.startFlag=="0"? 'checked':""}
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
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getRoleSelect", function (data) {
            addOption(data, "handleRole", '${node.handleRole}')
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JDJSFW", function (data) {
            addOption(data, "roleRange", '${node.roleRange}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JDLX", function (data) {
            addOption(data, "nodeType", '${node.nodeType}');
        });
    })

    function saveNode() {
        var nodeName = $("#nodeName").val()
        var handleRole = $("#handleRole  option:selected").val()
        var startFlag = $("input[type='radio']:checked").val();
        var roleRange = $("#roleRange  option:selected").val()
        var nodeOrder = $("#nodeOrder").val()
        var nodeType = $("#nodeType").val();
        if (nodeType == '' || nodeType == undefined || nodeType == null) {
            swal({
                title: "请填写节点类型！",
                type: "info"
            });
            //alert("请填写节点类型！")
            return
        }
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
        if (nodeOrder == '' || nodeOrder == undefined || nodeOrder == null) {
            swal({
                title: "请填写节点排序！",
                type: "info"
            });
            //alert("请填写节点排序！")
            return
        }
        $.post("<%=request.getContextPath()%>/updateNode", {
            nodeId: '${node.nodeId}',
            handleRole: handleRole,
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