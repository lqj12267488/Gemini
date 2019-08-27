<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/libs/css/stylesheets.css" rel="stylesheet" type="text/css">
<div class="modal-dialog">
    <input id="f_room" name="room" value="${room}" hidden>
    <input id="start" name="start" value="${start}" hidden>
    <input id="end"  name="end" value="${end}" hidden>
    <input id="examRoomId"  name="examRoomId" value="${examRoomId}" hidden>
    <input id="examId"  name="examId" value="${examId}" hidden>
    <input id="ids"  name="ids" value="${ids}" hidden>
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="examCourseId" name="examCourseId" hidden value="${course.examCourseId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考试开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="startTime" value="${course.startTime}"   type="datetime-local" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考试结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="endTime" value="${course.endTime}" type="datetime-local" onchange="countExamMinute()" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考试时长
                    </div>
                    <div class="col-md-9">
                        <input id="examMinute" readonly type="text"  value="${course.examMinute}"/>
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
    //计算考试时长
    function countExamMinute() {
        var startTime =$("#startTime").val().replace('T',' ');
        var endTime= $("#endTime").val().replace('T',' ');
        var beginYearMonthDay=startTime.substring(0,10);
        var endYearMonthDay=endTime.substring(0,10);
        var beginTimes =new Date(beginYearMonthDay).getTime();
        var endTimes= new Date(endYearMonthDay).getTime();
        var checkStartTimes =new Date($("#start").val()).getTime();
        var checkEndTimes= new Date($("#end").val()).getTime();
        if(endTimes >checkEndTimes){
            swal({
                title: "考试结束时间超出考试结束日期！",
                type: "info"
            });
            return;
        }
        if(beginTimes< checkStartTimes){
            swal({
                title: "考试开始时间超出考试开始日期！",
                type: "info"
            });
            return;
        }

        var minusTimes=endTimes-beginTimes
        if(startTime>endTimes){
            swal({
                title: "考试开始时间不能晚于考试结束日期！",
                type: "info"
            });
            return;
        }else if(minusTimes>3600000){
            swal({
                title: "开始时间和结束时间应设置在同一天！",
                type: "info"
            });
            return;
        }else{
            var beginHour=parseInt(startTime.substring(11,13))*60;
            var beginMinnus=parseInt(startTime.substring(14,startTime.length));
            var endHour=parseInt(endTime.substring(11,13))*60;
            var endMinnus=parseInt(endTime.substring(14,endTime.length));
            var beginCountMinute=beginHour+beginMinnus;
            var endCountMinute=endHour+endMinnus;
            var countMinute=endCountMinute-beginCountMinute;
            document.getElementById("examMinute").value=countMinute;

        }


    }
    function save() {
        var start = new Date($("#startTime").val()).getTime();
        var end = new Date($("#endTime").val()).getTime();
        var startTimeVal = $("#startTime").val();
        var endTimeVal = $("#endTime").val();

        if(startTimeVal=="" || startTimeVal == undefined || startTimeVal == null){
            swal({
                title: "请设置考试开始时间！",
                type: "info"
            });
            return;
        }
        if(endTimeVal=="" || endTimeVal == undefined || endTimeVal == null){
            swal({
                title: "请设置考试结束时间！",
                type: "info"
            });
            return;
        }
        if(start>end){
            swal({
                title: "考试开始时间不能晚于考试结束时间！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/exam/course/saveExamCourseTime", {
            ids:$("#ids").val(),
            examId:$("#examId").val(),
            examCourseId: $("#examCourseId").val(),
            startTime:$("#startTime").val().replace('T',' '),
            endTime:$("#endTime").val().replace('T',' '),
            examMinute:$("#examMinute").val(),
            examRoomId:$("#examRoomId").val(),
        }, function (data) {
            hideSaveLoading();
            if(data.status==1 ){
                swal({title: data.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#courseTableGrid').DataTable().ajax.reload();
            }
        })
    }
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
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>
