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
    <form id="dataForm" method="post" enctype="multipart/form-data">
        <div class="modal-content block-fill-white">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <span style="font-size: 14px;">${head}&nbsp;</span>
                <input id="id" name="id" hidden value="${data.id}"/>
                <input name="majorCode" type="hidden"/>
                <input name="trainingLevel" type="hidden"/>
            </div>
            <div class="modal-body clearfix">
                <div class="controls">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>所属系部
                        </div>
                        <div class="col-md-9">
                            <select id="deptId" name="deptId" onchange="changeDeptId()"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>教师名称
                        </div>
                        <div class="col-md-9">
                            <select id="teacherId" name="teacherId"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>讲座名称
                        </div>
                        <div class="col-md-9">
                            <input id="lectureName" name="lectureName" value="${data.lectureName}"
                                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; " maxlength="36"
                                   placeholder="最多输入36个字"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>专业
                        </div>
                        <div class="col-md-9">
                            <select id="majorCode" onchange="changeMajorId()"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>班级
                        </div>
                        <div class="col-md-9">
                            <select id="classId" name="classId"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>人数
                        </div>
                        <div class="col-md-9">
                            <input id="studentNumber" name="studentNumber" type="number" value="${data.studentNumber}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>课时数
                        </div>
                        <div class="col-md-9">
                            <input id="classHours" name="classHours" type="number" value="${data.classHours}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>场地类型
                        </div>
                        <div class="col-md-9">
                            <select id="fieldType" name="fieldType" class="js-example-basic-single" onchange="changeFieldType()"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>所在楼宇
                        </div>
                        <div class="col-md-9">
                            <select id="abuildingId" name="abuildingId" class="js-example-basic-single" onchange="changeBuilding()">
                                <option>请选择场地类型</option></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>授课地点
                        </div>
                        <div class="col-md-9">
                            <%--<input id="place" name="place" value="${data.place}"--%>
                            <%--onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; " maxlength="36"--%>
                            <%--placeholder="最多输入36个字"/>--%>
                            <select id="place" name="place" class="js-example-basic-single">
                                <option>请选择所在楼宇</option></select>
                        </div>
                    </div>
                    <%--<div class="form-row">--%>
                        <%--<div class="col-md-3 tar">--%>
                            <%--<span class="iconBtx">*</span>授课地点--%>
                        <%--</div>--%>
                        <%--<div class="col-md-9">--%>
                            <%--<input id="place" name="place" value="${data.place}"--%>
                                   <%--onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; " maxlength="36"--%>
                                   <%--placeholder="最多输入36个字"/>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            附件上传
                        </div>
                        <div class="col-md-9">
                            <input type="button" name="file" value="点击修改" onclick="addFiles()"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            附件名称
                        </div>
                        <div class="col-md-9" >
                            <span>${filesName}</span>
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
    </form>
</div>

<script>
    $(document).ready(function () {
        var fieldType = ${data.fieldType};
        var buildingId = '${data.abuildingId}';
        if (fieldType == 1){
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " ID",
                    text: " BUILDING_NAME ",
                    tableName: "T_JW_BUILDING",
                    where: " where id in (select building_id from T_JW_MEETINGROOM)",
                    orderby: " order by create_time desc"
                },
                function (data) {
                    addOption(data, "abuildingId",'${data.abuildingId}');
                });
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " ID",
                    text: " MEETING_ROOM_NAME ",
                    tableName: "T_JW_MEETINGROOM",
                    where: " where BUILDING_ID ='" + buildingId +"' ",
                    orderby: " order by create_time desc"
                },
                function (data) {
                    addOption(data, "place",'${data.place}');
                });
        }else if (fieldType == 2) {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " ID",
                    text: " BUILDING_NAME ",
                    tableName: "T_JW_BUILDING",
                    where: " where id in (select building_id from T_JW_CLASSROOM)",
                    orderby: " order by create_time desc"
                },
                function (data) {
                    addOption(data, "abuildingId",'${data.abuildingId}');
                });
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " ID",
                    text: " CLASS_ROOM_NAME ",
                    tableName: "T_JW_CLASSROOM",
                    where: " where BUILDING_ID ='" + buildingId +"' ",
                    orderby: " order by create_time desc"
                },
                function (data) {
                    addOption(data, "place",'${data.place}');
                });
        }else {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " ID",
                    text: " BUILDING_NAME ",
                    tableName: "T_JW_BUILDING",
                    where: " where id in (select building_id from T_JW_DORM)",
                    orderby: " order by create_time desc"
                },
                function (data) {
                    addOption(data, "abuildingId",'${data.abuildingId}');
                });
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " ID",
                    text: " DORM_NAME ",
                    tableName: "T_JW_DORM",
                    where: " where BUILDING_ID ='" + buildingId +"' ",
                    orderby: " order by create_time desc"
                },
                function (data) {
                    addOption(data, "place",'${data.place}');
                });
        }
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=CDLX", function (data) {
            addOption(data, 'fieldType','${data.fieldType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'deptId', '${data.deptId}');
        });

        if ('${data.deptId}' != "") {
            var deptId = '${data.deptId}';
            $.get("<%=request.getContextPath()%>/textbook/getMajorByDeptId?deptId=" + deptId, function (data) {
                addOption(data, 'majorCode', '${data.majorCode},${data.trainingLevel}');
            });
        } else {
            $("#majorCode").append("<option value='' selected>请选择</option>")
        }
        if ('${data.teacherId}' != "") {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " t.person_id ",
                    text: " t.name ",
                    tableName: "  T_RS_EMPLOYEE t, T_RS_EMPLOYEE_DEPT c ",
                    where: "  WHERE t.person_id = c.PERSON_ID and c.dept_id = '${data.deptId}' ",
                    orderby: "   "
                },
                function (data) {
                    addOption(data, "teacherId",'${data.teacherId}');
                });
        } else {
            $("#teacherId").append("<option value='' selected>请选择</option>")
        }
        if ('${data.classId}' != "") {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " t.class_id ",
                    text: " t.class_name ",
                    tableName: "  t_xg_class t ",
                    where: "  WHERE t.major_code = '${data.majorCode}' ",
                    orderby: "   "
                },
                function (data) {
                    addOption(data, "classId",'${data.classId}');
                });
        } else {
            $("#classId").append("<option value='' selected>请选择</option>")
        }

    });

    function changeDeptId() {
        var deptId = $("#deptId").val();
        $.get("<%=request.getContextPath()%>/textbook/getMajorByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCode');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " t.person_id ",
                text: " t.name ",
                tableName: "  T_RS_EMPLOYEE t, T_RS_EMPLOYEE_DEPT c ",
                where: "  WHERE t.person_id = c.PERSON_ID and c.dept_id = "+deptId  ,
                orderby: "   "
            },
            function (data) {
                addOption(data, "teacherId");
            });
    }
    function changeMajorId() {
        var majorCodeList = $("#majorCode option:selected").val();
        var mCList = majorCodeList.split(",");
        var majorCode = mCList[0];
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " t.class_id ",
                text: " t.class_name ",
                tableName: "  t_xg_class t ",
                where: "  WHERE t.major_code = '"+majorCode+"'" ,
                orderby: "   "
            },
            function (data) {
                addOption(data, "classId");
            });
    }

    function changeFieldType() {
        $("#abuildingId").val(" ");
        $("#place").append("<option value='' selected>请选择所在楼宇</option>");
        var fieldType = $("#fieldType option:selected").val();
        if (fieldType == 1){
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " ID",
                    text: " BUILDING_NAME ",
                    tableName: "T_JW_BUILDING",
                    where: " where id in (select building_id from T_JW_MEETINGROOM)",
                    orderby: " order by create_time desc"
                },
                function (data) {
                    addOption(data, "abuildingId");
                });
        }else if (fieldType == 2) {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " ID",
                    text: " BUILDING_NAME ",
                    tableName: "T_JW_BUILDING",
                    where: " where id in (select building_id from T_JW_CLASSROOM)",
                    orderby: " order by create_time desc"
                },
                function (data) {
                    addOption(data, "abuildingId");
                });
        }else if (fieldType == 3) {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " ID",
                    text: " BUILDING_NAME ",
                    tableName: "T_JW_BUILDING",
                    where: " where id in (select building_id from T_JW_DORM)",
                    orderby: " order by create_time desc"
                },
                function (data) {
                    addOption(data, "abuildingId");
                });
        }else {
            $("#abuildingId").append("<option value='' selected>请选择场地类型</option>")
        }
    }

    function changeBuilding() {
        var fieldType = $("#fieldType option:selected").val();
        var buildingId = $("#abuildingId option:selected").val();
        if (fieldType == 1){
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " ID",
                    text: " MEETING_ROOM_NAME ",
                    tableName: "T_JW_MEETINGROOM",
                    where: " where BUILDING_ID ='" + buildingId +"' ",
                    orderby: " order by create_time desc"
                },
                function (data) {
                    addOption(data, "place",'${data.place}');
                });
        }else if (fieldType == 2) {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " ID",
                    text: " CLASS_ROOM_NAME ",
                    tableName: "T_JW_CLASSROOM",
                    where: " where BUILDING_ID ='" + buildingId +"' ",
                    orderby: " order by create_time desc"
                },
                function (data) {
                    addOption(data, "place",'${data.place}');
                });
        }else if (fieldType == 3) {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " ID",
                    text: " DORM_NAME ",
                    tableName: "T_JW_DORM",
                    where: " where BUILDING_ID ='" + buildingId +"' ",
                    orderby: " order by create_time desc"
                },
                function (data) {
                    addOption(data, "place",'${data.place}');
                });
        }else {
            $("#place").append("<option value='' selected>请选择所在楼宇</option>")
        }
    }

    function save() {
        var id = $("#id").val();
        var teacherId = $("#teacherId option:selected").val();
        var deptId = $("#deptId option:selected").val();
        var lectureName = $("#lectureName").val();
        var majorCodeList = $("#majorCode option:selected").val();
        var mCList = majorCodeList.split(",");
        var majorCode = mCList[0];
        var trainingLevel=mCList[1];
        var classId = $("#classId option:selected").val();
        var studentNumber = $("#studentNumber").val();
        var classHours = $("#classHours").val();
        var place = $("#place").val();

        $("input[name=majorCode]").val(majorCode);
        $("input[name=trainingLevel]").val(trainingLevel);

        if (teacherId == "" || teacherId == undefined || teacherId == null) {
            swal({
                title: "请选择教师！",
                type: "info"
            });
            return;
        }
        if (deptId == "" || deptId == undefined || deptId == null) {
            swal({
                title: "请选择所属系部！",
                type: "info"
            });
            return;
        }
        if (lectureName == "" || lectureName == undefined || lectureName == null) {
            swal({
                title: "请填写讲座名称！",
                type: "info"
            });
            return;
        }
        if (majorCode == "" || majorCode == undefined || majorCode == null) {
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if (classId == "" || classId == undefined || classId == null) {
            swal({
                title: "请选择班级！",
                type: "info"
            });
            return;
        }
        if (studentNumber == "" || studentNumber == undefined || studentNumber == null) {
            swal({
                title: "请填写人数！",
                type: "info"
            });
            return;
        }
        if (classHours == "" || classHours == undefined || classHours == null) {
            swal({
                title: "请填写课时数！",
                type: "info"
            });
            return;
        }
        if (place == "" || place == undefined || place == null) {
            swal({
                title: "请填写授课地点！",
                type: "info"
            });
            return;
        }

        var from = new FormData(document.getElementById("dataForm"));
        $.ajax({
            type: "post",
            url: "<%=request.getContextPath()%>/lecture/updateLecture",
            processData: false,  //tell jQuery not to process the data
            contentType: false,  //tell jQuery not to set contentType
            data: from,
            success: function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $("#dialog").modal('hide');
                    $('#table').DataTable().ajax.reload();
                });
            }
        });
    }
    function addFiles() {
        var id=$("#id").val();
        $("#dialogFile").load("<%=request.getContextPath()%>/files/filesUpload?businessId="+id+"&businessType=TEST&tableName=T_JW_LECTURE");
        $("#dialogFile").modal("show");
    }
</script>



