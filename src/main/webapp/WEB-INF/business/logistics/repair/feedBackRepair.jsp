<%--报修类型管理新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/5/26
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <input id="rID" hidden value="${repair.repairID}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        反馈状态
                    </div>
                    <div class="col-md-9">
                        <select id="feedbackFlag"  class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        反馈意见
                    </div>
                    <div class="col-md-9">
                        <input id="fback" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${repair.feedback}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "dic_code",
                text: "dic_name",
                tableName: "T_SYS_DIC",
                where: " WHERE 1 = 1 and dic_code!='0' and parent_id='9e75c797-5264-4411-bbf7-24542975a5c9'",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "feedbackFlag", '${repair.feedbackFlag}');
            });
    })
    function save() {
        if($("#fback").val()=="" ||  $("#fback").val() =="0" || $("#fback").val() == undefined){
            swal({
                title: "请填写反馈意见！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/repair/saveFeedBack", {
            repairID:$("#rID").val(),
            feedback:$("#fback").val(),
            feedbackFlag:$("#feedbackFlag").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1 ) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#repairTable').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }
</script>
