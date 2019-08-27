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
    <input type="hidden" name="id" id="id" value="${id}">
    <input type="hidden" name="planId" id="planId" value="${planId}">
    <div class="modal-content block-fill-white">
        <div class="modal-header" style="height: 50px">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div  class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  缴/退费类型
                    </div>
                    <div class="col-md-9">
                        <select  id="paymentType" onchange="changeDiv()">
                            <option value="1" selected="selected">缴费</option>
                            <option value="2">退费</option>
                        </select>
                    </div>

                </div>
                <div id="paymentDiv"class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>   缴费金额
                    </div>
                    <div class="col-md-9">
                        <input  id="paymentAmount" name="paymentAmount" />
                    </div>
                </div>
                <div id="refundDiv" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>   退费金额
                    </div>
                    <div class="col-md-9">
                        <input  id="refundAmount" name="refundAmount" />
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
        var  paymentType=$("#paymentType").val();
        if(paymentType=="1"){
            $("#paymentDiv").show();
            $("#refundDiv").hide();
        }
        if(paymentType=="2"){
            $("#refundDiv").show();
            $("#paymentDiv").hide();
        }


    })

    function changeDiv(){
        var  paymentType=$("#paymentType").val();
        if(paymentType=="1"){
            $("#paymentDiv").show();
            $("#refundDiv").hide();
        }
        if(paymentType=="2"){
            $("#refundDiv").show();
            $("#paymentDiv").hide();
        }
    }

    function save() {
        var  paymentType=$("#paymentType").val();
        var  paymentAmount=$("#paymentAmount").val();
        var  refundAmount=$("#refundAmount").val();
        var  planId=$("#planId").val();
        var  ids=$("#ids").val();
        var  id=$("#id").val();
        if(paymentType=="1"){
            if(paymentAmount == "" || paymentAmount == undefined || paymentAmount == null){
                swal({
                    title: "请填写缴费金额!",
                    type: "info"
                });
                return;
            }
            var reg1 = /^[0-9]+.?[0-9]*$/;
            if(!reg1.test(paymentAmount)){
                swal({
                    title: "缴费金额请输入数字!",
                    type: "info"
                });
                return;
            }
        }
        if(paymentType=="2"){
            if(refundAmount == "" || refundAmount == undefined || refundAmount == null){
                swal({
                    title: "请填写退费金额!",
                    type: "info"
                });
                return;
            }
            var reg1 = /^[0-9]+.?[0-9]*$/;
            if(!reg1.test(refundAmount)){
                swal({
                    title: "退费金额请输入数字!",
                    type: "info"
                });
                return;
            }
        }
        showSaveLoading();
        swal({
            title: "您是否确认对已选择的学生进行添加缴费结果?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确定",
            closeOnConfirm: false
        }, function () {

            $.post("<%=request.getContextPath()%>/payment/info/savePaymentResult", {
                ids: ids,
                id: id,
                planId: planId,
                refundAmount: refundAmount,
                paymentAmount: paymentAmount,
                paymentType: paymentType
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#paymentInfoGrid').DataTable().ajax.reload();

            })

        });


    }

</script>

