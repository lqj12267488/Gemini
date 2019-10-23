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
                        <span class="iconBtx">*</span>全校总值
                    </div>
                    <div class="col-md-9">
                        <input id="totalSchoolValueEdit" value="${data.totalSchoolValue}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>资产总值
                    </div>
                    <div class="col-md-9">
                        <input id="totalAssetsEdit" value="${data.totalAssets}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>当年新增资产值
                    </div>
                    <div class="col-md-9">
                        <input id="assetsAddEdit" value="${data.assetsAdd}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>年份
                    </div>
                    <div class="col-md-9">
                        <select id="year" />
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
            addOption(data, 'year');
        });
    });

    function save() {
        if ($("#totalSchoolValueEdit").val() == "" || $("#totalSchoolValueEdit").val() == undefined || $("#totalSchoolValueEdit").val() == null) {
            swal({
                title: "请填写全校总值！",
                type: "warning"
            });
            return;
        }
        if ($("#totalAssetsEdit").val() == "" || $("#totalAssetsEdit").val() == undefined || $("#totalAssetsEdit").val() == null) {
            swal({
                title: "请填写资产总值！",
                type: "warning"
            });
            return;
        }
        if ($("#assetsAddEdit").val() == "" || $("#assetsAddEdit").val() == undefined || $("#assetsAddEdit").val() == null) {
            swal({
                title: "请填写当年新增资产值！",
                type: "warning"
            });
            return;
        }
        if ($("#year").val() == "" || $("#year").val() == undefined || $("#year").val() == null) {
            swal({
                title: "请选择年份",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/fixedassets/saveFixedAssets", {
            id: "${data.id}",
            totalSchoolValue: $("#totalSchoolValueEdit").val(),
            totalAssets: $("#totalAssetsEdit").val(),
            assetsAdd: $("#assetsAddEdit").val(),
            year:$("#year").val(),
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



