<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
    </style>
</head>
<div class="modal-dialog">
    <input type="hidden" name="ids" id="ids" value="${ids}">
    <input type="hidden" name="check_value" id="check_value" value="${check_value}">
    <input type="hidden" name="planId" id="planId" value="${planId}">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">设置缴费标准</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 缴费标准（元）
                    </div>
                    <div class="col-md-9">
                        <input  id="paymentStandard" name="paymentStandard" />
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
    $(document).ready(function () {

    })



    function save() {
        var  paymentStandard=$("#paymentStandard").val();
        var  ids=$("#ids").val();
        var  check_value=$("#check_value").val();
        var  planId=$("#planId").val();

        if(paymentStandard == "" || paymentStandard == undefined || paymentStandard == null){
            swal({
                title: "请填写缴费标准!",
                type: "info"
            });
            return;
        }
        var reg1 = /^[0-9]+.?[0-9]*$/;
        if(!reg1.test(paymentStandard)){
            swal({
                title: "缴费标准请输入数字!",
                type: "info"
            });
            return;
        }
        swal({
            title: "您是否确认设置已选择学生的缴费标准?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确定",
            closeOnConfirm: false
        }, function () {
            showSaveLoading();
            $.post("<%=request.getContextPath()%>/payment/newStudent/savePaymentStandard", {
                ids: ids,
                check_value: check_value,
                planId: planId,
                paymentStandard: paymentStandard,
            }, function (msg) {
                hideSaveLoading();
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#standardGrid').DataTable().ajax.reload();
                $('#statusStandardGrid').DataTable().ajax.reload();
            })

        });

    }

</script>

