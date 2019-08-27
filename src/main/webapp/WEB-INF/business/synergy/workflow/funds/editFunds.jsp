<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/6 0006
  Time: 下午 2:59
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
            <input id="e_id" hidden value="${funds.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请原因
                    </div>
                    <div class="col-md-9">
                        <%--<select id="itemname" class="js-example-basic-single"></select>--%>

                        <textarea id="e_reason" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${funds.reason}">${funds.reason}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        小写金额
                    </div>
                    <div class="col-md-9">
                        <input id="e_amount" type="" placeholder="请输入数字"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[100]] form-control"
                               value="${funds.amount}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="e_requestdept" type="text" readonly value="${funds.requestDept}"
                               class="validate[required,maxSize[100]] form-control"
                        />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="e_manager" type="" readonly value="${funds.manager}"
                               class="validate[required,maxSize[100]] form-control"
                        />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="date" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control" value="${funds.requestDate}"
                        />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="e_remark" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${funds.remark}">${funds.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<%--<input id="roleCache" hidden value="${funds.roletype}">--%>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $(".form_datetime").datetimepicker({
            format: "dd MM yyyy - hh:ii"
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'itemname');
        });
    })

    function save() {
        var reg = /^[0-9]+.?[0-9]*$/;
        var reg1 = /^\d+(\.\d{1,2})?$/;
        if ($("#e_reason").val() == "" || $("#e_reason").val() == null) {
            swal({
                title: "请填写申请原因",
                type: "info"
            });
            //alert("请填写申请原因");
            return;
        }
        if ($("#e_amount").val() == "") {
            swal({
                title: "请填写小写金额",
                type: "info"
            });
            //alert("请填写小写金额");
            return;
        }
        if (!reg.test($("#e_amount").val())) {
            swal({
                title: "小写金额请输入数字",
                type: "info"
            });
            //alert("小写金额请输入数字");
            return;
        }
        if (!reg1.test($("#e_amount").val())) {
            swal({
                title: "小写金额只能有两位小数",
                type: "info"
            });
            //alert("小写金额请输入数字");
            return;
        }
        var date = $("#date").val().replace("T", " ");
        $.post("<%=request.getContextPath()%>/funds/saveFunds", {
            id: $("#e_id").val(),
            amount: $("#e_amount").val(),
            remark: $("#e_remark").val(),
            requestDate: date,
            reason: $("#e_reason").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#funds').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>
