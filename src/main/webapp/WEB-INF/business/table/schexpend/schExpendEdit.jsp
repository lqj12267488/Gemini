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
                        <span class="iconBtx">*</span>学校总支出（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="expAllEdit" value="${data.expAll}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>征地（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="landEdit" value="${data.land}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>基础设施建设（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="expInfEdit" value="${data.expInf}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>设备采购（万元）合计
                    </div>
                    <div class="col-md-9">
                        <input id="expDevAllEdit" value="${data.expDevAll}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教学科研仪器设备值
                    </div>
                    <div class="col-md-9">
                        <input id="expTeachDevEdit" value="${data.expTeachDev}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>实(验)训耗材
                    </div>
                    <div class="col-md-9">
                        <input id="trainCostEdit" value="${data.trainCost}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>实习专项
                    </div>
                    <div class="col-md-9">
                        <input id="trainProEdit" value="${data.trainPro}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>聘请兼职教师经费
                    </div>
                    <div class="col-md-9">
                        <input id="hirePtTeachEdit" value="${data.hirePtTeach}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>体育维持费
                    </div>
                    <div class="col-md-9">
                        <input id="sportEdit" value="${data.sport}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>其他日常教学经费
                    </div>
                    <div class="col-md-9">
                        <input id="dailyOthEdit" value="${data.dailyOth}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教学改革及研究合计经费
                    </div>
                    <div class="col-md-9">
                        <input id="rsAllEdit" value="${data.rsAll}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>序号
                    </div>
                    <div class="col-md-9">
                        <input id="rsIndEdit" value="${data.rsInd}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目名称（全称）
                    </div>
                    <div class="col-md-9">
                        <input id="rsProNameEdit" value="${data.rsProName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目金额
                    </div>
                    <div class="col-md-9">
                        <input id="rsProMoneyEdit" value="${data.rsProMoney}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>师资建设合计（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="tcAllEdit" value="${data.tcAll}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>序号
                    </div>
                    <div class="col-md-9">
                        <input id="tcIndEdit" value="${data.tcInd}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目名称（全称）
                    </div>
                    <div class="col-md-9">
                        <input id="tcProNameEdit" value="${data.tcProName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目金额
                    </div>
                    <div class="col-md-9">
                        <input id="tcProMoneyEdit" value="${data.tcProMoney}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>图书购置费
                    </div>
                    <div class="col-md-9">
                        <input id="libCostEdit" value="${data.libCost}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>其他总支持
                    </div>
                    <div class="col-md-9">
                        <input id="othCostEdit" value="${data.othCost}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>还贷金额（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="payLoanEdit" value="${data.payLoan}"/>
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
        if ($("#expAllEdit").val() == "" || $("#expAllEdit").val() == undefined || $("#expAllEdit").val() == null) {
            swal({
                title: "请填写学校总支出（万元）！",
                type: "warning"
            });
            return;
        }
        if ($("#landEdit").val() == "" || $("#landEdit").val() == undefined || $("#landEdit").val() == null) {
            swal({
                title: "请填写征地（万元）！",
                type: "warning"
            });
            return;
        }
        if ($("#expInfEdit").val() == "" || $("#expInfEdit").val() == undefined || $("#expInfEdit").val() == null) {
            swal({
                title: "请填写基础设施建设（万元）！",
                type: "warning"
            });
            return;
        }
        if ($("#expDevAllEdit").val() == "" || $("#expDevAllEdit").val() == undefined || $("#expDevAllEdit").val() == null) {
            swal({
                title: "请填写设备采购（万元）合计！",
                type: "warning"
            });
            return;
        }
        if ($("#expTeachDevEdit").val() == "" || $("#expTeachDevEdit").val() == undefined || $("#expTeachDevEdit").val() == null) {
            swal({
                title: "请填写教学科研仪器设备值！",
                type: "warning"
            });
            return;
        }
        if ($("#trainCostEdit").val() == "" || $("#trainCostEdit").val() == undefined || $("#trainCostEdit").val() == null) {
            swal({
                title: "请填写实(验)训耗材！",
                type: "warning"
            });
            return;
        }
        if ($("#trainProEdit").val() == "" || $("#trainProEdit").val() == undefined || $("#trainProEdit").val() == null) {
            swal({
                title: "请填写实习专项！",
                type: "warning"
            });
            return;
        }
        if ($("#hirePtTeachEdit").val() == "" || $("#hirePtTeachEdit").val() == undefined || $("#hirePtTeachEdit").val() == null) {
            swal({
                title: "请填写聘请兼职教师经费！",
                type: "warning"
            });
            return;
        }
        if ($("#sportEdit").val() == "" || $("#sportEdit").val() == undefined || $("#sportEdit").val() == null) {
            swal({
                title: "请填写体育维持费！",
                type: "warning"
            });
            return;
        }
        if ($("#dailyOthEdit").val() == "" || $("#dailyOthEdit").val() == undefined || $("#dailyOthEdit").val() == null) {
            swal({
                title: "请填写其他日常教学经费！",
                type: "warning"
            });
            return;
        }
        if ($("#rsAllEdit").val() == "" || $("#rsAllEdit").val() == undefined || $("#rsAllEdit").val() == null) {
            swal({
                title: "请填写教学改革及研究合计经费！",
                type: "warning"
            });
            return;
        }
        if ($("#rsIndEdit").val() == "" || $("#rsIndEdit").val() == undefined || $("#rsIndEdit").val() == null) {
            swal({
                title: "请填写序号！",
                type: "warning"
            });
            return;
        }
        if ($("#rsProNameEdit").val() == "" || $("#rsProNameEdit").val() == undefined || $("#rsProNameEdit").val() == null) {
            swal({
                title: "请填写项目名称（全称）！",
                type: "warning"
            });
            return;
        }
        if ($("#rsProMoneyEdit").val() == "" || $("#rsProMoneyEdit").val() == undefined || $("#rsProMoneyEdit").val() == null) {
            swal({
                title: "请填写项目金额！",
                type: "warning"
            });
            return;
        }
        if ($("#tcAllEdit").val() == "" || $("#tcAllEdit").val() == undefined || $("#tcAllEdit").val() == null) {
            swal({
                title: "请填写师资建设合计（万元）！",
                type: "warning"
            });
            return;
        }
        if ($("#tcIndEdit").val() == "" || $("#tcIndEdit").val() == undefined || $("#tcIndEdit").val() == null) {
            swal({
                title: "请填写序号！",
                type: "warning"
            });
            return;
        }
        if ($("#tcProNameEdit").val() == "" || $("#tcProNameEdit").val() == undefined || $("#tcProNameEdit").val() == null) {
            swal({
                title: "请填写项目名称（全称）！",
                type: "warning"
            });
            return;
        }
        if ($("#tcProMoneyEdit").val() == "" || $("#tcProMoneyEdit").val() == undefined || $("#tcProMoneyEdit").val() == null) {
            swal({
                title: "请填写项目金额！",
                type: "warning"
            });
            return;
        }
        if ($("#libCostEdit").val() == "" || $("#libCostEdit").val() == undefined || $("#libCostEdit").val() == null) {
            swal({
                title: "请填写图书购置费！",
                type: "warning"
            });
            return;
        }
        if ($("#othCostEdit").val() == "" || $("#othCostEdit").val() == undefined || $("#othCostEdit").val() == null) {
            swal({
                title: "请填写其他总支持！",
                type: "warning"
            });
            return;
        }
        if ($("#payLoanEdit").val() == "" || $("#payLoanEdit").val() == undefined || $("#payLoanEdit").val() == null) {
            swal({
                title: "请填写还贷金额（万元）！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/SchExpend/saveSchExpend", {
            id: "${data.id}",
            expAll: $("#expAllEdit").val(),
            land: $("#landEdit").val(),
            expInf: $("#expInfEdit").val(),
            expDevAll: $("#expDevAllEdit").val(),
            expTeachDev: $("#expTeachDevEdit").val(),
            trainCost: $("#trainCostEdit").val(),
            trainPro: $("#trainProEdit").val(),
            hirePtTeach: $("#hirePtTeachEdit").val(),
            sport: $("#sportEdit").val(),
            dailyOth: $("#dailyOthEdit").val(),
            rsAll: $("#rsAllEdit").val(),
            rsInd: $("#rsIndEdit").val(),
            rsProName: $("#rsProNameEdit").val(),
            rsProMoney: $("#rsProMoneyEdit").val(),
            tcAll: $("#tcAllEdit").val(),
            tcInd: $("#tcIndEdit").val(),
            tcProName: $("#tcProNameEdit").val(),
            tcProMoney: $("#tcProMoneyEdit").val(),
            libCost: $("#libCostEdit").val(),
            othCost: $("#othCostEdit").val(),
            payLoan: $("#payLoanEdit").val(),
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



