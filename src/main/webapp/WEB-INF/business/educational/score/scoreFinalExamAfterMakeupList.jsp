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
                            <h5 class="mui-title">${scoreExamName} > 毕业后补考学生名单</h5>
                        </header>
                        <div class="form-row">
                            <div class="form-row">
                                <div class="col-md-10" style="overflow: hidden;  margin-bottom: 10px">
                                    <div class="col-md-2 tar">
                                        学生姓名：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <input id="query_studentName" type="text"
                                               class="validate[required,maxSize[100]] form-control"/>
                                    </div>
                                    <div class="col-md-1 tar">
                                        身份证号码：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <input id="query_studentId" type="text"
                                               class="validate[required,maxSize[100]] form-control"/>
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
                                <div class="col-md-10" style="overflow: hidden; margin-bottom: 10px;">
                                    <div class="col-md-2 tar">
                                        专业：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <select id="query_majorCode"></select>
                                    </div>
                                    <div class="col-md-1 tar">
                                        考核方式：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <select id="query_examType"></select>
                                    </div>
                                </div>
                                <div class="col-md-10" style="overflow: hidden; margin-bottom: 10px;">
                                    <div class="col-md-2 tar">
                                        授课老师：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <select id="query_teacherId"></select>
                                    </div>
                                    <div class="col-md-1 tar">
                                        学号：
                                    </div>
                                    <div class="col-md-2" style="width: 15%;">
                                        <input id="xuehao" type="text"
                                               class="validate[required,maxSize[100]] form-control"/>
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
                        <c:if test="${editFlag == '1' }">
                            <a id="impdata" class="btn btn-info btn-clean" onclick="impdata()">导入</a>
                            <a id="downImpdata" class="btn btn-info btn-clean" onclick="downTemplate()">下载导入模板</a>
                            <button id="saveBtn" type="button" class="btn btn-default btn-clean" onclick="saveScore()">
                                暂存
                            </button>
                        </c:if>
                        <button id="batchClear" type="button" class="btn btn-default btn-clean"
                                onclick="batchDel()">清除
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="toCheckedClass(4,3)">毕业后补考情况表
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="toCheckedClass(4,4)">
                            毕业后补考不合格情况表
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="biyemd(5,3)">毕业学生名单</button>
                        <button type="button" class="btn btn-default btn-clean" onclick="biyemd(6,4)">不毕业学生名单</button>
                        <c:if test="${editFlag == '1' }">
                        <button id="sumbitBtn" type="button" class="btn btn-default btn-clean"
                                onclick="checkSubmit()">
                            成绩提交
                        </button>
                        </c:if>
                        <c:if test="${flag == 1}">
                            <button type="button" class="btn btn-default btn-clean" onclick="changeOpenFlag()">发布成绩
                            </button>
                        </c:if>
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
    <input id="examMethod" hidden value="${examMethod}">
</div>
<script>
    var listTable;

    var bkcj;
    $.post("<%=request.getContextPath()%>/common/getSysDict", {
        name: 'BYQBKCJ',
    }, function (data) {
        bkcj = data;
    });
    var dataS;
    $.post("<%=request.getContextPath()%>/common/getSysDict", {
        name: 'BKZT',
    }, function (data) {
        dataS = data;
    });

    function checkSubmit() {
        $.get("<%=request.getContextPath()%>/scoreMakeup/check?scoreExamId=${scoreExamId}&termId=${termId}&course=${courseId}&classId=${classId}&flag=1", function (data) {
            if (data.status == 1) {
                $("#impdata").attr("disabled","disabled");
                $("#downImpdata").attr("disabled","disabled");
                $("#batchClear").attr("disabled","disabled");
                $("#saveBtn").attr("disabled","disabled");
                $("#sumbitBtn").attr("disabled","disabled");
                // swal({
                //     title: "提交成功！",
                //     type: "info"
                // }, function () {
                //     search();
                // });
                var scores = $("#scores").serializeArray();
                $.post("<%=request.getContextPath()%>/scoreMakeup/sumbitScoreMakeup",scores, function (msg) {
                    swal({title: msg.msg, type: "success"});
                    search();
                })
            } else {
                swal({
                    title: "请上传成绩！",
                    type: "info"
                });
            }
            search();
        });
    }

    var dataScoreType;
    $.post("<%=request.getContextPath()%>/common/getSysDict", {
        name: 'CJZT',
        where: " dic_name in ('正常','补违纪','补缺考')"
    }, function (data) {
        dataScoreType = data;
    });

    $(document).ready(function () {
        if ('${isSumbit}'==1){
            $("#impdata").attr("disabled","disabled");
            $("#downImpdata").attr("disabled","disabled");
            $("#batchClear").attr("disabled","disabled");
            $("#saveBtn").attr("disabled","disabled");
            $("#sumbitBtn").attr("disabled","disabled");
        }

        $.get("<%=request.getContextPath()%>/scoreMakeup/getQueryList?scoreExamId=${scoreExamId}", function (data) {
            if (data != null) {
                addOption(data["majorSelect"], 'query_majorCode');
                addOption(data["teacherSelect"], 'query_teacherId');
            }
        });

        $.post("<%=request.getContextPath()%>/common/getSysDict", {
            name: 'KHFS',
            where: " dic_name in ('考试','考查')"
        }, function (data) {
            addOption(data, 'query_examType');
        });
        search();
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/scoreMakeup/updateScoreMakeup?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "toEdit") {
                $("#dialog").load("<%=request.getContextPath()%>/scoreChange/editScoreChange?id=" + id);
                $("#dialog").modal("show");
            }
        });

        $("#right").css("overflow", "auto");
        $(".sorting_disabled").append("<input type='checkbox' id='checkAll' onclick='check()'>");
    })

    function searchClear() {
        $("#query_studentName").val("");
        $("#query_studentId").val("");
        $("#query_classId").val("");
        $("#query_majorCode").val("");
        $("#query_termId").val("");
        $("#query_examType").val("");
        $("#query_courseId").val("");
        $("#query_teacherId").val("");
        $("#xuehao").val("");
        search();
    }

    var render = "<a id='toEdit' class='icon-edit' title='成绩修改申请'>";

    function search() {

        $("#checkAll").removeAttr("checked");

        var studentName = $("#query_studentName").val();
        var studentId = $("#query_studentId").val();
        var majorCode = $("#query_majorCode").val();
        var examType = $("#query_examType").val();
        var teacherId = $("#query_teacherId").val();
        var studentNum = $("#xuehao").val();

        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/scoreMakeup/getScoreMakeupExamList1111',
                "data": {
                    scoreExamId: '${scoreExamId}',
                    studentName: studentName,
                    studentId: studentId,
                    classId: "${classId}",
                    majorCode: majorCode,
                    termId: "${termId}",
                    examMethod: examType,
                    courseId: "${courseId}",
                    teachingTeacherId: teacherId,
                    studentNum: studentNum
                }
            },
            "destroy": true,
            "columns": [
                {
                    "width": "6%",
                    "render": function (data, type, row) {
                        return "<input type='checkbox' text='checkbox' value='" + row.id + "'/>";
                    }
                },
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "courseShow", "width": "6%", "title": "课程"},
                {"data": "examMethod", "width": "6%", "title": "考试方式"},
                {"data": "classId", "width": "6%", "title": "班级"},
                {"data": "studentName", "width": "6%", "title": "学生姓名"},
                {"data": "studentNum", "width": "6%", "title": "学号"},
                {"data": "finalScore", "width": "6%", "title": "期末成绩"},
                {"data": "finalExaminationStatus", "width": "6%", "title": "期末考试状态"},
                {"data": "finalMakeupScore", "width": "6%", "title": "期末补考成绩"},
                {"data": "finalMakeupExaminationStatus", "width": "6%", "title": "期末补考状态"},
                {"data": "finalBeforeMakeupScore", "width": "6%", "title": "毕业前补考成绩"},
                {"data": "finalBeforeMakeupExaminationStatus", "width": "6%", "title": "毕业前补考状态"},
                {
                    "width": "6%", "title": "毕业后补考成绩", "data": "score",
                    "render": function (data, type, row) {
                        // if (row.submitFlag == '1') {
                        //     return row.score;
                        // }
                        // var scoreIn = "";
                        // if (row.score != null) {
                        //     scoreIn = row.score;
                        // }
                        // var html = "<input name='score_" + row.id + "' value='" + scoreIn + "' maxlength='10'>";
                        var dis = "";
                        if (row.submitFlag == '1') {
                            dis = 'disabled';
                        }
                        var html = "<select name='score_" + row.id + "' " + dis + " style='min-width: 65px;'>";
                        $.each(bkcj, function (index, content) {
                            if (content.text == row.score) {
                                html += "<option value='" + content.id + "' selected='selected'>" + content.text + "</option>";
                            } else {
                                html += "<option value='" + content.id + "'>" + content.text + "</option>";
                            }
                        });
                        html += "</select>"
                        return html;
                    }
                },
//                {
//                    "width": "6%","title": "毕业后补考成绩情况","data": "scoreType",
//                    "render": function (data, type, row) {
//                        var dis = "";
//                        if(row.openFlag == '1'){dis='disabled';}
//                        var html = "<select name='scoreType_"+row.id+"' "+dis+" style='min-width: 65px;'>";
//                        $.each(dataScoreType, function (index, content) {
//                            if (content.text === row.scoreType) {
//                                html += "<option value='" + content.id + "' selected='selected'>" + content.text + "</option>";
//                            } else {
//                                html += "<option value='" + content.id + "'>" + content.text + "</option>";
//                            }
//                        });
//                        html += "</select>";
//                        return html;
//                    }
//                },
                {
                    "width": "6%", "title": "补考状态", "data": "examinationStatus",
                    "render": function (data, type, row) {
                        var dis = "";
                        if (row.submitFlag == '1') {
                            dis = 'disabled';
                        }
                        var html = "<select name='examinationStatus_" + row.id + "' " + dis + " style='min-width: 65px;'>";
                        $.each(dataS, function (index, content) {
                            if (content.text == row.examinationStatus) {
                                html += "<option value='" + content.id + "' selected='selected'>" + content.text + "</option>";
                            } else {
                                html += "<option value='" + content.id + "'>" + content.text + "</option>";
                            }
                        });
                        html += "</select>"
                        return html;
                    }
                },
                {"width": "6%", "title": "系部", "data": "departmentsId"},
                {"width": "6%", "title": "专业", "data": "majorCode"},
                {"width": "6%", "title": "学期", "data": "termShow"},
                {"width": "6%", "title": "考试", "data": "scoreExamName"},
                {
                    "width": "11%", "title": "操作", "render": function (data, type, row) {
                        if (row.submitFlag == '1') {
                            return render;
                        }else {
                            return "<a class='icon-edit' title='成绩修改申请'>";
                        }
                    }
                }
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            pageLength: 100,
            language: language
        });
    }

    //返回
    function back() {
        <%--$("#right").load("<%=request.getContextPath()%>/scoreMakeup/examList?type=4");--%>
        $("#right").load("<%=request.getContextPath()%>/scoreExam/toCourseClass?id=${scoreExamId}&type=${type}");
        $("#right").modal("show");
    }

    //导出
    function expdata() {

        var studentName = $("#query_studentName").val();
        var studentId = $("#query_studentId").val();
        var majorCode = $("#query_majorCode").val();
        var examType = $("#query_examType").val();
        var teacherId = $("#query_teacherId").val();

        var href = "<%=request.getContextPath()%>/scoreMakeup/exportMakeupScoreForData?type=${type}&scoreExamId=${scoreExamId}" +
            "&studentName=" + studentName +
            "&studentId=" + studentId +
            "&classId=${classId}" +
            "&majorCode=" + majorCode +
            "&termId=${termId}&exam_method=" + examType +
            "&courseId=${courseId}" +
            "&teachingTeacherId=" + teacherId;
        $("#expdata").attr("href", href);
    }

    //导入
    <%--function impdata() {--%>
        <%--$("#dialog").load("<%=request.getContextPath()%>/scoreMakeup/scoreMakeupImport?type=${type}&scoreExamId=${scoreExamId}&scoreExamName=" + $("#scoreExamName").val());--%>
        <%--$("#dialog").modal("show");--%>
    <%--}--%>
    function impdata() {
        $("#dialog").load("<%=request.getContextPath()%>/scoreMakeup/scoreMakeupImport?type=${type}&scoreExamId=${scoreExamId}&scoreExamName=" + $("#scoreExamName").val()+"&courseId=${courseId}");
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

    function downTemplate() {
        $.get("<%=request.getContextPath()%>/scoreMakeup/checkExportMakeupScore?type=${type}&scoreExamId=${scoreExamId}&term=${termId}&courseId=${courseId}&classId=${classId}", function (data) {
            if (data.status == 0) {
                window.location.href = "<%=request.getContextPath()%>/scoreMakeup/exportMakeupScore" +
                    "?type=${type}&scoreExamId=${scoreExamId}&term=${termId}&courseId=${courseId}&classId=${classId}&examMethod=${examMethod}";
            } else {
                swal({
                    title: "无数据！",
                    type: "error"
                });
            }
        });
    }

    function toCheckedClass(examTypes, scoreType) {
        window.location.href = "<%=request.getContextPath()%>/score/export?courseId=${courseId}&scoreExamId=${scoreExamId}&examTypes=" + examTypes + "&scoreType=" + scoreType + "&classId=${classId}";
    }

    function biyemd(examTypes, scoreType) {
        window.location.href = "<%=request.getContextPath()%>/score/export?scoreExamId=${scoreExamId}&examTypes=" + examTypes + "&scoreType=" + scoreType;
    }

    function changeOpenFlag() {
        $.get("<%=request.getContextPath()%>/scoreMakeup/checkCount?termId=${termId}&examName=${scoreExamName}" +
            "&type=${type}&classId=${classId}&courseId=${courseId}", function (data) {
            if (data.status == 0) {
                swal({
                    title: "成绩未提交不可以进行成绩发布！",
                    type: "error"
                });
            } else {
                swal({
                    title: "确认公开成绩?",
                    text: "请确定成绩表已完成录入，公开后全校师生皆可查看！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "green",
                    confirmButtonText: "确认",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/scoreMakeup/changeOpenFlag", {
                        scoreExamId: '${scoreExamId}',
                        classId: '${classId}',
                        courseId: '${courseId}'
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: msg.result
                        });
                        search();
                    });
                })
            }
        });
    }
</script>