<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <%--<div class="block block-drop-shadow content block-fill-white">
                </div>--%>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <c:if test="${type == '1'}">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="$('#right').load('<%=request.getContextPath()%>/scoreMakeup/finalExamList')">
                                返回
                            </button>
                        </c:if>
                        <c:if test="${type != '1'}">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="$('#right').load('<%=request.getContextPath()%>/scoreMakeup/examList?type=${type}')">
                                返回
                            </button>
                        </c:if>

                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table11" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var table11;
    $(document).ready(function () {
        table11 = $("#table11").DataTable({
            ajax: {
                type: "post",
                url: '<%=request.getContextPath()%>/scoreExam/getCourseClass?id=${id}',
            },
            columns: [
                {
                    data: "term",
                    title: "学期"
                },
                {
                    data: "courseName",
                    title: "科目"
                },
                {
                    data: "className",
                    title: "班级"
                },
                {
                    data: "normalScoreStartTime",
                    title: "平时成绩上传开始时间"
                },
                {
                    data: "normalScoreEndTime",
                    title: "平时成绩上传结束时间"
                },
                {
                    data: "scoreStartTime",
                    title: "考试成绩上传开始时间"
                },
                {
                    data: "scoreEndTime",
                    title: "考试成绩上传结束时间"
                },
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-align-justify" onclick=toImport("' + row.examId + '","' + row.examName + '","'
                            + row.term + '","' + row.normalScoreEndTime + '","' + row.scoreEndTime + '","' + row.classId + '","' + row.courseId + '","' + row.termId + '","' + row.examMethod + '") title="成绩录入"></span>';
                    }
                },
            ],
            dom: 'rtlip',
            language: language
        });
    });

    function toImport(examId, examName, term, normalScoreEndTime, scoreEndTime, classId, courseId, termId, examMethod) {
        $.post("<%=request.getContextPath()%>/evaluation/getUserTask", {}, function (msg) {
            if (msg.status == 1) {
                $.get("<%=request.getContextPath()%>/scoreMakeup/getScoreEndTime?scoreEndTime=" + scoreEndTime, function (msg) {
                    if (msg.status == 1) {
                        $("#right").load("<%=request.getContextPath()%>/scoreMakeup/import?type=${type}&scoreExamId=" + examId + "&scoreExamName="
                            + examName + "&term=" + term + "&normalScoreEndTime=" + normalScoreEndTime + "&openFlag=${openFlag}&classId=" + classId + "&courseId="
                            + courseId + "&termId=" + termId + "&examMethod=" + examMethod)
                    } else {
                        swal({
                            title: "考试成绩上传时间已结束，不能录入成绩",
                            type: "error"
                        });
                    }
                })
            } else {
                swal({
                    title: msg.msg,
                    type: "info"
                });
            }
        });

    }

    function search() {
        var term = $("#searchTerm").val();
        table11.ajax.url("<%=request.getContextPath()%>/courseconstruction/getTeachingCalendarList?term=" + term).load();
    }

    function searchclear() {
        $("#searchTerm").val("");
        search();
    }

</script>