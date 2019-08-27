<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/31
  Time: 19:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
            <input id="internshipUnitId" hidden value="${internships.internshipUnitId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 单位名称
                    </div>
                    <div class="col-md-9">
                        <input id="f_internshipUnitName" type="text"
                               maxlength="10" placeholder="最多输入10个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internships.internshipUnitName}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 所在地区
                    </div>
                    <div class="col-md-9">
                        <input id="f_area" type="text"
                               maxlength="10" placeholder="最多输入10个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internships.area}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  地址
                    </div>
                    <div class="col-md-9">
                        <input id="f_address" type="text"
                               maxlength="10" placeholder="最多输入10个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internships.address}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 联系人
                    </div>
                    <div class="col-md-9">
                        <input id="f_contactPerson" type="text"
                               maxlength="10" placeholder="最多输入10个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internships.contactPerson}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 联系电话
                    </div>
                    <div class="col-md-9">
                        <input id="f_contactNumber" type="text"
                               maxlength="11" placeholder="最多输入11个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internships.contactNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  法人代表
                    </div>
                    <div class="col-md-9">
                        <input id="f_legalPerson" type="text"
                               maxlength="10" placeholder="最多输入10个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internships.legalPerson}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  企业性质
                    </div>
                    <div class="col-md-9">
                        <select id="f_enterpriseNature" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  注册资金
                    </div>
                    <div class="col-md-9">
                        <input id="f_registeredCapital" type="text"
                               maxlength="10" placeholder="最多输入10个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internships.registeredCapital}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  企业员工数
                    </div>
                    <div class="col-md-9">
                        <input id="f_enterprisePersonNumber" type="text"
                               maxlength="5" placeholder="最多输入5个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internships.enterprisePersonNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 合作时间
                    </div>
                    <div class="col-md-9">
                        <select id="f_cooperationTime" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  实习生是否留用
                    </div>
                    <div class="col-md-9">
                        <select id="f_internshipWhetherRetention" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 企业规模
                    </div>
                    <div class="col-md-9">
                        <select id="enterpriseScale" disabled />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button"  id="saveBtn" class="btn btn-success btn-clean" onclick="add()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $("#f_registeredCapital").blur(function () {
        var reg3 = new RegExp("^[0-9]*$");
        if( $("#f_registeredCapital").val() == "" || $("#f_registeredCapital").val() == "0" || $("#f_registeredCapital").val() == undefined){
            swal({
                title: "请填写注册资金！",
                type: "info"
            });
            $("#f_registeredCapital").val("");
            return;
        }else if(!reg3.test($("#f_registeredCapital").val())){
            swal({
                title: "注册资金填写有误，请填写数字！",
                type: "info"
            });
            $("#f_registeredCapital").val("");
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=HZSJ", function (data) {
            addOption(data, 'f_cooperationTime', '${internships.cooperationTime}');
        });
    })
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=QYGM", function (data) {
            addOption(data, 'enterpriseScale', '${internships.enterpriseScale}');
        });
    })
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=QYXZ", function (data) {
            addOption(data, 'f_enterpriseNature', '${internships.enterpriseNature}');
        });
    })
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SFLY", function (data) {
            addOption(data, 'f_internshipWhetherRetention', '${internships.internshipWhetherRetention}');
        });
    })
    function add() {
        var reg3 = new RegExp("^[0-9]*$");

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
        if( $("#f_contactNumber").val() == "" || $("#f_contactNumber").val() == "0" || $("#f_contactNumber").val() == undefined){
            swal({
                title: "请填写联系电话！",
                type: "info"
            });
            return;
        }


        if( $("#f_legalPerson").val() == "" || $("#f_legalPerson").val() == "0" || $("#f_legalPerson").val() == undefined){
            swal({
                title: "请填写法人代表！",
                type: "info"
            });
            return;
        }if( $("#f_enterpriseNature").val() == "" || $("#f_enterpriseNature").val() == "0" || $("#f_enterpriseNature").val() == undefined){
            swal({
                title: "请填写企业性质！",
                type: "info"
            });
            return;
        }

        if( $("#f_enterprisePersonNumber").val() == "" || $("#f_enterprisePersonNumber").val() == "0" || $("#f_enterprisePersonNumber").val() == undefined){
            swal({
                title: "请填写企业员工数！",
                type: "info"
            });
            return;
        }if(!reg3.test($("#f_enterprisePersonNumber").val())){
            swal({
                title: "企业员工数填写有误，请重新填写！",
                type: "info"
            });
            return;
        }

        if( $("#f_registeredCapital").val() == "" || $("#f_registeredCapital").val() == "0" || $("#f_registeredCapital").val() == undefined) {
            swal({
                title: "请填写注册资金！",
                type: "info"
            });
            return;
        }


        if( $("#f_cooperationTime").val() == "" || $("#f_cooperationTime").val() == "0" || $("#f_cooperationTime").val() == undefined){
            swal({
                title: "请填写合作时间！",
                type: "info"
            });
            return;
        }if( $("#f_internshipWhetherRetention").val() == "" || $("#f_internshipWhetherRetention").val() == "0" || $("#f_internshipWhetherRetention").val() == undefined){
            swal({
                title: "请填写实习生是否留用！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/internships/saveInternships", {
            internshipUnitId: $("#internshipUnitId").val(),
            internshipUnitName: $("#f_internshipUnitName").val(),
            area: $("#f_area").val(),
            address:$("#f_address").val(),
            contactPerson: $("#f_contactPerson").val(),
            contactNumber: $("#f_contactNumber").val(),
            internshipWhetherRetention: $("#f_internshipWhetherRetention").val(),
            cooperationTime: $("#f_cooperationTime").val(),
            enterprisePersonNumber: $("#f_enterprisePersonNumber").val(),
            registeredCapital:$("#f_registeredCapital").val(),
            enterpriseNature: $("#f_enterpriseNature").val(),
            legalPerson: $("#f_legalPerson").val(),
            enterpriseScale:$("#enterpriseScale").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#internshipsGrid').DataTable().ajax.reload();

            }
        })
    }

</script>
