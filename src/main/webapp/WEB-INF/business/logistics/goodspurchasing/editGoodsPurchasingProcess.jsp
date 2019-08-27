<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/31
  Time: 18:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<input type="hidden" id="goodsPurchasingId" value="${goodsPurchasing.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        采购物品
    </div>
    <div class="col-md-9">
        <input id="goodsName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="12" placeholder="最多输入12个字"
               class="validate[required,maxSize[20]] form-control"
               value="${goodsPurchasing.goodsName}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        采购数量
    </div>
    <div class="col-md-9">
        <input id="goodsNum" type="text" placeholder="请输入数字"
               class="validate[required,maxSize[100]] form-control"
               value="${goodsPurchasing.goodsNum}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        物品单位
    </div>
    <div class="col-md-9">
        <input id="unit" type="text" placeholder="最多输入15个字" maxlength="15"
               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               class="validate[required,maxSize[100]] form-control"
               value="${goodsPurchasing.unit}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请事由
    </div>
    <div class="col-md-9">
        <input id="reason" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="15" placeholder="最多输入15个字"
               class="validate[required,maxSize[100]] form-control"
               value="${goodsPurchasing.reason}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        预算(万元)
    </div>
    <div class="col-md-9">
        <input id="budget" type="text" placeholder="请输入数字"
               class="validate[required,maxSize[100]] form-control"
               value="${goodsPurchasing.budget}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-local"
               value="${goodsPurchasing.requestDate}"
               class="validate[required,maxSize[100]] form-control" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${goodsPurchasing.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="requester" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${goodsPurchasing.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="remark" maxlength="330" placeholder="最多输入330个字"
                  class="validate[required,maxSize[100]] form-control"
                  value="${goodsPurchasing.remark}"
        >${goodsPurchasing.remark}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/goodsPurchasing/printGoodsPurchasing?id=${goodsPurchasing.id}">
<script>
    $(document).ready(function () {

    });
    function save() {
        if ($("#goodsName").val() == "" || $("#goodsName").val() == "0" || $("#goodsName").val() == undefined) {
            swal({
                title: "请选择采购物品！",
                type: "info"
            });
            return;
        }
        if ($("#goodsNum").val() == "" || $("#goodsNum").val() == "0" || $("#goodsNum").val() == undefined) {
            swal({
                title: "请填写采购数量！",
                type: "info"
            });
            return;
        }
        if (!reg2.test($("#goodsNum01").val())) {
            swal({
                title: "采购数量请填写数字！",
                type: "info"
            });
            return;
        }
        if ($("#unit").val() == "" || $("#unit").val() == "0" || $("#unit").val() == undefined) {
            swal({
                title: "请填写物品单位！",
                type: "info"
            });
            return;
        }
        if ($("#reason").val() == "" || $("#reason").val() == "0" || $("#reason").val() == undefined) {
            swal({
                title: "请填写申请事由！",
                type: "info"
            });
            return;
        }
        if ($("#budget").val() == "" || $("#budget").val() == "0" || $("#budget").val() == undefined) {
            swal({
                title: "预算金额不能为0或空！",
                type: "info"
            });
            return;
        }
        if (!reg2.test($("#budget").val())) {
            swal({
                title: "预算请填写数字！",
                type: "info"
            });
            return;
        } else if (!reg3.test($("#budget").val())) {
            swal({
                title: "预算小数位数不能超过4位,请重新填写！",
                type: "info"
            });
            return;
        }
        var requestDate = $("#requestDate").val().replace('T', '');
        $.post("<%=request.getContextPath()%>/goodsPurchasing/saveGoodsPurchasing", {
            id: $("#goodsPurchasingId").val(),
//            requestDept: $("#requestDept").val(),
            goodsName: $("#goodsName").val(),
            goodsNum: $("#goodsNum").val(),
            unit:$("#unit").val(),
            reason: $("#reason").val(),
            budget: $("#budget").val(),
//            requester: $("#requester").val(),
            requestDate: requestDate,
            remark: $("#remark").val()
        }, function (msg) {
            if (msg.status == 1) {
                $('#goodsPurchasingGrid').DataTable().ajax.reload(function () {
                    $('#goodsPurchasingGrid tr a').qtip()
                });
                /*swal({
                    title: "修改成功!",
                    type: "success"
                });*/
            }
        })
        return true;
    }

</script>









