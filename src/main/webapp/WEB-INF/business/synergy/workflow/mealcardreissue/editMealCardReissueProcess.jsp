<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/11
  Time: 14:20
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
                <input type="hidden" id="id" value="${mealCardReissue.id}">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDept" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${mealCardReissue.deptId}"/>
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
                               value="${mealCardReissue.teacherId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        补卡原因
                    </div>
                    <div class="col-md-9">
                        <select id="f_reissueReason" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        补卡待遇
                    </div>
                    <div class="col-md-9">
                        <input id="f_treatment" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${mealCardReissue.treatment}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请办卡时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_reissueTime" value="${mealCardReissue.reissueTime}"
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
                                  class="validate[required,maxSize[100]] form-control">${mealCardReissue.remark}</textarea>
                    </div>
                </div>
                <input id="workflowCode" hidden value="T_BG_MEALCARD_HANDLE_WF01">

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BBYY", function (data) {
            addOption(data, 'f_reissueReason', '${mealCardReissue.reissueReason}');
        });
    })
    function save() {
        var date = $("#f_reissueTime").val();
        date = date.replace('T', '');
        if ($("#f_reissueReason").val() == "" || $("#f_reissueReason").val() == "0" || $("#f_reissueReason").val() == undefined) {
            swal({
                title: "请填写补办原因！",
                type: "info"
            });
            return;
        }
        if ($("#f_treatment").val() == "" || $("#f_treatment").val() == "0" || $("#f_treatment").val() == undefined) {
            swal({
                title: "请填写补办待遇！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/mealCardReissue/saveMealCardReissue", {
            id: $("#id").val(),
            reissueReason: $("#f_reissueReason").val(),
            treatment:$("#f_treatment").val(),
            reissueTime: date,
            remark: $("#f_remark").val()
        }, function (msg) {
            if (msg.status == 1) {
                /*swal({title: msg.msg, type: "success"});*/
                $("#dialog").modal('hide');
                $('#mealCardReissueGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }
</script>



