<%--
  Description: 意见箱--教师--保存回复(处理意见)
  Creator: 郭千恺
  Date: 2018/9/27 10:43
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <span style="font-size: 14px;">意见回复</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        主题
                    </div>
                    <div class="col-md-10">
                        <div>
                            <input id="title" type="text" value="${detail.title}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        内容
                    </div>
                    <div class="col-md-10">
                        <div>
                            <textarea id="suggestion" cols="30" rows="10" readonly>${detail.suggestion}</textarea>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>回复
                    </div>
                    <div class="col-md-10">
                        <div>
                            <textarea id="reply" cols="30" rows="10">${reply.reply}</textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    function save() {
        var reply = $("#reply").val();

        if (reply=="" || reply==undefined || reply==null) {
            infoMessage("请填写意见!");
            return;
        } else if (title.length > 50) {
            infoMessage("意见太长,请不要超过500字符!");
            return;
        }

        showSaveLoading();
        $.post("<%=request.getContextPath()%>/suggestionBox/teacher/manage/reply", {
            id: "${reply.id}",
            suggestionId: "${detail.id}",
            reply: reply
        }, function (success) {
            hideSaveLoading();
            if (success) {
                successMessage("回复成功!");
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            } else {
                errorMessage("回复失败!");
            }
        });
    }
    function infoMessage(msg, type) {
        swal({
            title: msg,
            type: type || "info"
        });
    }
    function successMessage(msg, type) {
        swal({
            title: msg,
            type: type || "success"
        });
    }
    function errorMessage(msg, type) {
        swal({
            title: msg,
            type: type || "error"
        });
    }
</script>
