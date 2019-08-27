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
        申请事由
    </div>
    <div class="col-md-9">
        <input id="reason" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${computer.reason}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        外设名称
    </div>
    <div class="col-md-9">
            <div>
                <input id="suppliesnameShow" type="text" onclick="showMenu()"  value="${computer.suppliesnameShow}" readonly />
            </div>
            <div id="menuContent" class="menuContent">
                <ul id="suppliesnameTree" class="ztree"></ul>
            </div>
            <input id="suppliesname" type="hidden" value="${computer.suppliesname}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestdept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${computer.requestdept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        经办人
    </div>
    <div class="col-md-9">
        <input id="manager" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${computer.manager}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestdate" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${computer.requestdate}" readonly="readonly"/>

    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <input id="remark" type="text"
                  class="validate[required,maxSize[100]] form-control"
                  value="${computer.remark}" readonly="readonly">
        </input>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/computer/printComputer?id=${computer.id}">

<script>

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=JSJHC", function (data) {
            var suppliesnameTree = $.fn.zTree.init($("#suppliesnameTree"), setting, data);
        });

        $.get("<%=request.getContextPath()%>/compuer/getDept", function (data) {
            $("#requestdept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#requestdept").val(ui.item.label);
                    $("#requestdept").attr("keycode", ui.item.value);
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
