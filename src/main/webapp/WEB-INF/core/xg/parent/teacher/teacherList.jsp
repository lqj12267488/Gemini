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
                            <h5 class="mui-title"> ${studentName} > 任课教师查看</h5>
                            <input id="studentId" value="${studentId}" hidden>
                        </header>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="teacherTable" cellpadding="0" cellspacing="0"
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
    var teacherTable;
    $(document).ready(function () {
        teacherTable = $("#teacherTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/core/parent/getTeacherList',
            },
            "destroy": true,
            "columns": [
                {"data":"teacherPersonId","visible": false},
                {"data":"teacherPersonName","title":"教师姓名"},
                {"data":"className","title":"所属班级"},
                {"data":"courseShow","title":"任课科目"},
                {"data":"termShow","title":"学期"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return  '<span class="icon-tags" title="教科任教信息" onclick=getTeachingResult("' + row.teacherPersonId + '","' + row.teacherPersonName + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function getTeachingResult(teacherId,teacherName) {
        $("#right").load("<%=request.getContextPath()%>/core/parent/toTeachingResult?teacherId="+teacherId+"&teacherName="+teacherName);
    }

</script>