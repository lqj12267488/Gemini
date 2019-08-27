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
                        <span class="iconBtx">*</span> 系部
                    </div>
                    <div class="col-md-9">
                        <select id="edit_buildingIdd" onchange="onchangeDept1()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 专业
                    </div>
                    <div class="col-md-9">
                        <select id="edit_majorName1" onchange="onchangemajor1()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 班级
                    </div>
                    <div class="col-md-9">
                        <select id="edit_className1" onchange="onchangeClass1()"
                        ></select>
                    </div>
                </div>
                <div id="deptPproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 学生
                    </div>
                    <div class="col-md-9">
                        <select id="edit_student11"></select>
                    </div>
                </div>
                <div id="majorPproperty1" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="edit_startTime1" value="${DormManage.startTime}" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div id="majorPproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="edit_endTime1" value="${DormManage.endTime}" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <input type="hidden" id="edit_dormManageType" value="1"/>

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
        $("#edit_startTime1").val(start_time1);
        var end_time = '${DormManage.endTime}';
        var end_time1 = end_time.replace(" ", "T");
        $("#edit_endTime1").val(end_time1);
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=LQLX", function (data) {
            addOption(data, 'edit_dormManageType', '${DormManage.dormManageType}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " id",
            text: " text ",
            tableName: "(select DEPT_ID id, DEPT_NAME text from T_SYS_DEPT where DEPT_TYPE='8' )",
            where: " ",
            orderby: " "
        }, function (data) {
            addOption(data, "edit_buildingIdd", '${DormManage.deparmentsId}');
        });

        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " id",
            text: " text ",
            tableName: "(select MAJOR_CODE id,MAJOR_NAME text from T_XG_MAJOR where DEPARTMENTS_ID='" + "${DormManage.deparmentsId}" + "')",
            where: " ",
            orderby: " "
        }, function (data) {
            addOption(data, "edit_majorName1", '${DormManage.majorCodeId}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " id",
            text: " text ",
            tableName: "(select CLASS_ID id ,CLASS_NAME text from T_XG_CLASS where MAJOR_CODE='" + "${DormManage.majorCodeId}" + "')",
            where: " ",
            orderby: " "
        }, function (data) {
            addOption(data, "edit_className1", '${DormManage.classId}');
        });

        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " id",
            text: " text ",
            tableName: "(select s.STUDENT_ID id, s.NAME text from T_XG_STUDENT s, T_XG_CLASS c, T_xg_student_class sc where s.STUDENT_ID=sc.STUDENT_ID and c.CLASS_ID=sc.CLASS_ID and c.CLASS_ID='" + "${DormManage.classId}" + "')",
            where: " ",
            orderby: " "
        }, function (data) {
            addOption(data, "edit_student11", '${DormManage.studentId}');
        });
    });

    function onchangeDept1() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " id",
            text: " text ",
            tableName: "(select MAJOR_CODE id,MAJOR_NAME text from T_XG_MAJOR where DEPARTMENTS_ID='" + $("#edit_buildingIdd").val() + "')",
            where: " ",
            orderby: " "
        }, function (data) {
            addOption(data, "edit_majorName1", '${teacherPlanJob.buildingId}');
        });
    }

    function onchangemajor1() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " id",
            text: " text ",
            tableName: "(select CLASS_ID id ,CLASS_NAME text from T_XG_CLASS where MAJOR_CODE='" + $("#edit_majorName1").val() + "')",
            where: " ",
            orderby: " "
        }, function (data) {
            addOption(data, "edit_className1", '${teacherPlanJob.buildingId}');
        });

    }

    function onchangeClass1() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " id",
            text: " text ",
            tableName: "(select s.STUDENT_ID id, s.NAME text from T_XG_STUDENT s, T_XG_CLASS c, T_xg_student_class sc where s.STUDENT_ID=sc.STUDENT_ID and c.CLASS_ID=sc.CLASS_ID and c.CLASS_ID='" + $("#edit_className1").val() + "')",
            where: " ",
            orderby: " "
        }, function (data) {
            addOption(data, "edit_student11", '${teacherPlanJob.buildingId}');
        });

    }

    function save() {

        var edit_student = $("#edit_student11").val();
        var edit_remark = $("#edit_remark").val();
        var edit_dormManageType = $("#edit_dormManageType").val();
        var startTime = $("#edit_startTime1").val();
        var endTime = $("#edit_endTime1").val();
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
        showSaveLoading();
        var startTime1 = startTime.replace("T", " ");
        var endTime1 = endTime.replace("T", " ");
        $.post("<%=request.getContextPath()%>/dormmanage/save", {
            manageId: manageId,
            studentId: edit_student,
            remark: edit_remark,
            startTime: startTime1,
            endTime: endTime1,
            dormitoryId: "397e0682-778c-43c8-9a6c-da9e701793f2",
            dormManageType: edit_dormManageType
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#examTable').DataTable().ajax.reload();
        })


    }
</script>


