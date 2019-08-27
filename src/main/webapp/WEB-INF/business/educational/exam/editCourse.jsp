<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/libs/css/stylesheets.css" rel="stylesheet" type="text/css">
<div class="modal-dialog">
    <input id="f_room" name="room" value="${room}" hidden>
    <input id="start" name="start" value="${start}" hidden>
    <input id="end"  name="end" value="${end}" hidden>
    <input id="courseType"  name="courseType" value="${course.courseType}" hidden>
    <input id="examId"  name="examId" value="${examId}" hidden>
    <input id="departmentShow" name="departmentShow" value="${course.departmentShow}" hidden>
    <input id="up_departments" name="up_departments" value="${course.departmentsId}" hidden>
    <input id="trainingLevel" name="trainingLevel" value="${course.trainingLevel}" hidden>
    <input id="majorCode" name="majorCode" value="${course.majorCode}" hidden>
    <input id="up_course" name="up_course" value="${course.courseId}" hidden>
    <input id="up_roomShow" name="roomShow" value="${course.roomShow}" hidden>


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
                        <span class="iconBtx">*</span> 考场名称
                    </div>
                    <div class="col-md-9">
                        <select id="room"   />
                    </div>
                </div>
                <%--<div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 课程类型
                    </div>
                    <div class="col-md-9">
                        <select id="typeId"    onchange="hideOtherPproperty()"/>
                    </div>
                </div>--%>
               <%-- <div id="deptPproperty"  class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  班级
                    </div>
                    <div class="col-md-9">
                        <input id="classid"  class="js-example-basic-single"/>
                    </div>
                </div>--%>
                <%--<div id="deptPproperty"  class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsid"  class="js-example-basic-single"/>
                    </div>
                </div>
                <div  id="majorPproperty" class="form-row">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span> 专业
                </div>
                <div class="col-md-9">
                    <select id="majorid"  class="js-example-basic-single"/>
                </div>
              </div>--%>
               <div id="examTypeProperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  考试形式
                    </div>
                    <div class="col-md-9">
                        <select id="exam_type"  type="text" onchange="changeOtherPropertyHide()" />
                    </div>
                </div>
                <%--<div id="roomProperty"  class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  考试科目
                    </div>
                    <div class="col-md-9">
                        <div style="white-space:nowrap;">
                            <input id="courseShow" type="text" onclick="showTree()"  value="${course.courseShow}" readonly/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="courseTree" class="ztree"></ul>
                        </div>
                        <input id="courseid" type="hidden" value="${course.courseId}"/>
                    </div>
                </div>--%>
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
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.excheck.js"></script>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var zTree;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " room_id",
                text: " room_name ",
                tableName: "T_JW_EXAM_ROOM",
                where: " where exam_id = '${examId}' ",
                orderby: " order by room_id "
            },
            function (data) {
                addOption(data, "room", $("#f_room").val());
            });

        $("#room").change(function(){
            if($("#room").val()!=""){
                /*$.get("<%=request.getContextPath()%>/exam/getClassIdByRoom?roomId="+$("#room option:selected").val()+"&examId=${examId}",function (data) {
                    if(data!= null){
                        console.log(data);
                        console.log(data.classId);
                        $("#classid").val(data.classId);
                    }
                });*/
                $.get("<%=request.getContextPath()%>/exam/getRoomTypeByExamRoomId?roomId="+$("#room option:selected").val(),function (data) {
                    if(data!= null){
                        console.log(data);
                        console.log(data.roomType);
                        $("#exam_type").val(data.roomType);
                    }

                });
            }
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KSXS", function (data) {
            addOption(data, 'exam_type',$("#exam_type").val());
        });
            //编辑不可再编辑的字段
            $("#classid").attr("disabled","disabled").css("background-color","#2c5c82;");
            $("#exam_type").attr("disabled","disabled").css("background-color","#2c5c82;");







    });


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

    /*function changeOtherPropertyHide(){
        var exam_type= $("#exam_type").val();
        if("1"==exam_type){
            $("#roomProperty").hide();
        }else{
            $("#roomProperty").show();
            $.get("/common/getTableToTree",{
                    id: " id",
                    text: " class_room_name ",
                    tableName: "T_JW_CLASSROOM ",
                    where: " WHERE VALID_FLAG = 1 and ROOM_TYPE = '"+$("#exam_type").val()+"'"
                },
                function (data) {
                    zTree = $.fn.zTree.init($("#roomTree"), setting, data);
                    var node;
                });
        }



    }*/
    function save() {
        var typeId = $("#typeId option:selected").val();
        var departmentsid = $("#departmentsid option:selected").val();
        var majorVal = $("#majorid option:selected").val();
        var trainingLevel="";
        var majorData="";
        var room = $("#room option:selected").val();
        var exam_type = $("#exam_type option:selected").val();
        var start = new Date($("#startTime").val()).getTime();
        var end = new Date($("#endTime").val()).getTime();
        var startTimeVal = $("#startTime").val();
        var endTimeVal = $("#endTime").val();
        var courseid = $("#courseid").val();
        var roomShow = $("#roomShow").val();
       if (room == "" || room == undefined || room == null) {
            swal({
                title: "请选择考试场地！",
                type: "info"
            });
            return;
        }/* else if("1"==typeId){
            if (course_id == "" || course_id == undefined || course_id == null) {
                swal({
                    title: "请选择考试科目！",
                    type: "info"
                });
                return;
            }
        }else{
            if (departmentsid == "" || departmentsid == undefined || departmentsid == null) {
                swal({
                    title: "请选择系部！",
                    type: "info"
                });
                return;
            }
            if (majorVal == "" || majorVal == undefined || majorVal == null) {
                swal({
                    title: "请选择专业！",
                    type: "info"
                });
                return;
            }
            if (course_id == "" || course_id == undefined || course_id == null) {
                swal({
                    title: "请选择考试科目！",
                    type: "info"
                });
                return;
            }

             majorData=majorVal.split(",")[0];
             trainingLevel=majorVal.split(",")[1];
        }
        if(exam_type == "" || exam_type == undefined || exam_type == null){
            swal({
                title: "请选择考试形式！",
                type: "info"
            });
            return;
         }else if("1"==exam_type){

           } else {
            if (courseid == "" || courseid == undefined || courseid == null) {
                swal({
                    title: "请选择考试科目！",
                    type: "info"
                });
                return;
            }
        }*/
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
        $.post("<%=request.getContextPath()%>/exam/course/save", {
            examId:$("#examId").val(),
            examCourseId: $("#examCourseId").val(),
            startTime:$("#startTime").val().replace('T',''),
            endTime:$("#endTime").val().replace('T',''),
            examMinute:$("#examMinute").val(),
            roomId:room
        }, function (data) {
            hideSaveLoading();
            if(data.status==1 || data.status==2 || data.status==3){
                swal({title: data.msg, type: "error"});
            }else{
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
