<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="id" hidden value="${arrayClassCourse.arrayClassCourseId}">
            <input id="a_arrayClassId" hidden value="${arrayClassId}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程类型
                    </div>
                    <div class="col-md-9">
                        <select id="a_courseType" class="js-example-basic-single"
                                onchange="hideOtherProperty()"></select>
                    </div>
                </div>
                <div class="form-row" id="departmentsId">
                    <div class="col-md-3 tar">
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="a_departmentsId" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row" id="majorId">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="a_majorId" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程名称
                    </div>
                    <div class="col-md-9">
                        <select id="a_courseID" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学分
                    </div>
                    <div class="col-md-9">
                        <input id="a_credit" value="${arrayClassCourse.credit}">
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
        var courseType = $("#a_courseType option:selected").val();
        if ("1" == courseType) {
            $("#departmentsId").hide();
            $("#majorId").hide();
        } else {
            $("#departmentsId").show();
            $("#majorId").show();
        }

        //课程类型
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCLX", function (data) {
            addOption(data, 'a_courseType', '${arrayClassCourse.courseType}');
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
                addOption(data, "a_departmentsId", '${arrayClassCourse.departmentsId}');
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
                var major = '${arrayClassCourse.majorCode}' +"," +'${arrayClassCourse.trainingLevel}';
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
                addOption(data, "a_courseID", '${arrayClassCourse.courseID}');
            });
        //系部联动专业
        $("#a_departmentsId").blur(function () {
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
        });
        //专业联动课程
        $("#a_majorId").blur(function () {
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
                    addOption(data, "a_courseID");
                })
        });
        //课程类型联动课程
        $("#a_courseType").blur(function () {
            var typeId = $("#a_courseType option:selected").val();
            if (typeId == 1) {
                var course_sql = "(select course_id  code,course_name value from T_JW_COURSE where 1 = 1  and course_type=1 and  valid_flag = 1";
                course_sql += ")";
                $.get("<%=request.getContextPath()%>/common/getTableDict", {
                        id: " code ",
                        text: " value ",
                        tableName: course_sql,
                        where: " ",
                        orderby: " "
                    },
                    function (data) {
                        addOption(data, "a_courseID");
                    })
            }
        });

    })

    function hideOtherProperty() {
        var typeId = $("#a_courseType").val();
        if ("1" == typeId) {
            $("#departmentsId").hide();
            $("#majorId").hide();
        } else {
            $("#departmentsId").show();
            $("#majorId").show();
        }

    }

    function save() {
        var trainingLevel = "";
        var majorData = "";
        var majorId = $("#a_majorId option:selected").val();
        if ($("#a_courseType option:selected").val() == "" || $("#a_courseType option:selected").val() == undefined || $("#a_courseType option:selected").val() == null) {
            swal({
                title: "请选择课程类型！",
                type: "info"
            });
            return;
        } else if ("1" == $("#a_courseType option:selected").val()) {

        } else {
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
            if ($("#a_courseID option:selected").val() == "" || $("#a_courseID option:selected").val() == undefined || $("#a_courseID option:selected").val() == null) {
                swal({
                    title: "请选择课程！",
                    type: "info"
                });
                return;
            }
            majorData = majorId.substring(0, 6);
            trainingLevel = majorId.substring(7, majorId.length);
        }
        if ($("#a_credit").val() == "" || $("#a_credit").val() == undefined || $("#a_credit").val() == null) {
            swal({
                title: "请填写学分！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/arrayClassCourse/saveArrayClassCourse", {
            arrayClassId: $("#a_arrayClassId").val(),
            courseType: $("#a_courseType option:selected").val(),
            arrayClassCourseId: $("#id").val(),
            departmentsId: $("#a_departmentsId option:selected").val(),
            majorCode: majorData,
            trainingLevel: trainingLevel,
            courseID: $("#a_courseID option:selected").val(),
            credit: $("#a_credit").val(),
            term: '${term}'
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#arrayClassCourseGrid').DataTable().ajax.reload();
            }
        })
    }

</script>


