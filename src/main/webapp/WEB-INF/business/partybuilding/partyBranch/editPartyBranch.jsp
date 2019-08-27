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
            <input id="id" hidden value="${partyBranch.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 党支部名称:
                    </div>
                    <div class="col-md-9">
                        <input id="partyBranchName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${partyBranch.branchName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注:
                    </div>
                    <div class="col-md-9">
                    <textarea id="remark"
                              class="validate[required,maxSize[100]] form-control">${partyBranch.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn"	 class="btn btn-success btn-clean" onclick="savePartyBranch()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    function savePartyBranch() {
        if ($("#partyBranchName").val() == "" || $("#partyBranchName").val() == "0" || $("#partyBranchName").val() == undefined) {
            swal({
                title: "请填写党支部名称!",
                type: "info"
            });
            return;
        }
        var branchName = $("#partyBranchName").val();
        $.post("<%=request.getContextPath()%>/partyBranch/checkName",{
            branchName: branchName,
            id: $("#id").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: "该党支部名称已存在，请检查！",
                    type: "info"
                });
            } else {
                showSaveLoading();
                $.post("<%=request.getContextPath()%>/savePartyBranch", {
                    branchName: $("#partyBranchName").val(),
                    remark: $("#remark").val(),
                    id: $("#id").val()
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        $("#dialog").modal('hide');
                        $('#partyBranchGrid').DataTable().ajax.reload();
                    }
                })
            }

        })
    }

</script>