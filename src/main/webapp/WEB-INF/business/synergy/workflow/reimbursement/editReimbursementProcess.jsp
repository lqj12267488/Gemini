<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/19
  Time: 11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="h_requestDept" type="text"
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
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        报销事由
    </div>
    <div class="col-md-9">
        <input id="rcause" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="15" placeholder="最多输入15个字"
               class="validate[required,maxSize[100]] form-control"
               value="${reimbursement.rcause}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        报销内容
    </div>
    <div class="col-md-9">
        <input id="content" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="30" placeholder="最多输入30个字"
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
        <input id="money" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               placeholder="请填写数字"
               class="validate[required,maxSize[100]] form-control"
               value="${reimbursement.money}"/>
    </div>
</div>
<input id="h_Id" hidden value="${reimbursement.id}"/>
<input id="workflowCode" hidden value="T_BG_REIMBURSEMENT_WF">

<script>
    $(document).ready(function () {
        var reg=/^[0-9]+.?[0-9]*$/;
        if($("#rcause").val()=="" ||  $("#rcause").val() =="0" || $("#rcause").val() == undefined){
            alert("请填写报销事由");
            return;
        }
        if($("#content").val()=="" ||  $("#content").val() =="0" || $("#content").val() == undefined){
            alert("请填写报销内容");
            return;
        }
        if($("#money").val()=="" ||  $("#money").val() =="0" || $("#money").val() == undefined){
            alert("请填写报销金额");
            return;
        }
        if(!reg.test($("#money").val())){
            alert("报销金额请填写数字");
            return;
        }
        if($("#requestDate").val()=="" ||  $("#requestDate").val() =="0" || $("#requestDate").val() == undefined){
            alert("请填写申请日期");
            return;
        }
        $.get("<%=request.getContextPath()%>/hotelStay/getDept", function (data) {
            $("#h_requestDept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#h_requestDept").val(ui.item.label);
                    $("#h_requestDept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            }
        })
    })

    /**功能：修改的申请信保存
     * create by wq
     * @return mv界面
     */
    function save(){
        /*var a = $("#photographyid").val();*/
        var t_requestDate = $("#requestDate").val();
        var reg=/^[0-9]+.?[0-9]*$/;
        if($("#rcause").val()=="" ||  $("#rcause").val() =="0" || $("#rcause").val() == undefined){
             swal({
                title: "请填写报销事由!",
                type: "info"
            });
            return;
        }
        if($("#content").val()=="" ||  $("#content").val() =="0" || $("#content").val() == undefined) {
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
        $.post("<%=request.getContextPath()%>/reimbursement/saveReimbur", {
            id: $("#h_Id").val(),//获取页面数据得值
            requestDept: $("#requestDept").val(),
            requester: $("#requester").val(),
            requestDate: $("#requestDate").val(),
            rcause:$("#rcause").val(),
            money: $("#money").val(),
            content: $("#content").val()
        }, function (msg) {
            if (msg.status == 1 ) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                $("#dialog").modal('hide');
                $('#reimbursementGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }
</script>


