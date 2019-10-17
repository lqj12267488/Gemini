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
                        <span class="iconBtx">*</span>接入互联网出口带宽(mbps)
                    </div>
                    <div class="col-md-9">
                        <input id="internetBandwidthEdit" value="${data.internetBandwidth}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>校园网主干最大带宽（mbps）
                    </div>
                    <div class="col-md-9">
                        <input id="networkBandwidthEdit" value="${data.networkBandwidth}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>一卡通使用
                    </div>
                    <div class="col-md-9">
                        <select id="oneCardUseEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>无线覆盖情况
                    </div>
                    <div class="col-md-9">
                        <select id="wirelessCoverageEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>网络信息点数（个）
                    </div>
                    <div class="col-md-9">
                        <input id="networkInformationEdit" value="${data.networkInformation}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>管理信息系统数据总量
                    </div>
                    <div class="col-md-9">
                        <input id="managementInformationEdit" value="${data.managementInformation}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>电子邮件系统用户数（个）
                    </div>
                    <div class="col-md-9">
                        <input id="systemMailNumberEdit" value="${data.systemMailNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>上网课程数（门）
                    </div>
                    <div class="col-md-9">
                        <input id="onlineCoursesEdit" value="${data.onlineCourses}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>数字资源量
                    </div>
                    <div class="col-md-9">
                        <input id="digitalResourcesEdit" value="${data.digitalResources}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>电子图书（册）
                    </div>
                    <div class="col-md-9">
                        <input id="electronicsBookEdit" value="${data.electronicsBook}"/>
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
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
                addOption(data, 'oneCardUseEdit','${data.oneCardUse}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=WXFGQK", function (data) {
                addOption(data, 'wirelessCoverageEdit','${data.wirelessCoverage}');
            });
    });

    function save() {
        if ($("#internetBandwidthEdit").val() == "" || $("#internetBandwidthEdit").val() == undefined || $("#internetBandwidthEdit").val() == null) {
            swal({
                title: "请填写接入互联网出口带宽(mbps)！",
                type: "warning"
            });
            return;
        }
        if ($("#networkBandwidthEdit").val() == "" || $("#networkBandwidthEdit").val() == undefined || $("#networkBandwidthEdit").val() == null) {
            swal({
                title: "请填写校园网主干最大带宽（mbps）！",
                type: "warning"
            });
            return;
        }
        if ($("#oneCardUseEdit").val() == "" || $("#oneCardUseEdit").val() == undefined || $("#oneCardUseEdit").val() == null) {
            swal({
                title: "请选择一卡通使用！",
                type: "warning"
            });
            return;
        }
        if ($("#wirelessCoverageEdit").val() == "" || $("#wirelessCoverageEdit").val() == undefined || $("#wirelessCoverageEdit").val() == null) {
            swal({
                title: "请选择无线覆盖情况！",
                type: "warning"
            });
            return;
        }
        if ($("#networkInformationEdit").val() == "" || $("#networkInformationEdit").val() == undefined || $("#networkInformationEdit").val() == null) {
            swal({
                title: "请填写网络信息点数（个）！",
                type: "warning"
            });
            return;
        }
        if ($("#managementInformationEdit").val() == "" || $("#managementInformationEdit").val() == undefined || $("#managementInformationEdit").val() == null) {
            swal({
                title: "请填写管理信息系统数据总量！",
                type: "warning"
            });
            return;
        }
        if ($("#systemMailNumberEdit").val() == "" || $("#systemMailNumberEdit").val() == undefined || $("#systemMailNumberEdit").val() == null) {
            swal({
                title: "请填写电子邮件系统用户数（个）！",
                type: "warning"
            });
            return;
        }
        if ($("#onlineCoursesEdit").val() == "" || $("#onlineCoursesEdit").val() == undefined || $("#onlineCoursesEdit").val() == null) {
            swal({
                title: "请填写上网课程数（门）！",
                type: "warning"
            });
            return;
        }
        if ($("#digitalResourcesEdit").val() == "" || $("#digitalResourcesEdit").val() == undefined || $("#digitalResourcesEdit").val() == null) {
            swal({
                title: "请填写数字资源量！",
                type: "warning"
            });
            return;
        }
        if ($("#electronicsBookEdit").val() == "" || $("#electronicsBookEdit").val() == undefined || $("#electronicsBookEdit").val() == null) {
            swal({
                title: "请填写电子图书（册）！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/generalconstruction/saveGeneralConstruction", {
            id: "${data.id}",
            internetBandwidth: $("#internetBandwidthEdit").val(),
            networkBandwidth: $("#networkBandwidthEdit").val(),
            oneCardUse: $("#oneCardUseEdit").val(),
            wirelessCoverage: $("#wirelessCoverageEdit").val(),
            networkInformation: $("#networkInformationEdit").val(),
            managementInformation: $("#managementInformationEdit").val(),
            systemMailNumber: $("#systemMailNumberEdit").val(),
            onlineCourses: $("#onlineCoursesEdit").val(),
            digitalResources: $("#digitalResourcesEdit").val(),
            electronicsBook: $("#electronicsBookEdit").val(),
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



