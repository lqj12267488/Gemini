<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="softid" hidden value="${itDeviceRepair.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请原因
                    </div>
                    <div class="col-md-9">
                        <textarea id="f_reason"
                                  class="validate[required,maxSize[100]] form-control" maxlength="330" placeholder="最多输入330个字"
                                  value="${itDeviceRepair.reason}">${itDeviceRepair.reason}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestEr" type="text"
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
                        <input id="f_requestDept" type="text"
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
                        <input id="f_requestDate" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                                value="${itDeviceRepair.requestDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="f_remark"
                                  class="validate[required,maxSize[100]] form-control" maxlength="330" placeholder="最多输入330个字"
                                  value="${itDeviceRepair.remark}">${itDeviceRepair.remark}</textarea>
                    </div>
                </div>
                <%--  <div class="form-row">
                      <div class="col-md-3 tar">
                          角色类型
                      </div>
                      <div class="col-md-9">
                          <input id="roletype" type="number" value="${role.roletype}"/>
                      </div>
                  </div>--%>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    function saveDept() {
        if($("#f_requestDate").val()=="" ||  $("#f_requestDate").val() =="0"){
            swal({
                title: "请填写申请时间",
                type: "info"
            });
         //alert("请填写申请时间");
         return;
         }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            swal({
                title: "请填写申请理由",
                type: "info"
            });
            //alert("请填写申请理由");
            return;
        }
        var date = $("#f_requestDate").val().replace("T"," ");
        $.post("<%=request.getContextPath()%>/itdevicerepai/updateITDeviceRepaiById", {
            id: $("#softid").val(),
            requestDate: date,
            reason: $("#f_reason").val(),
            remark:$("#f_remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#itDeviceRepair').DataTable().ajax.reload();

            }
        })
        showSaveLoading();
    }

</script>
