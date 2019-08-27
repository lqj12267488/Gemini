<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:19
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea{
            resize:none;
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
            <%--<input id="scoreChangeid" name="scoreChangeid" type="hidden" value="${scoreChange.id}">--%>
            <input id="id" type="hidden" value="${otherExamination.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >

                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--<span class="iconBtx">*</span>--%>
                        <%--申请部门--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<input id="f_requestDept" type="text" readonly="readonly"--%>
                               <%--class="validate[required,maxSize[100]] form-control"--%>
                               <%--value="${otherExamination.requestDept}"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--<span class="iconBtx">*</span>--%>
                        <%--申请人--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<input id="f_requester" type="text" readonly="readonly"--%>
                               <%--class="validate[required,maxSize[100]] form-control"--%>
                               <%--value="${scoreChange.requester}"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--<span class="iconBtx">*</span>--%>
                        <%--申请日期--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<input id="f_requestDate" value="${scoreChange.requestDate}" readonly="readonly" type="datetime-local" class="validate[required,maxSize[100]] form-control"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        系部
                    </div>
                    <div class="col-md-9">
                        <select  id="f_departmentsId" disabled
                                 class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <select  id="f_majorCode" disabled="disabled"  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        班级
                    </div>
                    <div class="col-md-9">
                        <select  id="f_classId" disabled="disabled"  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学生姓名
                    </div>
                    <div class="col-md-9">
                        <input  id="f_studentId" disabled="disabled"  class="validate[required,maxSize[100]] form-control" value="${otherExamination.name}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学号
                    </div>
                    <div class="col-md-9">
                        <input id="f_studentNumber" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${otherExamination.studentNumber}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        科目
                    </div>
                    <div class="col-md-9">
                        <select  id="f_courseId" disabled="disabled"  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学期
                    </div>
                    <div class="col-md-9">
                        <select  id="f_term" disabled="disabled"  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        成绩
                    </div>
                    <div class="col-md-9">
                        <input id="f_originalScore" type="type" class="validate[required,maxSize[100]] form-control"
                               value="${otherExamination.score}"/>
                    </div>
                </div>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--更改后成绩--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<input id="f_score" type="text" class="validate[required,maxSize[100]] form-control"--%>
                               <%--value="${scoreChange.score}" />--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--变更原因--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<input id="f_reason" type="type" class="validate[required,maxSize[100]] form-control"--%>
                               <%--value="${scoreChange.reason}" />--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--变更时间--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<input id="f_time" type="datetime-local" class="validate[required,maxSize[100]] form-control"--%>
                               <%--value="${scoreChange.time}" />--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--成绩状态--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<SELECT id="f_scoreType" />--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--考试状态--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<SELECT id="f_examinationStatus" />--%>
                    <%--</div>--%>
                <%--</div>--%>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveScoreChange()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function (){
        <%--$.get("<%=request.getContextPath()%>/common/getSysDict?name=CJZT", function (data) {--%>
            <%--addOption(data, 'f_scoreType','${otherExamination.scoreType}');--%>
        <%--});--%>
        <%--$.get("<%=request.getContextPath()%>/common/getSysDict?name=KSZT", function (data) {--%>
            <%--addOption(data, 'f_examinationStatus','${scoreChange.examinationStatus}');--%>
        <%--});--%>
//系统字典项
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " "
            },
            function (data) {
                addOption(data, "f_departmentsId",'${otherExamination.departmentsId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " major_code",
                text: " major_name",
                tableName: "t_xg_major",
                where: "  ",
                orderby: " "
            },
            function (data) {
                addOption(data, "f_majorCode",'${otherExamination.majorCode}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " CLASS_ID",
                text: "CLASS_NAME",
                tableName: "T_XG_CLASS",
                where: "  ",
                orderby: " "
            },
            function (data) {
                addOption(data, "f_classId",'${otherExamination.classId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " COURSE_ID",
                text: " COURSE_NAME ",
                tableName: "T_JW_COURSE",
                where: "  ",
                orderby: " "
            },
            function (data) {
                addOption(data, "f_courseId",'${otherExamination.courseId}');
            });
        <%--$.get("<%=request.getContextPath()%>/common/getTableDict", {--%>
                <%--id: " STUDENT_ID",--%>
                <%--text: " NAME ",--%>
                <%--tableName: "T_XG_STUDENT",--%>
                <%--where: "  ",--%>
                <%--orderby: " "--%>
            <%--},--%>
            <%--function (data) {--%>
                <%--addOption(data, "f_studentId",'${scoreChange.studentId}');--%>
            <%--});--%>
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'f_term','${otherExamination.termId}');
        });
    })
    function saveScoreChange() {
        var score = $("#f_originalScore").val();
        // date = date.replace('T','');
        // var time = $("#f_time").val();
        // time = time.replace('T','');
        // var reg = new RegExp("^[0-9]*$");
        if ($("#f_originalScore").val() == "" || $("#f_originalScore").val() == "0" || $("#f_originalScore").val() == undefined) {
            swal({
                title: "请填写成绩!",
                type: "info"
            });
            return;
        }
        // if(!reg.test($("#f_score").val())){
        //     swal({title: "成绩请填写整数！",type: "info"});
        //     return;
        // }
        // if($("#f_score").val()>100) {
        //     swal({title: "成绩请填写100以下的整数！",type: "info"});
        //     return;
        // }
        // if($("#f_score").val()<0){
        //     swal({title: "成绩请填写0以上的整数！",type: "info"});
        //     return;
        // }
        // if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
        //     swal({
        //         title: "请填写变更原因!",
        //         type: "info"
        //     });
        //     return;
        // }
        // if ($("#f_time").val() == "" || $("#f_time").val() == "0") {
        //     swal({
        //         title: "请填写变更时间!",
        //         type: "info"
        //     });
        //     return;
        // }
        //
        // if ($("#f_scoreType").val() == ""|| $("#f_scoreType").val() == null || $("#f_scoreType").val() == undefined) {
        //     swal({
        //         title: "请选择成绩状态!",
        //         type: "info"
        //     });
        //     return;
        // }
        // if ($("#f_examinationStatus").val() == ""|| $("#f_examinationStatus").val() == null || $("#f_examinationStatus").val() == undefined) {
        //     swal({
        //         title: "请选择成绩状态!",
        //         type: "info"
        //     });
        //     return;
        // }
        $.post("<%=request.getContextPath()%>/otherExamination/saveOtherExaminationImport", {
            id: $("#id").val(),
            score:score,
            // examinationStatus:$("#f_examinationStatus").val(),
            // scoreId:$("#scoreid").val(),
            // requestDate: date,
            // time:time,
            // departmentsId:$("#f_departmentsId").val(),
            // majorCode:$("#f_majorCode").val(),
            // classId:$("#f_classId").val(),
            // studentId:$("#f_studentId").val(),
            // studentNumber:$("#f_studentNumber").val(),
            // courseId:$("#f_courseId").val(),
            // term:$("#f_term").val(),
            // originalScore:$("#f_originalScore").val(),
            // score:$("#f_score").val(),
            // reason:$("#f_reason").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 0 ) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#listGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>


