<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/11
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
            <input id="leaveid" hidden value="${leave.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                         学籍号
                    </div>
                    <div class="col-md-9">
                        <input id="studentNumber" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${leave.studentNumber}" readonly="readonly"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        系部
                    </div>
                    <div class="col-md-9">
                        <input id="departmentsId" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${leave.departmentsId}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <input id="majorCode" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${leave.majorCode}" readonly="readonly"/>
                    </div>
                </div>
                <%--<div class="form-row">
                    <div class="col-md-3 tar">
                        培养层次
                    </div>
                    <div class="col-md-9">
                        <select readonly id="trainingLevelId" type="text"  disabled="disabled"  class="validate[required,maxSize[100]] form-control" ></select>
                    </div>
                </div>--%>
                    <div class="form-row">
                    <div class="col-md-3 tar">
                        班级名称
                    </div>
                        <div class="col-md-9">
                            <input id="classId" type="text" class="validate[required,maxSize[100]] form-control"
                                   value="${leave.classId}" readonly="readonly"/>
                        </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学生姓名
                    </div>
                    <div class="col-md-9">
                        <input id="studentName" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${leave.studentName}" readonly="readonly"/>
                    </div>
                </div>
                    <div class="form-row">
                    <div class="col-md-3 tar">
                        性别
                    </div>
                        <div class="col-md-9">
                            <input id="sex" type="text" class="validate[required,maxSize[100]] form-control"
                                   value="${leave.sex}" readonly="readonly"/>
                        </div>
                </div>
                <div class="form-row" hidden>

                    <div class="col-md-9">
                        <input id="studentId" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${leave.studentId}" readonly="readonly"/>
                    </div>
                </div>



                <div class="form-row">
                    <div class="col-md-3 tar">
                        代申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="dept" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${leave.requestDept}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        代申请人
                    </div>
                    <div class="col-md-9">
                        <input id="jbr" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${leave.requester}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDate" type="datetime-local" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${leave.requestDate}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        请假开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_startTime" type="date" onchange="changeRequestDays()"
                               value="${leave.startTime}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        请假结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_endTime" type="date" onchange="shijian();changeRequestDays()"
                               value="${leave.endTime}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        请假天数
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDays" value="${leave.requestDays}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        假条类型
                    </div>
                    <div class="col-md-9">
                        <select id="leaveTypeId"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        请假原因
                    </div>
                    <div class="col-md-9">
                        <textarea id="f_reason" maxlength="300" placeholder="最多输入300个字" style="resize:none;">${leave.reason}</textarea>
                    </div>

                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>



<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    function shijian() {
        if ($("#f_startTime").val() > $("#f_endTime").val()) {
            swal({
                title: "请选择请假开始时间需要在请假结束时间之前!",
                type: "info"
            });
            //alert("请选择请假开始时间需要在请假结束时间之前！");
            $("#f_endTime").val("");
            return;
        }

    }

    function changeRequestDays() {
        var start = new Date($("#f_startTime").val().substring(0, 10)).getTime();
        var end = new Date($("#f_endTime").val().substring(0, 10)).getTime();
        if (end >= start) {
            var cha = (end - start) / 60 / 60 / 24 / 1000;
            $("#f_requestDays").val(cha + 1);
        }
    }

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JTLX", function (data) {
            addOption(data, 'leaveTypeId', '${leave.leaveType}');
        });

    })
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");



    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " "
            },
            function (data) {
                addOption(data, "departmentsId", '${leave.departmentsId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " major_code",
                text: " major_name ",
                tableName: "t_xg_major"
            },
            function (data) {
                addOption(data, "majorCodeId",'${leave.majorCode}' );
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " student_id",
                text: " name ",
                tableName: "t_xg_student"
            },
            function (data) {
                addOption(data, "studentId", '${leave.studentId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " class_id",
                text: " class_name ",
                tableName: "t_xg_class"
            },
            function (data) {
                addOption(data, "classIdId", '${leave.classId}');
            });


        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data,'sex', '${leave.sex}');
        });





    })

    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        var startTime = $("#f_startTime").val();
        startTime = startTime.replace('T', '');
        var endTime = $("#f_endTime").val();
        endTime = endTime.replace('T', '');
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0") {
            swal({
                title: "请填写申请时间",
                type: "info"
            });
            //alert("请填写申请时间");
            return;
        }
        if ($("#f_startTime").val() == "" || $("#f_startTime").val() == "0") {
            swal({
                title: "请填写请假开始时间",
                type: "info"
            });
            //alert("请填写请假开始时间");
            return;
        }
        if ($("#f_endTime").val() == "" || $("#f_endTime").val() == "0") {
            swal({
                title: "请填写请假结束时间",
                type: "info"
            });
            //alert("请填写请假结束时间");
            return;
        }
        if ($("#f_startTime").val() > $("#f_endTime").val()) {
            swal({
                title: "请选择请假开始时间需要在请假结束时间之前",
                type: "info"
            });
            //alert("请选择请假开始时间需要在请假结束时间之前！");
            return;
        }
        if ($("#leaveTypeId").val() == "" || $("#leaveTypeId").val() == "0" || $("#leaveTypeId").val() == undefined) {
            swal({
                title: "请填写请假类型",
                type: "info"
            });
            //alert("请填写请假类型");
            return;
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            swal({
                title: "请填写请假原因",
                type: "info"
            });
            //alert("请填写请假原因");
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/studentLeave/saveStudentLeave", {
            id: $("#leaveid").val(),
            requestDate: date,
            startTime: startTime,
            endTime: endTime,
            requestDays: $("#f_requestDays").val(),
            leaveType: $("#leaveTypeId option:selected").val(),
            reason: $("#f_reason").val(),
            studentId:$("#studentId option:selected").val(),
            classId: $("#classIdId option:selected").val(),
            sex: $("#sex option:selected").val(),
            departmentsId: $("#departmentsId option:selected").val(),
            majorCode: $("#majorCodeId option:selected").val(),
            studentNumber: $("#studentNumber").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
               // alert(msg.msg);
                $("#dialog").modal('hide');
                $('#leaveGrid').DataTable().ajax.reload();
            }
        })
    }




</script>

