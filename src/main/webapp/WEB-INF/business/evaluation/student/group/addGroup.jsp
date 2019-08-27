<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/libs/css/stylesheets.css" rel="stylesheet" type="text/css">
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">新增</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center">
            </div>
            <div class="controls">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            考评组名称
                        </div>
                        <div class="col-md-9">
                            <input id="groupName" type="text"
                                   class="validate[required,maxSize[20]] form-control" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="30" placeholder="最多输入30个字"/>
                        </div>
                    </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()" id="saveBtn">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var eType = '1';

    function save() {
        if ($("#groupName").val() == "" || $("#groupName").val() == null) {
            swal({
                title: "请填写评委组名称！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/xgEvaluation/saveGroup", {
            groupName: $("#groupName").val(),
            evaluationType: eType,
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal("hide");
                $('#groupTable').DataTable().ajax.reload();
            }
        })
    }
</script>