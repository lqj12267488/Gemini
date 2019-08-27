<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block block-drop-shadow">
                <div class="content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <header class="mui-bar mui-bar-nav">
                            <h5 class="mui-title">${scoreExamName} > ${className} > 考试科目</h5>
                        </header>
                    </div>
                    <div>
                        <button type="button" class="btn btn-default btn-clean" id="back"
                                onclick="back()">返回
                        </button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="courseGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="scoreExamName" value="${scoreExamName}" hidden>
<input id="examId" value="${examId}" hidden>
<input id="classId" value="${classId}" hidden>
<input id="className" value="${className}" hidden>
<script>
    var courseGrid ;
    $(document).ready(function () {
        courseGrid = $("#courseGrid").DataTable({
            "ajax" :{
                "type":"post",
                "url": '<%=request.getContextPath()%>/scoreImport/getCourseList?scoreExamId=${examId}'+
                            '&classId=${classId}',
            },
            "destroy": true,
            "columns": [
                {"data": "subjectId", "visible": false},
                {"data": "courseId", "visible": false},
                {"data": "classId", "visible": false},
                {"width": "18%","data": "scoreExamName", "title": "考试名称"},
                {"width": "18%","data": "termId", "title": "学期"},
                {"width": "18%","data": "courseShow", "title": "学科"},
                {"width": "18%","title": "班级名称" ,
                    "render": function () {
                        return "${className}" ;
                    }
                },
                {"width": "10%","data": "courseFlag", "title": "考核类型"},
                {"width": "10%","data": "personId", "title": "任课教师"},
                {"width": "10%","data": "examTime", "title": "考试时间"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='getScoreClass' class='icon-eye-open' title='生成学生成绩报告表'></a>" ;
                    }
                },
                {"data": "classId", "visible": false},
            ],
            'order' : [[2,'asc'],[6,'desc']],
            "dom": 'rtlip',
            language: language
        });
        courseGrid.on('click', 'tr a', function () {
            var data = courseGrid.row($(this).parent()).data();
            if (this.id == "getScoreClass") {
                $("#right").load("<%=request.getContextPath()%>/scoreClass/courseClass"
                    +"?classId=${classId}&examId=${examId}&className=${className}&scoreExamName=${scoreExamName}"
                    +"&subjectId="+data.subjectId+"&courseShow="+data.courseShow+
                    "&courseFlag="+data.courseFlag+"&personId="+data.personId);
            }
        });
    })
    function back() {
        $("#right").load("<%=request.getContextPath()%>/scoreImport/examList");
    }

</script>