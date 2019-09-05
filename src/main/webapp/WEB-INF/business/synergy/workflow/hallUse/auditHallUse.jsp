<%--礼堂使用管理办理页面
  Created by IntelliJ IDEA.
  User: qw
  Date: 2017/7/18
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="h_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${hallUse.requestDept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="h_requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${hallUse.requester}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="h_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${hallUse.requestDate}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        开始时间
    </div>
    <div class="col-md-9">
        <input id="h_startTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${hallUse.startTime}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        结束时间
    </div>
    <div class="col-md-9">
        <input id="h_endTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${hallUse.endTime}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        使用设备
    </div>
    <div class="col-md-9">
        <div>
            <input id="usedeviceShow" type="text" readonly value="${hallUse.usedeviceShow}"/>
        </div>
        <input id="usedevice" type="hidden" value="${hallUse.usedevice}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        会议主题
    </div>
    <div class="col-md-9">
                        <textarea id="h_content"
                                  class="validate[required,maxSize[100]] form-control"
                                  readonly="readonly">${hallUse.content}</textarea>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        会议地点
    </div>
    <div class="col-md-9">
        <input id="site" type="text"
               class="validate[required,maxSize[10]] form-control"
               value="${hallUse.meetingSiteShow}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        会议申请
    </div>
    <div class="col-md-9">
        <input id="request" type="text"
               class="validate[required,maxSize[10]] form-control"
               value="${hallUse.meetingRequestShow}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        人数
    </div>
    <div class="col-md-9">
        <input id="h_peopleNumber" type="text"
               class="validate[required,maxSize[10]] form-control"
               value="${hallUse.peopleNumber}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="h_remark"
                                  class="validate[required,maxSize[100]] form-control"
                                  readonly="readonly">${hallUse.remark}</textarea>
    </div>
</div>
<input id="h_id" hidden value="${hallUse.id}">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/hallUse/printHallUse?id=${hallUse.id}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=ITSB", function (data) {
            var deviceNameTree = $.fn.zTree.init($("#deviceNameTree"), setting, data);
        });
    })
</script>