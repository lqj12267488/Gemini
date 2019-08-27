<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/9
  Time: 15:11
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
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="departmentsIdSel" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-2">
                                <input id="classIdSel" placeholder="请输入班级名称"   type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                学生姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="studentIdSel" placeholder="请输入学生姓名"   type="text"/>
                                <%-- <select id="studentIdSel" class="js-example-basic-single"></select>--%>
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
                        <table id="internshipManageGrid" cellpadding="0" cellspacing="0"
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
    var roleTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " "
            },
            function (data) {
                addOption(data, "departmentsIdSel");
            });
        roleTable = $("#internshipManageGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/internshipManage/InternshipManageAction',
                "data": {

                }
            },
            "destroy": true,
            "columns": [
                {"data": "internshipId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "8%", "data": "departmentsIdShow", "title": "系部"},
                {"width": "7%", "data": "classIdShow", "title": "班级"},
                {"width": "8%", "data": "studentIdShow", "title": "学生"},
                {"width": "7%", "data": "majorCodeShow", "title": "专业"},
                {"width": "10%", "data": "internshipUnitIdShow", "title": "实习单位"},
                {"width": "10%", "data": "idcard", "title": "身份证号"},
                {"width": "10%", "data": "postsTime", "title": "上岗时间"},
                {"width": "10%", "data": "internshipTypeShow", "title": "实习形式"},
                {"width": "9%", "data": "sexShow", "title": "性别"},
                {"width": "8%", "data": "salaryShow", "title": "工资"},
                {"width": "13%", "data": "majorMatchFlagShow", "title": "专业是否对口"},

            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });


    })


    function addInternshipManage() {
        $("#dialog").load("<%=request.getContextPath()%>/internshipManage/addInternshipManage");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#departmentsIdSel").val("");
        $("#studentIdSel").val("");
        $("#classIdSel").val("");
        search();
    }

    function search() {
        var departmentsId = $("#departmentsIdSel option:selected").val();
        var classId = $("#classIdSel").val();
        roleTable.ajax.url("<%=request.getContextPath()%>/internshipManage/InternshipManageAction?departmentsId=" + departmentsId + "&classId=" + classId + "&studentId=" + $("#studentIdSel").val()).load();
    }
</script>

