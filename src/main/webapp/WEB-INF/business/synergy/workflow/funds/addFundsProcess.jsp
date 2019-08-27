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
                        <textarea id="e_reason" readonly="readonly"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${funds.reason}">${funds.reason}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        金额
    </div>
    <div class="col-md-9">
        <input id="e_amount" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${funds.amount}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="f_requestEr" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${funds.manager}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${funds.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${funds.requestDate}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="a_remark" class="validate[required,maxSize[100]] form-control" readonly="readonly">${funds.remark}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        已关联业务
    </div>
    <div class="col-md-9">
        <div class="side pull-right">
                <a href="#" onclick="fundAudit()"></a>
        </div>
        <div class="head bg-dot30" id="fuAudit" style="width: 100%;">
        </div>
    </div>
</div>
<input id="h_id" hidden value="${funds.id}">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/funds/printFunds?id=${funds.id}">
<script>

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/funds/getDept", function (data) {
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

        $.get("<%=request.getContextPath()%>/funds/getPerson", function (data) {
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
        fundAudit();
    })

    function fundAudit() {
        $("#fuAudit").load("<%=request.getContextPath()%>/funds/processLoadIndexUnAudit?id=${funds.id}");
    }
    function fAudit(url, tableName, businessId,flag) {
        $("#dialogFile").load("<%=request.getContextPath()%>/funds/getFundsLog", {
            id: businessId,
            url:url,
            tableName:tableName,
            businessId:businessId
        })
        $("#dialogFile").modal("show");

    }
</script>
