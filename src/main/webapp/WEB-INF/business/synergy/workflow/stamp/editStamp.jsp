<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
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
            <input id="stampid" name="stampid" type="hidden" value="${stamp.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        印章类型
                    </div>
                    <div class="col-md-9">
                        <select  id="stampFlag" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        合同内容（用途）
                    </div>
                    <div class="col-md-9">
                        <input id="contractDetails" type="text" maxlength="330" placeholder="最多输入330个字"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[20]] form-control"
                               value="${stamp.contractDetails}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="requestDept" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${stamp.requestDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        经办人
                    </div>
                    <div class="col-md-9">
                        <input id="manager" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${stamp.manager}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="requestDate" value="${stamp.requestDate}" type="datetime-local" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control">${stamp.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveStamp()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YZLX", function (data) {
            addOption(data, 'stampFlag','${stamp.stampFlag}');
        });
    })



    function saveStamp() {
        var date = $("#requestDate").val();
        date = date.replace('T','');
        if($("#stampFlag").val() =="" || $("#stampFlag").val() == undefined){
           swal({
                title: "请选择印章类型!",
                type: "info"
            });
            return;
        }
        if($("#contractDetails").val() =="" ||  $("#contractDetails").val() =="0" || $("#contractDetails").val() == undefined){
           swal({
                title: "请填写合同内容!",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/stamp/saveStamp", {
            id: $("#stampid").val(),
            stampFlag: $("#stampFlag option:selected").val(),
            contractDetails: $("#contractDetails").val(),
            remark: $("#remark").val(),
            requestDate: date
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1 ) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#stampGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>

