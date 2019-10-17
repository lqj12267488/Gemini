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
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>职业技能鉴定站（所）
                    </div>
                    <div class="col-md-4">
                        <input id="evaNameEdit" value="${data.evaName}"/>
                    </div>
                </div>
                <div class="form-row">
                    鉴定内容：
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                       工种证书名称
                    </div>
                    <div class="col-md-4">
                        <input id="certNameEdit" value="${data.certName}"/>
                    </div>
                    <div class="col-md-2 tar">
                       等级
                    </div>
                    <div class="col-md-4">
                        <select id="evaLevelEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    建立单位
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        级别
                    </div>
                    <div class="col-md-4">
                        <select id="buildDepLevEdit"/>
                    </div>
                    <div class="col-md-2 tar">
                        部门
                    </div>
                    <div class="col-md-4">
                        <input id="departEdit" value="${data.depart}"/>
                    </div>
                </div>
                <div class="form-row">
                    鉴定数（人天）
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        社会
                    </div>
                    <div class="col-md-4">
                        <input id="ssEvaNumEdit" value="${data.ssEvaNum}" />
                    </div>
                    <div class="col-md-2 tar">
                        在校生
                    </div>
                    <div class="col-md-4">
                        <input id="schEvaNumEdit" value="${data.schEvaNum}"/>
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
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=	ZYDJ", function (data) {
                addOption(data, 'evaLevelEdit','${data.evaLevel}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=	DWBMDJ", function (data) {
                addOption(data, 'buildDepLevEdit','${data.buildDepLev}');
            });
    });

    function save() {
        if ($("#evaNameEdit").val() == "" || $("#evaNameEdit").val() == undefined || $("#evaNameEdit").val() == null) {
            swal({
                title: "请填写职业技能鉴定站（所）！",
                type: "warning"
            });
            return;
        }
        if ($("#certNameEdit").val() == "" || $("#certNameEdit").val() == undefined || $("#certNameEdit").val() == null) {
            swal({
                title: "请填写工种证书名称！",
                type: "warning"
            });
            return;
        }
        if ($("#evaLevelEdit").val() == "" || $("#evaLevelEdit").val() == undefined || $("#evaLevelEdit").val() == null) {
            swal({
                title: "请选择等级！",
                type: "warning"
            });
            return;
        }
        if ($("#buildDepLevEdit").val() == "" || $("#buildDepLevEdit").val() == undefined || $("#buildDepLevEdit").val() == null) {
            swal({
                title: "请选择建立单位级别！",
                type: "warning"
            });
            return;
        }
        if ($("#departEdit").val() == "" || $("#departEdit").val() == undefined || $("#departEdit").val() == null) {
            swal({
                title: "请填写部门！",
                type: "warning"
            });
            return;
        }
        if ($("#ssEvaNumEdit").val() == "" || $("#ssEvaNumEdit").val() == undefined || $("#ssEvaNumEdit").val() == null) {
            swal({
                title: "请填写社会鉴定数（人天）！",
                type: "warning"
            });
            return;
        }
        if ($("#schEvaNumEdit").val() == "" || $("#schEvaNumEdit").val() == undefined || $("#schEvaNumEdit").val() == null) {
            swal({
                title: "请填写在校生鉴定数(人天)！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/ProEvaAgency/saveProEvaAgency", {
            id: "${data.id}",
            evaName: $("#evaNameEdit").val(),
            certName: $("#certNameEdit").val(),
            evaLevel: $("#evaLevelEdit").val(),
            buildDepLev: $("#buildDepLevEdit").val(),
            depart: $("#departEdit").val(),
            ssEvaNum: $("#ssEvaNumEdit").val(),
            schEvaNum: $("#schEvaNumEdit").val(),
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



