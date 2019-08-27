<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/16
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <header class="mui-bar mui-bar-nav">
                            <h5 class="mui-title">${scoreExamName} > 学生名单</h5>
                        </header>
                        <div class="form-row">
                            <div class="form-row">
                                <div class="col-md-10" style="overflow: hidden;  margin-bottom: 10px">
                                    <div class="col-md-2 tar">
                                        学生姓名：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <input id="query_studentName" type="text" class="validate[required,maxSize[100]] form-control"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                        身份证号码：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <input id="query_studentId" type="text" class="validate[required,maxSize[100]] form-control"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                        班级：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <select id="query_classId"></select>
                                    </div>
                                </div>
                                <div class="col-md-10" style="overflow: hidden; margin-bottom: 10px;">
                                    <div class="col-md-2 tar">
                                        专业：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <select id="query_majorCode"></select>
                                    </div>
                                    <div class="col-md-2 tar">
                                        学期：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <select id="query_termId"></select>
                                    </div>
                                    <div class="col-md-2 tar">
                                        考试方式：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <select id="f_queryExamType"></select>
                                    </div>
                                </div>
                                <div class="col-md-10" style="overflow: hidden; margin-bottom: 10px;">
                                    <div class="col-md-2 tar">
                                        科目：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <select id="query_courseId"></select>
                                    </div>
                                    <div class="col-md-2 tar">
                                        授课老师：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <select id="query_teacherId"></select>
                                    </div>
                                    <div class="col-md-2 tar"></div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                        </button>
                                        <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">
                                            清空
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                        <a id="expdata" class="btn btn-info btn-clean" onclick="expdata()">导出</a>
                        </button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <form id="scores">
                            <input name="type" value="${type}" type="hidden"/>
                            <table id="listGrid" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="scoreExamId" hidden value="${scoreExamId}">
    <input id="scoreExamName" hidden value="${scoreExamName}">
    <input id="term" hidden value="${term}">
</div>
<script>
    var listTable;
    var dataS;
    $.get("<%=request.getContextPath()%>/common/getSysDict?name=KSZT", function (data) {
        dataS = data
    });

    var dataKCCJ;
    $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCCJ", function (data) {
        dataKCCJ = data
    });

    var dataBKCJZT;
    $.get("<%=request.getContextPath()%>/common/getSysDict?name=BKCJZT", function (data) {
        dataBKCJZT = data
    });

    var dataScoreType;
    $.get("<%=request.getContextPath()%>/common/getSysDict?name=CJZT", function (data) {
        dataScoreType = data
    });

    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/scoreMakeup/getQueryList?scoreExamId=${scoreExamId}", function (data) {
            if(data != null){
                addOption(data["classSelect"], 'query_classId');
                addOption(data["majorSelect"], 'query_majorCode');
                addOption(data["courseSelect"], 'query_courseId');
                addOption(data["teacherSelect"], 'query_teacherId');
            }
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'query_termId');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KHFS", function (data) {
            addOption(data, 'f_queryExamType');
        });
        search();
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/scoreMakeup/updateScoreMakeup?id=" + id);
                $("#dialog").modal("show");
            }
            if(this.id == "toEdit"){
                $("#dialog").load("<%=request.getContextPath()%>/scoreChange/editScoreChange?id=" + id);
                $("#dialog").modal("show");
            }
        });

        $("#right").css("overflow","auto");
        $(".sorting_disabled").append("<input type='checkbox' id='checkAll' onclick='check()'>");
    })

    function searchClear() {
        $("#query_studentName").val("");
        $("#query_studentId").val("");
        $("#query_classId").val("");
        $("#query_majorCode").val("");
        $("#query_termId").val("");
        $("#f_queryExamType").val("");
        $("#query_courseId").val("");
        $("#query_teacherId").val("");
        search();
    }

    var render ="<a id='toEdit' class='icon-edit' title='成绩修改申请'>";

    function search() {

        $("#checkAll").removeAttr("checked");

        var studentName = $("#query_studentName").val();
        var studentId = $("#query_studentId").val();
        var classId = $("#query_classId").val();
        var majorCode = $("#query_majorCode").val();
        var termId = $("#query_termId").val();
        var examType = $("#f_queryExamType").val();
        var courseId = $("#query_courseId").val();
        var teacherId = $("#query_teacherId").val();

        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/scoreMakeup/getScoreMakeupExamList1111',
                "data": {
                    scoreExamId: '${scoreExamId}',
                    studentName: studentName,
                    studentId: studentId,
                    classId: classId,
                    majorCode: majorCode,
                    termId: termId,
                    examMethod: examType,
                    courseId: courseId,
                    teachingTeacherId: teacherId
                }
            },
            "destroy": true,
            "columns": [
                {"width": "6%",
                    "render": function (data, type, row) { return "<input type='checkbox' text='checkbox' value='" + row.id + "'/>";
                    }
                },
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "courseShow","width": "6%","title": "课程"},
                {"data": "examMethod","width": "6%","title": "考试方式"},
                {"data": "classId","width": "6%","title": "班级"},
                {"data": "studentName","width": "6%","title": "学生姓名"},
                {"data": "peacetimeScoreA","width": "7%","title": "学生到课情况(满分10分)"},
                {"width": "7%","title": "学生作业情况(满分10分)","data": "peacetimeScoreB"},
                {"width": "7%","title": "学生测验情况(满分10分)","data": "peacetimeScoreC"},
                {"width": "7%","title": "学生课上提问情况(满分10分)","data": "peacetimeScoreD"},
                {"width": "7%","title": '${scoreName}',"data": "score"},
                {"width": "7%","title": "考试状态","data": "examinationStatus"},
                {"width": "6%","title": "系部","data": "departmentsId"},
                {"width": "6%","title": "专业","data": "majorCode"},
                {"width": "6%","title": "学期","data": "termShow"},
                {"width": "6%","title": "考试","data": "scoreExamName"}
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    //返回
    function back() {
        $("#right").load("<%=request.getContextPath()%>/resultInquiry/resultInquiryList");
        $("#right").modal("show");
    }

    //导出
    function expdata() {

        var studentName = $("#query_studentName").val();
        var studentId = $("#query_studentId").val();
        var classId = $("#query_classId").val();
        var majorCode = $("#query_majorCode").val();
        var termId = $("#query_termId").val();
        var examType = $("#query_examType").val();
        var courseId = $("#query_courseId").val();
        var teacherId = $("#query_teacherId").val();

        var href = "<%=request.getContextPath()%>/scoreMakeup/exportMakeupScoreForData?type=${type}&scoreExamId=${scoreExamId}" +
            "&studentName=" + studentName +
            "&studentId=" + studentId +
            "&classId=" + classId +
            "&majorCode=" + majorCode +
            "&termId=" + termId +
            "&exam_method=" + examType +
            "&courseId=" + courseId +
            "&teachingTeacherId=" + teacherId;
        $("#expdata").attr("href", href);
    }

    //导入
    function impdata() {
        $("#dialog").load("<%=request.getContextPath()%>/scoreMakeup/scoreMakeupImport?type=${type}&scoreExamId=${scoreExamId}&scoreExamName=" + $("#scoreExamName").val());
        $("#dialog").modal("show");
    }

    function saveScore() {
        var scores = $("#scores").serializeArray();
        $.post("<%=request.getContextPath()%>/scoreMakeup/saveScore", scores, function (msg) {
            swal({title: msg.msg, type: "success"});
            search();
        })
    }

    function check() {
        if ($("#checkAll").attr("checked")) {
            $("[text='checkbox']").attr("checked", "checked");
        } else {
            $("[text='checkbox']").removeAttr("checked");
        }
    }

    function batchDel() {
        var chk_value = "'";
        if ($('input[text="checkbox"]:checked').length > 0) {
            swal({
                title: "确认清除所选学生的考试成绩?",
                text: "清除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "清除",
                closeOnConfirm: false
            }, function () {
                $('input[text="checkbox"]:checked').each(function () {
                    chk_value += $(this).val() + "','";
                });
                chk_value = chk_value.substring(0, chk_value.length - 2)
                $.get("<%=request.getContextPath()%>/scoreMakeup/delScoreImport?ids=" + chk_value, function (msg) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    }, function () {
                        listTable.ajax.reload();
                    });
                });
            })
        } else {
            swal({
                title: "请选择一条或多条记录!",
                type: "info"
            });
        }

    }
</script>