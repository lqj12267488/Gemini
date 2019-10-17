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
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--<span class="iconBtx">*</span>序号--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<input id="saIndexEdit" value="${data.saIndex}"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目名称
                    </div>
                    <div class="col-md-9">
                        <input id="saProNameEdit" value="${data.saProName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目级别
                    </div>
                    <div class="col-md-9">
                        <select id="saProLevEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>获奖日期
                    </div>
                    <div class="col-md-9">
                        <input id="saTimeEdit" value="${data.saTime}" type="date"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remarkEdit" value="${data.remark}"/>
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
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=JB", function (data) {
                addOption(data, 'saProLevEdit','${data.saProLev}');
            });
    });
    function save() {
        if ($("#saProNameEdit").val() == "" || $("#saProNameEdit").val() == undefined || $("#saProNameEdit").val() == null) {
            swal({
                title: "请填写项目名称！",
                type: "warning"
            });
            return;
        }
        if ($("#saProLevEdit").val() == "" || $("#saProLevEdit").val() == undefined || $("#saProLevEdit").val() == null) {
            swal({
                title: "请选择项目级别！",
                type: "warning"
            });
            return;
        }
        if ($("#saTimeEdit").val() == "" || $("#saTimeEdit").val() == undefined || $("#saTimeEdit").val() == null) {
            swal({
                title: "请填写获奖日期！",
                type: "warning"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/SchAward/saveSchAward", {
            id: "${data.id}",
            // saIndex: $("#saIndexEdit").val(),
            saProName: $("#saProNameEdit").val(),
            saProLev: $("#saProLevEdit").val(),
            saTime: $("#saTimeEdit").val(),
            remark: $("#remarkEdit").val(),
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



