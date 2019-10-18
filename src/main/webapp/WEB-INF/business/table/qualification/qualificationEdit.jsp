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
                        <span class="iconBtx">*</span>资格证书名称
                    </div>
                    <div class="col-md-9">
                        <input id="qualificationNameEdit" value="${data.qualificationName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>资格证书等级
                    </div>
                    <div class="col-md-9">
                        <select id="qualificationLevelEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>发证机构
                    </div>
                    <div class="col-md-9">
                        <input id="qualificationAuthorityEdit" value="${data.qualificationAuthority}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>鉴定地点
                    </div>
                    <div class="col-md-9">
                        <select id="identificationSiteEdit"/>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZGZSDJ", function (data) {
            addOption(data, 'qualificationLevelEdit','${data.qualificationLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JDDD", function (data) {
            addOption(data, 'identificationSiteEdit','${data.identificationSite}');
        });
    });

    function save() {
        if ($("#qualificationNameEdit").val() == "" || $("#qualificationNameEdit").val() == undefined || $("#qualificationNameEdit").val() == null) {
            swal({
                title: "请填写资格证书名称！",
                type: "warning"
            });
            return;
        }
        if ($("#qualificationLevelEdit").val() == "" || $("#qualificationLevelEdit").val() == undefined || $("#qualificationLevelEdit").val() == null) {
            swal({
                title: "请选择资格证书等级！",
                type: "warning"
            });
            return;
        }
        if ($("#qualificationAuthorityEdit").val() == "" || $("#qualificationAuthorityEdit").val() == undefined || $("#qualificationAuthorityEdit").val() == null) {
            swal({
                title: "请填写发证机构！",
                type: "warning"
            });
            return;
        }
        if ($("#identificationSiteEdit").val() == "" || $("#identificationSiteEdit").val() == undefined || $("#identificationSiteEdit").val() == null) {
            swal({
                title: "请选择鉴定地点！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/qualification/saveQualification", {
            id: "${data.id}",
            qualificationName: $("#qualificationNameEdit").val(),
            qualificationLevel: $("#qualificationLevelEdit").val(),
            qualificationAuthority: $("#qualificationAuthorityEdit").val(),
            identificationSite: $("#identificationSiteEdit").val()
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



