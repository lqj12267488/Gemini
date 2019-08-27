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
            <input id="id" hidden value="${id}">
            <input id="textbookId" hidden value="${textbookId}">
            <input id="declareId" hidden value="${declareId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        实订数
                    </div>
                    <div class="col-md-9">
                        <input id="s_actualSubscription" value="${actualNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        折扣
                    </div>
                    <div class="col-md-9">
                        <input id="s_discount"  value="${discount}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveTextBookStatistics()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    function saveTextBookStatistics() {
        var reg = new RegExp("^[0-9]*$");
        var reg1 = new RegExp("([1-9]+[0-9]*|0)(\\.[\\d]+)?");
        var actualSubscription = $("#s_actualSubscription").val();
        var remark = $("#s_discount").val();
        if (actualSubscription == "" || actualSubscription == undefined || actualSubscription == null) {
            swal({
                title: "请填写实订数！",
                type: "info"
            });
            return;
        }else if (!reg.test(actualSubscription)) {
            swal({
                title: "实订数量必须为整数！",
                type: "info"
            });
            return;
        }
        if (remark == "" || remark == undefined || remark == null) {
            swal({
                title: "请填写折扣！",
                type: "info"
            });
            return;
        }
        if(!reg1.test(remark)){
            swal({
                title: "折扣请填写数字或小数！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/textbook/saveTextbookDeclareDiscount", {
            id: $("#id").val(),
            textbookId: $("#textbookId").val(),
            declareId: $("#declareId").val(),
            actualNum: actualSubscription,
            discount:remark,
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#textBookGrid').DataTable().ajax.reload();
            }else{
                swal({title: msg.msg, type: "error"});
                $("#dialog").modal('hide');
                $('#textBookGrid').DataTable().ajax.reload();
            }
        })

    }
</script>
<style>
    #menuContent {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>
