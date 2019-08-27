<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/10
  Time: 16:00
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
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="id" name="id" type="hidden" value="${mealCardHandle.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDept" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${mealCardHandle.deptId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请教师
                    </div>
                    <div class="col-md-9">
                        <input id="f_requester" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${mealCardHandle.teacherId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        饭卡类型
                    </div>
                    <div class="col-md-9">
                        <select id="f_mealCardType" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请办卡时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_mealCardTime" value="${mealCardHandle.mealCardTime}"
                               type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="f_remark" maxlength="165" placeholder="最多输入165个字"
                                  class="validate[required,maxSize[100]] form-control">${mealCardHandle.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveMealCardHandle()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=FKLX", function (data) {
            addOption(data, 'f_mealCardType', '${mealCardHandle.mealCardType}');
        });
    })
    function saveMealCardHandle() {
        var date = $("#f_mealCardTime").val();
        date = date.replace('T', '');

        if ($("#f_mealCardType").val() == "" || $("#f_mealCardType").val() == "0" || $("#f_mealCardType").val() == undefined) {
           swal({
                title: "请填写饭卡类型！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/mealCardHandle/saveMealCardHandle", {
            id: $("#id").val(),
            mealCardType: $("#f_mealCardType").val(),
            mealCardTime: date,
            remark: $("#f_remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#mealCardHandleGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }
</script>


