<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:29
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
<input type="hidden" id="scoreChangeid" value="${scoreChange.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="f_requester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" value="${scoreChange.requestDate}" readonly="readonly" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        系部
    </div>
    <div class="col-md-9">
        <select id="f_departmentsId" disabled
                class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        专业
    </div>
    <div class="col-md-9">
        <select id="f_majorCode" disabled="disabled" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        班级
    </div>
    <div class="col-md-9">
        <select id="f_classId" disabled="disabled" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学生姓名
    </div>
    <div class="col-md-9">
        <select id="f_studentId" disabled="disabled" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学号
    </div>
    <div class="col-md-9">
        <input id="f_studentNumber" type="text" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.studentNumber}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        科目
    </div>
    <div class="col-md-9">
        <select id="f_courseId" disabled="disabled" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学期
    </div>
    <div class="col-md-9">
        <select id="f_term" disabled="disabled" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        原成绩
    </div>
    <div class="col-md-9">
        <input id="f_originalScore" type="type" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.originalScore}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        考试状态
    </div>
    <div class="col-md-9">
        <SELECT id="f_examinationStatus" onchange="examinationStatusChange(value)"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        更改后成绩
    </div>
    <div class="col-md-9">
        <div id="appendScore">
            <%--<div class="col-md-9">
                <input id="f_score" type="text" class="validate[required,maxSize[100]] form-control"
                       value="${scoreChange.score}" />
            </div>--%>
        </div>

    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        变更原因
    </div>
    <div class="col-md-9">
        <input id="f_reason" type="type" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.reason}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        变更时间
    </div>
    <div class="col-md-9">
        <input id="f_time" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.time}"/>
    </div>
</div>

<input id="workflowCode" hidden value="T_JW_SCORE_CHANGE_WF01">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/scoreChange/printScoreChange?id=${scoreChange.id}">


<script>

    var kszt = new Array();
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        <%--$.get("<%=request.getContextPath()%>/common/getSysDict?name=CJZT", function (data) {--%>
        <%--addOption(data, 'f_scoreType','${scoreChange.scoreType}');--%>
        <%--});--%>
        <%--如果是期末考试则--%>
        if ('${scoreChange.examTypes}' == "1") {
            if ('${scoreChange.examTypes}' == "2") {
                $("#appendScore").html("<div class='col-md-9'><select id='examinationResults' class='validate[required,maxSize[100]] form-control'/></div>");
                $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCCJ", function (data) {
                    addOption(data, 'examinationResults', '${scoreChange.examinationResults}');
                });
                $.get("<%=request.getContextPath()%>/common/getSysDict?name=KSZT", function (data) {
                    kszt = data;
                    examinationStatusChange('${scoreChange.examinationStatus}');
                    addOption(data, 'f_examinationStatus', '${scoreChange.examinationStatus}');
                });
            } else {
                $("#appendScore").html(" <div class=\"col-md-9\">\n" +
                    "                            <input id=\"f_score\" type=\"text\" class=\"validate[required,maxSize[100]] form-control\"\n" +
                    "                                   value=\"${scoreChange.score}\" />\n" +
                    "                        </div>");
                $.get("<%=request.getContextPath()%>/common/getSysDict?name=KSZT", function (data) {
                    kszt = data;
                    examinationStatusChange('${scoreChange.examinationStatus}');
                    addOption(data, 'f_examinationStatus', '${scoreChange.examinationStatus}');
                });
            }

        } else {
            $("#appendScore").html("<div class='col-md-9'><select id='makeUpScore' class='validate[required,maxSize[100]] form-control'/></div>");
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=BYQBKCJ", function (data) {
                addOption(data, 'makeUpScore', '${scoreChange.scoreType}');
            });

            $.get("<%=request.getContextPath()%>/common/getSysDict?name=BKZT", function (data) {
                kszt = data;
                examinationStatusChange('${scoreChange.examinationStatus}');
                addOption(data, 'f_examinationStatus', '${scoreChange.examinationStatus}');
            });
        }
//系统字典项
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " "
            },
            function (data) {
                addOption(data, "f_departmentsId", '${scoreChange.departmentsId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " major_code",
                text: " major_name",
                tableName: "t_xg_major",
                where: "  ",
                orderby: " "
            },
            function (data) {
                addOption(data, "f_majorCode", '${scoreChange.majorCode}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " CLASS_ID",
                text: "CLASS_NAME",
                tableName: "T_XG_CLASS",
                where: "  ",
                orderby: " "
            },
            function (data) {
                addOption(data, "f_classId", '${scoreChange.classId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " COURSE_ID",
                text: " COURSE_NAME ",
                tableName: "T_JW_COURSE",
                where: "  ",
                orderby: " "
            },
            function (data) {
                addOption(data, "f_courseId", '${scoreChange.courseId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " STUDENT_ID",
                text: " NAME ",
                tableName: "T_XG_STUDENT",
                where: "  ",
                orderby: " "
            },
            function (data) {
                addOption(data, "f_studentId", '${scoreChange.studentId}');
            });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'f_term', '${scoreChange.term}');
        });
    })

    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        var time = $("#f_time").val();
        time = time.replace('T', '');
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_examinationStatus").val() == "" || $("#f_examinationStatus").val() == undefined) {
            swal({
                title: "请选择考试状态!",
                type: "info"
            });
            return;
        }
        if ("1" == '${scoreChange.examTypes}') {
            if ("2" == '${examMethod}') {
                if ($("#examinationResults").val() == "" || $("#examinationResults").val() == undefined) {
                    swal({
                        title: "请填写更改后成绩!",
                        type: "info"
                    });
                    return;
                }
            } else {
                if ($("#f_score").val() == "" || $("#f_score").val() == undefined) {
                    swal({
                        title: "请填写更改后成绩!",
                        type: "info"
                    });
                    return;
                }
            }
        } else {
            if ($("#makeUpScore").val() == "" || $("#makeUpScore").val() == undefined) {
                swal({title: "请填写补考成绩", type: "info"});
                return;
            }
            $("#f_score").val($("#makeUpScore option:selected").text())
        }
        if ($("#f_examinationStatus").val() == "1" && ("1" == '${scoreChange.examTypes}')) {
            if ("2" == '${examMethod}') {
            } else {
                if (!reg.test($("#f_score").val())) {
                    swal({title: "成绩请填写整数！", type: "info"});
                    return;
                }
                if (parseInt($("#f_score").val()) > 100) {
                    swal({title: "成绩请填写100以下的整数！", type: "info"});
                    return;
                }
                if (parseInt($("#f_score").val()) < 0) {
                    swal({title: "成绩请填写0以上的整数！", type: "info"});
                    return;
                }
            }
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            swal({
                title: "请填写变更原因!",
                type: "info"
            });
            return;
        }
        if ($("#f_time").val() == "" || $("#f_time").val() == "0") {
            swal({
                title: "请填写变更时间!",
                type: "info"
            });
            return;
        }
        if ($("#examinationResults").val() == "" || $("#examinationResults").val() == undefined) {

        } else {
            $("#f_score").val($("#examinationResults option:selected").text())
        }
        $.post("<%=request.getContextPath()%>/scoreChange/saveScoreChange", {
            id: $("#scoreChangeid").val(),
            examinationStatus: $("#f_examinationStatus").val(),
            scoreId: $("#scoreid").val(),
            requestDate: date,
            time: time,
            examinationResults: $("#examinationResults").val(),
            makeupScore: $("#makeUpScore").val(),
            departmentsId: $("#f_departmentsId").val(),
            majorCode: $("#f_majorCode").val(),
            classId: $("#f_classId").val(),
            studentId: $("#f_studentId").val(),
            studentNumber: $("#f_studentNumber").val(),
            courseId: $("#f_courseId").val(),
            term: $("#f_term").val(),
            originalScore: $("#f_originalScore").val(),
            score: $("#f_score").val(),
            reason: $("#f_reason").val(),
        }, function (msg) {
            if (msg.status == 1) {
                $("#dialog").modal('hide');
                $('#scoreChangeGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }

    function examinationStatusChange(values) {
        if ('${scoreChange.examTypes}' == "1") {
            if ("1" != values) {
                for (var i = 0; i < kszt.length; i++) {
                    if (kszt[i].id == values) {
                        $("#f_score").val(kszt[i].text);
                        $('#f_score').attr("readonly", "readonly");
                    }
                }
            } else {
                if (parseInt($('#f_score').val()) < 101) {
                    $('#f_score').removeAttr("readonly");
                } else {
                    $('#f_score').val("");
                    $('#f_score').removeAttr("readonly");
                }

            }
        } else {
            if ("1" != values) {
                $("#f_score").val("");
                $('#f_score').removeAttr("disabled");
                $("#f_score").val("2");
                $('#f_score').attr("disabled", "disabled");
            } else {
                $('#f_score').removeAttr("disabled");
            }
        }
    }

</script>

