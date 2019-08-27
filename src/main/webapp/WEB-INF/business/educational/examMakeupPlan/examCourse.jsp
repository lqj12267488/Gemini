<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">

                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">补考科目列表</span>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <div class="col-md-1 tar" style="width:100px">
                            考试名称：
                        </div>
                        <div class="col-md-2">
                            <input id="selName" type="text"/>
                        </div>
                        <div class="col-md-1 tar" style="width:100px">
                            学期:
                        </div>
                        <div class="col-md-2">
                            <select id="selTerm" class="js-example-basic-single"></select>
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
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="scoreExamTable" cellpadding="0" cellspacing="0"
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
    var scoreExamTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'selTerm');
        });
        search();
        scoreExamTable.on('click', 'tr a', function () {
            var data = scoreExamTable.row($(this).parent()).data();
            var scoreExamId = data.scoreExamId;
            if (this.id == "editCoursePlan") {
                $("#dialog").load("<%=request.getContextPath()%>/exam/makeup/editCoursePlan?examCourseId=" + data.examCourseId );
                $("#dialog").modal("show");
            }else if (this.id == "planGrid"){
                $("#dialog").load("<%=request.getContextPath()%>/exam/makeup/scoreGraduateMakeup/importAfterGraduation?scoreExamId=" + scoreExamId);
                $("#dialog").modal("show");
            }
        });
    })

    function searchclear() {
        $("#selName").val("");
        $("#selTerm").val("");
        search();
    }
    function search() {
        scoreExamTable = $("#scoreExamTable").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/exam/makeup/getMakeupExamCourseList?scoreExamId='+'${scoreExamId}'
            },
            "destroy": true,
            "columns": [
                {"data": "examCourseId", "visible": false},
                {"data": "examId", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"width":"12%","data": "courseShow", "title": "学科名称"},
                {"width":"12%","data": "courseTypeShow", "title": "班级名称"},
                {"width":"12%","data": "studentNumber", "title": "补考人数"},
                {"width":"8%","data": "startTime", "title": "开始时间"},
                {"width":"8%","data": "endTime", "title": "结束时间"},
                {"width":"8%","data": "roomShow", "title": "考场"},
                {"width":"8%","title": "操作",
                    "render": function () {
                        return "<a id='editCoursePlan' class='icon-align-justify' title='设置考场及时间'></a>&nbsp;&nbsp;&nbsp;&nbsp;"
//                            +"<a id='planGrid' class='icon-wrench' title='查看考场状态'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam/makeup/makeupExamPlan");
    }

</script>