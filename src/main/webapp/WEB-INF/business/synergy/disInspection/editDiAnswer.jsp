<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/9/5
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="seeFlag" type="hidden" value="${seeFlag}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        留言：
                    </div>
                    <div class="col-md-9">
                        <textarea id="reMsgEdit" cols="30" rows="10" readonly class="validate[required,maxSize[100]] form-control">${diAnswerEdit.reMsg}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>回复：
                    </div>
                    <div class="col-md-9">
                        <textarea id="ansMsgEdit" cols="30" rows="10" class="validate[required,maxSize[100]] form-control">${diAnswerEdit.ansMsg}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(document).ready(function () {
        if($("#seeFlag").val()=='1'){
            $("#saveBtn").hide();
            $("textarea").attr('readonly','readonly');
        }
    });

    $(function () {
        if ("${diAnswerEdit.answerId}"!=null &&"${diAnswerEdit.answerId}"!=""){
            $("#ansMsgEdit").attr("readonly","readonly");
        }
    })
    function save() {
        if($("#ansMsgEdit").val()=="" || $("#ansMsgEdit").val() == undefined){
            swal({
                title: "回复信息不能为空",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/diAnswer/saveDiAnswer", {
            answerId:"${diAnswerEdit.answerId}",
            remarkId:"${diAnswerEdit.remarkId}",
            ansMsg: $("#ansMsgEdit").val()
        },function (msg) {
            swal({title: msg.msg,type: "success"});
            $("#dialog").modal('hide');
            $('#diRemarkGrid').DataTable().ajax.reload();
        })
    }
</script>
