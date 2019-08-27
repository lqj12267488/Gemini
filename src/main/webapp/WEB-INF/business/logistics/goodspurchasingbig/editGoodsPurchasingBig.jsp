<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/31
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<%@ include file="/WEB-INF/common/treeSelect.jsp" %>--%>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="goodsPurchasingBigId" hidden value="${goodsPurchasingBig.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        采购物品
                    </div>
                    <div class="col-md-9">
                        <input id="goodsBigName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="12" placeholder="最多输入12个字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${goodsPurchasingBig.goodsBigName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div style="text-align: right" class="col-md-3">
                        <span class="iconBtx">*</span>
                        采购数量
                    </div>
                    <div class="col-md-4">
                        <input id="goodsBigNum01" type="text" placeholder="请输入数字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${goodsPurchasingBig.goodsBigNum}"/>
                    </div>

                    <div class="col-md-2">
                        <span class="iconBtx">*</span>
                        单位
                    </div>
                    <div class="col-md-3">
                        <input id="goodsBigNum02" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="15" placeholder="最多输入15个字"
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
                               class="validate[required,maxSize[100]] form-control"
                               value="${goodsPurchasingBig.requestDate}"/>
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
                                >${goodsPurchasingBig.remark}</textarea>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var goodsNumber;
    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        var reg2 = new RegExp("^\\d+(\\.\\d+)?$");
        var reg3 = new RegExp("^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,4})?$");
        var reg5 = new RegExp("^[\u4e00-\u9fa5],{0,}$");
        var reg4 = /\\d$/gi;

        if ($("#goodsBigName").val() == "" || $("#goodsBigName").val() == "0" || $("#goodsBigName").val() == undefined) {
            swal({
                title: "请填写采购物品名称！",
                type: "info"
            });
            return;
        }
        if ($("#goodsBigNum01").val() == "" || $("#goodsBigNum01").val() == "0" || $("#goodsBigNum01").val() == undefined) {
            swal({
                title: "请填写采购物品数量！",
                type: "info"
            });
            return;
        }
        if (!reg2.test($("#goodsBigNum01").val())) {
            swal({
                title: "采购物品数量请填写数字！",
                type: "info"
            });
            return;
        }
        if ($("#goodsBigNum02").val() == "" || $("#goodsBigNum02").val() == "0" || $("#goodsBigNum02").val() == undefined) {
            swal({
                title: "请填写采购物品数量单位！",
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
                title: "请填写预算(万元)！",
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
        if ($("#requestDate").val() == "" || $("#requestDate").val() == "0" || $("#requestDate").val() == undefined) {
            swal({
                title: "请填写申请时间！",
                type: "info"
            });
            return;
        }
        var requestDate = $("#requestDate").val().replace('T', '');
        $.post("<%=request.getContextPath()%>/goodsPurchasingBig/saveGoodsPurchasingBig", {
            id: $("#goodsPurchasingBigId").val(),
            goodsBigNum: $("#goodsBigNum01").val(),
            unit:$("#goodsBigNum02").val(),
            goodsBigName: $("#goodsBigName").val(),
            reason: $("#reason").val(),
            budget: $("#budget").val(),
            requestDate: requestDate,
            remark: $("#remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#goodsPurchasingBigGrid').DataTable().ajax.reload(function () {
                    $('#goodsPurchasingBigGrid tr a').qtip()
                });
            }
        })
        showSaveLoading();
    }
</script>


