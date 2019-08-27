<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/16
  Time: 20:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
            <input id="employmentUnitId" hidden value="${employment.internshipUnitId}">
            <input id="internshipUnitName" hidden value="${employment.internshipUnitName}">
            <input id="area" hidden value="${employment.area}">
            <input id="address" hidden value="${employment.address}">
            <input id="contactPerson" hidden value="${employment.contactPerson}">
            <input id="contactNumber" hidden value="${employment.contactNumber}">
            <input id="legalPerson" hidden value="${employment.legalPerson}">
            <input id="registeredCapital" hidden value="${employment.registeredCapital}">
            <input id="personNumber" hidden value="${employment.enterprisePersonNumber}">
            <input id="unitProperty" hidden value="${employment.enterpriseNature}">
            <input id="enterpriseScale" hidden value="${employment.enterpriseScale}">
            <input id="internshipWhetherRetention" hidden value="${employment.internshipWhetherRetention}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 单位编码
                    </div>
                    <div class="col-md-4">
                        <input id="f_unitEncoding" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.unitEncoding}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 就业性质
                    </div>
                    <div class="col-md-4">
                        <select id="employmentNature" class="js-example-basic-single"></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 就业产业
                    </div>
                    <div class="col-md-4">
                        <select id="employmentIndustry" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>就业地域
                    </div>
                    <div class="col-md-4">
                        <select id="employmentArea" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  就业地点
                    </div>
                    <div class="col-md-4">
                        <select id="employmentPlace" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  企业类别
                    </div>
                    <div class="col-md-4">
                        <select id="enterpriseCategory" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 就业渠道
                    </div>
                    <div class="col-md-4">
                        <select id="employmentChannels" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 对口性质
                    </div>
                    <div class="col-md-4">
                        <select id="counterpartProperty" class="js-example-basic-single"></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="add()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'internshipUnitFlag', $("#internshipUnitFlagShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYDWXZ", function (data) {
            addOption(data, 'unitProperty', $("#unitPropertyShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYCYLB", function (data) {
            addOption(data, 'employmentIndustry', $("#employmentIndustryShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYDYLB", function (data) {
            addOption(data, 'employmentArea', $("#employmentAreaShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYDD", function (data) {
            addOption(data, 'employmentPlace', $("#employmentPlaceShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYQYSSLB", function (data) {
            addOption(data, 'enterpriseCategory', $("#enterpriseCategoryShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYQD", function (data) {
            addOption(data, 'employmentChannels', $("#employmentChannelsShow").val());
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYDKXZ", function (data) {
            addOption(data, 'counterpartProperty', $("#counterpartPropertyShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYXZ", function (data) {
            addOption(data, 'employmentNature', $("#employmentNatureShow").val());
        });
    })
    function add() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_unitEncoding").val() == "" || $("#f_unitEncoding").val() == "0" || $("#f_unitEncoding").val() == undefined) {
            swal({
                title: "请填写单位编码！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#f_unitEncoding").val())){
            swal({
                title: "单位编码填写错误，请填写数字！",
                type: "info"
            });
            return;
        }
        if ($("#employmentNature option:selected").val() == "") {
            swal({
                title: "请选择就业性质！",
                type: "info"
            });
            return;
        }
        if ($("#employmentIndustry option:selected").val() == "") {
            swal({
                title: "请选择就业产业！",
                type: "info"
            });
            return;
        }
        if ($("#employmentArea option:selected").val() == "") {
            swal({
                title: "请选择就业地域！",
                type: "info"
            });
            return;
        }
        if ($("#employmentPlace option:selected").val() == "") {
            swal({
                title: "请选择就业地点！",
                type: "info"
            });
            return;
        }
        if ($("#enterpriseCategory option:selected").val() == "") {
            swal({
                title: "请选择企业所属类别！",
                type: "info"
            });
            return;
        }
        if ($("#employmentChannels option:selected").val() == "") {
            swal({
                title: "请选择就业渠道！",
                type: "info"
            });
            return;
        }
        if ($("#counterpartProperty option:selected").val() == "") {
            swal({
                title: "请选择对口性质！",
                type: "info"
            });
            return;
        }

        var internshipUnitFlag;
        if($("#internshipWhetherRetention").val() == '1'){
            internshipUnitFlag = 1;
        }else{
            internshipUnitFlag = 0;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/employments/saveEmployments1", {
            employmentUnitId: $("#employmentUnitId").val(),
            internshipUnitName: $("#internshipUnitName").val(),
            area: $("#area").val(),
            address:$("#address").val(),
            contactPerson: $("#contactPerson").val(),
            contactNumber: $("#contactNumber").val(),
            unitEncoding: $("#f_unitEncoding").val(),
            legalPerson:$("#legalPerson").val(),
            registeredCapital: $("#registeredCapital").val(),
            personNumber: $("#personNumber").val(),
            unitProperty: $("#unitProperty").val(),
            employmentIndustry: $("#employmentIndustry option:selected").val(),
            employmentArea: $("#employmentArea option:selected").val(),
            employmentPlace: $("#employmentPlace option:selected").val(),
            enterpriseCategory: $("#enterpriseCategory option:selected").val(),
            employmentChannels: $("#employmentChannels option:selected").val(),
            counterpartProperty: $("#counterpartProperty option:selected").val(),
            employmentNature: $("#employmentNature option:selected").val(),
            internshipUnitFlag: internshipUnitFlag,
            enterpriseScale:$("#enterpriseScale").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#right").load("<%=request.getContextPath()%>/employments/request");
                $("#dialog").modal('hide');
                $('#employmentsGrid').DataTable().ajax.reload();

            }
        })
    }

</script>
