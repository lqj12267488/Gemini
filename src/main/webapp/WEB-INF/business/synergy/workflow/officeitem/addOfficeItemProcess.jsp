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
        物品名称
    </div>
    <div class="col-md-9">
        <div>
            <input id="itemNameShow" type="text" onclick="showMenu()"  value="${officeItem.itemNameShow}" readonly="readonly"/>
        </div>
        <div id="menuContent" class="menuContent">

        </div>
        <input id="itemName" type="hidden" value="${officeItem.itemName}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请数量
    </div>
    <div class="col-md-9">
        <input id="itemNumber" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${officeItem.itemNumber}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${officeItem.requestDept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${officeItem.requester}" readonly="readonly"/>
    </div>
</div>


<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-loca"
               class="validate[required,maxSize[100]] form-control"
               value="${officeItem.requestDate}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="remark" readonly="readonly"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${officeItem.remark}">${officeItem.remark}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/officeItem/printOfficeItem?id=${officeItem.id}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=BGHC", function (data) {
            var itemNameTree = $.fn.zTree.init($("#itemNameTree"), setting, data);
        });
    })
</script>
