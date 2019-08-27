<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/libs/css/stylesheets.css" rel="stylesheet" type="text/css">
<div class="modal-dialog">
    <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">修改</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        考评方案名称
                    </div>
                    <div class="col-md-9">
                        <input id="planName" type="text" value="${plan.planName}"
                               class="validate[required,maxSize[20]] form-control" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="30" placeholder="最多输入30个字"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        总分数
                    </div>
                    <div class="col-md-9">
                        <input id="score" type="text" value="${plan.score}"
                               class="validate[required,maxSize[20]] form-control" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="10" placeholder="最多输入10位数字"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark"
                                  onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                  maxlength="160" placeholder="最多输入160个字">${plan.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()" id="saveBtn">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="planId" value="${plan.planId}" hidden>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    function save() {
        var score = $("#score").val();
        var remark = $("#remark").val();
        var planName = $("#planName").val();
        if ($("#planName").val() == "" || $("#planName").val() == null) {
            swal({
                title: "请填考评方案名称！",
                type: "info"
            });
            return;
        }
        if (score == "" || score == null) {
            swal({
                title: "请填写总分数！",
                type: "info"
            });
            return;
        }
        var reg = new RegExp("^[0-9]*$");
        if (!reg.test(score)) {
            swal({
                title: "总分数只能为数字！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/xgEvaluation/updatePlan", {
            planId: $("#planId").val(),
            planName: planName,
            remark: remark,
            score: score
        }, function (msg) {
            if (msg.status == 1) {
                hideSaveLoading();
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal("hide");
                planTable.ajax.reload();
            }
        })
    }
</script>