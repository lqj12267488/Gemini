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
                        <span class="iconBtx">*</span>机构代码
                    </div>
                    <div class="col-md-9">
                        <input id="organizationCodeEdit" value="${data.organizationCode}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>机构名称(全称)
                    </div>
                    <div class="col-md-9">
                        <input id="organizationNameEdit" value="${data.organizationName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>负责人教工号
                    </div>
                    <div class="col-md-9">
                        <input id="personStaffEdit" value="${data.personStaff}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>负责人姓名
                    </div>
                    <div class="col-md-9">
                        <input id="personNameEdit" value="${data.personName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专职人员数（个）
                    </div>
                    <div class="col-md-9">
                        <input id="staffNumberEdit" value="${data.staffNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>兼职人员数（个）
                    </div>
                    <div class="col-md-9">
                        <input id="employeNumberEdit" value="${data.employeNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>年份
                    </div>
                    <div class="col-md-9">
                        <select id="years"/>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'years','${data.year}');
        });
        if($("#flag").val()=='on'){
            $("#save").hide();
            $("input").attr('readonly','readonly');
            $("select").attr('disabled','disabled');
        }
    });

    function save() {
        if ($("#organizationCodeEdit").val() == "" || $("#organizationCodeEdit").val() == undefined || $("#organizationCodeEdit").val() == null) {
            swal({
                title: "请填写机构代码！",
                type: "warning"
            });
            return;
        }
        if ($("#organizationNameEdit").val() == "" || $("#organizationNameEdit").val() == undefined || $("#organizationNameEdit").val() == null) {
            swal({
                title: "请填写机构名称(全称)！",
                type: "warning"
            });
            return;
        }
        if ($("#personStaffEdit").val() == "" || $("#personStaffEdit").val() == undefined || $("#personStaffEdit").val() == null) {
            swal({
                title: "请填写负责人教工号！",
                type: "warning"
            });
            return;
        }
        if ($("#personNameEdit").val() == "" || $("#personNameEdit").val() == undefined || $("#personNameEdit").val() == null) {
            swal({
                title: "请填写负责人姓名！",
                type: "warning"
            });
            return;
        }
        if ($("#staffNumberEdit").val() == "" || $("#staffNumberEdit").val() == undefined || $("#staffNumberEdit").val() == null) {
            swal({
                title: "请填写专职人员数（个）！",
                type: "warning"
            });
            return;
        }
        if ($("#employeNumberEdit").val() == "" || $("#employeNumberEdit").val() == undefined || $("#employeNumberEdit").val() == null) {
            swal({
                title: "请填写兼职人员数（个）！",
                type: "warning"
            });
            return;
        }
        if ($("#years").val() == "" || $("#years").val() == undefined || $("#years").val() == null) {
                swal({
                    title: "请选择年份！",
                    type: "warning"
                });
            return;
        }
        if ($("#years").val() != '${data.year}') {
            $.post("<%=request.getContextPath()%>/informationpersonnel/checkYear", {
                    id: '${id}',
                    year: $("#years").val(),
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: "年份重复，请重新填写！", type: "error"});
                    }}
            )
            return;
        }
                $.post("<%=request.getContextPath()%>/informationpersonnel/saveInformationPersonnel", {
                    id: "${data.id}",
                    organizationCode: $("#organizationCodeEdit").val(),
                    organizationName: $("#organizationNameEdit").val(),
                    personStaff: $("#personStaffEdit").val(),
                    personName: $("#personNameEdit").val(),
                    staffNumber: $("#staffNumberEdit").val(),
                    employeNumber: $("#employeNumberEdit").val(),
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



