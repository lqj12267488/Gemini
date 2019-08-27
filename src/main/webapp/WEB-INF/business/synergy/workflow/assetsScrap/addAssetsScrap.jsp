<%--资产报废管理待办修改页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        资产编号
    </div>
    <div class="col-md-9">
        <input id="f_assetsId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="12" placeholder="最多输入12个字"
               class="validate[required,maxSize[100]] form-control"
               value="${AssetsScrap.assetsId}"/>
    </div>
</div>--%>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        资产名称
    </div>
    <div class="col-md-9">
        <input id="f_assetsName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="30" placeholder="最多输入30个字"
               class="validate[required,maxSize[20]] form-control"
               value="${AssetsScrap.assetsName}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        报废原因
    </div>
    <div class="col-md-9">
                        <textarea id="f_reason" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${softinstall.reason}">${AssetsScrap.reason}</textarea>
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
               value="${AssetsScrap.requestDept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        经办人
    </div>
    <div class="col-md-9">
        <input id="f_manager" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${AssetsScrap.manager}" readonly="readonly"/>
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
               value="${AssetsScrap.requestDate}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="f_remark" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control">${AssetsScrap.remark}</textarea>
    </div>
</div>
<input type="hidden" id="f_Id" value="${AssetsScrap.id}">
<input id="workflowCode" hidden value="T_BG_ASSETSSCRAP_WF01">
<script>
    function save(){
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
       /* if ($("#f_assetsId").val() == "" || $("#f_assetsId").val() == "0" || $("#f_assetsId").val() == undefined) {
             swal({
                title: "请填写资产编号!",
                type: "info"
            });
            return;
        }*/
        if ($("#f_assetsName").val() == "" || $("#f_assetsName").val() == "0" || $("#f_assetsName").val() == undefined) {
             swal({
                title: "请填写资产名称!",
                type: "info"
            });
            return;
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
             swal({
                title: "请填写报废原因!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/assetsScrap/saveAssetsScrap", {
            id: $("#f_Id").val(),
            assetsName: $("#f_assetsName").val(),
            manager: $("#f_manager").val(),
            requestDept: $("#f_requestDept").val(),
            requestDate:date,
            reason: $("#f_reason").val(),
            remark:$("#f_remark").val()
        }, function (msg) {
            if (msg.status == 1) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                $("#dialog").modal('hide');
                $('#softInstallGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }
</script>