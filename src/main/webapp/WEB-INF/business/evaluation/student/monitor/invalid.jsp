<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <input id="id" hidden value="${id}">
            <h4 class="modal-title">设为废票</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="form-row">
                <div class="col-md-3 tar">
                    废票说明
                </div>
                <div class="col-md-9">
                    <input id="invalidReason" type="text"/>
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
    function save() {
        var invalidReason = $("#invalidReason").val();
        if (invalidReason == "" || invalidReason == null) {
            swal({
                title: "废票说明不能为空！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/xgEvaluation/invalid", {
            invalidReason: invalidReason,
            id: $("#id").val(),
        }, function (msg) {
            swal({title: msg.msg, type: "success"});
            taskTable.ajax.reload();
            $("#invalid").modal("hide");
        })
    }
</script>