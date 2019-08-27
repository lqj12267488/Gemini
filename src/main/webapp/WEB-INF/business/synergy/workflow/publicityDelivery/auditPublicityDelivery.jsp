<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/13
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/publicityDelivery/printPublicityDelivery?id=${publicityDelivery.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        标题
    </div>
    <div class="col-md-9">
        <textarea id="caption"  class="validate[required,maxSize[100]] form-control" readonly="readonly"
                  value="${publicityDelivery.caption}">${publicityDelivery.caption}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        发布渠道
    </div>
    <div class="col-md-9">
        <div>
            <input id="distributionChannelsShow" type="text" value="${publicityDelivery.distributionChannelsShow}" readonly="readonly"/>
        </div>
        <div id="menuContent" class="menuContent" style="display: none">
            <ul id="publicityDeliveryTree" class="ztree"></ul>
        </div>
        <input id="distributionChannels" type="hidden" value="${publicityDelivery.distributionChannels}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-local" class="validate[required,maxSize[20]] form-control" readonly="readonly"
               value="${publicityDelivery.requestDate}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${publicityDelivery.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        撰稿人
    </div>
    <div class="col-md-9">
        <input id="requester" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${publicityDelivery.requester}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>

    <div class="col-md-9">
        <textarea id="remark" readonly="readonly"
                  class="validate[required,maxSize[100]] form-control"
                  value="${publicityDelivery.remark}">${publicityDelivery.remark}</textarea>
    </div>
</div>
<script>

    $(document).ready(function () {
        $(document).ready(function () {
            $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=FBQD", function (data) {
                var publicityDeliveryTree = $.fn.zTree.init($("#publicityDeliveryTree"), setting, data);
            });
        })
    })

</script>
