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
                    <div class="col-md-2 tar">
                       征地（万元）
                    </div>
                    <div class="col-md-4">
                        <input id="landEdit" value="${data.land}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        基础设施建设（万元）
                    </div>
                    <div class="col-md-4">
                        <input id="expInfEdit" value="${data.expInf}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    设备采购（万元）:
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        合计
                    </div>
                    <div class="col-md-4">
                        <input id="expDevAllEdit" value="${data.expDevAll}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        教学科研仪器设备值
                    </div>
                    <div class="col-md-4">
                        <input id="expTeachDevEdit" value="${data.expTeachDev}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    日常教学经费：
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        实(验)训耗材
                    </div>
                    <div class="col-md-4">
                        <input id="trainCostEdit" value="${data.trainCost}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        实习专项
                    </div>
                    <div class="col-md-4">
                        <input id="trainProEdit" value="${data.trainPro}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        聘请兼职教师经费
                    </div>
                    <div class="col-md-4">
                        <input id="hirePtTeachEdit" value="${data.hirePtTeach}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        体育维持费
                    </div>
                    <div class="col-md-4">
                        <input id="sportEdit" value="${data.sport}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        其他
                    </div>
                    <div class="col-md-4">
                        <input id="dailyOthEdit" value="${data.dailyOth}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    教学改革及研究
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        项目名称
                    </div>
                    <div class="col-md-4">
                        <input id="rsProNameEdit" value="${data.rsProName}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        项目金额
                    </div>
                    <div class="col-md-4">
                        <input id="rsProMoneyEdit" value="${data.rsProMoney}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    师资建设
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        项目名称
                    </div>
                    <div class="col-md-4">
                        <input id="tcProNameEdit" value="${data.tcProName}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        项目金额
                    </div>
                    <div class="col-md-4">
                        <input id="tcProMoneyEdit" value="${data.tcProMoney}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                       图书购置费
                    </div>
                    <div class="col-md-4">
                        <input id="libCostEdit" value="${data.libCost}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        其他总支持
                    </div>
                    <div class="col-md-4">
                        <input id="othCostEdit" value="${data.othCost}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        还贷金额（万元）
                    </div>
                    <div class="col-md-4">
                        <input id="payLoanEdit" value="${data.payLoan}" class="validate[required,maxSize[20]] form-control"/>
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
        //
        // if ($("#landEdit").val() == "" || $("#landEdit").val() == undefined || $("#landEdit").val() == null) {
        //     swal({
        //         title: "请填写征地（万元）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#expInfEdit").val() == "" || $("#expInfEdit").val() == undefined || $("#expInfEdit").val() == null) {
        //     swal({
        //         title: "请填写基础设施建设（万元）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#expDevAllEdit").val() == "" || $("#expDevAllEdit").val() == undefined || $("#expDevAllEdit").val() == null) {
        //     swal({
        //         title: "请填写设备采购（万元）合计！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#expTeachDevEdit").val() == "" || $("#expTeachDevEdit").val() == undefined || $("#expTeachDevEdit").val() == null) {
        //     swal({
        //         title: "请填写教学科研仪器设备值！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#trainCostEdit").val() == "" || $("#trainCostEdit").val() == undefined || $("#trainCostEdit").val() == null) {
        //     swal({
        //         title: "请填写实(验)训耗材！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#trainProEdit").val() == "" || $("#trainProEdit").val() == undefined || $("#trainProEdit").val() == null) {
        //     swal({
        //         title: "请填写实习专项！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#hirePtTeachEdit").val() == "" || $("#hirePtTeachEdit").val() == undefined || $("#hirePtTeachEdit").val() == null) {
        //     swal({
        //         title: "请填写聘请兼职教师经费！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#sportEdit").val() == "" || $("#sportEdit").val() == undefined || $("#sportEdit").val() == null) {
        //     swal({
        //         title: "请填写体育维持费！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#dailyOthEdit").val() == "" || $("#dailyOthEdit").val() == undefined || $("#dailyOthEdit").val() == null) {
        //     swal({
        //         title: "请填写其他日常教学经费！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#rsProNameEdit").val() == "" || $("#rsProNameEdit").val() == undefined || $("#rsProNameEdit").val() == null) {
        //     swal({
        //         title: "请填写项目名称（全称）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#rsProMoneyEdit").val() == "" || $("#rsProMoneyEdit").val() == undefined || $("#rsProMoneyEdit").val() == null) {
        //     swal({
        //         title: "请填写项目金额！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#tcProNameEdit").val() == "" || $("#tcProNameEdit").val() == undefined || $("#tcProNameEdit").val() == null) {
        //     swal({
        //         title: "请填写项目名称（全称）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#tcProMoneyEdit").val() == "" || $("#tcProMoneyEdit").val() == undefined || $("#tcProMoneyEdit").val() == null) {
        //     swal({
        //         title: "请填写项目金额！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#libCostEdit").val() == "" || $("#libCostEdit").val() == undefined || $("#libCostEdit").val() == null) {
        //     swal({
        //         title: "请填写图书购置费！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#othCostEdit").val() == "" || $("#othCostEdit").val() == undefined || $("#othCostEdit").val() == null) {
        //     swal({
        //         title: "请填写其他总支持！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#payLoanEdit").val() == "" || $("#payLoanEdit").val() == undefined || $("#payLoanEdit").val() == null) {
        //     swal({
        //         title: "请填写还贷金额（万元）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        $.post("<%=request.getContextPath()%>/SchExpend/saveSchExpend", {
            id: "${data.id}",
            land: $("#landEdit").val(),
            expInf: $("#expInfEdit").val(),
            expDevAll: $("#expDevAllEdit").val(),
            expTeachDev: $("#expTeachDevEdit").val(),
            trainCost: $("#trainCostEdit").val(),
            trainPro: $("#trainProEdit").val(),
            hirePtTeach: $("#hirePtTeachEdit").val(),
            sport: $("#sportEdit").val(),
            dailyOth: $("#dailyOthEdit").val(),
            rsProName: $("#rsProNameEdit").val(),
            rsProMoney: $("#rsProMoneyEdit").val(),
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



