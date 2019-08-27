<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/8/29
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12" >
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <header class="mui-bar mui-bar-nav">
                        <h5 id="arrayClassName" class="mui-title">${arrayClassName} > 查看教师列表</h5>
                        </header>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                授课教师：
                            </div>
                            <div class="col-md-2">
                                <input id="teacherId" type="text" />
                            </div>
                            <%--<div class="col-md-1 tar">--%>
                            <%--课程：--%>
                            <%--</div>--%>
                            <%--<div class="col-md-2">--%>
                            <%--<select id="courseIdSel" />--%>
                            <%--</div>--%>
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
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="teacherSyllabusGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="arrayclassId" hidden value="${arrayClassId}">
</div>
<script>
    var teacherSyllabusTable;

    $(document).ready(function () {
        search();
        teacherSyllabusTable.on('click', 'tr a', function () {
            var data = teacherSyllabusTable.row($(this).parent()).data();
            var teacherPersonId = data.teacherPersonId;
            var teacherPersonShow = data.teacherPersonShow;
            var arrayclassId = data.arrayclassId;
            if (this.id == "teacherSyllabusView") {
                $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/teacherSyllabusView?arrayClassName=${arrayClassName}&arrayclassId="+arrayclassId+
                    "&teacherPersonShow="+teacherPersonShow+"&teacherPersonId="+teacherPersonId);
            }
        });
    })

    function searchclear() {
        $("#teacherId").val("");
        search();
    }

    function search() {
        var teacherId=$("#teacherId").val();
        teacherId='%'+teacherId+'%';
        var arrayclassId = $("#arrayclassId").val();
        teacherSyllabusTable = $("#teacherSyllabusGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClassResultClass/getTeacherSyllabusList',
                "data": {
                    teacherPersonId:teacherId,
                    arrayclassId:arrayclassId
                }
            },
            "destroy": true,
            "columns": [
                {"data": "arrayclassTeacherId", "visible": false},
                {"data": "teacherPersonId", "visible": false},
                {"data": "arrayclassId", "visible": false},
                {"width": "40%", "data": "teacherPersonShow", "title": "授课教师"},
                {"width": "40%", "data": "teacherDeptId", "title": "所在部门"},
                {
                    "width": "20%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='teacherSyllabusView' class='icon-th' title='查看教师课表'></a>";
                    }
                }
            ],
            'order' : [3,'asc'],
            "dom": 'rtlip',
            language: language
        });
//        arrayclassTeacherList.ajax.url(
//            "/arrayClass/teacher/getTeacherList?arrayclassId="+arrayclassId+
//            "&teacherPersonId="+teacherId
//        ).load();
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/teacher/look");
        $("#right").modal("show");
    }
</script>
