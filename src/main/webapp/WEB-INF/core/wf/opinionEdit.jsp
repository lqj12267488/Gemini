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
            <input id="opinionId" hidden value="${data.opinionId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        意见
                    </div>
                    <div class="col-md-9">
                        <input id="opinionContent" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="165" placeholder="最多输入165个字"
                               value="${data.opinionContent}"/>
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
    $(document).ready(function () {
    });
    function save() {
        var opinionId = $("#opinionId").val();
        var opinionContent = $("#opinionContent").val();
        if (opinionContent == "" || opinionContent == undefined || opinionContent == null) {
            swal({
                title: "请填写意见",
                type: "info"
            });
            //alert("请填写意见！");
            return;
        }

        $.post("<%=request.getContextPath()%>/opinion/saveOpinion", {
            opinionId: opinionId,
            opinionContent: opinionContent,
        }, function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
            //alert(msg.msg);
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })
        showSaveLoading();
    }
</script>



