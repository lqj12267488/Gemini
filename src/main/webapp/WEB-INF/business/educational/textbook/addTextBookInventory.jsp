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
            <input id="f_id" hidden value="${textBookLog.textbookId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 教材名称
                    </div>
                    <div class="col-md-9">
                        <input id="f_textbookId" type="text"  readonly="readonly" value="${textBookLog.textbookName}"
                               class="validate[required,maxSize[8]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 入库数量
                    </div>
                    <div class="col-md-9">
                        <input id="operationNum" type="text" value="${textBookLog.textbookNumIn}"
                               class="validate[required,maxSize[8]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark" class="validate[required,maxSize[8]] form-control"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveTextBookInventory()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
    })
    function saveTextBookInventory() {
        var reg = /^[1-9]*[1-9][0-9]*$/;
        if ($("#operationNum").val() == "" || $("#operationNum").val() == null) {
            swal({
                title: "请填写入库数量！",
                type: "info"
            });
            return;
        } else if (!reg.test($("#operationNum").val())) {
            swal({
                title: "入库数量必须为正整数！",
                type: "info"
            });
            return;
        }else if ($("#operationNum").val()<=0){
            swal({
                title: "入库数量必须大于0！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/saveTextBookInventory", {
            textbookType: $("#textbookType").val(),
            textbookId: $("#f_id").val(),
            operationNum: $("#operationNum").val(),
            remark: $("#remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            }
        })
    }
</script>