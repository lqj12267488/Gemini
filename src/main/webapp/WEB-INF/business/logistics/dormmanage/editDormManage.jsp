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
            <input id="manageId" name="manageId" hidden value="${DormManage.manageId}"/>
            <input id="person_id" value="${person_id}" hidden>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 楼宇
                    </div>
                    <div class="col-md-9">
                        <select id="edit_buildingIdd" onchange="onchangeBuilding()" value="${DormManage.buildingId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 寝室
                    </div>
                    <div class="col-md-9">
                        <select id="edit_dormm" onchange="onchangeDorm()"/>
                    </div>
                </div>
                <div id="deptPproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 学生
                    </div>
                    <div class="col-md-9">
                        <select id="edit_studentt"/>
                    </div>
                </div>
                <div id="majorPproperty1" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="start_time" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div id="majorPproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="end_time" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>

                <input type="hidden" id="edit_dormManageType" value="0"/>

                <div id="coursePproperty" class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="edit_remark" value="${DormManage.remark}" type="date"
                                  class="validate[required,maxSize[100]] form-control">${DormManage.remark}</textarea>
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
    var manageId = $("#manageId").val();
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var personId = $("#person_id").val();
    $(document).ready(function () {
        var start_time = '${DormManage.startTime}';
        var start_time1 = start_time.replace(" ", "T");
        $("#start_time").val(start_time1);
        var end_time = '${DormManage.endTime}';
        var end_time1 = end_time.replace(" ", "T");
        $("#end_time").val(end_time1);
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select b.id id , b.building_name text from t_jw_building b where b.id in " +
                "(select t.building_id from T_ZW_TEACHER_ORDEROFFICE t where t.valid_flag ='1' and t.teacher_id = '" + personId + "'))",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_buildingIdd", '${DormManage.buildingId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select d.id id , d.dorm_name text from T_JW_DORM d where d.building_id ='" + "${DormManage.buildingId}" + "')",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_dormm", '${DormManage.dormitoryId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select t.student_id id ,FUNC_GET_TABLEVALUE(t.student_id,'t_xg_student','student_id','name') text  from T_XG_DORM_ADJUST_RESULT t where t.dorm_id = '" + "${DormManage.dormitoryId}" + "')",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_studentt", '${DormManage.studentId}');
            });

    });

    function onchangeBuilding() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select d.id id , d.dorm_name text from T_JW_DORM d where d.building_id ='" + $("#edit_buildingIdd").val() + "')",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_dormm", '${teacherPlanJob.buildingId}');
            });
    }

    function onchangeDorm() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select t.student_id id ,FUNC_GET_TABLEVALUE(t.student_id,'t_xg_student','student_id','name') " +
                "text  from T_XG_DORM_ADJUST_RESULT t where t.dorm_id = '" + $("#edit_dormm").val() + "')",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_studentt", '${DormManage.studentId}');
            });
    }

    function save() {
        var edit_buildingId = $("#edit_buildingIdd").val();
        var edit_dorm = $("#edit_dormm").val();
        var edit_student = $("#edit_studentt").val();
        var edit_remark = $("#edit_remark").val();
        var edit_dormManageType = $("#edit_dormManageType").val();
        var startTime = $("#start_time").val();
        var endTime = $("#end_time").val();

        if (edit_dormManageType == "" || edit_dormManageType == undefined || edit_dormManageType == null) {
            swal({
                title: "请选择违纪类型！",
                type: "info"
            });
            return;
        }
        if (edit_buildingId == "" || edit_buildingId == undefined || edit_buildingId == null) {
            swal({
                title: "请选择楼宇！",
                type: "info"
            });
            return;
        }
        if (edit_dorm == "" || edit_dorm == undefined || edit_dorm == null) {
            swal({
                title: "请选择寝室！",
                type: "info"
            });
            return;
        }
        if (edit_student == "" || edit_student == undefined || edit_student == null) {
            swal({
                title: "请选择学生！",
                type: "info"
            });
            return;
        }
        if (startTime == "" || startTime == undefined || startTime == null) {
            swal({
                title: "请选择开始时间！",
                type: "info"
            });
            return;
        }
        if (endTime == "" || endTime == undefined || endTime == null) {
            swal({
                title: "请选择结束时间！",
                type: "info"
            });
            return;
        }

        if (startTime > endTime) {
            swal({
                title: "开始时间必须早于结束时间！",
                type: "info"
            });
            return;
        }
        var startTime1 = startTime.replace("T", " ");
        var endTime1 = endTime.replace("T", " ");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/dormmanage/save", {
            manageId: manageId,
            buildingId: edit_buildingId,
            dormitoryId: edit_dorm,
            studentId: edit_student,
            startTime: startTime1,
            endTime: endTime1,
            remark: edit_remark,
            dormManageType: edit_dormManageType
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#examTable').DataTable().ajax.reload();
        })


    }
</script>


