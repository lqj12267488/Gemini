<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 18:14
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<input type="hidden" id="leaveid" value="${leave.id}">
<div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
<div class="form-row">
    <div class="col-md-3 tar">
        学籍号
    </div>
    <div class="col-md-9">
        <input id="studentNumber" type="text" value="${leave.studentNumber}" />
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        系部
    </div>
    <div class="col-md-9">
        <input id="departmentsId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.departmentsId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        专业
    </div>
    <div class="col-md-9">
        <input id="majorCode" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.majorCode}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        班级名称
    </div>
    <div class="col-md-9">
        <input id="classId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.classId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学生姓名
    </div>
    <div class="col-md-9">
        <input id="studentName" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.studentName}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        性别
    </div>
    <div class="col-md-9">
        <input id="sex" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.sex}" readonly="readonly"/>
    </div>
</div>
<div class="form-row" hidden>

    <div class="col-md-9">
        <input id="studentId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.studentId}" readonly="readonly"/>
    </div>
</div>



<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${leave.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="f_requester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${leave.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" value="${leave.requestDate}" readonly="readonly"
               type="datetime-local" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        请假开始时间
    </div>
    <div class="col-md-9">
        <input id="f_startTime" type="date" class="validate[required,maxSize[100]] form-control"
               value="${leave.startTime}" onchange="changeRequestDays()"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        请假结束时间
    </div>
    <div class="col-md-9">
        <input id="f_endTime" type="date" class="validate[required,maxSize[100]] form-control"
               value="${leave.endTime}" onchange="shijian();changeRequestDays()"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        请假天数
    </div>
    <div class="col-md-9">
        <input  id="f_requestDays" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                 value="${leave.requestDays}" onclick="cha()" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        假条类型
    </div>
    <div class="col-md-9">
        <select id="eleaveType" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        请假原因
    </div>
    <div class="col-md-9">
                            <textarea id="f_reason"  maxlength="300" placeholder="最多输入300个字"
                                      class="validate[required,maxSize[100]] form-control"
                                      >${leave.reason}</textarea>
    </div>
</div>
<input id="workflowCode" hidden >
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    function shijian() {
        if( $("#f_startTime").val() > $("#f_endTime").val()){
            swal({
                title: "请选择开始时间需要在结束时间之前",
                type: "info"
            });
            //alert("请选择开始时间需要在结束时间之前！");
            $("#f_endTime").val("");
            return;
        }
    }
    function changeRequestDays() {
        var start = new Date($("#f_startTime").val().substring(0, 10)).getTime();
        var end = new Date($("#f_endTime").val().substring(0, 10)).getTime();
        if (end >= start) {
            var cha = (end - start) / 60 / 60 / 24 / 1000;
            $("#f_requestDays").val(cha + 1);
        }
    }
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JTLX", function (data) {
            addOption(data, 'eleaveType', '${leave.leaveType}');
        });
    })


    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T','');
        var startTime = $("#f_startTime").val();
        startTime = startTime.replace('T','');
        var endTime = $("#f_endTime").val();
        endTime = endTime.replace('T','');
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0") {
            swal({
                title: "请填写申请时间",
                type: "info"
            });
            //alert("请填写申请时间");
            return;
        }
        if ($("#f_startTime").val() == "" || $("#f_startTime").val() == "0") {
            swal({
                title: "请填写请假开始时间",
                type: "info"
            });
            //alert("请填写请假开始时间");
            return;
        }
        if ($("#f_endTime").val() == "" || $("#f_endTime").val() == "0") {
            swal({
                title: "请填写请假结束时间",
                type: "info"
            });
            //alert("请填写请假结束时间");
            return;
        }
        if ($("#f_startTime").val() > $("#f_endTime").val()) {
            swal({
                title: "请选择请假开始时间需要在请假结束时间之前",
                type: "info"
            });
            //alert("请选择请假开始时间需要在请假结束时间之前！");
            return;
        }
        if ($("#eleaveType").val() == "" || $("#eleaveType").val() == "0" || $("#eleaveType").val() == undefined) {
            swal({
                title: "请填写请假类型",
                type: "info"
            });
            return;
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            swal({
                title: "请填写请假原因",
                type: "info"
            });
            //alert("请填写请假原因");
            return;
        }
        $.post("<%=request.getContextPath()%>/studentLeave/auditStudentLeaveEdit", {
            id: $("#leaveid").val(),
            requestDate: date,
            startTime:startTime,
            endTime:endTime,
            requestDays: $("#f_requestDays").val(),
            leaveType: $("#eleaveType option:selected").val(),
            reason: $("#f_reason").val()
        }, function (msg) {
            if (msg.status == 1 ) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                $("#dialog").modal('hide');
                $('#leaveGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }

</script>


