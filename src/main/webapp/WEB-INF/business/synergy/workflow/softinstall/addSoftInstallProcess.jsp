<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        软件名称
    </div>
    <div class="col-md-9">
        <input id="softName" type="text" maxlength="30" placeholder="最多输入30个字"
               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               class="validate[required,maxSize[20]] form-control"
               value="${softinstall.softName}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="f_requestEr" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${softinstall.requester}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${softinstall.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${softinstall.requestDate}" />
    </div>
    <%--<div class="col-md-9">
        <div class="input-append date form_datetime">
            <input size="16" type="text" value="" readonly>
            <span class="add-on"><i class="icon-th"></i></span>
        </div>
    </div>--%>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        安装机房及原因
    </div>
    <div class="col-md-9">
                        <textarea id="f_reason" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${softinstall.reason}">${softinstall.reason}</textarea>
    </div>
</div>
<input type="hidden" id="softid" value="${softinstall.id}">
<input id="workflowCode" hidden value="T_BG_SOFTINSTALL_WF01">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/softInstall/printSoftInstall?id=${softinstall.id}">

<script>

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/softInstall/getDept", function (data) {
            $("#f_requestDept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_requestDept").val(ui.item.label);
                    $("#f_requestDept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            }
        })

        $.get("<%=request.getContextPath()%>/softInstall/getPerson", function (data) {
            $("#f_requestEr").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_requestEr").val(ui.item.label);
                    $("#f_requestEr").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    })
    function save() {
        if ($("#softName").val() == "" || $("#softName").val() == "0" || $("#softName").val() == undefined) {
            swal({
                title: "请填写软件名称",
                type: "info"
            });
            //alert("请填写软件名称");
            return;
        }
       /* if ($("#f_requestEr").val() == "" || $("#f_requestEr").val() == "0" || $("#f_requestEr").val() == undefined) {
            swal({
                title: "请填写申请人",
                type: "info"
            });
            //alert("请填写申请人");
            return;
        }
        if ($("#f_requestDept").val() == "" || $("#f_requestDept").val() == "0" || $("#f_requestDept").val() == undefined) {
            swal({
                title: "请填写申请部门",
                type: "info"
            });
            //alert("请填写申请部门");
            return;
        }*/
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0") {
            swal({
                title: "请填写申请日期",
                type: "info"
            });
            //alert("请填写申请日期");
            return;
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            swal({
                title: "请填写安装机房及原因",
                type: "info"
            });
            //alert("请填写申请理由");
            return;
        }
        var c_requestDate = $("#f_requestDate").val().replace('T', ' ');
        $.post("<%=request.getContextPath()%>/softInstall/updateSoftById", {
            id: $("#softid").val(),
            softName: $("#softName").val(),
            requester: $("#f_requestEr").val(),
            requestDept: $("#f_requestDept").val(),
            requestDate: c_requestDate,
            reason: $("#f_reason").val()
        },
        function (msg) {
            if (msg.status == 1) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                $("#dialog").modal('hide');
                $('#softInstallGrid').DataTable().ajax.reload();

            }
        })
        return true;
    }

</script>
