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
            <input id="roleid" hidden value="${role.roleid}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 角色名称
                    </div>
                    <div class="col-md-9">
                        <input id="rolename" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="20" placeholder="最多输入20个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${role.rolename}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>角色说明
                    </div>
                    <div class="col-md-9">
                        <input id="roledescription" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${role.roledescription}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>角色类型
                    </div>
                    <div class="col-md-9">
                        <select id="reroletype" class="js-example-basic-single"></select>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="roleCache" hidden value="${role.roletype}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        var roleCache = $("#roleCache").val();
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TYJB", function (data) {
            addOption(data, 'reroletype', roleCache)
        });
    })
    function saveDept() {
        if ($("#rolename").val() == "") {
            swal({
                title: "请填写角色名称",
                type: "info"
            });
            //alert("请填写角色名称");
            return;
        }
        if ($("#rolename").val().length>20) {
            swal({
                title: "角色名称过长",
                type: "info"
            });
            //alert("角色名称过长");
            return;
        }
        if ($("#roledescription").val() == "") {
            swal({
                title: "请填写角色说明",
                type: "info"
            });
            return;
        }
        if ($("#roledescription").val().length>30) {
            swal({
                title: "角色说明过长",
                type: "info"
            });
            //alert("角色说明过长");
            return;
        }
        if ($("#reroletype option:selected").val() == "" || $("#reroletype option:selected").val() == "0") {
            swal({
                title: "请填写角色类型",
                type: "info"
            });
            //alert("请填写角色类型");
            return;
        }


        showSaveLoading();
        $.post("<%=request.getContextPath()%>/saveRole", {
            roleid: $("#roleid").val(),
            rolename: $("#rolename").val(),
            roletype: $("#reroletype option:selected").val(),
            roledescription: $("#roledescription").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#roleGrid').DataTable().ajax.reload();
            }
        })
    }

</script>