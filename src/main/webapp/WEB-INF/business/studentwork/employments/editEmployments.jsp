<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/11
  Time: 10:11
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
            <input id="employmentUnitId" hidden value="${employments.employmentUnitId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   单位名称
                    </div>
                    <div class="col-md-4">
                        <input id="f_internshipUnitName" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.internshipUnitName}" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 所在地区
                    </div>
                    <div class="col-md-4">
                        <input id="f_area" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.area}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  地址
                    </div>
                    <div class="col-md-4">
                        <input id="f_address" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.address}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  联系人
                    </div>
                    <div class="col-md-4">
                        <input id="f_contactPerson" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.contactPerson}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 联系人职务
                    </div>
                    <div class="col-md-4">
                        <input id="personPost" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.personPost}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>电子邮箱
                    </div>
                    <div class="col-md-4">
                        <input id="email" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.email}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  联系电话
                    </div>
                    <div class="col-md-4">
                        <input id="f_contactNumber" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.contactNumber}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  单位编码
                    </div>
                    <div class="col-md-4">
                        <input id="f_unitEncoding" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.unitEncoding}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>    法人
                    </div>
                    <div class="col-md-4">
                        <input id="f_legalPerson" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.legalPerson}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  注册资金
                    </div>
                    <div class="col-md-4">
                        <input id="f_registeredCapital" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.registeredCapital}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 员工数
                    </div>
                    <div class="col-md-4">
                        <input id="f_personNumber" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${employments.personNumber}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 单位性质
                    </div>
                    <div class="col-md-4">
                        <select id="unitProperty" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>就业产业
                    </div>
                    <div class="col-md-4">
                        <select id="employmentIndustry" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   就业地域
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
                        <span class="iconBtx">*</span>  对口性质
                    </div>
                    <div class="col-md-4">
                        <select id="counterpartProperty" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  就业性质
                    </div>
                    <div class="col-md-4">
                        <select id="employmentNature" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  企业规模
                    </div>
                    <div class="col-md-4">
                        <select id="enterpriseScale" disabled="disabled" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 是否做过雇主调查
                    </div>
                    <div class="col-md-4">
                        <select id="investigation" class="js-example-basic-single">
                            <option value="">请选择</option>
                            <option value="是">是</option>
                            <option value="否">否</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button"id="saveBtn" class="btn btn-success btn-clean" onclick="add()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="internshipUnitFlagShow" hidden value="${employments.internshipUnitFlag}">
<input id="unitPropertyShow" hidden value="${employments.unitProperty}">
<input id="employmentIndustryShow" hidden value="${employments.employmentIndustry}">
<input id="employmentAreaShow" hidden value="${employments.employmentArea}">
<input id="employmentPlaceShow" hidden value="${employments.employmentPlace}">
<input id="enterpriseCategoryShow" hidden value="${employments.enterpriseCategory}">
<input id="employmentChannelsShow" hidden value="${employments.employmentChannels}">
<input id="counterpartPropertyShow" hidden value="${employments.counterpartProperty}">
<input id="employmentNatureShow" hidden value="${employments.employmentNature}">
<input id="enterpriseScaleShow" hidden value="${employments.enterpriseScale}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $("#f_registeredCapital").blur(function () {
        var reg = new RegExp("^[0-9]*$");
        if( $("#f_registeredCapital").val() == "" || $("#f_registeredCapital").val() == "0" || $("#f_registeredCapital").val() == undefined){
            swal({
                title: "请填写注册资金！",
                type: "info"
            });
            $("#f_registeredCapital").val();
            return;
        }else if(!reg.test($("#f_registeredCapital").val())){
            swal({
                title: "注册资金填写错误，请重新填写！",
                type: "info"
            });
            $("#f_registeredCapital").val();
            return;
        }else if($("#f_registeredCapital").val() != ""){
            if($("#f_registeredCapital").val()<3000000){
                $("#enterpriseScale").val(3);
            }else if($("#f_registeredCapital").val()<20000000){
                $("#enterpriseScale").val(2);
            }else{
                $("#enterpriseScale").val(1);
            }
        }
    })
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=QYGM", function (data) {
            addOption(data, 'enterpriseScale', $("#enterpriseScaleShow").val());
        });
        $("#investigation").val("${employments.investigation}");
    })
    function add() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_internshipUnitName").val() == "" || $("#f_internshipUnitName").val() == "0" || $("#f_internshipUnitName").val() == undefined) {
            swal({
                title: "请填写单位名称！",
                type: "info"
            });
            return;
        }
        if ($("#f_area").val() == "" || $("#f_area").val() == "0" || $("#f_area").val() == undefined) {
            swal({
                title: "请填写所在地区！",
                type: "info"
            });
            return;
        }
        if ($("#f_address").val() == "" || $("#f_address").val() == "0" || $("#f_address").val() == undefined) {
            swal({
                title: "请填写地址！",
                type: "info"
            });
            return;
        }
        if ($("#f_contactPerson").val() == "" || $("#f_contactPerson").val() == "0" || $("#f_contactPerson").val() == undefined){
            swal({
                title: "请填写联系人！",
                type: "info"
            });
            return;
        }
        if ($("#personPost").val() == "" || $("#personPost").val() == "0" || $("#personPost").val() == undefined) {
            swal({
                title: "请填写联系人职务！",
                type: "info"
            });
            return;
        }
        if (  $("#email").val() == "" || $("#email").val() == "0" || $("#email").val() == undefined) {
            swal({
                title: "请填写电子邮箱！",
                type: "info"
            });
            return;
        }
        if( $("#f_contactNumber").val() == "" || $("#f_contactNumber").val() == "0" || $("#f_contactNumber").val() == undefined){
            swal({
                title: "请填写联系电话！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#f_contactNumber").val())){
            swal({
                title: "联系电话填写错误，请重新填写！",
                type: "info"
            });
            return;
        }
        if ($("#f_unitEncoding").val() == "" || $("#f_unitEncoding").val() == "0" || $("#f_unitEncoding").val() == undefined) {
            swal({
                title: "请填写单位编码！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#f_unitEncoding").val())){
            swal({
                title: "单位编码填写错误，请重新填写！",
                type: "info"
            });
            return;
        }
        if($("#f_legalPerson").val() == "" || $("#f_legalPerson").val() == "0" || $("#f_legalPerson").val() == undefined) {
            swal({
                title: "请填写法人！",
                type: "info"
            });
            return;
        }
        if( $("#f_registeredCapital").val() == "" || $("#f_registeredCapital").val() == "0" || $("#f_registeredCapital").val() == undefined){
            swal({
                title: "请填写注册资金！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#f_registeredCapital").val())){
            swal({
                title: "注册资金填写错误，请重新填写！",
                type: "info"
            });
            return;
        }
        if(  $("#f_personNumber").val() == "" || $("#f_personNumber").val() == "0" || $("#f_personNumber").val() == undefined){
            swal({
                title: "请填写员工数！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#f_personNumber").val())){
            swal({
                title: "员工数填写错误，请重新填写！",
                type: "info"
            });
            return;
        }
        if ($("#unitProperty option:selected").val() == "") {
            swal({
                title: "请选择单位性质！",
                type: "info"
            });
            return;
        }
        if ($("#employmentIndustry option:selected").val() == "") {
            swal({
                title: "请填写就业产业！",
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
                title: "请填写就业地点！",
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
        if ($("#employmentNature option:selected").val() == "") {
            swal({
                title: "请选择就业性质！",
                type: "info"
            });
            return;
        }
        if ($("#employmentNature option:selected").val() == "") {
            swal({
                title: "请选择是否做过雇主调查！",
                type: "info"
            });
            return;
        }

        var enterpriseScale
        if($("#f_registeredCapital").val()<1000000){
            enterpriseScale=3;
        }else if($("#f_registeredCapital").val()<5000000){
            enterpriseScale=2;
        }else{
            enterpriseScale=1;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/employments/saveEmployments", {
            employmentUnitId: $("#employmentUnitId").val(),
            internshipUnitName: $("#f_internshipUnitName").val(),
            area: $("#f_area").val(),
            address:$("#f_address").val(),
            contactPerson: $("#f_contactPerson").val(),
            contactNumber: $("#f_contactNumber").val(),
            unitEncoding: $("#f_unitEncoding").val(),
            legalPerson:$("#f_legalPerson").val(),
            registeredCapital: $("#f_registeredCapital").val(),
            personNumber: $("#f_personNumber").val(),
            unitProperty: $("#unitProperty option:selected").val(),
            employmentIndustry: $("#employmentIndustry option:selected").val(),
            employmentArea: $("#employmentArea option:selected").val(),
            employmentPlace: $("#employmentPlace option:selected").val(),
            enterpriseCategory: $("#enterpriseCategory option:selected").val(),
            employmentChannels: $("#employmentChannels option:selected").val(),
            counterpartProperty: $("#counterpartProperty option:selected").val(),
            employmentNature: $("#employmentNature option:selected").val(),
            personPost: $("#personPost").val(),
            email: $("#email").val(),
            investigation: $("#investigation option:selected").val(),
            internshipUnitFlag: 0,
            enterpriseScale: enterpriseScale
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#employmentsGrid').DataTable().ajax.reload();

            }
        })
    }

</script>
