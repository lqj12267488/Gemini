<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">成绩录入教师设置</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2">
                        班级名称：
                    </div>
                    <div class="col-md-10">
                        ${classId}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        选择录入教师系部
                    </div>
                    <div class="col-md-9">
                        <select id="s_departmentsId" onchange="changeEditTeacher()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        选择录入教师
                    </div>
                    <div class="col-md-9">
                        <select id="s_teacherId"  ></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>


<script>

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept", function (data) {
            addOption(data, 's_departmentsId','${arrayClassTeacher.teacherDeptId}');
        });
//      根据选择的系部显示教师
        if ('${arrayClassTeacher.teacherPersonId}' != "") {
            var deptId = '${arrayClassTeacher.teacherDeptId}';
            $.post("<%=request.getContextPath()%>/common/getTableDict", {
                id: " user_id",
                text: " name ",
                tableName: " T_SYS_USER ",
                where: " WHERE 1 = 1 " ,
                orderby: " order by name desc"
            },function (data) {
                addOption(data, "s_teacherId", '${arrayClassTeacher.teacherPersonId}');
            });
        }else{
            $("#t_teacherId").append("<option value='' selected>请选择</option>");
        }

    })

    function save() {
        if ($("#s_departmentsId").val() == "" || $("#s_departmentsId").val()  == undefined) {
            swal({title: "请选择录入教师系部！",type: "info"});
            return;
        }
        if ($("#s_teacherId").val() == "" || $("#s_teacherId").val() == undefined) {
            swal({title: "请选择录入教师！",type: "info"});
            return;
        }
        var scoreClassIds = '${scoreClassIds}';

        $.post("<%=request.getContextPath()%>/scoreClass/setScoreClassTeacher", {
            scoreClassIds:scoreClassIds,
            personId: $("#s_teacherId").val(),
            teacherDeptId: $("#s_departmentsId").val(),
            teacherPersonId: $("#s_teacherId").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $("#scoreClassGrid").DataTable().ajax.reload();
            }
        })
    }

    //选择系部后,根据系部id查询所属教师
    function changeEditTeacher() {
        var deptId = $("#s_departmentsId").val();
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " user_id",
            text: " name ",
            tableName: " T_SYS_USER ",
            where: " WHERE 1 = 1 and DEFAULT_DEPT = '"+ deptId +"'"
        },function (data) {
            addOption(data, "s_teacherId");
        });
    }
</script>



