<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/28
  Time: 15:25
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
                            <h5 class="mui-title">${arrayClassName} > 生成学生课表</h5>
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
                            <table id="studentArrayClassGrid" cellpadding="0" cellspacing="0"
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
    var roleTable;
    $(document).ready(function () {
        roleTable = $("#studentArrayClassGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClassResultClass/selectArrayClassResultStudentList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "studentId", "visible": false},
                {"width": "12%","data": "studentIdShow", "title": "学生姓名"},
                {"width": "12%","data": "classId", "title": "班级名称"},
                {"width": "12%","data": "departmentsId", "title": "系部名称"},
                {"width": "13%","data": "majorCode", "title": "专业名称"},
                {"width": "13%","data": "roomIdShow", "title": "教室名称"},
                {"width": "12%","data": "weekTypeShow", "title": "学周"},
                {"width": "12%","data": "hours", "title": "学时数"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return "<a id='edit' class='icon-search' title='查看详细'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='select' class='icon-th' title='查看学生课表'></a>";
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var arrayclassId = data.arrayclassId;
            var studentId = data.studentId;
            var classIdShow = data.classId;
            if (this.id == "select") {
                $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/lookStudentTableView" +
                    "?arrayclassId="+arrayclassId+"&studentId="+studentId+"&studentName="+data.studentIdShow+
                    "&classId="+classIdShow+"&arrayClassName=${arrayClassName}");
            }
            if (this.id == "edit") {
                $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/selectArrayClassResultStudentById?id="+id);
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
        roleTable.ajax.url("<%=request.getContextPath()%>/arrayClassResultClass/selectArrayClassResultStudentList" +
            "?classId="+classId+"&studentId="+studentId).load();
    }

</script>
