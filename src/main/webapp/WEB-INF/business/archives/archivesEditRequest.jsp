<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2018/3/26
  Time: 16:38
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
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div id="reason1" class="col-md-3 tar">
                        <span class="iconBtx">*</span>申请原因:
                    </div>
                    <div id="reason2" class="col-md-3 tar">
                        申请原因 :
                    </div>
                    <div id="reason3" class="col-md-9">${archives.reason}</div>
                    <div class="col-md-9">
                        <textarea id="reason" maxlength="200" placeholder="最多输入200个字"
                                  class="validate[required,maxSize[100]] form-control"></textarea>
                    </div>
                </div>
                <div id="re" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        建议:
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark" maxlength="200" placeholder="最多输入200个字"
                                  class="validate[required,maxSize[100]] form-control"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">申请</button>
            <button type="button" id="auditBtn" class="btn btn-success btn-clean" onclick="auditBtn()">通过</button>
            <button type="button" id="rejectBtn" class="btn btn-default btn-clean" onclick="rejectBtn()">驳回</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
    <input id="archivesId" hidden value="${archives.archivesId}">
    <input id="archivesName" hidden value="${archives.archivesName}">
    <input id="archivesCode" hidden value="${archives.archivesCode}">
</div>
<script>
    $(document).ready(function(){
        if("${audit}"=="audit"){
            $("#saveBtn").hide();
            $("#reason").hide();
            $("#auditBtn").show();
            $("#re").show();
            $("#reason1").hide();
            $("#reason2").show();
            $("#rejectBtn").show();
        }else{
            $("#reason2").hide();
            $("#reason3").hide();
            $("#reason1").show();
            $("#saveBtn").show();
            $("#reason").show();
            $("#auditBtn").hide();
            $("#rejectBtn").hide();
            $("#re").hide();
            $("textarea").removeAttr('readonly');
        }
    });
    function save() {
        if ($("#reason").val() == "" || $("#reason").val() == "0" || $("#reason").val() == undefined) {
            swal({
                title: "请填写申请原因!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/archives/saveArchivesRequest", {
            archivesId: $("#archivesId").val(),
            archivesName:$("#archivesName").val(),
            archivesCode:$("#archivesCode").val(),
            reason: $("#reason").val(),
            requestFlag:"1",
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#listGrid').DataTable().ajax.reload();
            }
        })
    }
    function auditBtn() {
        $.post("<%=request.getContextPath()%>/archives/saveArchivesRequest", {
            archivesId: $("#archivesId").val(),
            archivesName:$("#archivesName").val(),
            archivesCode:$("#archivesCode").val(),
            remark:$("#remark").val(),
            requestFlag:"7",
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg,type: "success"});
                $("#dialog").modal('hide');
                $('#listGrid').DataTable().ajax.reload();
            }
        })
    }
    function rejectBtn() {
        if ($("#remark").val() == "" || $("#remark").val() == null || $("#remark").val() == undefined) {
            swal({
                title: "请填写建议!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/archives/updateArchivesRemark", {
            archivesId: $("#archivesId").val(),
            archivesName:$("#archivesName").val(),
            archivesCode:$("#archivesCode").val(),
            remark:$("#remark").val(),
            requestFlag:"3",
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg,type: "success"});
                $("#dialog").modal('hide');
                $('#listGrid').DataTable().ajax.reload();
            }
        })
    }
</script>