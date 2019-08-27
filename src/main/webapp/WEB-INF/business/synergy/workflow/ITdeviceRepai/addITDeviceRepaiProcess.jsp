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
        申请原因
    </div>
    <div class="col-md-9">
        <textarea id="a_reason" readonly="readonly" class="validate[required,maxSize[100]] form-control"  readonly="readonly"
                  value="${itDeviceRepair.reason}">${itDeviceRepair.reason}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="f_requestEr" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${itDeviceRepair.requester}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${itDeviceRepair.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${itDeviceRepair.requestDate}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="f_remark" readonly="readonly"
                  class="validate[required,maxSize[100]] form-control"
                  value="${itDeviceRepair.remark}">${itDeviceRepair.remark}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/ITdeviceRepai/printItDeviceRepair?id=${itDeviceRepair.id}">
<script>

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/itdevicerepai/getDept", function (data) {
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

        $.get("<%=request.getContextPath()%>/itdevicerepai/getPerson", function (data) {
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

</script>
