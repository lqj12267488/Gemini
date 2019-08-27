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
                        栏目名称
                    </div>
                    <div class="col-md-9">
                        <input id="channelName" value="${data.channelName}" maxlength="100" placeholder="最多输入100个字符"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        栏目地址
                    </div>
                    <div class="col-md-9">
                        <input id="domain" value="${data.domain}" maxlength="100" placeholder="最多输入100个字符"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        网站分类
                    </div>
                    <div class="col-md-9">
                        <select id="typeId"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        网站名称
                    </div>
                    <div class="col-md-9">
                        <input id="webName" value="${data.webName}" maxlength="100" placeholder="最多输入100个字符"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        网站地址
                    </div>
                    <div class="col-md-9">
                        <input id="webUrl" value="${data.webUrl}" maxlength="100" placeholder="最多输入100个字符"/>
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
            tableName: "YQ_WEBTYPE ",
        }, function (data) {
            addOption(data, "typeId", '${data.typeId}');
        });

    });


    function save() {
        var id = $("#id").val();
        var channelName = $("#channelName").val();
        var domain = $("#domain").val();
        var typeId = $("#typeId").val();
        var webName = $("#webName").val();
        var webUrl = $("#webUrl").val();
        if (channelName == "" || channelName == undefined || channelName == null) {
            swal({
                title: "请填写栏目名称！",
                type: "info"
            });
            return;
        }
        if (domain == "" || domain == undefined || domain == null) {
            swal({
                title: "请填写栏目地址！",
                type: "info"
            });
            return;
        }
        if (typeId == "" || typeId == undefined || typeId == null) {
            swal({
                title: "请选择网站分类！",
                type: "info"
            });
            return;
        }
        if (webName == "" || webName == undefined || webName == null) {
            swal({
                title: "请选择网站名称！",
                type: "info"
            });
            return;
        }
        if (webUrl == "" || webUrl == undefined || webUrl == null) {
            swal({
                title: "请选择网站地址！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/crawler/webchannel/saveWebChannel", {
            id: id,
            channelName: channelName,
            domain: domain,
            typeId: typeId,
            webName: webName,
            webUrl: webUrl,
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



