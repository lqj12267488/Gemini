<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">设置补考时间</span>
            <input id="examCourseId" hidden value="${examCourse.examCourseId}"/>
            <input id="examId" hidden value="${examCourse.examId}"/>
            <input id="departmentsId" hidden value="${examCourse.departmentsId}"/>
            <input id="courseId" hidden value="${examCourse.courseId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        补考学科名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="courseShow"  type="text" value="${examCourse.courseShow}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        班级名称
                    </div>
                    <div class="col-md-9">
                        <input  type="text" id="courseTypeShow" value="${examCourse.courseTypeShow}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        补考人数
                    </div>
                    <div class="col-md-9">
                        <input  type="text" id="studentNumber" value="${examCourse.studentNumber}" readonly />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        考场
                    </div>
                    <div class="col-md-9">
                        <select  type="text" id="roomId" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        开始时间
                    </div>
                    <div class="col-md-9">
                        <input  id="startTime" type="datetime-local" value="${examCourse.startTime}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        结束时间
                    </div>
                    <div class="col-md-9">
                        <input  id="endTime" type="datetime-local" value="${examCourse.endTime}"/>
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
/*
        $.get("< %=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '$ {course.departmentsId}');
        });
*/
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " ROOM_ID ",
            text: " ROOM_NAME ",
            tableName: " T_JW_MAKEUP_ROOM_CLASS ",
            where: " WHERE 1 = 1 and EXAM_ID = '${examCourse.examId}' "
        },function (data) {
            addOption(data, "roomId" ,'${examCourse.roomId}');
        });
    });


    function save() {
        var examCourseId = $("#examCourseId").val();
        var roomId = $("#roomId option:selected").val();
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var examId = $("#examId").val();
        var departmentsId = $("#departmentsId").val();
        var studentNumber = $("#studentNumber").val();
        var courseId = $("#courseId").val();

        if (roomId == "" || roomId == undefined || roomId == null) {
            swal({title: "请选择考场！",type: "info"});
            return;
        }
        if(startTime>endTime){
            swal({ title: "开始时间必须早于结束时间", type: "info"});
            return;
        }
        startTime = startTime.replace('T',' ');
        endTime = endTime.replace('T',' ');

        showSaveLoading();
        $.post("<%=request.getContextPath()%>/exam/makeup/saveExamCourse",{
            examCourseId: examCourseId,
            roomId: roomId,
            startTime: startTime,
            endTime: endTime,
            departmentsId: departmentsId,
            examId: examId,
            studentNumber: studentNumber,
            courseId: courseId,
        },function(msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: msg.result
            });
            if(msg.status =='1'){
                $("#dialog").modal('hide');
                $('#scoreExamTable').DataTable().ajax.reload();
            }
        })
    }
</script>



