<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 通信地址：
                            </div>
                            <div class="col-md-4">
                                <input id="mailingAddressEdit" value="${data.mailingAddress}">
                            </div>
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 邮政编码：
                            </div>
                            <div class="col-md-4">
                                <input id="postalCodeEdit" value="${data.postalCode}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 学校网址：
                            </div>
                            <div class="col-md-4">
                                <input id="schoolWebsiteEdit" value="${data.schoolWebsite}">
                            </div>
                        </div>
                            <div  id="ldht">
                                <div class="form-row">
                                    法人代表信息
                                </div>
                                <div class="form-row">
                              <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 法人姓名：
                            </div>
                            <div class="col-md-4">
                                <input id="teacherInfoName" type="text" value="${data.areaPersonName}"/>
                                <input id="perId" type="hidden" value="${data.areaPerson}"/>
                            </div>
                            <div class="col-md-2 tar">
                                教职工号：
                            </div>
                            <div class="col-md-4">
                                <input id="personNumber" class="validate[required,maxSize[20]] form-control"
                                       readonly="readonly" value="${data.areaStaff}">
                            </div>
                           </div>
                         <div class="form-row" >
                            <div class="col-md-2 tar">
                                职务：
                            </div>
                            <div class="col-md-4">
                                <input id="personPost" class="validate[required,maxSize[20]] form-control"
                                       readonly="readonly" value="${data.areaPost}">
                            </div>
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 法人区号－电话号码：
                            </div>
                            <div class="col-md-4">
                                <input id="areaNumberEdit" value="${data.areaNumber}">
                            </div>
                         </div>
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 法人区号－传真号：
                            </div>
                            <div class="col-md-4">
                                <input id="areaFaxEdit" value="${data.areaFax}">
                            </div>
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 法人电子邮箱：
                            </div>
                            <div class="col-md-4">
                                <input id="mailBoxEdit" value="${data.mailBox}">
                            </div>
                        </div>
                      <div id="jzxy">
                         <div class="form-row">
                            法人代表信息
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 联系人姓名：
                            </div>
                            <div class="col-md-4">
                                <input id="teacherInfoNameContacts" type="text" value="${data.contactsPersonName}"/>
                                <input id="perIdContacts" type="hidden" value="${data.contactsPerson}"/>
                            </div>
                            <div class="col-md-2 tar">
                                教职工号：
                            </div>
                            <div class="col-md-4">
                                <input id="f_personNumber" class="validate[required,maxSize[20]] form-control"
                                       readonly="readonly" value="${data.areaContactsStaff}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                职务：
                            </div>
                            <div class="col-md-4">
                                <input id="f_personPost" class="validate[required,maxSize[20]] form-control"
                                       readonly="readonly"  value="${data.areaContactsPost}">
                            </div>
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 联系人区号－电话号码：
                            </div>
                            <div class="col-md-4">
                                <input id="contactsAreaNumberEdit" value="${data.contactsAreaNumber}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 联系人区号－传真号：
                            </div>
                            <div class="col-md-4">
                                <input id="contactsAreaFaxEdit" value="${data.contactsAreaFax}">
                            </div>
                            <div class="col-md-2 tar">
                                手机号：
                            </div>
                            <div class="col-md-4">
                                <input id="f_phone" class="validate[required,maxSize[20]] form-control"
                                       readonly="readonly"  value="${data.areaContactsPhone}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 联系人电子邮箱：
                            </div>
                            <div class="col-md-4">
                                <input id="contactsMailBoxEdit" value="${data.contactsMailBox}">
                            </div>
                        </div>
                            <div class="col-md-2 tar">
                            </div>
                            <div class="col-md-4">
                            </div>
                            <div class="col-md-2 tar">
                            </div>
                            <div class="col-md-4"  style="text-align: right;">
                                <button type="button" class="btn btn-default btn-clean" onclick="save()">保存</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="id" hidden value="${data.id}"/>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#teacherInfoName").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherInfoName").val(ui.item.label.split(" ---- ")[0]);
                    $("#departmentsIdEdit").val(ui.item.label.split(" ---- ")[1]);
                    $("#teacherInfoName").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#teacherInfoNameContacts").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherInfoNameContacts").val(ui.item.label.split(" ---- ")[0]);
                    $("#departmentsIdEditContacts").val(ui.item.label.split(" ---- ")[1]);
                    $("#teacherInfoNameContacts").attr("keycode", ui.item.value);
                    $("#perIdContacts").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    })
    $("#teacherInfoName").change(function () {
        var perIdNames = "";
        if ($("#perId").val() != "") {
            if ($("#perId").val().split(",").length == 1) {
                perIdNames = $("#perId").val();
            } else {
                perIdNames = $("#perId").val().split(",")[1];
            }
            $.get("<%=request.getContextPath()%>/contactinformation/getPersonByPersonId?personId=" + perIdNames,
                function (data) {
                    if (data != null) {
                        $("#personNumber").val(data.areaContactsStaff);
                        $("#personPost").val(data.areaContactsPost);
                    }
                })
        }
    })


    $("#teacherInfoNameContacts").change(function () {
        var perIdNameContactses = "";
        if ($("#perIdContacts").val() != "") {
            if ($("#perIdContacts").val().split(",").length == 1) {
                perIdNameContactses = $("#perIdContacts").val();
            } else {
                perIdNameContactses = $("#perIdContacts").val().split(",")[1];
            }
            $.get("<%=request.getContextPath()%>/contactinformation/getPersonByPersonId?personId=" + perIdNameContactses,
                function (data) {
                    if (data != null) {
                        $("#f_personNumber").val(data.areaContactsStaff);
                        $("#f_phone").val(data.areaContactsPhone);
                        $("#f_personPost").val(data.areaContactsPost);
                    }
                })
        }
    })
    function save() {
        /*   if ($("#mailingAddressEdit").val() == "" || $("#mailingAddressEdit").val() == undefined || $("#mailingAddressEdit").val() == null) {
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
           }*/
        var perIdName = "";
        if ("" == $("#perId").val() || null == $("#perId").val()) {

        } else {
            if ($("#perId").val().split(",").length == 1) {
                perIdName = $("#perId").val();
            } else {
                perIdName = $("#perId").val().split(",")[1];
            }
        }
        var perIdNameContacts = "";
        if ("" == $("#perIdContacts").val() || null == $("#perIdContacts").val()) {

        } else {
            if ($("#perIdContacts").val().split(",").length == 1) {
                perIdNameContacts = $("#perIdContacts").val();
            } else {
                perIdNameContacts = $("#perIdContacts").val().split(",")[1];
            }

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
            areaPerson: perIdName,
            contactsPerson: perIdNameContacts,
            areaPersonName: $("#teacherInfoName").val(),
            contactsPersonName: $("#teacherInfoNameContacts").val()
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