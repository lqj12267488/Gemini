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
            <input id="softid" hidden value="${softinstall.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        软件名称
                    </div>
                    <div class="col-md-9">
                        <input id="softName" type="text" maxlength="30" placeholder="最多输入30个字"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[20]] form-control"
                               value="${softinstall.softName}"/>
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
                               value="${softinstall.requester}" readonly="readonly"/>
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
                               value="${softinstall.requestDept}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDate" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${softinstall.requestDate}"/>
                    </div>
                    <%--<div class="col-md-9">
                        <div class="input-append date form_datetime">
                            <input size="16" type="text" value="" readonly>
                            <span class="add-on"><i class="icon-th"></i></span>
                        </div>
                    </div>--%>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        安装机房及原因
                    </div>
                    <div class="col-md-9">
                        <textarea id="f_reason" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control" style="height: 100px"
                                  value="${softinstall.reason}">${softinstall.reason}</textarea>
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
        if ($("#softName").val() == "" || $("#softName").val() == "0" || $("#softName").val() == undefined) {
            swal({
                title: "请填写软件名称",
                type: "info"
            });
            //alert("请填写软件名称");
            return;
        }
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0") {
            swal({
                title: "请填写申请日期",
                type: "info"
            });
            //alert("请填写申请日期");
            return;
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            swal({
                title: "请填写安装机房及原因",
                type: "info"
            });
            //alert("请填写申请理由");
            return;
        }
        var c_requestDate = $("#f_requestDate").val().replace('T',' ');
        $.post("<%=request.getContextPath()%>/softInstall/updateSoftById", {
             id: $("#softid").val(),
             softName: $("#softName").val(),
             requester: $("#f_requestEr").val(),
             requestDept: $("#f_requestDept").val(),
             requestDate: c_requestDate,
             reason: $("#f_reason").val()

        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#softInstallGrid').DataTable().ajax.reload();

            }
        })
        showSaveLoading();
    }

</script>
