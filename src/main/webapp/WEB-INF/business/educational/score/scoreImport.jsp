<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-2">
                                <input id="classIdSel" type="text"/>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                考试名称：
                            </div>
                            <div class="col-md-2">
                                <input id="examNameSel" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                课程：
                            </div>
                            <div class="col-md-2">
                                <input id="courseIdSel" type="text"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="scoreImportGrid" cellpadding="0" cellspacing="0"
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
    var scoreImportTable;

    $(document).ready(function () {
        scoreImportTable = $("#scoreImportGrid").DataTable({
            "destroy": true,
            "columns": [
                {"data": "scoreClassId", "visible": false},
                {"data": "subjectId", "visible": false},
                {"data": "planId", "visible": false},
                {"data": "scoreExamId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "18%", "data": "scoreExamName", "title": "考试名称"},
                {"width": "18%", "data": "departmentsId", "title": "系部"},
                {"width": "18%", "data": "majorCode", "title": "专业"},
                {"width": "18%", "data": "classId", "title": "班级"},
                {"width": "18%", "data": "courseId", "title": "课程"},
                {"width": "18%", "data": "personId", "title": "录入教师"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='getScoreImport' class='icon-edit-sign' title='成绩录入'></a>"
                    }
                }
            ],
            'order': [[4, 'desc'], [5, 'desc']],
            "dom": 'rtlip',
            language: language
        });
        search();
        scoreImportTable.on('click', 'tr a', function () {
            var data = scoreImportTable.row($(this).parent()).data();
            var id = data.scoreClassId;
            var classId = data.classId;
            var subjectId = data.subjectId;
            var courseId = data.courseId;
            var scoreExamName = data.scoreExamName;
            var courseFlag = data.courseFlag;

            if (this.id == "getScoreImport") {
                $("#right").load("<%=request.getContextPath()%>/scoreImport/getList?scoreClassId=" + id +"&subjectId="+ subjectId + "&courseId=" + courseId + "&classId=" + classId + "&scoreExamName=" + scoreExamName+"&courseFlag="+courseFlag);
                $("#right").modal("show");
            }

        });
    })

    function searchclear() {
        $("#classIdSel").val("");
        $("#examNameSel").val("");
        $("#courseIdSel").val("");
        search();
    }

    function search() {
        scoreImportTable.ajax.url("<%=request.getContextPath()%>/scoreImport/selectScoreClass?classId="
            + $("#classIdSel").val() + "&scoreExamName=" + $("#examNameSel").val() +
            "&courseId=" + $("#courseIdSel").val()).load();
    }

</script>
