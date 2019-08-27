<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/8/23
  Time: 16:05
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
                        课程类型
                    </div>
                    <div class="col-md-9">
                        <select id="a_courseType" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row" id="departmentsId">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="a_departmentsId" class="js-example-basic-single" onchange="changeDept()"></select>
                    </div>
                </div>
                <div class="form-row" id="majorId">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="a_majorId" class="js-example-basic-single" onchange="changeMajor()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        课程名称
                    </div>
                    <div class="col-md-9">
                        <select id="a_courseId" class="js-example-basic-single"></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
    <input id="id" hidden value="${arrayclassTeacherCourse.id}">
    <input id="arrayclassId" hidden value="${arrayclassId}">
    <input id="teacherPersonId" hidden value="${teacherPersonId}">
    <input id="arrayclassTeacherId" hidden value="${arrayclassTeacherId}">
</div>
<script>

    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    $(document).ready(function () {
        //课程类型
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCLX", function (data) {
            addOption(data, 'a_courseType', '${arrayclassTeacherCourse.courseType}');
        });
        //系部下拉回显
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " order by dept_id "
            },
            function (data) {
                addOption(data, "a_departmentsId", '${arrayclassTeacherCourse.departmentsId}');
            })
        //专业下拉回显
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: "(select major_code || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1)",
                where: " ",
                orderby: " "
            },
            function (data) {
                var major = '${arrayclassTeacherCourse.majorCode}' +"," +'${arrayclassTeacherCourse.trainingLevel}';
                addOption(data, "a_majorId", major);
            });
        //课程回显
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: "(select course_id  code,course_name value from T_JW_COURSE where 1 = 1  and valid_flag = 1)",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "a_courseId", '${arrayclassTeacherCourse.courseId}');
            });
        $("#a_courseType").change(function () {
            var course_sql  = "";
            var typeId = $("#a_courseType").val();
            var majorId = $("#a_majorId option:selected").val();
            if (typeId == 1) {
                course_sql = "(select course_id  code,course_name value from T_JW_COURSE where 1 = 1  and course_type=1 and  valid_flag = 1";
            }else{
                course_sql = "(select course_id  code,course_name value from T_JW_COURSE where 1 = 1  and valid_flag = 1";
                if (majorId != "") {
                    course_sql += " and major_code ='" + majorId.substring(0, 6) + "' and training_level='" + majorId.substring(7, majorId.length) + "' ";
                }
            }
            course_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: course_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "a_courseId");
                }
            )
        })
    })

    function save() {
        var majorId = $("#a_majorId option:selected").val();
        if ($("#a_courseType option:selected").val() == "" || $("#a_courseType option:selected").val() == undefined || $("#a_courseType option:selected").val() == null) {
            swal({
                title: "请选择课程类型！",
                type: "info"
            });
            return;
        }
        if ($("#a_departmentsId option:selected").val() == "" || $("#a_departmentsId option:selected").val() == undefined || $("#a_departmentsId option:selected").val() == null) {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if (majorId == "" || majorId == undefined || majorId == null) {
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if ($("#a_courseId option:selected").val() == "" || $("#a_courseId option:selected").val() == undefined || $("#a_courseId option:selected").val() == null) {
            swal({
                title: "请选择课程！",
                type: "info"
            });
            return;
        }
        showSaveLoading();

        var teacherPersonId=$("#teacherPersonId").val();
        var majorData = majorId.substring(0, 6);
        var trainingLevel = majorId.substring(7, majorId.length);
        $.post("<%=request.getContextPath()%>/arrayClass/teacher/saveTeacherCourse", {
            id:$("#id").val(),
            arrayclassId: $("#arrayclassId").val(),
            teacherPersonId: teacherPersonId,
            courseType: $("#a_courseType option:selected").val(),
            courseId: $("#a_courseId").val(),
            departmentsId: $("#a_departmentsId option:selected").val(),
            majorCode: majorData,
            trainingLevel: trainingLevel,
            arrayclassTeacherId:$("#arrayclassTeacherId").val()
        }, function (msg) {
            hideSaveLoading();

            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#teacherCourseGrid').DataTable().ajax.reload();
            }
        })
    }
    //系部联动专业
    function changeDept(){
        var major_sql = "(select major_code || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
        if ($("#a_departmentsId option:selected").val() != "") {
            major_sql += " and departments_id ='" + $("#a_departmentsId option:selected").val() + "' ";
        }
        major_sql += ")";
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: major_sql,
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "a_majorId");
            })
    }
    //专业联动课程
    function changeMajor(){
        if($("#a_courseType option:selected").val()==2) {
            var majorId = $("#a_majorId option:selected").val();
            var course_sql = "(select course_id  code,course_name value from T_JW_COURSE where 1 = 1  and valid_flag = 1";
            if (majorId != "") {
                course_sql += " and major_code ='" + majorId.substring(0, 6) + "' and training_level='" + majorId.substring(7, majorId.length) + "' ";
            }
            course_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: course_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "a_courseId");
                })
        }
    }
</script>

