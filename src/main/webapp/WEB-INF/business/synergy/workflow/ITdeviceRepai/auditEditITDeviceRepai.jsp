<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请原因
    </div>
    <div class="col-md-9">
        <textarea id="a_reason"
                  class="validate[required,maxSize[100]] form-control" maxlength="330" placeholder="最多输入330个字"
                  value="${itDeviceRepair.reason}" >${itDeviceRepair.reason}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="a_requestEr" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${itDeviceRepair.requester}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="a_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${itDeviceRepair.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请时间
    </div>
    <div class="col-md-9">
        <input id="a_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${itDeviceRepair.requestDate}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="a_remark" class="validate[required,maxSize[100]] form-control"
                  maxlength="330" placeholder="最多输入330个字">${itDeviceRepair.remark}</textarea>
    </div>
</div>
<input id="id" hidden value="${itDeviceRepair.id}">
<input id="workflowCode" hidden value="T_BG_ITDEVICEREPAIR_WF01">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/ITdeviceRepai/printItDeviceRepair?id=${itDeviceRepair.id}">
<script>

    function save() {
        if ($("#a_reason").val() == "" || $("#a_reason").val() == "0" || $("#a_reason").val() == undefined) {
            swal({
                title: "请填写申请理由",
                type: "info"
            });
            //alert("请填写申请理由");
            return;
        }
        var date = $("#a_requestDate").val().replace("T"," ");
        $.post("<%=request.getContextPath()%>/itdevicerepai/updateITDeviceRepaiById", {
            id: $("#id").val(),
            requestDate: date,
            reason: $("#a_reason").val(),
            remark:$("#a_remark").val()
        }, function (msg) {
            if (msg.status == 1) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#itDeviceRepair').DataTable().ajax.reload();
            }
        })
        return true;
    }

</script>
