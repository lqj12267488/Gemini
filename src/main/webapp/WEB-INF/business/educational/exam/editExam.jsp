<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">

    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="now" name="now" hidden value="${now}"/>
            <input id="examId" name="examId" hidden value="${exam.examId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考试名称
                    </div>
                    <div class="col-md-9">
                        <input id="examName" value="${exam.examName}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="30"
                               placeholder="最多输入30个字"/>
                    </div>
                </div>
                <div id="deptPproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 学期
                    </div>
                    <div class="col-md-9">
                        <select id="term" value="${exam.termShow}"/>
                    </div>
                </div>
                <div id=" examType" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 类型
                    </div>
                    <div class="col-md-9">
                        <select id="examTypes" value="${exam.examTypes}"/>
                    </div>
                </div>
                <div id="majorPproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考试开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="startTime" value="${exam.startTime}" type="date"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div id="coursePproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考试结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="endTime" value="${exam.endTime}" type="date"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 平时成绩录入开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="normalScoreStartTime" value="${exam.normalScoreStartTime}" type="date"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 平时成绩录入结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="normalScoreEndTime" value="${exam.normalScoreEndTime}" type="date"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考试成绩录入开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="scoreStartTime" value="${exam.scoreStartTime}" type="date"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考试成绩录入结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="scoreEndTime" value="${exam.scoreEndTime}" type="date"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        var examId = $("#examId").val();
        if (examId == "" || examId == undefined || examId == null) {

        } else {
            $("#term").attr("disabled", "disabled").css("background-color", "#2c5c82;");
        }
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'term', '${exam.term}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KSXXLX", function (data) {
            addOption(data, 'examTypes', '${exam.examTypes}');
        });


    });

    function save() {
        var examName = $("#examName").val();
        var term = $("#term").val();
        var types = $("#examTypes option:selected").val();
        var startTimeVal = $("#startTime").val();
        var endTimeVal = $("#endTime").val();
        var now = $("#now").val();
        var nowTime = new Date($("#now").val()).getTime();
        var scoreStartTime = $("#scoreStartTime").val();
        var scoreEndTime = new Date($("#scoreEndTime").val().replace('T', ' ')).getTime();
        var normalScoreStartTime = $("#normalScoreStartTime").val();
        var normalScoreEndTime = $("#normalScoreEndTime").val();

        if (examName == "" || examName == undefined || examName == null) {
            swal({
                title: "请填写考试名称！",
                type: "info"
            });
            return;
        } else {
            if (examName.indexOf(" ") != -1 || examName.indexOf("/") != -1 || examName.indexOf("@") != -1) {
                swal({title: "考试名称中不可包含特殊符号。例如[空格]、[/]、[@]等！", type: "info"});
                return;
            }
        }
        if (term == "" || term == undefined || term == null) {
            swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }
        if ($("#examTypes option:selected").val() == "" || $("#examTypes option:selected").val() == undefined || $("#examTypes option:selected").val() == null) {
            swal({
                title: "请选择类型！",
                type: "info"
            });
            return;
        }
        if (startTimeVal == "" || startTimeVal == undefined || startTimeVal == null) {
            swal({
                title: "请选择考试开始时间！",
                type: "info"
            });
            return;
        }
        if (new Date($("#startTime").val().replace('T', ' ')).getTime() < nowTime) {
            swal({
                title: "考试开始日期应在" + now + "之后！",
                type: "info"
            });
            return;
        }

        if (endTimeVal == "" || endTimeVal == undefined || endTimeVal == null) {
            swal({
                title: "请选择考试结束时间！",
                type: "info"
            });
            return;
        }
        if (new Date($("#startTime").val().replace('T', ' ')).getTime() > new Date($("#endTime").val().replace('T', ' ')).getTime()) {
            swal({
                title: "考试开始日期不能晚于结束日期！",
                type: "info"
            });
            return;
        }
        if (normalScoreStartTime == "" || normalScoreStartTime == undefined || normalScoreStartTime == null) {
            swal({
                title: "请选择平时成绩录入开始时间！",
                type: "info"
            });
            return;
        }
        if (new Date($("#normalScoreStartTime").val().replace('T', ' ')).getTime() < nowTime) {
            swal({
                title: "平时成绩录入开始日期应在" + now + "之后！",
                type: "info"
            });
            return;
        }
        if (normalScoreEndTime == "" || normalScoreEndTime == undefined || normalScoreEndTime == null) {
            swal({
                title: "请选择平时成绩录入结束时间！",
                type: "info"
            });
            return;
        }
        if (new Date($("#normalScoreStartTime").val().replace('T', ' ')).getTime() > new Date($("#normalScoreEndTime").val().replace('T', ' ')).getTime()) {
            swal({
                title: "平时成绩录入开始日期不能晚于结束日期！",
                type: "info"
            });
            return;
        }
        if (scoreStartTime == "" || scoreStartTime == undefined || scoreStartTime == null) {
            swal({
                title: "请选择考试成绩录入开始时间！",
                type: "info"
            });
            return;
        }
        if (new Date($("#normalScoreEndTime").val().replace('T', ' ')).getTime() > new Date($("#scoreStartTime").val().replace('T', ' ')).getTime()) {
            swal({
                title: "考试成绩录入开始时间需在平时成绩录入结束时间之后！",
                type: "info"
            });
            return;
        }
        if ($("#scoreEndTime").val() == "" || $("#scoreEndTime").val() == undefined || $("#scoreEndTime").val() == null) {
            swal({
                title: "请选择考试成绩录入结束时间！",
                type: "info"
            });
            return;
        }

        if (new Date($("#scoreStartTime").val().replace('T', ' ')).getTime() > new Date($("#scoreEndTime").val().replace('T', ' ')).getTime()) {
            swal({
                title: "考试开始成绩录入开始时间不能晚于结束日期！",
                type: "info"
            });
            return;
        }



        showSaveLoading();
        $.post("<%=request.getContextPath()%>/exam/save", {
            examId: $("#examId").val(),
            examName: examName,
            term: term,
            startTime: startTimeVal,
            endTime: endTimeVal,
            examTypes: $("#examTypes option:selected").val(),
            scoreStartTime: $("#scoreStartTime").val(),
            scoreEndTime: $("#scoreEndTime").val(),
            normalScoreStartTime: $("#normalScoreStartTime").val(),
            normalScoreEndTime: $("#normalScoreEndTime").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "error"});
            } else {
                swal({title: msg.msg, type: "success"});
            }

            $("#dialog").modal('hide');
            $('#examTable').DataTable().ajax.reload();
        })
    }
</script>


