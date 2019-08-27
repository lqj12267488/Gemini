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
                                学生名称：
                            </div>
                            <div class="col-md-2">
                                <input id="studentNameSel" />
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
                        <table id="studentGrid" cellpadding="0" cellspacing="0"
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
    var studentGrid;

    $(document).ready(function () {
        search();

        studentGrid.on('click', 'tr a', function () {
            var data = studentGrid.row($(this).parent()).data();
            var studentId = data.studentId;
            if (this.id == "getScoreImport") {
                $("#right").load("<%=request.getContextPath()%>/student/studentScoreList?studentId="+studentId);
            }
            if (this.id == "editScore") {
                $("#right").load("<%=request.getContextPath()%>/scoreImport/getListByStudent?studentId="+studentId);
            }

        });
    })
    function searchclear() {
        $("#studentNameSel").val("");
        search();
    }

    function search() {
        var studentName = $("#studentNameSel").val();
        studentGrid = $("#studentGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax" :{
                "type":"post",
                "url": '<%=request.getContextPath()%>/scoreImport/getScoreStudentList',
                "data": {
                    studentName: studentName
                }
            },
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"data": "classId", "title": "班级名称"},
                {"data": "majorCode", "title": "专业名称"},
                {"data": "studentName", "title": "学生名称"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='getScoreImport' class='icon-eye-open' title='查看学生成绩单'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='editScore' class='icon-edit' title='成绩编辑'></a>" ;
                    }
                }
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }

</script>
