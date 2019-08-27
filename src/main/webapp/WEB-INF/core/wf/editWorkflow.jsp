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
                        流程名称
                    </div>
                    <div class="col-md-9">
                        <input id="workflowName" type="text" value="${workflow.workflowName}"
                               class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        流程标识
                    </div>
                    <div class="col-md-9">
                        <input id="workflowCode" type="text" value="${workflow.workflowCode}"
                               class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="workflowRemark" type="text"
                               class="validate[required,maxSize[20]] form-control" value="${workflow.workflowRemark}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        是否启用
                    </div>
                    <div class="col-md-9">
                        <div class="checkbox-inline">
                            <label>
                                <input type="radio" class="validate[required]" name="openFlag"
                                ${workflow.openFlag=="1"? 'checked':""} value="1"/> 是
                            </label>
                        </div>
                        <div class="checkbox-inline">
                            <label>
                                <input type="radio" class="validate[required]" name="openFlag"
                                ${workflow.openFlag=="0"? 'checked':""} value="0"/> 否
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveWorkflow()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="workflowId" hidden value="${workflow.workflowId}">
<script>
    $(document).ready(function () {
        var wcode = document.getElementById("workflowCode");
        /*alert('${loginId}');*/
        if('${loginId}'!='sa'){
            wcode.setAttribute("readonly",true,0);
        }
    })
    function saveWorkflow() {
        var workflowName = $("#workflowName").val()
        var workflowCode = $("#workflowCode").val()
        var workflowRemark = $("#workflowRemark").val()
        var openFlag = $("input[name='openFlag']:checked").val()
        if (workflowName == '' || workflowName == undefined || workflowName == null) {
            swal({
                title: "请填写流程名称！",
                type: "info"
            });
            //alert("请填写流程名称！")
            return
        }
        if (workflowCode == '' || workflowCode == undefined || workflowCode == null) {
            swal({
                title: "请填写流程标识！",
                type: "info"
            });
            //alert("请填写流程标识！")
            return
        }
        var reg=new RegExp("^[0-9A-Z_]*$");
        if(!reg.test(workflowCode)){
            swal({title: "流程标识不符合规范",type: "info"});
            return;
        }
        $.post("<%=request.getContextPath()%>/updateWorkflow", {
            workflowId: $("#workflowId").val(),
            workflowName: workflowName,
            workflowCode: workflowCode,
            workflowRemark: workflowRemark,
            openFlag: openFlag
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg)
                $("#dialog").modal("hide");
                workflowTable.ajax.reload()
            }
        })
    }
</script>