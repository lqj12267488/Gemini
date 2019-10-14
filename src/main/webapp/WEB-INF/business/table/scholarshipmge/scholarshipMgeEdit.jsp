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
                        <span class="iconBtx">*</span>项目名称
                    </div>
                    <div class="col-md-9">
                        <input id="smProNameEdit" value="${data.smProName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目种类
                    </div>
                    <div class="col-md-9">
                        <select id="smProTypeEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>奖助范围
                    </div>
                    <div class="col-md-9">
                        <input id="aidRgeEdit" value="${data.aidRge}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>奖助人数
                    </div>
                    <div class="col-md-9">
                        <input id="aidCountsEdit" value="${data.aidCounts}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>奖助金额
                    </div>
                    <div class="col-md-9">
                        <input id="aidMoneyEdit" value="${data.aidMoney}"/>
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
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=	JZXXMZL", function (data) {
                addOption(data, 'smProTypeEdit','${data.smProType}');
            });
    });

    function save() {
        if ($("#smProNameEdit").val() == "" || $("#smProNameEdit").val() == undefined || $("#smProNameEdit").val() == null) {
            swal({
                title: "请填写项目名称！",
                type: "warning"
            });
            return;
        }
        if ($("#smProTypeEdit").val() == "" || $("#smProTypeEdit").val() == undefined || $("#smProTypeEdit").val() == null) {
            swal({
                title: "请选择项目种类{	jzxxmzl}！",
                type: "warning"
            });
            return;
        }
        if ($("#aidRgeEdit").val() == "" || $("#aidRgeEdit").val() == undefined || $("#aidRgeEdit").val() == null) {
            swal({
                title: "请填写奖助范围！",
                type: "warning"
            });
            return;
        }
        if ($("#aidCountsEdit").val() == "" || $("#aidCountsEdit").val() == undefined || $("#aidCountsEdit").val() == null) {
            swal({
                title: "请填写奖助人数！",
                type: "warning"
            });
            return;
        }
        if ($("#aidMoneyEdit").val() == "" || $("#aidMoneyEdit").val() == undefined || $("#aidMoneyEdit").val() == null) {
            swal({
                title: "请填写奖助金额！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/ScholarshipMge/saveScholarshipMge", {
            id: "${data.id}",
            smProName: $("#smProNameEdit").val(),
            smProType: $("#smProTypeEdit").val(),
            aidRge: $("#aidRgeEdit").val(),
            aidCounts: $("#aidCountsEdit").val(),
            aidMoney: $("#aidMoneyEdit").val(),
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



