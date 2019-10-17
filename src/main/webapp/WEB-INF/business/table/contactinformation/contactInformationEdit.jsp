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
                        <span class="iconBtx">*</span>通信地址
                    </div>
                    <div class="col-md-9">
                        <input id="mailingAddressEdit" value="${data.mailingAddress}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>邮政编码
                    </div>
                    <div class="col-md-9">
                        <input id="postalCodeEdit" value="${data.postalCode}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学校网址
                    </div>
                    <div class="col-md-9">
                        <input id="schoolWebsiteEdit" value="${data.schoolWebsite}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>法人区号－电话号码
                    </div>
                    <div class="col-md-9">
                        <input id="areaNumberEdit" value="${data.areaNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>法人区号－传真号
                    </div>
                    <div class="col-md-9">
                        <input id="areaFaxEdit" value="${data.areaFax}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>法人电子邮箱
                    </div>
                    <div class="col-md-9">
                        <input id="mailBoxEdit" value="${data.mailBox}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>联系人区号－电话号码
                    </div>
                    <div class="col-md-9">
                        <input id="contactsAreaNumberEdit" value="${data.contactsAreaNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>联系人区号－传真号
                    </div>
                    <div class="col-md-9">
                        <input id="contactsAreaFaxEdit" value="${data.contactsAreaFax}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>联系人电子邮箱
                    </div>
                    <div class="col-md-9">
                        <input id="contactsMailBoxEdit" value="${data.contactsMailBox}"/>
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
        if ($("#mailingAddressEdit").val() == "" || $("#mailingAddressEdit").val() == undefined || $("#mailingAddressEdit").val() == null) {
            swal({
                title: "请填写通信地址！",
                type: "warning"
            });
            return;
        }
        if ($("#postalCodeEdit").val() == "" || $("#postalCodeEdit").val() == undefined || $("#postalCodeEdit").val() == null) {
            swal({
                title: "请填写邮政编码！",
                type: "warning"
            });
            return;
        }
        if ($("#schoolWebsiteEdit").val() == "" || $("#schoolWebsiteEdit").val() == undefined || $("#schoolWebsiteEdit").val() == null) {
            swal({
                title: "请填写学校网址！",
                type: "warning"
            });
            return;
        }
        if ($("#areaNumberEdit").val() == "" || $("#areaNumberEdit").val() == undefined || $("#areaNumberEdit").val() == null) {
            swal({
                title: "请填写法人区号－电话号码！",
                type: "warning"
            });
            return;
        }
        if ($("#areaFaxEdit").val() == "" || $("#areaFaxEdit").val() == undefined || $("#areaFaxEdit").val() == null) {
            swal({
                title: "请填写法人区号－传真号！",
                type: "warning"
            });
            return;
        }
        if ($("#mailBoxEdit").val() == "" || $("#mailBoxEdit").val() == undefined || $("#mailBoxEdit").val() == null) {
            swal({
                title: "请填写法人电子邮箱！",
                type: "warning"
            });
            return;
        }
        if ($("#contactsAreaNumberEdit").val() == "" || $("#contactsAreaNumberEdit").val() == undefined || $("#contactsAreaNumberEdit").val() == null) {
            swal({
                title: "请填写联系人区号－电话号码！",
                type: "warning"
            });
            return;
        }
        if ($("#contactsAreaFaxEdit").val() == "" || $("#contactsAreaFaxEdit").val() == undefined || $("#contactsAreaFaxEdit").val() == null) {
            swal({
                title: "请填写联系人区号－传真号！",
                type: "warning"
            });
            return;
        }
        if ($("#contactsMailBoxEdit").val() == "" || $("#contactsMailBoxEdit").val() == undefined || $("#contactsMailBoxEdit").val() == null) {
            swal({
                title: "请填写联系人电子邮箱！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/contactinformation/saveContactInformation", {
            id: "${data.id}",
            mailingAddress: $("#mailingAddressEdit").val(),
            postalCode: $("#postalCodeEdit").val(),
            schoolWebsite: $("#schoolWebsiteEdit").val(),
            areaNumber: $("#areaNumberEdit").val(),
            areaFax: $("#areaFaxEdit").val(),
            mailBox: $("#mailBoxEdit").val(),
            contactsAreaNumber: $("#contactsAreaNumberEdit").val(),
            contactsAreaFax: $("#contactsAreaFaxEdit").val(),
            contactsMailBox: $("#contactsMailBoxEdit").val(),
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



