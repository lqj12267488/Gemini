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
            <input id="examRoomId" name="examRoomId" hidden value="${room.examRoomId}"/>
            <input id="roomId" name="roomId" hidden value="${room.roomId}"/>
            <input id="roomName" name="roomName" hidden value="${room.roomName}"/>
            <input id="roomType" name="roomType" hidden value="${room.roomType}"/>
            <input id="up_departments" name="up_departments" value="${room.departmentsId}" hidden>
            <input id="trainingLevel" name="trainingLevel" value="${room.trainingLevel}" hidden>
            <input id="majorCode" name="majorCode" value="${room.majorCode}" hidden>
            <input id="up_classId" name="up_classId" value="${room.classId}" hidden>
            <input id="examId" name="examId" hidden value="${examId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 教室类型
                    </div>
                    <div class="col-md-9">
                        <select id="room_type" onchange="hideOtherProperty()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考场
                    </div>
                    <div class="col-md-9">
                        <select id="room_id"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 容纳考生数量
                    </div>
                    <div class="col-md-9">
                        <input id="student_number" class="js-example-basic-single" value="${room.studentNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 场地容纳总人数
                    </div>
                    <div class="col-md-9">
                        <input id="people_number" readonly="readonly" class="js-example-basic-single"
                               value="${room.peopleNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 监考教师数量
                    </div>
                    <div class="col-md-9">
                        <input id="teacher_number" class="js-example-basic-single" value="${room.teacherNumber}"/>
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
        var examRoomId = $("#examRoomId").val();
        if (examRoomId == "" || examRoomId == undefined || examRoomId == null) {
            $("#majorid").html("<option>请选择系部</option>");
            $("#classid").html("<option>请选择专业</option>");
        } else {
            //考场回显
            var room_sql = "(select id || ',' || class_room_name code,class_room_name  value from T_JW_CLASSROOM where 1=1  and valid_flag = 1";
            if ($("#roomType").val() != "") {
                room_sql += " and room_type ='" + $("#roomType").val() + "' ";
            }
            room_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: room_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "room_id", $("#roomId").val() + "," + $("#roomName").val());
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
                    var up_major = $("#majorCode").val() + "," + $("#trainingLevel").val();
                    addOption(data, "majorid", up_major);
                })
            //班级下拉回显
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1)",
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "classid", $("#up_classId").val());
                })
            //编辑不可再编辑的字段
            $("#room_type").attr("disabled", "disabled").css("background-color", "#2c5c82;");
            $("#room_id").attr("disabled", "disabled").css("background-color", "#2c5c82;");
        }
        //系部下拉回显
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " order by dept_id "
            },
            function (data) {
                addOption(data, "departmentsid", $("#up_departments").val());
            })

        //系部联动专业
        $("#departmentsid").change(function () {
            var major_sql = "(select distinct major_code || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if ($("#departmentsid option:selected").val() != "") {
                major_sql += " and departments_id ='" + $("#departmentsid option:selected").val() + "' ";
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
                    addOption(data, "majorid");
                })
        });
        //专业联动班级
        $("#majorid").change(function () {
            var class_sql = "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1";
            if ($("#majorid option:selected").val() != "") {
                class_sql += " and major_code ='" + $("#majorid option:selected").val().substring(0, 6) + "' and training_level='" + $("#majorid option:selected").val().substring(7, $("#majorid option:selected").val().length) + "' ";
            }
            class_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: class_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "classid");
                })

        });

        //教室类型回显
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSLX", function (data) {
            addOption(data, 'room_type', '${room.roomType}');
        });


        //教室类型联动教室
        $("#room_type").change(function () {
            var room_sql = "(select id || ',' || class_room_name code,class_room_name  value from T_JW_CLASSROOM where 1=1  and valid_flag = 1";
            if ($("#room_type option:selected").val() != "") {
                room_sql += " and room_type ='" + $("#room_type option:selected").val() + "' ";
            }
            room_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: room_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "room_id");
                })
        });
        $("#room_id").change(function () {
            if ($("#room_id").val() != "") {
                $.get("<%=request.getContextPath()%>/exam/getPeopleNumber?roomId=" + $("#room_id").val(), function (data) {
                    if (data != null) {
                        console.log(data);
                        console.log(data.peopleNumber);
                        $("#people_number").val(data.peopleNumber);
                    }
                })
            }
        });

    });

    function hideOtherProperty() {
        var room_type = $("#room_type").val();
        if ("1" == room_type) {
            $("#deptPproperty").show();
            $("#majorPproperty").show();
            $("#classPproperty").show();
        } else {
            $("#deptPproperty").hide();
            $("#majorPproperty").hide();
            $("#classPproperty").hide();
        }

    }

    function save() {
        var examRoomId = $("#examRoomId").val();
        var reg = new RegExp("^[0-9]*$");
        var room_type = $("#room_type option:selected").val();
        var room_id = $("#room_id option:selected").val();
        var departmentsid = $("#departmentsid option:selected").val();
        var majorid = $("#majorid option:selected").val();
        var classid = $("#classid option:selected").val();
        var teacher_number = $("#teacher_number").val();
        var trainingLevel = "";
        var majorData = "";
        if (room_type == "" || room_type == undefined || room_type == null) {
            swal({
                title: "请选择教室类型！",
                type: "info"
            });
            return;
        }
        if (room_id == "" || room_id == undefined || room_id == null) {
            swal({
                title: "请选择考场！",
                type: "info"
            });
            return;
        }
        if ($("#student_number").val() == "" || $("#student_number").val() == undefined || $("#student_number").val() == null) {
            swal({
                title: "请填写可容纳考生数量！",
                type: "info"
            });
            return;
        } else {
            if (!reg.test($("#student_number").val())) {
                swal({
                    title: "考生数量请填写整数！",
                    type: "info"
                });
                return;
            }

        }
        if (parseInt($("#student_number").val()) > parseInt($("#people_number").val())) {
            swal({
                title: "容纳考生数量不能超过场地容纳总人数！",
                type: "info"
            });
            $("#student_number").val("");
            return;
        }
        if (teacher_number == "" || teacher_number == undefined || teacher_number == null) {
            swal({
                title: "请填写监考教师数量！",
                type: "info"
            });
            return;
        } else {
            if (!reg.test(teacher_number)) {
                swal({
                    title: "监考教师数量请填写整数！",
                    type: "info"
                });
                return;
            }
        }
        var roomVal = room_id.substring(0, 36);
        var roomVbl = room_id.substring(37, room_id.length);
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/exam/room/save", {
            examRoomId: $("#examRoomId").val(),
            roomType: room_type,
            roomId: roomVal,
            /*departmentsId:departmentsid,
            majorCode:majorData,
            trainingLevel:trainingLevel,
            classId:classid,*/
            examId: $("#examId").val(),
            roomName: roomVbl,
            studentNumber: $("#student_number").val(),
            teacherNumber: teacher_number,
            peopleNumber: $("#people_number").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "error"});
                $("#dialog").modal('hide');
                $('#roomTable').DataTable().ajax.reload();
            } else {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#roomTable').DataTable().ajax.reload();
            }
        })
    }
</script>


