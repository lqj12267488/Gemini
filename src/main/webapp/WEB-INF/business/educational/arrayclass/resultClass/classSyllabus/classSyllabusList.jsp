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
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <header class="mui-bar mui-bar-nav">
                            <h5 id="arrayClassName">${arrayClassName} > 查看班级列表</h5>
                        </header>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                班级名称：
                            </div>
                            <div class="col-md-2">
                                <input id="classId" type="text" />
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
                        <table id="classSyllabusGrid" cellpadding="0" cellspacing="0"
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
    var classSyllabusTable;

    $(document).ready(function () {
        search();
        classSyllabusTable.on('click', 'tr a', function () {
            var data = classSyllabusTable.row($(this).parent()).data();
            var classId = data.classId;
            var className = data.className;
            var arrayclassId = data.arrayclassId;
            if (this.id == "classSyllabusView") {
                $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/classSyllabusView?arrayClassName=${arrayClassName}&arrayclassId="+arrayclassId+
                    "&className="+className+"&classId="+classId);
            }
        });
    })

    function searchclear() {
        $("#classId").val("");
        search();
    }

    function search() {
        var classId=$("#classId").val();
        classId='%'+classId+'%';
        var arrayclassId = $("#arrayclassId").val();
        classSyllabusTable = $("#classSyllabusGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClassResultClass/getClassSyllabusList',
                "data": {
                    classId:classId,
                    arrayclassId:arrayclassId
                }
            },
            "destroy": true,
            "columns": [
                {"data": "classId", "visible": false},
                {"data": "arrayclassId", "visible": false},
                {"width": "20%", "data": "className", "title": "排课班级"},
                {"width": "20%", "data": "departmentsId", "title": "系部"},
                {"width": "20%", "data": "majorCode", "title": "专业"},
                {"width": "20%", "data": "trainingLevel", "title": "专业层次"},
                {
                    "width": "20%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='classSyllabusView' class='icon-th' title='查看班级课表'></a>";
                    }
                }
            ],
            'order' : [2,'asc'],
            "dom": 'rtlip',
            language: language
        });
//        arrayclassTeacherList.ajax.url(
//            "/arrayClass/teacher/getTeacherList?arrayclassId="+arrayclassId+
//            "&teacherPersonId="+teacherId
//        ).load();
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/class/look");
        $("#right").modal("show");
    }
</script>
