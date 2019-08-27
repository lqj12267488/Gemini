<%--新闻稿发布管理待办修改页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/20
  Time: 13:42
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
        拟稿部门
    </div>
    <div class="col-md-9">
        <input id="n_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${newsDraft.requestDept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        拟稿人
    </div>
    <div class="col-md-9">
        <input id="n_requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${newsDraft.requester}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        拟稿时间
    </div>
    <div class="col-md-9">
        <input id="n_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${newsDraft.requestDate}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        标题
    </div>
    <div class="col-md-9">
        <input id="n_newsTitle" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="130" placeholder="最多输入130个字"
               class="validate[required,maxSize[100]] form-control"
               value="${newsDraft.newsTitle}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        内容
    </div>
    <div class="col-md-9">
        <input id="n_newsContent" type="text" style="height: 300px" maxlength="1330" placeholder="最多输入1330个字"
               class="validate[required,maxSize[1000]] form-control"
               value="${newsDraft.newsContent}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        核稿人
    </div>
    <div class="col-md-9">
        <select  id="n_auditor"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        新闻稿类型
    </div>
    <div class="col-md-9">
        <select  id="n_newsType"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="n_remark" maxlength="130" placeholder="最多输入130个字"
                                  class="validate[required,maxSize[100]] form-control">${newsDraft.remark}</textarea>
    </div>
</div>
<input id="n_Id" hidden value="${newsDraft.id}"/>
<input id="workflowCode" hidden value="T_BG_NEWSDRAFT_WF"/>

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/newsDraft/getDeptPerson", function (data) {
            addOption(data, 'n_auditor','${newsDraft.auditor}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XWGLX", function (data) {
            addOption(data, 'n_newsType','${newsDraft.newsType}');
        });
        if($('#n_newsType').val()=='1'){
            $('#workflowCode').val($('#workflowCode').val()+'01');
        }else{
            $('#workflowCode').val($('#workflowCode').val()+'02');
        }
    })
    /**功能：修改的申请信息保存
     * create by wq
     * @return mv界面
     */
    function save(){
        var date = $("#n_requestDate").val();
        date = date.replace('T', '');
        var reg = /^[0-9]+.?[0-9]*$/;
        // if($("#n_newsTitle").val()=="" ||  $("#n_newsTitle").val() =="0" || $("#n_newsTitle").val() == undefined){
        //     swal({
        //         title: "请选择部门领导!",
        //         type: "info"
        //     });
        //     return;
        // }
        if ($("#n_requestDate").val() == "" || $("#n_requestDate").val() == "0" || $("#n_requestDate").val() == undefined) {
            swal({
                title: "请填写拟稿时间!",
                type: "info"
            });
            return;
        }
        if ($("#n_newsTitle").val() == "" || $("#n_newsTitle").val() == "0" || $("#n_newsTitle").val() == undefined) {
            swal({
                title: "请填写标题!",
                type: "info"
            });
            return;
        }
        if ($("#n_newsContent").val() == "" || $("#n_newsContent").val() == "0" || $("#n_newsContent").val() == undefined) {
            swal({
                title: "请填写内容!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/newsDraft/saveNewsDraft", {
            id:$("#n_Id").val(),
            requestDept: $("#n_requestDept").val(),
            requester: $("#n_requester").val(),
            requestDate:date,
            newsTitle: $("#n_newsTitle").val(),
            newsContent: $("#n_newsContent").val(),
            auditor: $("#n_auditor").val(),
            newsType: $("#n_newsType").val(),
            remark:$("#n_remark").val()
        }, function (msg) {
//          保存后刷新页面数据表
            if (msg.status == 1) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                $("#dialog").modal('hide');
                $('#newsDraftGrid').DataTable().ajax.reload(function () {
                    $('#newsDraftGrid tr a').qtip()
                });
            }
        })
        return true;
    }
</script>
