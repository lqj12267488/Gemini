<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学校总收入
                    </div>
                    <div class="col-md-9">
                        <input id="incomeAllEdit" value="${data.incomeAll}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学费合计收入
                    </div>
                    <div class="col-md-9">
                        <input id="sfAllEdit" value="${data.sfAll}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学费序号
                    </div>
                    <div class="col-md-9">
                        <input id="sfIndEdit" value="${data.sfInd}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学生类别
                    </div>
                    <div class="col-md-9">
                        <input id="sfStuTypeEdit" value="${data.sfStuType}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>标准（元/生）
                    </div>
                    <div class="col-md-9">
                        <input id="sfStdEdit" value="${data.sfStd}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>金额（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="sfMoneyEdit" value="${data.sfMoney}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>补助收入合计
                    </div>
                    <div class="col-md-9">
                        <input id="awAllEdit" value="${data.awAll}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>补助序号
                    </div>
                    <div class="col-md-9">
                        <input id="awIndexEdit" value="${data.awIndex}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目名称（全称）
                    </div>
                    <div class="col-md-9">
                        <input id="awProNameEdit" value="${data.awProName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>补助标准
                    </div>
                    <div class="col-md-9">
                        <input id="awStdEdit" value="${data.awStd}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目金额
                    </div>
                    <div class="col-md-9">
                        <input id="awProMoneyEdit" value="${data.awProMoney}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>财政专项投入合计
                    </div>
                    <div class="col-md-9">
                        <input id="finAllEdit" value="${data.finAll}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>序号
                    </div>
                    <div class="col-md-9">
                        <input id="finIndexEdit" value="${data.finIndex}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目名称（全称）
                    </div>
                    <div class="col-md-9">
                        <input id="finProNameEdit" value="${data.finProName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目金额（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="finProMoneyEdit" value="${data.finProMoney}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>社会捐赠金额（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="ssDonateEdit" value="${data.ssDonate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>其他收入总额
                    </div>
                    <div class="col-md-9">
                        <input id="otherIncomeEdit" value="${data.otherIncome}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>贷款金额（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="loanEdit" value="${data.loan}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>贷款余额（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="loanBalEdit" value="${data.loanBal}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
    });

    function save() {
        if ($("#incomeAllEdit").val() == "" || $("#incomeAllEdit").val() == undefined || $("#incomeAllEdit").val() == null) {
            swal({
                title: "请填写学校总收入！",
                type: "warning"
            });
            return;
        }
        if ($("#sfAllEdit").val() == "" || $("#sfAllEdit").val() == undefined || $("#sfAllEdit").val() == null) {
            swal({
                title: "请填写学费合计收入！",
                type: "warning"
            });
            return;
        }
        if ($("#sfIndEdit").val() == "" || $("#sfIndEdit").val() == undefined || $("#sfIndEdit").val() == null) {
            swal({
                title: "请填写学费序号！",
                type: "warning"
            });
            return;
        }
        if ($("#sfStuTypeEdit").val() == "" || $("#sfStuTypeEdit").val() == undefined || $("#sfStuTypeEdit").val() == null) {
            swal({
                title: "请填写学生类别！",
                type: "warning"
            });
            return;
        }
        if ($("#sfStdEdit").val() == "" || $("#sfStdEdit").val() == undefined || $("#sfStdEdit").val() == null) {
            swal({
                title: "请填写标准（元/生）！",
                type: "warning"
            });
            return;
        }
        if ($("#sfMoneyEdit").val() == "" || $("#sfMoneyEdit").val() == undefined || $("#sfMoneyEdit").val() == null) {
            swal({
                title: "请填写金额（万元）！",
                type: "warning"
            });
            return;
        }
        if ($("#awAllEdit").val() == "" || $("#awAllEdit").val() == undefined || $("#awAllEdit").val() == null) {
            swal({
                title: "请填写补助收入合计！",
                type: "warning"
            });
            return;
        }
        if ($("#awIndexEdit").val() == "" || $("#awIndexEdit").val() == undefined || $("#awIndexEdit").val() == null) {
            swal({
                title: "请填写补助序号！",
                type: "warning"
            });
            return;
        }
        if ($("#awProNameEdit").val() == "" || $("#awProNameEdit").val() == undefined || $("#awProNameEdit").val() == null) {
            swal({
                title: "请填写项目名称（全称）！",
                type: "warning"
            });
            return;
        }
        if ($("#awStdEdit").val() == "" || $("#awStdEdit").val() == undefined || $("#awStdEdit").val() == null) {
            swal({
                title: "请填写补助标准！",
                type: "warning"
            });
            return;
        }
        if ($("#awProMoneyEdit").val() == "" || $("#awProMoneyEdit").val() == undefined || $("#awProMoneyEdit").val() == null) {
            swal({
                title: "请填写项目金额！",
                type: "warning"
            });
            return;
        }
        if ($("#finAllEdit").val() == "" || $("#finAllEdit").val() == undefined || $("#finAllEdit").val() == null) {
            swal({
                title: "请填写财政专项投入合计！",
                type: "warning"
            });
            return;
        }
        if ($("#finIndexEdit").val() == "" || $("#finIndexEdit").val() == undefined || $("#finIndexEdit").val() == null) {
            swal({
                title: "请填写序号！",
                type: "warning"
            });
            return;
        }
        if ($("#finProNameEdit").val() == "" || $("#finProNameEdit").val() == undefined || $("#finProNameEdit").val() == null) {
            swal({
                title: "请填写项目名称（全称）！",
                type: "warning"
            });
            return;
        }
        if ($("#finProMoneyEdit").val() == "" || $("#finProMoneyEdit").val() == undefined || $("#finProMoneyEdit").val() == null) {
            swal({
                title: "请填写项目金额（万元）！",
                type: "warning"
            });
            return;
        }
        if ($("#ssDonateEdit").val() == "" || $("#ssDonateEdit").val() == undefined || $("#ssDonateEdit").val() == null) {
            swal({
                title: "请填写社会捐赠金额（万元）！",
                type: "warning"
            });
            return;
        }
        if ($("#otherIncomeEdit").val() == "" || $("#otherIncomeEdit").val() == undefined || $("#otherIncomeEdit").val() == null) {
            swal({
                title: "请填写其他收入总额！",
                type: "warning"
            });
            return;
        }
        if ($("#loanEdit").val() == "" || $("#loanEdit").val() == undefined || $("#loanEdit").val() == null) {
            swal({
                title: "请填写贷款金额（万元）！",
                type: "warning"
            });
            return;
        }
        if ($("#loanBalEdit").val() == "" || $("#loanBalEdit").val() == undefined || $("#loanBalEdit").val() == null) {
            swal({
                title: "请填写贷款余额（万元）！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/SchIncome/saveSchIncome", {
            id: "${data.id}",
            incomeAll: $("#incomeAllEdit").val(),
            sfAll: $("#sfAllEdit").val(),
            sfInd: $("#sfIndEdit").val(),
            sfStuType: $("#sfStuTypeEdit").val(),
            sfStd: $("#sfStdEdit").val(),
            sfMoney: $("#sfMoneyEdit").val(),
            awAll: $("#awAllEdit").val(),
            awIndex: $("#awIndexEdit").val(),
            awProName: $("#awProNameEdit").val(),
            awStd: $("#awStdEdit").val(),
            awProMoney: $("#awProMoneyEdit").val(),
            finAll: $("#finAllEdit").val(),
            finIndex: $("#finIndexEdit").val(),
            finProName: $("#finProNameEdit").val(),
            finProMoney: $("#finProMoneyEdit").val(),
            ssDonate: $("#ssDonateEdit").val(),
            otherIncome: $("#otherIncomeEdit").val(),
            loan: $("#loanEdit").val(),
            loanBal: $("#loanBalEdit").val(),
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            });
        })
    }
</script>



