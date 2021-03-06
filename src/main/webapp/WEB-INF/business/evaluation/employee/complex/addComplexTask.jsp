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
<div class="modal-dialog" id="modaldialog">
    <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">新增</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            综合评教任务名称
                        </div>
                        <div class="col-md-9">
                            <input id="complexTaskName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="30" placeholder="最多输入30个字"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            学期
                        </div>
                        <div class="col-md-9">
                            <select id="term" />
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            总分
                        </div>
                        <div class="col-md-9">
                            <input id="score" type="number" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="10" placeholder="最多输入10位数字"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            说明
                        </div>
                        <div class="col-md-9">
                            <textarea id="remark" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                      maxlength="160" placeholder="最多输入160个字"></textarea>
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
        <input id="eType" value="${evaluationType}" hidden>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'term');
        });
    });

    function save() {
        if ($("#complexTaskName").val() == "" || $("#complexTaskName").val() == null) {
            swal({
                title: "请填写综合评教任务名称！",
                type: "info"
            });
            return;
        }

        if ($("#term option:selected").val() == "" || $("#term option:selected").val() == null) {
            swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }

        if ($("#score").val() == "" || $("#score").val() == null) {
            swal({
                title: "请选择总分！",
                type: "info"
            });
            return;
        }

        if(parseInt($("#score").val())< 0 ){
            swal({
                title: "评分不能为负数！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/evaluation/complex/saveComplexTask", {
            complexTaskName: $("#complexTaskName").val(),
            term: $("#term option:selected").val(),
            score: $("#score").val(),
            remark: $("#remark").val(),
            complexTaskId: $("#complexTaskId").val(),
            evaluationType:$("#eType").val(),
        }, function (msg) {
            if (msg.status == 1) {
                hideSaveLoading();
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal("hide");
                $('#ComplexTaskTable').DataTable().ajax.reload();
            }
        })
    }
</script>
<style>
    #menuContent{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
