<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>   系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsId"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 专业
                    </div>
                    <div class="col-md-9">
                        <select id="majorCode"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程
                    </div>
                    <div class="col-md-9">
                        <select id="courseId" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        选择教师姓名
                    </div>
                    <div class="col-md-9">
                        <input id="t_teacherId" type="text" placeholder="请选择人员姓名" value="${examTeacherCourse.teacherPersonIdShow}" ></input>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" id="saveBtn" onclick="saveSalary()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="id" hidden value="${examTeacherCourse.id}">
<input id="person" hidden value="${examTeacherCourse.teacherPersonId}">
<input id="dept" hidden value="${examTeacherCourse.teacherDeptId}">
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        var id = $("#id").val();
        if (id != '') {
            $("#majorCode").attr("disabled", "disabled");
            $("#departmentsId").attr("disabled", "disabled");
            $("#courseId").attr("disabled", "disabled");
        }});
    $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
        addOption(data, 'departmentsId', '${examTeacherCourse.departmentsId}');
    });
    $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " major_code",
            text: " major_name ",
            tableName: "t_xg_major"
        },
        function (data) {
        var majorCodeLevel='${examTeacherCourse.majorCode}';
            var majorCode = majorCodeLevel.split(",")[0];
            addOption(data, "majorCode",majorCode);
        });
    $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " COURSE_ID",
            text: " COURSE_NAME ",
            tableName: "T_JW_COURSE"
        },
        function (data) {
            addOption(data, "courseId",'${examTeacherCourse.courseId}');
        });
    $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
        $("#t_teacherId").autocomplete({
            source: data,
            select: function (event, ui) {
                $("#t_teacherId").val(ui.item.label);
                $("#t_teacherId").attr("keycode", ui.item.value);
                return false;
            }
        }).data("ui-autocomplete")._renderItem = function (ul, item) {
            return $("<li>")
                .append("<a>" + item.label + "</a>")
                .appendTo(ul);
        };
    })
    $("#departmentsId").change(function() {
        if($("#departmentsId").val()!=""){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " distinct id ",
                    text: " name ",
                    tableName: " (select  MAJOR_CODE||','||TRAINING_LEVEL as id ," +
                    " MAJOR_NAME||' -- '||FUNC_GET_DICVALUE(TRAINING_LEVEL,'ZXZYPYCC') as name " +
                    "from T_XG_MAJOR where 1 = 1 and DEPARTMENTS_ID = '"+$("#departmentsId").val()+"'  ) ",
                    where: " ",
                    orderby: " "
                },
                function (data1) {
                    addOption(data1, "majorCode", '${examTeacherCourse.majorCode}');
                })
        }
    });

    $("#majorCode").change(function() {
        if($("#majorCode").val()!=""){
            var mCode = $("#majorCode option:selected").val();
            var majorCode = mCode.split(",")[0];
            var trainingLevel = mCode.split(",")[1];
            var wheresql = "where major_Code = '"+majorCode+"' and TRAINING_LEVEL = '"+trainingLevel+"'";

            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " COURSE_ID ",
                    text: " COURSE_NAME ",
                    tableName: "(select COURSE_ID , COURSE_NAME from T_JW_COURSE " + wheresql +")" ,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "courseId", '${examTeacherCourse.courseId}');
                })
        }
    });
    function saveSalary() {
        var departmentsId = $("#departmentsId option:selected").val();
        if (departmentsId == "" ||departmentsId == undefined) {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }

        var majorCode = $("#majorCode option:selected").val();
        if (majorCode == "" ||majorCode == undefined) {
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        var courseId = $("#courseId option:selected").val();
        if (courseId == "" ||courseId == undefined) {
            swal({
                title: "请选择课程！",
                type: "info"
            });
            return;
        }
        var personId = $("#t_teacherId").val();
        var teacherId = $("#t_teacherId").attr("keycode");
        var person;
        var dept;
        if (personId == "" || personId == null || personId == undefined) {
            swal({
                title: "请填写姓名！",
                type: "info"
            });
            return;
        } else {
            if (teacherId == "" || teacherId == null || teacherId == undefined) {
                person = $("#person").val();
                dept = $("#dept").val();
            } else {
                var headT = $("#t_teacherId").attr("keycode");
                var personList = headT.split(",");
                person = personList[1];
                dept = personList[0];
            }
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/examTeacherCourse/saveExamTeacherCourse", {
            id: $("#id").val(),
            teacherPersonId: person,
            teacherDeptId: dept,
            departmentsId: departmentsId,
            majorCode:majorCode,
            courseId:courseId,
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#examTeacherCourseGrid').DataTable().ajax.reload();
            }
        })


    }

</script>
