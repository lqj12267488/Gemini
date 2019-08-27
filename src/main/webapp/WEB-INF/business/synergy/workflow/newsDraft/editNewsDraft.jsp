<%--新闻稿发布管理新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/20
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="n_Id" name="n_Id" type="hidden" value="${newsDraft.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
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
                        <textarea id="n_newsContent" style="height: 200px" maxlength="1330" placeholder="最多输入1330个字"
                                  class="validate[required,maxSize[1000]] form-control">${newsDraft.newsContent}</textarea>
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
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">
                保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">
                关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/newsDraft/getDeptPerson", function (data) {
            addOption(data, 'n_auditor','${newsDraft.auditor}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XWGLX", function (data) {
            addOption(data, 'n_newsType','${newsDraft.newsType}');
        });
    })
    /**功能：修改的申请信息保存
     * create by wq
     * @return mv界面
     */
    function save(){
        var date = $("#n_requestDate").val();
        date = date.replace('T', '');
        var reg = /^[0-9]+.?[0-9]*$/;
        if($("#n_newsTitle").val()=="" ||  $("#n_newsTitle").val() =="0" || $("#n_newsTitle").val() == undefined){
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
        if ($("#n_auditor").val() == "" || $("#n_auditor").val() == "0" || $("#n_auditor").val() == undefined) {
            swal({
                title: "请选择核稿人!",
                type: "info"
            });
            return;
        }
        if ($("#n_newsType").val() == "" || $("#n_newsType").val() == "0" || $("#n_newsType").val() == undefined) {
            swal({
                title: "请选择新闻类型!",
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
            hideSaveLoading();
//          保存后刷新页面数据表
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#newsDraftGrid').DataTable().ajax.reload(function () {
                    $('#newsDraftGrid tr a').qtip()
                });
            }
        })
        showSaveLoading();
    }
</script>

