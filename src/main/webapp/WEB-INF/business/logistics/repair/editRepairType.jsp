<%--报修类型管理新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/5/26
  Time: 10:39
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
            <input id="id" hidden value="${userDic.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        报修类型
                    </div>
                    <div class="col-md-9">
                        <input id="dicname" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="15" placeholder="最多输入15个字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${userDic.dicname}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    function save() {
        if ($("#dicname").val() == "" || $("#dicname").val() == "0" || $("#dicname").val() == undefined) {
            swal({
                title: "请填写报修类型！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/userDic/checkName", {
            dicname: $("#dicname").val(),
            id: $("#id").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: "报修类型重复，请重新填写!", type: "error"});
            } else {
                $.post("<%=request.getContextPath()%>/userDic/saveUserDicSupplies", {
                    id: $("#id").val(),
                    dicname: $("#dicname").val(),
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        $("#dialog").modal('hide');
                        $('#repairTypeGrid').DataTable().ajax.reload();
                    }
                })
                showSaveLoading();
            }

        })
    }

</script>