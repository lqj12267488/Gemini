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
<div class="modal-dialog" style="width: 900px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" id="data">
                <div class="form-row">
                    学费收入：
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        学生类别
                    </div>
                    <div class="col-md-4">
                        <input id="sfStuTypeEdit" value="${data.sfStuType}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        标准（元/生）
                    </div>
                    <div class="col-md-4">
                        <input id="sfStdEdit" value="${data.sfStd}" class="validate[required,maxSize[20]] form-control"
                        placeholder="单位:元/生"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        金额（万元）
                    </div>
                    <div class="col-md-4">
                        <input id="sfMoneyEdit" value="${data.sfMoney}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
            <div class="form-row">
                财政经常性补助收入：
            </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        项目名称
                    </div>
                    <div class="col-md-4">
                        <input id="awProNameEdit" value="${data.awProName}" class="validate[required,maxSize[20]] form-control"
                        placeholder="项目全称"/>
                    </div>
                    <div class="col-md-2 tar">
                        补助标准
                    </div>
                    <div class="col-md-4">
                        <input id="awStdEdit" value="${data.awStd}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        项目金额（万元）
                    </div>
                    <div class="col-md-4">
                        <input id="awProMoneyEdit" value="${data.awProMoney}" class="validate[required,maxSize[20]] form-control"
                        placeholder="单位:万元"/>
                    </div>
                </div>
                <div class="form-row">
                    中央丶地方财政专项投入:
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        项目名称（全称）
                    </div>
                    <div class="col-md-4">
                        <input id="finProNameEdit" value="${data.finProName}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        项目金额（万元）
                    </div>
                    <div class="col-md-4">
                        <input id="finProMoneyEdit" value="${data.finProMoney}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        年份
                    </div>
                    <div class="col-md-4">
                        <select id="years" value="${data.year}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="save" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, "years");
        });

        if ("${seeFlag}" == "1"){
            $("#data input").attr("readonly","readonly")
            $("#data select").attr("disabled","disabled")
            $("#save").hide();
        }else {
            $("#data input").removeAttr("readonly")
            $("#data select").removeAttr("disabled")
            $("#save").show();
        }
    });

    function save() {

        // if ($("#sfAllEdit").val() == "" || $("#sfAllEdit").val() == undefined || $("#sfAllEdit").val() == null) {
        //     swal({
        //         title: "请填写学费合计收入！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#sfIndEdit").val() == "" || $("#sfIndEdit").val() == undefined || $("#sfIndEdit").val() == null) {
        //     swal({
        //         title: "请填写学费序号！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#sfStuTypeEdit").val() == "" || $("#sfStuTypeEdit").val() == undefined || $("#sfStuTypeEdit").val() == null) {
        //     swal({
        //         title: "请填写学生类别！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#sfStdEdit").val() == "" || $("#sfStdEdit").val() == undefined || $("#sfStdEdit").val() == null) {
        //     swal({
        //         title: "请填写标准（元/生）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#sfMoneyEdit").val() == "" || $("#sfMoneyEdit").val() == undefined || $("#sfMoneyEdit").val() == null) {
        //     swal({
        //         title: "请填写金额（万元）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#awAllEdit").val() == "" || $("#awAllEdit").val() == undefined || $("#awAllEdit").val() == null) {
        //     swal({
        //         title: "请填写补助收入合计！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#awIndexEdit").val() == "" || $("#awIndexEdit").val() == undefined || $("#awIndexEdit").val() == null) {
        //     swal({
        //         title: "请填写补助序号！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#awProNameEdit").val() == "" || $("#awProNameEdit").val() == undefined || $("#awProNameEdit").val() == null) {
        //     swal({
        //         title: "请填写项目名称（全称）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#awStdEdit").val() == "" || $("#awStdEdit").val() == undefined || $("#awStdEdit").val() == null) {
        //     swal({
        //         title: "请填写补助标准！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#awProMoneyEdit").val() == "" || $("#awProMoneyEdit").val() == undefined || $("#awProMoneyEdit").val() == null) {
        //     swal({
        //         title: "请填写项目金额！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#finAllEdit").val() == "" || $("#finAllEdit").val() == undefined || $("#finAllEdit").val() == null) {
        //     swal({
        //         title: "请填写财政专项投入合计！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#finIndexEdit").val() == "" || $("#finIndexEdit").val() == undefined || $("#finIndexEdit").val() == null) {
        //     swal({
        //         title: "请填写序号！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#finProNameEdit").val() == "" || $("#finProNameEdit").val() == undefined || $("#finProNameEdit").val() == null) {
        //     swal({
        //         title: "请填写项目名称（全称）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#finProMoneyEdit").val() == "" || $("#finProMoneyEdit").val() == undefined || $("#finProMoneyEdit").val() == null) {
        //     swal({
        //         title: "请填写项目金额（万元）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#ssDonateEdit").val() == "" || $("#ssDonateEdit").val() == undefined || $("#ssDonateEdit").val() == null) {
        //     swal({
        //         title: "请填写社会捐赠金额（万元）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#otherIncomeEdit").val() == "" || $("#otherIncomeEdit").val() == undefined || $("#otherIncomeEdit").val() == null) {
        //     swal({
        //         title: "请填写其他收入总额！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#loanEdit").val() == "" || $("#loanEdit").val() == undefined || $("#loanEdit").val() == null) {
        //     swal({
        //         title: "请填写贷款金额（万元）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#loanBalEdit").val() == "" || $("#loanBalEdit").val() == undefined || $("#loanBalEdit").val() == null) {
        //     swal({
        //         title: "请填写贷款余额（万元）！",
        //         type: "warning"
        //     });
        //     return;
        // }
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
            year:$("#years").val(),
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



