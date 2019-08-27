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
<input type="hidden" id="goodsPurchasingBigId" value="${goodsPurchasingBig.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        采购物品
    </div>
    <div class="col-md-9">
        <input id="goodsBigName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="12" placeholder="最多输入12个字"
               class="validate[required,maxSize[20]] form-control"
               value="${goodsPurchasingBig.goodsBigName}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        采购数量
    </div>
    <div class="col-md-9">
        <input id="goodsBigNum" type="text" placeholder="请输入数字"
               class="validate[required,maxSize[100]] form-control"
               value="${goodsPurchasingBig.goodsBigNum}"/>
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
               value="${goodsPurchasingBig.unit}"/>
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
               value="${goodsPurchasingBig.reason}"/>
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
               value="${goodsPurchasingBig.budget}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-local"
               value="${goodsPurchasingBig.requestDate}"
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
               value="${goodsPurchasingBig.requestDept}"/>
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
               value="${goodsPurchasingBig.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="remark" maxlength="330" placeholder="最多输入330个字"
                  class="validate[required,maxSize[100]] form-control"
                  value="${goodsPurchasingBig.remark}"
        >${goodsPurchasingBig.remark}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/goodsPurchasingBig/printGoodsPurchasingBig?id=${goodsPurchasingBig.id}">
<script>
    $(document).ready(function () {

    });
    function save() {
        var reg = new RegExp("^[0-9]*$");
        var reg2 = new RegExp("^\\d+(\\.\\d+)?$");
        var reg3 = new RegExp("^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,4})?$");
        var reg5 = new RegExp("^[\u4e00-\u9fa5],{0,}$");
        var reg4 = /\\d$/gi;
        if ($("#goodsBigName").val() == "" || $("#goodsBigName").val() == "0" || $("#goodsBigName").val() == undefined) {
            swal({
                title: "请选择采购物品！",
                type: "info"
            });
            return;
        }
        if ($("#goodsBigNum").val() == "" || $("#goodsBigNum").val() == "0" || $("#goodsBigNum").val() == undefined) {
            swal({
                title: "请填写采购数量！",
                type: "info"
            });
            return;
        }
        if (!reg2.test($("#goodsBigNum").val())) {
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
        $.post("<%=request.getContextPath()%>/goodsPurchasingBig/saveGoodsPurchasingBig", {
            id: $("#goodsPurchasingBigId").val(),
            goodsBigName: $("#goodsBigName").val(),
            unit:$("#unit").val(),
            goodsBigNum: $("#goodsBigNum").val(),
            reason: $("#reason").val(),
            budget: $("#budget").val(),
            requestDate: requestDate,
            remark: $("#remark").val()
        }, function (msg) {
            if (msg.status == 1) {
                $('#goodsPurchasingBigGrid').DataTable().ajax.reload(function () {
                    $('#goodsPurchasingBigGrid tr a').qtip()
                });
            }
        })
        return true;
    }

</script>









