<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input hidden="hidden" id="scoreClassId" value="${scoreClass.scoreClassId}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            考试名称
                        </div>
                        <div class="col-md-9">
                            <input id="t_scoreExamName" value="${scoreClass.scoreExamName}"readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            课程
                        </div>
                        <div class="col-md-9">
                            <input id="t_courseId" value="${scoreClass.courseId}"readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            系部
                        </div>
                        <div class="col-md-9">
                            <input id="f_departments" value="${scoreClass.departmentsId}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            专业
                        </div>
                        <div class="col-md-9">
                            <input id="f_majorCode" value="${scoreClass.majorCode}" readonly="readonly"/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-3 tar">
                            班级
                        </div>
                        <div class="col-md-9">
                            <input id="t_classId" value="${scoreClass.classId}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            选择录入教师系部
                        </div>
                        <div class="col-md-9">
                            <select id="t_departmentsId" onchange="changeEditTeacher()"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            选择录入教师
                        </div>
                        <div class="col-md-9">
                            <select id="t_teacherId"  ></select>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>

</div>
<script>

    $(document).ready(function () {


        $.get("<%=request.getContextPath()%>/common/getSelectDept", function (data) {
            addOption(data, 't_departmentsId','${scoreClass.teacherDeptId}');
        });
//      根据选择的系部显示教师
        if ('${scoreClass.teacherPersonId}' != "") {
            var deptId = '${scoreClass.teacherDeptId}';
            $.post("<%=request.getContextPath()%>/common/getTableDict", {
                id: " user_id",
                text: " name ",
                tableName: " T_SYS_USER ",
                where: " WHERE 1 = 1 and DEFAULT_DEPT = '"+ deptId +"'" ,
                orderby: " order by name desc"
            },function (data) {
                addOption(data, "t_teacherId", '${scoreClass.teacherPersonId}');
            });
        }else{
            $("#t_teacherId").append("<option value='' selected>请选择</option>");
        }

    })

    function save() {
        if ( $("#t_departmentsId").val() == "" ||$("#t_departmentsId").val()  == undefined) {
            swal({title: "请选择录入教师系部！",type: "info"});
            return;
        }
        if ( $("#t_teacherId").val() == "" || $("#t_teacherId").val() == undefined) {
            swal({title: "请选择录入教师！",type: "info"});
            return;
        }

        $.post("<%=request.getContextPath()%>/scoreClass/saveScoreClassTeacher", {
            scoreClassId:$("#scoreClassId").val(),
            personId: $("#t_teacherId").val(),
            teacherDeptId: $("#t_departmentsId").val(),
            teacherPersonId: $("#t_teacherId").val()

        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                search();
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



