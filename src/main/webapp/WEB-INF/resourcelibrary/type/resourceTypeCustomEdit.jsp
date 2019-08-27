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
<div class="modal-dialog"  style=" height:auto">
    <div class="tanchu-content">
        <div class="tanchu-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeDialog()">
                &times;
            </button>
            <span style="margin-left:30px">${head}</span>
            <input id="typeId" hidden value="${data.typeId}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="tanchu">
                <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
                <div class="tc_list">
                    <div class="tc_l_l">
                        <span class="iconBtx">*</span>分类名称
                    </div>
                    <div class="tc_l_r">
                        <input id="typeName1" value="${data.typeName}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="tc_an">
            <button type="button" class="tc_btn1" id="saveBtn" onclick="save()">保存
            </button>
            <button type="button" class="tc_btn2" data-dismiss="modal" onclick="closeDialog()">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {

    });

    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    function save() {
        var typeId = $("#typeId").val();
        var typeName1 = $("#typeName1").val();
        if (typeName1 == "" || typeName1 == undefined || typeName1 == null) {
            swal({title: "请填写分类名称！",type: "info"});
            return;
        }

        showSaveLoading();
        $.post("<%=request.getContextPath()%>/resourceLibrary/typeCustom/saveResourceTypeCustom", {
            typeId:typeId,
            typeName:typeName1,
        }, function (msg) {
            hideSaveLoading();

            swal({title: msg.msg,type: msg.result});
            $("#dialog").css('display','none');
            $('#tableType').DataTable().ajax.reload();
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



