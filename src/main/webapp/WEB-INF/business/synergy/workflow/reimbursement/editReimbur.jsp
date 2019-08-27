<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/19
  Time: 11:01
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
            <div class="controls" >

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        报销事由
                    </div>
                    <div class="col-md-9">
                        <input id="rcause" maxlength="15" placeholder="最多输入15个字"
                               class="validate[required,maxSize[100]] form-control"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               value="${reimbursement.rcause}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        报销内容
                    </div>
                    <div class="col-md-9">
                        <input id="content" maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${reimbursement.content}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        报销金额
                    </div>
                    <div class="col-md-9">
                        <input id="money" placeholder="请填写数字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${reimbursement.money}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="requestDept" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               readonly=“readonly”
                               value="${reimbursement.requestDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="requester"
                               class="validate[required,maxSize[100]] form-control"
                               readonly=“readonly”
                               value="${reimbursement.requester}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="requestDate" type="date"
                               class="validate[required,maxSize[100]] form-control"
                               value="${reimbursement.requestDate}" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<input id="reimburid" type="hidden" value="${reimbursement.id}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    function saveDept() {
        var reg=/^[0-9]+.?[0-9]*$/;
       if($("#rcause").val()=="" ||  $("#rcause").val() =="0" || $("#rcause").val() == undefined){
            swal({
               title: "请填写报销事由!",
               type: "info"
           });
            return;
        }
        if($("#content").val()=="" ||  $("#content").val() =="0" || $("#content").val() == undefined){
            swal({
                title: "请填写报销内容!",
                type: "info"
            });
            return;
        }
        if($("#money").val()=="" ||  $("#money").val() =="0" || $("#money").val() == undefined){
            swal({
                title: "请填写报销金额!",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#money").val())){
            swal({
                title: "报销金额请填写数字!",
                type: "info"
            });
            return;
        }

        if($("#requestDate").val()=="" ||  $("#requestDate").val() =="0" || $("#requestDate").val() == undefined){
             swal({
                title: "请填写申请日期!",
                type: "info"
            });
            return;
        }
        /*
        if($("#shootingMethod").val()=="" ||  $("#shootingMethod").val() =="0" || $("#shootingMethod").val() == undefined) {
            alert("请填写出拍摄方法");
        }
        if($("#machineNumber").val()=="" ||  $("#machineNumber").val() =="0" || $("#machineNumber").val() == undefined){
            alert("请填写出摄影机机位数");
            return;
        }
        if($("#content").val()=="" ||  $("#content").val() =="0" || $("#content").val() == undefined){
            alert("请填写出活动内容");
            return;
        }*/

        $.post("<%=request.getContextPath()%>/reimbursement/saveReimbur", {
            id: $("#reimburid").val(),
            rcause:$("#rcause").val(),
            requestDept: $("#requestDept").val(),
            requester: $("#requester").val(),
            requestDate: $("#requestDate").val(),
            money: $("#money").val(),
            content: $("#content").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1 ) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#reimbursementGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }
</script>
