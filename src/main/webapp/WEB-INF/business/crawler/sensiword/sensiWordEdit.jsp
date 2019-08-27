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
                        敏感词名称
                    </div>
                    <div class="col-md-9">
                        <input id="sensiName" value="${data.sensiName}" maxlength="25" placeholder="最多输入25个字符"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        敏感词类型
                    </div>
                    <div class="col-md-9">
                        <select id="sensiType"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        敏感词级别
                    </div>
                    <div class="col-md-9">
                        <select id="sensiLevel"/>
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
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " id ",
            text: " type_name ",
            tableName: "YQ_SENSITYPE ",
        }, function (data) {
            addOption(data, "sensiType", '${data.sensiType}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " store_value ",
            text: " show_value ",
            tableName: "YQ_SENSILEVEL ",
        }, function (data) {
            addOption(data, "sensiLevel", '${data.sensiLevel}');
        });
    });


    function save() {
        var id = $("#id").val();
        var sensiName = $("#sensiName").val();
        var sensiType = $("#sensiType").val();
        var sensiLevel = $("#sensiLevel").val();
        if (sensiName == "" || sensiName == undefined || sensiName == null) {
            swal({
                title: "请填写敏感词名称！",
                type: "info"
            });
            return;
        }
        if (sensiType == "" || sensiType == undefined || sensiType == null) {
            swal({
                title: "请选择敏感词类型！",
                type: "info"
            });
            return;
        }
        if (sensiLevel == "" || sensiLevel == undefined || sensiLevel == null) {
            swal({
                title: "请选择敏感词级别！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/crawler/sensiword/saveSensiWord", {
            id: id,
            sensiName: sensiName,
            sensiType: sensiType,
            sensiLevel: sensiLevel,
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



