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
            <input id="l_id" hidden value="${leagues.id}">
        </div>
        <div class="modal-body clearfix">

            <div class="controls">

                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请原因
                    </div>
                    <div class="col-md-9">
                        <%--<select id="itemname" class="js-example-basic-single"></select>--%>

                        <textarea id="e_reason"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${leagues.reason}">${leagues.reason}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        小写金额
                    </div>
                    <div class="col-md-9">
                        <input id="e_amount" type=""
                               class="validate[required,maxSize[100]] form-control"
                               value="${leagues.amount}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="e_requestdept" type="text" readonly value="${leagues.requestDept}"
                               class="validate[required,maxSize[100]] form-control"
                               />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="e_manager" type="" readonly value="${leagues.manager}"
                               class="validate[required,maxSize[100]] form-control"
                               />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="date" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control" value="${leagues.requestDate}"
                               />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="e_remark"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${leagues.remark}">${leagues.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
        </div>
</div>
<%--<input id="roleCache" hidden value="${funds.roletype}">--%>
<script>
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
        if(!reg.test($("#e_amount").val())){
            swal({
                title: "小写金额请输入数字",
                type: "info"
            });
            //alert("小写金额请输入数字");
            return;
        }
        var date = $("#date").val().replace("T"," ");
        $.post("<%=request.getContextPath()%>/leagues/saveLeague", {
            id: $("#l_id").val(),
            amount: $("#e_amount").val(),
            remark: $("#e_remark").val(),
            requestDate:date,
            reason:$("#e_reason").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#leaguesTable').DataTable().ajax.reload();
            }
        })
    }

</script>
