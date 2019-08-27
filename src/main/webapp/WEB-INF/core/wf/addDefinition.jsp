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
                        操作名称
                    </div>
                    <div class="col-md-9">
                        <input id="operationName" type="text"
                               class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        下行节点名称
                    </div>
                    <div class="col-md-9">
                        <select id="nextNodeName"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        操作条件
                    </div>
                    <div class="col-md-9">
                        <%--<input id="term" type="number">--%>
                        <select id="term" class="js-example-basic-single" ></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDefinition()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="nodeId" hidden value="${nodeId}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/getNextNodeList?workflowId=" + $("#definitionWorkflowId").val() + "&nodeId=${nodeId}", function
            (data) {
            addOption(data, "nextNodeName")
        })
    })

    $.get("<%=request.getContextPath()%>/common/getSysDict?name=GZLTJ", function (data) {
        addOption(data, 'term');
    });

    function saveDefinition() {
        var workflowId = $("#definitionWorkflowId").val()
        var operationName = $("#operationName").val()
        var nextNodeId = $("#nextNodeName  option:selected").val()
        var term = $("#term").val()
        var nodeId = $("#nodeId").val()
        if(operationName==''||operationName==undefined||operationName==null){
            swal({
                title: "请填写操作名称！",
                type: "info"
            });
            //alert("请填写操作名称！")
            return
        }
        if(nextNodeId==''||nextNodeId==undefined||nextNodeId==null){
            swal({
                title: "请选择下行节点！",
                type: "info"
            });
            //alert("请选择下行节点！")
            return
        }
        if(term==''||term==undefined||term==null){
            swal({
                title: "请填写条件！",
                type: "info"
            });
            //alert("请填写条件！")
            return
        }
        $.post("<%=request.getContextPath()%>/saveDefinition", {
            operationName: operationName,
            workflowId: workflowId,
            nextNodeId: nextNodeId,
            term: term,
            nodeId: nodeId
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg)
                $("#dialog").modal("hide");
                definitionTable.ajax.reload();
            }
        })
    }
</script>