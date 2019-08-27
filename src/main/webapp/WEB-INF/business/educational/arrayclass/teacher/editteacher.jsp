<%--
  Created by IntelliJ IDEA.
  User: Admin
  modify: wq 2017/08/23
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="t_departmentsId" onchange="changeEditTeacher()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        授课教师
                    </div>
                    <div class="col-md-9">
                        <select id="t_teacherId" ></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
    <input id="arrayclassTeacherId" hidden value="${arrayClassTeacher.arrayclassTeacherId}"/>
    <input id="arrayclassId" hidden value="${arrayclassId}"/>
</div>
<script>

    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept", function (data) {
            addOption(data, 't_departmentsId','${arrayClassTeacher.teacherDeptId}');
        });
//      根据选择的系部显示教师
        if ('${arrayClassTeacher.teacherPersonId}' != "") {
            var deptId = '${arrayClassTeacher.teacherDeptId}';
            $.post("<%=request.getContextPath()%>/common/getTableDict", {
                id: " user_id",
                text: " name ",
                tableName: " T_SYS_USER ",
                where: " WHERE 1 = 1 and DEFAULT_DEPT = '"+ deptId +"'" ,
                orderby: " order by name desc"
            },function (data) {
                addOption(data, "t_teacherId", '${arrayClassTeacher.teacherPersonId}');
            });
        }else{
            $("#t_teacherId").append("<option value='' selected>请选择</option>");
        }
        <%--var deptId = '${arrayClassTeacher.teacherDeptId}';--%>
        <%--$.post("/common/getTableDict", {--%>
        <%--id: " ID",--%>
        <%--text: " CLASS_ROOM_NAME ",--%>
        <%--tableName: " T_JW_CLASSROOM ",--%>
        <%--where: " WHERE 1 = 1 and ROOM_TYPE = '"+ roomType +"'"--%>
        <%--},function (data) {--%>
        <%--addOption(data, "w_roomId", '${arrayClassRoom.roomId}');--%>
        <%--});--%>
    })

    function save() {
        var t_departmentsId = $("#t_departmentsId option:selected").val();
        var t_teacherId = $("#t_teacherId option:selected").val();
        if (t_departmentsId == "" ||t_departmentsId == undefined) {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if (t_teacherId == "" ||t_teacherId == undefined) {
            swal({
                title: "请选择授课教师！",
                type: "info"
            });
            return;
        }
        if ($("#arrayclassTeacherId").val() == "" || $("#arrayclassTeacherId").val() == "0" || $("#arrayclassTeacherId").val() == undefined) {
            arrayclassId=$("#arrayclassId").val();
        }else{
            arrayclassId='${arrayClassTeacher.arrayclassId}';
        }
        showSaveLoading();

        $.post("<%=request.getContextPath()%>/arrayClass/teacher/checkTeacher",{
            arrayclassTeacherId:$("#arrayclassTeacherId").val(),
            arrayclassId: arrayclassId,
            teacherPersonId:t_teacherId
        },function(msg){
            hideSaveLoading();

            if(msg.status == 1){
                swal({
                    title: "该教师已在排课计划中，请重新选择！",
                    type: "info"
                });

            }else{
                showSaveLoading();
                $.post("<%=request.getContextPath()%>/arrayClass/teacher/saveArrayClassTeacher", {
                    arrayclassTeacherId:$("#arrayclassTeacherId").val(),
                    arrayclassId:$("#arrayclassId").val(),
                    teacherPersonId: t_teacherId,
                    teacherDeptId: t_departmentsId
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        $("#dialog").modal('hide');
                        search();
                    }
                })
            }
        })
    }

    //选择系部后,根据系部id查询所属教师
    function changeEditTeacher() {
        var deptId = $("#t_departmentsId").val();
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " user_id",
            text: " name ",
            tableName: " T_SYS_USER ",
            where: " WHERE 1 = 1 and DEFAULT_DEPT = '"+ deptId +"'"
        },function (data) {
            addOption(data, "t_teacherId");
        });
    }
</script>



