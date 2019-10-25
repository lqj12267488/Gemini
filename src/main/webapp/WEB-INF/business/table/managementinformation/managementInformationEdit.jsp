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
                        <span class="iconBtx">*</span>类型
                    </div>
                    <div class="col-md-9">
                        <select id="typeEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>系统名称(全称)
                    </div>
                    <div class="col-md-9">
                        <input id="systemNameEdit" value="${data.systemName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>来源
                    </div>
                    <div class="col-md-9">
                        <select id="sourcesEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>开发单位名称(全称)
                    </div>
                    <div class="col-md-9">
                        <input id="unitNameEdit" value="${data.unitName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>年份
                    </div>
                    <div class="col-md-9">
                        <select id="years" value="${data.year}"/>
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
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=GLXXXTLX", function (data) {
                addOption(data, 'typeEdit','${data.type}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=GLXXXTLY", function (data) {
                addOption(data, 'sourcesEdit','${data.sources}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
                addOption(data, 'years','${data.year}');
            });
    });

    function save() {
        if ($("#typeEdit").val() == "" || $("#typeEdit").val() == undefined || $("#typeEdit").val() == null) {
            swal({
                title: "请选择类型！",
                type: "warning"
            });
            return;
        }
        if ($("#systemNameEdit").val() == "" || $("#systemNameEdit").val() == undefined || $("#systemNameEdit").val() == null) {
            swal({
                title: "请填写系统名称(全称)！",
                type: "warning"
            });
            return;
        }
        if ($("#sourcesEdit").val() == "" || $("#sourcesEdit").val() == undefined || $("#sourcesEdit").val() == null) {
            swal({
                title: "请选择来源！",
                type: "warning"
            });
            return;
        }
        if ($("#unitNameEdit").val() == "" || $("#unitNameEdit").val() == undefined || $("#unitNameEdit").val() == null) {
            swal({
                title: "请填写开发单位名称(全称)！",
                type: "warning"
            });
            return;
        }
        if ($("#years").val() == "" || $("#years").val() == undefined || $("#years").val() == null) {
            swal({
                title: "请选择年份!",
                type: "warning"
            });
            return;
        }
        if ($("#years").val() != '${data.year}') {
            $.post("<%=request.getContextPath()%>/managementinformation/checkYear", {
                    id: '${id}',
                    year: $("#years").val(),
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: "年份重复，请重新填写！", type: "error"});
                    }}
            )
            return;
        }
        $.post("<%=request.getContextPath()%>/managementinformation/saveManagementInformation", {
            id: "${data.id}",
            type: $("#typeEdit").val(),
            systemName: $("#systemNameEdit").val(),
            sources: $("#sourcesEdit").val(),
            unitName: $("#unitNameEdit").val(),
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



