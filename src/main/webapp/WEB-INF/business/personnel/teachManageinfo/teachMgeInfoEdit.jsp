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
<div class="modal-dialog" style="width: 800px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>姓名
                    </div>
                    <div class="col-md-3">
                        <input id="nameEdit" value="${data.name}"   class="validate[required,maxSize[20]] form-control" readonly/>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>部门
                    </div>
                    <div class="col-md-3">
                        <input id="deptIdEdit" value="${data.deptShow}" class="validate[required,maxSize[20]] form-control" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>证件号
                    </div>
                    <div class="col-md-3">
                        <input id="idcardEdit" value="${data.idcard}"  class="validate[required,maxSize[20]] form-control"  readonly/>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>银行卡号
                    </div>
                    <div class="col-md-3">
                        <input id="bankIdEdit" value="${data.bankId}"  class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div id="data">
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>一寸照
                        </div>
                        <div class="col-md-3">
                            <select id="phoneEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>

                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>身份证复印件
                        </div>
                        <div class="col-md-3">
                            <select id="idcardCopyEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>身份证期限
                        </div>
                        <div class="col-md-3">
                            <input id="idcardEndtimeEdit" type="date" value="${data.idcardEndtime}"  class="validate[required,maxSize[20]] form-control"/>
                        </div>

                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>户口
                        </div>
                        <div class="col-md-3">
                            <select id="accountEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>
                    </div>


                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>毕业证
                        </div>
                        <div class="col-md-3">
                            <select id="diplomaEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>

                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>学位证
                        </div>
                        <div class="col-md-3">
                            <select id="degreeCertEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>解除劳动合同
                        </div>
                        <div class="col-md-3">
                            <select id="disContractEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>计算机
                        </div>
                        <div class="col-md-3">
                            <select id="computerEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>英语
                        </div>
                        <div class="col-md-3">
                            <select id="englishEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>

                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>普通话
                        </div>
                        <div class="col-md-3">
                            <select id="putonghuaEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>国语水平
                        </div>
                        <div class="col-md-3">
                            <select id="pthLevelEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>教师资格证
                        </div>
                        <div class="col-md-3">
                            <select id="teachCertEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>其他资格证
                        </div>
                        <div class="col-md-3">
                            <select id="otherCertEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>驾驶证
                        </div>
                        <div class="col-md-3">
                            <select id="driverCertEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>电工证
                        </div>
                        <div class="col-md-3">
                            <select id="eleCertEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>

                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>退休证
                        </div>
                        <div class="col-md-3">
                            <select id="retireCertEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>退休证明
                        </div>
                        <div class="col-md-3">
                            <select id="retireProveEdit" class="validate[required,maxSize[20]] form-control"/>
                        </div>

                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>外单位交社保证明
                        </div>
                        <div class="col-md-3">
                            <select id="extSsCertEdit" class="validate[required,maxSize[20]] form-control"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>人事档案
                        </div>
                        <div class="col-md-3">
                            <select id="personFileEdit"  class="validate[required,maxSize[20]] form-control"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>其他资料
                        </div>
                        <div class="col-md-3">
                            <select id="otherInfoEdit" class="validate[required,maxSize[20]] form-control" />
                        </div>
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
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=	YW", function (data) {
                addOption(data, 'phoneEdit','${data.phone}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=	YW", function (data) {
                addOption(data, 'idcardCopyEdit','${data.idcardCopy}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=	YW", function (data) {
                addOption(data, 'accountEdit','${data.account}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=	YW", function (data) {
                addOption(data, 'diplomaEdit','${data.diploma}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=	YW", function (data) {
                addOption(data, 'degreeCertEdit','${data.degreeCert}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'disContractEdit','${data.disContract}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'computerEdit','${data.computer}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'englishEdit','${data.english}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'putonghuaEdit','${data.putonghua}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'pthLevelEdit','${data.pthLevel}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'teachCertEdit','${data.teachCert}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'otherCertEdit','${data.otherCert}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'driverCertEdit','${data.driverCert}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'eleCertEdit','${data.eleCert}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'retireCertEdit','${data.retireCert}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'retireProveEdit','${data.retireProve}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'extSsCertEdit','${data.extSsCert}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'personFileEdit','${data.personFile}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
                addOption(data, 'otherInfoEdit','${data.otherInfo}');
            });

            if ("${seeFlag}" == "1"){
                $("#data input").attr("readonly","readonly")
                $("#bankIdEdit").attr("readonly","readonly")
                $("#data select").attr("disabled","disabled")
                $("#save").hide();
            }else {
                $("#data input").removeAttr("readonly")
                $("#bankIdEdit").removeAttr("readonly")
                $("#data select").removeAttr("disabled")
                $("#save").show();
            }
    });

    function save() {
        if ($("#bankIdEdit").val() == "" || $("#bankIdEdit").val() == undefined || $("#bankIdEdit").val() == null) {
            swal({
                title: "请填写银行卡号！",
                type: "warning"
            });
            return;
        }

        if ($("#bankIdEdit").val().length != 19 && $("#bankIdEdit").val().length != 16){
            swal({
                title: "银行卡号长度有误！",
                type: "warning"
            });
            return;
        }

        if ($("#phoneEdit").val() == "" || $("#phoneEdit").val() == undefined || $("#phoneEdit").val() == null) {
            swal({
                title: "请选择一寸照！",
                type: "warning"
            });
            return;
        }
        if ($("#idcardCopyEdit").val() == "" || $("#idcardCopyEdit").val() == undefined || $("#idcardCopyEdit").val() == null) {
            swal({
                title: "请选择身份证复印件！",
                type: "warning"
            });
            return;
        }
        if ($("#idcardEndtimeEdit").val() == "" || $("#idcardEndtimeEdit").val() == undefined || $("#idcardEndtimeEdit").val() == null) {
            swal({
                title: "请填写身份证期限！",
                type: "warning"
            });
            return;
        }
        if ($("#accountEdit").val() == "" || $("#accountEdit").val() == undefined || $("#accountEdit").val() == null) {
            swal({
                title: "请选择户口！",
                type: "warning"
            });
            return;
        }
        if ($("#diplomaEdit").val() == "" || $("#diplomaEdit").val() == undefined || $("#diplomaEdit").val() == null) {
            swal({
                title: "请选择毕业证！",
                type: "warning"
            });
            return;
        }
        if ($("#degreeCertEdit").val() == "" || $("#degreeCertEdit").val() == undefined || $("#degreeCertEdit").val() == null) {
            swal({
                title: "请选择学位证！",
                type: "warning"
            });
            return;
        }
        if ($("#disContractEdit").val() == "" || $("#disContractEdit").val() == undefined || $("#disContractEdit").val() == null) {
            swal({
                title: "请选择解除劳动合同！",
                type: "warning"
            });
            return;
        }
        if ($("#computerEdit").val() == "" || $("#computerEdit").val() == undefined || $("#computerEdit").val() == null) {
            swal({
                title: "请选择计算机！",
                type: "warning"
            });
            return;
        }
        if ($("#englishEdit").val() == "" || $("#englishEdit").val() == undefined || $("#englishEdit").val() == null) {
            swal({
                title: "请选择英语！",
                type: "warning"
            });
            return;
        }
        if ($("#putonghuaEdit").val() == "" || $("#putonghuaEdit").val() == undefined || $("#putonghuaEdit").val() == null) {
            swal({
                title: "请选择普通话！",
                type: "warning"
            });
            return;
        }
        if ($("#pthLevelEdit").val() == "" || $("#pthLevelEdit").val() == undefined || $("#pthLevelEdit").val() == null) {
            swal({
                title: "请选择国语水平！",
                type: "warning"
            });
            return;
        }
        if ($("#teachCertEdit").val() == "" || $("#teachCertEdit").val() == undefined || $("#teachCertEdit").val() == null) {
            swal({
                title: "请选择教师资格证！",
                type: "warning"
            });
            return;
        }
        if ($("#otherCertEdit").val() == "" || $("#otherCertEdit").val() == undefined || $("#otherCertEdit").val() == null) {
            swal({
                title: "请选择其他资格证！",
                type: "warning"
            });
            return;
        }
        if ($("#driverCertEdit").val() == "" || $("#driverCertEdit").val() == undefined || $("#driverCertEdit").val() == null) {
            swal({
                title: "请选择驾驶证！",
                type: "warning"
            });
            return;
        }
        if ($("#eleCertEdit").val() == "" || $("#eleCertEdit").val() == undefined || $("#eleCertEdit").val() == null) {
            swal({
                title: "请选择电工证！",
                type: "warning"
            });
            return;
        }
        if ($("#retireCertEdit").val() == "" || $("#retireCertEdit").val() == undefined || $("#retireCertEdit").val() == null) {
            swal({
                title: "请选择退休证！",
                type: "warning"
            });
            return;
        }
        if ($("#retireProveEdit").val() == "" || $("#retireProveEdit").val() == undefined || $("#retireProveEdit").val() == null) {
            swal({
                title: "请选择退休证名！",
                type: "warning"
            });
            return;
        }
        if ($("#extSsCertEdit").val() == "" || $("#extSsCertEdit").val() == undefined || $("#extSsCertEdit").val() == null) {
            swal({
                title: "请选择外单位交社保证明！",
                type: "warning"
            });
            return;
        }
        if ($("#personFileEdit").val() == "" || $("#personFileEdit").val() == undefined || $("#personFileEdit").val() == null) {
            swal({
                title: "请选择人事档案！",
                type: "warning"
            });
            return;
        }
        if ($("#otherInfoEdit").val() == "" || $("#otherInfoEdit").val() == undefined || $("#otherInfoEdit").val() == null) {
            swal({
                title: "请选择其他资料！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/TeachMgeInfo/saveTeachMgeInfo", {
            personId:  "${data.personId}",
            bankId: $("#bankIdEdit").val(),
            phone: $("#phoneEdit").val(),
            idcardCopy: $("#idcardCopyEdit").val(),
            idcardEndtime: $("#idcardEndtimeEdit").val(),
            account: $("#accountEdit").val(),
            diploma: $("#diplomaEdit").val(),
            degreeCert: $("#degreeCertEdit").val(),
            disContract: $("#disContractEdit").val(),
            computer: $("#computerEdit").val(),
            english: $("#englishEdit").val(),
            putonghua: $("#putonghuaEdit").val(),
            pthLevel: $("#pthLevelEdit").val(),
            teachCert: $("#teachCertEdit").val(),
            otherCert: $("#otherCertEdit").val(),
            driverCert: $("#driverCertEdit").val(),
            eleCert: $("#eleCertEdit").val(),
            retireCert: $("#retireCertEdit").val(),
            retireProve: $("#retireProveEdit").val(),
            extSsCert: $("#extSsCertEdit").val(),
            personFile: $("#personFileEdit").val(),
            otherInfo: $("#otherInfoEdit").val(),
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



