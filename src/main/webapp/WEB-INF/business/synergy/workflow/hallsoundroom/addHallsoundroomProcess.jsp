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
        会议内容
    </div>
    <div class="col-md-9">
        <input id="meetingcontent" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${hallsoundroom.meetingcontent}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        使用开始时间
    </div>
    <div class="col-md-9">
        <input id="starttime" type="datetime-local"
               class="validate[required,maxSize[20]] form-control"
               value="${hallsoundroom.starttime}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        使用结束时间
    </div>
    <div class="col-md-9">
        <input id="endtime" type="datetime-local"
               class="validate[required,maxSize[20]] form-control"
               value="${hallsoundroom.endtime}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        使用设备
    </div>
    <div class="col-md-9">
        <div>
            <input id="usedeviceShow" type="text" onclick="showMenu()"  value="${hallsoundroom.usedeviceShow}" readonly="readonly"/>
        </div>
        <%--<div id="menuContent" class="menuContent">--%>
            <%--<ul id="deviceNameTree" class="ztree"></ul>--%>
        <%--</div>--%>
        <input id="usedevice" type="hidden" value="${hallsoundroom.usedevice}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestdept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${hallsoundroom.requestdept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${hallsoundroom.requester}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="requestdate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${hallsoundroom.requestdate}" readonly="readonly"/>
    </div>
</div>

<script>
    $(document).ready(function () {
        $.get("/common/getUserDictToTree?name=BGHC", function (data) {
            var deviceNameTree = $.fn.zTree.init($("#deviceNameTree"), setting, data);
        });
    })
</script>