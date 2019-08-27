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
                                班级
                            </div>
                            <div class="col-md-2">
                                <input id="classSel"/>
                            </div>
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <input id="deptSel"/>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <input id="majorSel"/>
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
        $("#right").load("<%=request.getContextPath()%>/scoreImport/examList");
    }

    $(document).ready(function () {
        search2();
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.scoreExamId;
            var classId = data.classId;
            if (this.id == "see") {
                $("#right").load("<%=request.getContextPath()%>/scoreImport/scoreCourseList?scoreExamName=${data.scoreExamName}"
                    + "&scoreExamId=" + id + "&classId=" + classId);
            }
        });
    });

    function search2clear() {
        $("#classSel").val("");
        $("#deptSel").val("");
        $("#majorSel").val("");
        search2();
    }

    function search2() {
        var classSel = $("#classSel").val();
        var departmentsId = $("#deptSel").val();
        var majorSel = $("#majorSel").val();
        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/scoreImport/getClassScore',
                "data": {
                    scoreExamId: '${data.scoreExamId}',
                    classId: classSel,
                    departmentsId: departmentsId,
                    majorCode: majorSel
                }
            },

            "destroy": true,
            "columns": [
                {"data": "scoreExamId", "visible": false},
                {"width": "18%", "data": "className", "title": "班级名称"},
                {"width": "18%", "data": "departmentsId", "title": "系部"},
                {"width": "18%", "data": "majorCode", "title": "专业"},
                {"width": "18%", "data": "classType", "title": "班级类型"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='see' class='icon-eye-open' title='查看详情'></a>&nbsp;&nbsp;&nbsp;";
                    }
                },
            ],
            'order': [2, 'asc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }

</script>
