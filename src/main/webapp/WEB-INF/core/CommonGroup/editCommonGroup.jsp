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
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  分组名称
                    </div>
                    <div class="col-md-10">
                        <input id="groupName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="30" placeholder="最多输入30个字" value="${commomGroup.groupName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        备注
                    </div>
                    <div class="col-md-10">
                        <input id="remarks" type="text"  value="${commomGroup.remarks}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button"  id="saveBtn"	class="btn btn-success btn-clean" onclick="saveClass()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="groupId" hidden value="${commomGroup.groupId}">

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    function saveClass() {
        if ($("#groupName").val() == "") {
            swal({
                title: "请填写分组名称",
                type: "info"
            });
            //alert("请填写班级名称");
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/commonGroup/updateGroup", {
            groupName: $("#groupName").val(),
            remarks: $("#remarks").val(),
            groupId: $("#groupId").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $("#commonGroupGrid").DataTable().ajax.reload();
            }
        })
    }

</script>