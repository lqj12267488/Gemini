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
                                科目：
                            </div>
                            <div class="col-md-2">
                                <input id="courseSel"/>
                            </div>
                            <div class="col-md-1 tar">
                                任课教师：
                            </div>
                            <div class="col-md-2">
                                <input id="name"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search2()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search2clear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                        <%--<a id="expdata" class="btn btn-info btn-clean" onclick="expdata()">导出</a>--%>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
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
    var table;

    function back() {
        $("#right").load("<%=request.getContextPath()%>/scoreClass/studentGrid?scoreExamName=${data.scoreExamName}" +
            "&scoreExamId=${data.scoreExamId}");
    }

    $(document).ready(function () {
        search2();
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var courseId = data.courseId;
            if (this.id == "see") {
                $("#right").load("<%=request.getContextPath()%>/scoreImport/scoreDetails?scoreExamName=${data.scoreExamName}" +
                    "&scoreExamId=${data.scoreExamId}&classId=${data.classId}&courseId=" + courseId);
            }
        });
    });

    function search2clear() {
        $("#courseSel").val("");
        $("#name").val("");
        search2();
    }

    function search2() {
        var courseSel = $("#courseSel").val();
        var name = $("#name").val();
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/scoreImport/getScoreCourse',
                "data": {
                    scoreExamId: '${data.scoreExamId}',
                    classId: '${data.classId}',
                    courseShow: courseSel,
                    personId: name
                }
            },

            "destroy": true,
            "columns": [
                {"data": "scoreExamId", "visible": false},
                {"width": "18%", "data": "className", "title": "班级"},
                {"width": "18%", "data": "courseShow", "title": "科目"},
                {"width": "18%", "data": "personId", "title": "任课教师"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='see' class='icon-eye-open' title='查看详情'></a>&nbsp;&nbsp;&nbsp;";
                    }
                },
            ],
            'order': [2, 'asc'],
            "dom": 'rtlip',
            language: language
        });
    }

</script>
