<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }

        .iconBtx{
            color: #E9003A;
            font-size: 16px;
        }
    </style>
</head>
<div class="modal-dialog" style="height:auto">
    <div class="tanchu-content">
        <div class="tanchu-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeDialog()">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="edit_resourceId" hidden value="${resourcePrivate.resourceId}"/>
        </div>
        <div class="tanchu">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="tc_list">
                <div class="tc_l_l">
                    <span class="iconBtx">*</span>资源名称
                </div>
                <div class="tc_l_r">
                    <input id="edit_resourceName" value="${resourcePrivate.resourceName}"/>
                </div>
            </div>
            <div class="tc_list">
                <div class="tc_l_l">
                    <span class="iconBtx">*</span>资源分类
                </div>
                <div class="tc_l_r">
                    <select id="edit_resourceType"></select>
                </div>
            </div>
            <div class="tc_list">
                <div class="tc_l_l">
                    自定义分类
                </div>
                <div class="tc_l_r">
                    <select id="edit_resourceCustom" ></select>
                </div>
            </div>
            <div class="tc_list">
                <div class="tc_l_l">
                    备注
                </div>
                <div class="tc_l_r">
                    <textarea id="edit_remark" style="height: 100px"
                        class="validate[required,maxSize[20]] form-control"
                            value="${resourcePrivate.remark}">${resourcePrivate.remark}</textarea>
                </div>
            </div>
        </div>
        <div class="tc_an">
            <button type="button" class="tc_btn1" onclick="save()">保存
            </button>
            <button type="button" class="tc_btn2" onclick="closeDialog()">关闭
            </button>
        </div>

    </div>
</div>
<script>
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYLX", function (data) {
            addOption(data, 'edit_resourceType', '${resourcePrivate.resourceType}');
        });

        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "type_id",
                text: "type_name ",
                tableName: "zyk_type_custom",
                where: " where CREATOR = '"+$("#personId").val()+"'",
                orderby: "  "
            },
            function (data) {
                addOption(data, 'edit_resourceCustom', '${resourcePrivate.resourceCustom}');
            });
    });
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");


    function save() {
        var edit_resourceId = $("#edit_resourceId").val();
        var edit_resourceName = $("#edit_resourceName").val();
        var edit_resourceType = $("#edit_resourceType option:selected").val();
        var edit_resourceCustom = $("#edit_resourceCustom option:selected").val();
        /*    var uploadPersonId = $("#uploadPersonId").val();
         var uploadDeptId = $("#uploadDeptId").val();*/
        var edit_remark = $("#edit_remark").val();
        if (edit_resourceName == "" || edit_resourceName == undefined || edit_resourceName == null) {
            swal({title: "请填写资源名称！", type: "info"});
            return;
        }
        if (edit_resourceType == "" || edit_resourceType == undefined || edit_resourceType == null) {
            swal({title: "请填写资源分类！", type: "info"});
            return;
        }
        showSaveLoading();

        $.post("<%=request.getContextPath()%>/resourcePrivate/saveResourcePrivate", {
            resourceId: edit_resourceId,
            resourceName: edit_resourceName,
            resourceType: edit_resourceType,
            publicFlag: '0',
            classicFlag: '0',
            remark: edit_remark
        }, function (msg) {
            hideSaveLoading();

            swal({title: msg.msg, type: msg.result});
            $("#dialog").css('display', 'none');
            $('#tablePrivate').DataTable().ajax.reload();
            closeDialog();
        })
    }
</script>
<style>
    .modal-dialog {
        width: 400px;
        height: 400px;
    }

</style>
