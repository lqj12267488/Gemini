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
                            <h5 class="mui-title">${arrayClassName} > 学生列表查看</h5>
                            <input id="arrayClassId" value="${arrayClassId}" hidden>
                        </header>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学生：
                            </div>
                            <div class="col-md-3">
                                <input id="studentIdSel" type="text" class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-3">
                                <input id="classIdSel" type="text" class="validate[required,maxSize[20]] form-control"/>
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
                    <div>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="back()">返回
                            </button>
                            <br>
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
</div>

<script>
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClassResultClass/getArrayClassStudentClassList',
            },
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"width": "14%","data": "studentName", "title": "学生姓名"},
                {"width": "14%","data": "classIdShow", "title": "班级名称"},
                {"width": "14%","data": "departmentsId", "title": "系部名称"},
                {"width": "14%","data": "majorCode", "title": "专业名称"},
                {"width": "14%","data": "roomId", "title": "教室名称"},
                {"width": "16%","data": "studentNumber", "title": "班级学生数量"},
                {
                    "width": "14%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return "<a id='edit' class='icon-th' title='查看学生课表'></a>";
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var arrayclassId = data.arrayclassId;
            var studentId = data.studentId;
            var studentNumber = data.studentNumber;
            var classIdShow = data.classId;
            if (this.id == "edit") {

                $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/lookStudentViewCourse" +
                    "?arrayclassId="+arrayclassId+"&studentId="+studentId+"&studentName="+data.studentName+
                    "&studentNumber="+studentNumber +"&classId="+classIdShow+
                    "&arrayClassName=${arrayClassName}");
            }

        });

    })



    function back() {
        $("#right").load("<%=request.getContextPath()%>/student/look");
    }

    function searchclear() {
        $("#classIdSel").val("");
        $("#studentIdSel").val("");
        search();
    }
    function search() {
        var classId = $("#classIdSel").val();
        var studentId = $("#studentIdSel").val();
        table.ajax.url("<%=request.getContextPath()%>/arrayClassResultClass/getArrayClassStudentClassList" +
            "?classId="+classId+"&studentId="+studentId).load();
    }

</script>