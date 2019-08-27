<%--
  Created by IntelliJ IDEA.
  User: go
  Date: 2019/6/19
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
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
            <span style="font-size: 14px">${head}</span>
            <input id="id" name="id" type="hidden" value="${rescheduleCourse.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学院：
                    </div>
                    <div class="col-md-9">
                        <select id="majorSchool"
                                class="validate[required,maxSize[100]] form-control"
                                disabled="disabled"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>系部：
                    </div>
                    <div class="col-md-9">
                        <select id="deptShow"
                                onchange="changeDept()" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专业：
                    </div>
                    <div class="col-md-9">
                        <select id="majorShow" onchange="changeMajor()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>班级：
                    </div>
                    <div class="col-md-9">
                        <select id="classShow" onchange="changeClass()" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程：
                    </div>
                    <div class="col-md-9">
                        <select id="courseShow"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>原定周次：
                    </div>
                    <div class="col-md-9">
                        <select id="oringalWeek"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 原定上课日期
                    </div>
                    <div class="col-md-9">
                        <input id="oringalDate" type="date"
                               value="${rescheduleCourse.oringalDate}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>原定上课星期：
                    </div>
                    <div class="col-md-9">
                        <select id="oringalWeekday"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>原定上课节次：
                    </div>
                    <div class="col-md-9">
                        <input id="oringalClassTime" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.oringalClassTime}" placeholder="1-2或者1-4"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>改调上课周次：
                    </div>
                    <div class="col-md-9">
                        <select id="rescheduleWeek"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 改调上课日期
                    </div>
                    <div class="col-md-9">
                        <input id="rescheduleDate" type="date" onchange="changeRequestDays()"
                               value="${rescheduleCourse.rescheduleDate}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>改调上课星期：
                    </div>
                    <div class="col-md-9">
                        <select id="rescheduleWeekday"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>改调上课节次：
                    </div>
                    <div class="col-md-9">
                        <input id="rescheduleClassTime" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.rescheduleClassTime}" placeholder="1-2或者1-4"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请人:
                    </div>
                    <div class="col-md-9">
                        <input id="applicantPersonId" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.applicantPersonId}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  申请理由
                    </div>
                    <div class="col-md-9">
                            <textarea id="applicantReason"
                                      class="validate[required,maxSize[100]] form-control">${rescheduleCourse.applicantReason}</textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 申请时间
                    </div>
                    <div class="col-md-9">
                        <input id="applicantDate" type="date"
                               class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.applicantDate}" disabled/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script>

    $(function () {
        var ad =  '${rescheduleCourse.applicantDate}'
        var time = new Date()
        var month = time.getMonth()+1;
        if (month<10){
            month = "0"+month;
        }
        var day = time.getDate()
        if (day<10){
            day = "0"+day
        }
        var now = time.getFullYear()+"-"+month+"-"+day
        if (undefined == ad || "" == ad) {
            $("#applicantDate").val(now);
        }
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XY", function (data) {
            addOption(data,'majorSchool','${rescheduleCourse.majorSchool}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZC", function (data) {
            addOption(data, 'oringalWeek', '${rescheduleCourse.oringalWeek}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQZ", function (data) {
            addOption(data, 'rescheduleWeekday', '${rescheduleCourse.rescheduleWeekday}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQZ", function (data) {
            addOption(data, 'oringalWeekday', '${rescheduleCourse.oringalWeekday}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZC", function (data) {
            addOption(data, 'rescheduleWeek', '${rescheduleCourse.rescheduleWeek}');
        });


        $.get("<%=request.getContextPath()%>/common/getDistinctTableDict",
                {
                    id: "t.department",
                    text:"FUNC_GET_TABLEVALUE(department, 'T_SYS_DEPT', 'dept_id', 'dept_name')",
                    tableName: "T_JW_TEACHINGTASK t,T_SYS_PARAMETER p",
                    where: "where teacher_id = '"+ '${rescheduleCourse.creator}'+"' and p.code = 'DQXQ' and p.value = t.semester"
                },
                function (data) {
                    console.log("data",data);
                    addOption(data,'deptShow','${rescheduleCourse.deptId}');
                });

        $.get("<%=request.getContextPath()%>/common/getTableDict",
            {
                id: " t.MAJOR_CODE",
                text: " t.MAJOR_NAME ",
                tableName: "T_XG_MAJOR t",
                where: "WHERE DEPARTMENTS_ID = '"+'${rescheduleCourse.deptId}'+"'"
            },
            function (data) {
                addOption(data, 'majorShow', '${rescheduleCourse.majorCode}');
            });

        $.get("<%=request.getContextPath()%>/common/getTableDict",
            {
                id: " t.CLASS_ID",
                text: " t.CLASS_NAME ",
                tableName: "T_XG_CLASS t",
                where: "WHERE MAJOR_CODE = '"+'${rescheduleCourse.majorCode}'+"'"
            },
            function (data) {
                addOption(data, 'classShow', '${rescheduleCourse.classId}');
            });

        $.get("<%=request.getContextPath()%>/common/getTableDict",
            {
                id: "t.course_id",
                text:"FUNC_GET_TABLEVALUE(course_id,'T_JW_COURSE','course_id', 'course_name')",
                tableName: "T_JW_TEACHINGTASK t,T_SYS_PARAMETER p",
                where: "where teacher_id = '"+ '${rescheduleCourse.creator}'+"' and p.code = 'DQXQ' and p.value = t.semester " +
                    " and t.class_info= '"+'${rescheduleCourse.classId}'+"'ORDER BY t.create_time DESC"
            },
            function (data) {
                console.log("data",data);
                addOption(data,'courseShow','${rescheduleCourse.courseId}');
            });


    })



    function changeDept() {
        var deptId = $("#deptShow").val();

        $.get("<%=request.getContextPath()%>/common/getTableDict",
            {
                id: " t.MAJOR_CODE",
                text: " t.MAJOR_NAME ",
                tableName: "T_XG_MAJOR t",
                where: "WHERE DEPARTMENTS_ID = '"+deptId +"'"
            },
            function (data) {
            addOption(data, 'majorShow', '${rescheduleCourse.majorCode}');
        });
    }

    function changeMajor() {
        var majorCode = $("#majorShow").val();
        $.get("<%=request.getContextPath()%>/common/getTableDict",
            {
                id: " t.CLASS_ID",
                text: " t.CLASS_NAME ",
                tableName: "T_XG_CLASS t",
                where: "WHERE MAJOR_CODE = '"+majorCode +"'"
            },
            function (data) {
            addOption(data, 'classShow', '${rescheduleCourse.classId}');
        });
    }
    function changeClass() {
        var classId = $("#classShow").val();
        console.log("classId",classId);
        $.get("<%=request.getContextPath()%>/common/getTableDict",
            {
                id: "t.course_id",
                text:"FUNC_GET_TABLEVALUE(course_id,'T_JW_COURSE','course_id', 'course_name')",
                tableName: "T_JW_TEACHINGTASK t,T_SYS_PARAMETER p",
                where: "where teacher_id = '"+ '${rescheduleCourse.creator}'+"' and p.code = 'DQXQ' and p.value = t.semester " +
                    " and t.class_info= '"+classId+"'ORDER BY t.create_time DESC"
            },
            function (data) {
                console.log("data",data);
                addOption(data,'courseShow');
            });
    }
    function save() {
        if ($("#majorShow").val() == "" || $("#majorShow").val() == undefined || $("#majorShow").val() == "0" ){
            swal({
                title: "请选择专业",
                type: "info"
            });
            return;
        }
        if ($("#classShow").val() == "" || $("#classShow").val() == undefined || $("#classShow").val() == "0" ){
            swal({
                title: "请选择班级",
                type: "info"
            });
            return;
        }

        if ($("#courseShow").val() == "" || $("#courseShow").val() == undefined || $("#courseShow").val()== "0" ){
            swal({
                title: "请选择课程",
                type: "info"
            });
            return;
        }

        if ($("#oringalWeek").val() == "" || $("#oringalWeek").val() == undefined || $("#oringalWeek").val()== "0" ){
            swal({
                title: "请选择原定上课周次",
                type: "info"
            });
            return;
        }

        if ($("#oringalDate").val() == "" || $("#oringalDate").val() == undefined || $("#oringalDate").val()== "0" ){
            swal({
                title: "请填写原定上课日期",
                type: "info"
            });
            return;
        }

        if ($("#oringalWeekday").val() == "" || $("#oringalWeekday").val() == undefined ||$("#oringalWeekday").val()== "0" ){
            swal({
                title: "请选择原定上课星期",
                type: "info"
            });
            return;
        }


        if ( $("#oringalClassTime").val() == "" ||  $("#oringalClassTime").val() == undefined  ){
            swal({
                title: "请填写原定上课节次",
                type: "info"
            });
            return;
        }



        if ( $("#rescheduleWeek").val() == "" || $("#rescheduleWeek").val()  == undefined ||$("#rescheduleWeek").val()== "0"){
            swal({
                title: "请选择改调上课周次",
                type: "info"
            });
            return;
        }

        if ( $("#rescheduleDate").val()== "" ||  $("#rescheduleDate").val()  == undefined || $("#rescheduleDate").val()== "0"){
            swal({
                title: "请填写改调上课日期",
                type: "info"
            });
            return;
        }

        if ( $("#rescheduleWeekday").val()== "" ||  $("#rescheduleWeekday").val()  == undefined || $("#rescheduleWeekday").val()== "0"){
            swal({
                title: "请填写改调上课星期",
                type: "info"
            });
            return;
        }

        if ( $("#rescheduleClassTime").val()== "" ||   $("#rescheduleClassTime").val()  == undefined || $("#rescheduleClassTime").val()== "0"){
            swal({
                title: "请填写改调上课节次",
                type: "info"
            });
            return;
        }

        if ($("#applicantReason").val()=="" ||$("#applicantReason").val()== undefined ){
            swal({
                title: "请填写申请理由",
                type: "info"
            });
            return;
        }

        if ( $("#applicantDate").val()== "" ||  $("#applicantDate").val()  == undefined || $("#applicantDate").val() =='0'){
            swal({
                title: "请填写申请日期",
                type: "info"
            });
            return;
        }
        
        
        $.post("<%=request.getContextPath()%>/rescheduleCourse/saveRescheduleCourse", {
            id:$("#id").val(),
            majorSchool:$("#majorSchool").val(),
            deptId:$("#deptShow").val(),
            majorCode: $("#majorShow").val(),
            classId: $("#classShow").val(),
            courseId: $("#courseShow").val(),
            oringalDate:  $("#oringalDate").val(),
            oringalWeekday:$("#oringalWeekday").val(),
            oringalClassTime: $("#oringalClassTime").val(),
            oringalWeek: $("#oringalWeek").val(),
            // oringalTeacher:$("#oringalTeacher").val(),
            rescheduleDate : $("#rescheduleDate").val(),
            rescheduleWeekday :$("#rescheduleWeekday").val(),
            rescheduleClassTime: $("#rescheduleClassTime").val(),
            // rescheduleTeacher:$("#rescheduleTeacher").val(),
            rescheduleWeek: $("#rescheduleWeek").val(),
            applicantPersonId : $("#applicantPersonId").val(),
            applicantDate : $("#applicantDate").val(),
            applicantReason:$("#applicantReason").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#rescheduleGrid').DataTable().ajax.reload();
            }
        })
    }
</script>
