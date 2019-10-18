<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="form-row" id="deptSel">
    <div class="col-md-3 tar">
        部门
    </div>
    <div class="col-md-9">
        <input id="a_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${reportManagement.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row" id="classSel" hidden>
    <div class="col-md-3 tar">
        班级
    </div>
    <div class="col-md-9">
        <input id="s_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${reportManagement.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="a_requestEr" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${reportManagement.manager}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="a_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${reportManagement.requestDate}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申诉内容
    </div>
    <div class="col-md-9">
        <input id="rcProjectName" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${reportManagement.reportContent}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申诉类型
    </div>
    <div class="col-md-9" >
        <select id="l_request" disabled="true"/>
    </div>
</div>
<input id="id" hidden value="${reportManagement.id}">
<input id="requestTypeShowSel" type="hidden" value="${reportManagement.reportType}">

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        if ('${reportManagement.studentTeacherType}' == '0') {
            $("#classSel").show();
            $("#deptSel").hide();
        }else{
            $("#deptSel").show();
            $("#classSel").hide();
        }


        $(".form_datetime").datetimepicker({
            format: "dd MM yyyy - hh:ii"
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SSLX", function (data) {
            addOption(data, 'l_request', $("#requestTypeShowSel").val());
        });

    })


    function save() {

        if ($("#rcProjectName").val() == "" || $("#rcProjectName").val() == null) {
            swal({
                title: "请填写申诉内容",
                type: "info"
            });
            return;
        }

        var reDate = $("#a_requestDate").val().replace("T", " ");

        $.post("<%=request.getContextPath()%>/reportManagement/saveReportManagement", {
            id: $("#id").val(),
            requestDate: reDate,
            reportType: $("#l_request").val(),
            reportContent: $("#rcProjectName").val()
        }, function (msg) {
            if (msg.status == 1) {
                $("#dialog").modal('hide');
                $('#cpTable').DataTable().ajax.reload();

            }
        })
        return true;
    }

</script>
