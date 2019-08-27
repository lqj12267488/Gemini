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
                                所属班级：
                            </div>
                            <div class="col-md-1">
                                <input id="classNameSe" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-1">
                                <select id="departmentsIdSel" onchange="changeMajor()" type="text"></select>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-1">
                                <select id="majorIdSel" type="text"></select>
                            </div>
                            <div class="col-md-1 tar">
                                学生姓名：
                            </div>
                            <div class="col-md-1">
                                <input id="studentNameSe" type="text"/>
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
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean" onclick="exportSchoolReportAll()">导出
                            </button>
                            <button type="button" class="btn btn-default btn-clean" onclick="exportSchoolReport()">
                                导出当前数据
                            </button>
                            <br>
                        </div>
                        <table id="schoolReportGrid" cellpadding="0" cellspacing="0"
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
    var schoolReportTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " dept_id",
            text: " dept_name ",
            tableName: "T_SYS_DEPT",
            where: " WHERE DEPT_TYPE =8 ",
            orderby: "  "
        }, function (data) {
            addOption(data, "departmentsIdSel");
        });

        search();
    });
    function changeMajor() {
        var deptId = $("#departmentsIdSel").val();
        $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorIdSel');
        });
    }

    function searchclear() {
        $("#classNameSe").val("");
        $("#studentNameSe").val("");
        $("#departmentsIdSel").val("");
        $("#majorIdSel").val("");
        search();
    }

    function search() {
        var classNameSe = $("#classNameSe").val();
        var studentNameSe = $("#studentNameSe").val();
        var departmentId = $("#departmentsIdSel").val();
        var majorIdSel = $("#majorIdSel").val();
        if(null == majorIdSel || "" == majorIdSel){
            majorIdSel = "";
        }else{
            majorIdSel = $("#majorIdSel").val().split(",")[0];
        }
        schoolReportTable = $("#schoolReportGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/schoolReport/getSchoolReportList',
                "data": {
                    studentName: studentNameSe,
                    className: classNameSe,
                    departmentsId: departmentId,
                    majorId: majorIdSel
                }
            },
            "destroy": true,
            "columns": [
                {
                    width: "10%",
                    "title": '<input type="checkbox" class="checkall"/>',
                    "render": function (data, type, row) {
                        return '<input type="checkbox" name="checkbox" value="' + row.studentId + '"/>';
                    }
                },
                {"width": "10%", "data": "studentName", "title": "学生姓名"},
                {"width": "20%", "data": "className", "title": "所属班级"},
                {"width": "20%", "data": "departmentName", "title": "系部"},
                {"width": "20%", "data": "majorName", "title": "专业"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<a id="ex" href="<%=request.getContextPath()%>/schoolReport/exportSchoolReport?ids=' + row.studentId + '" class="icon-download" title="导出"></a>';
                    }
                }
            ],
            columnDefs: [{
                targets: 0,
                orderable: false
            }],
            'order': [2, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });

        $(".checkall").bind("click", function () {
            if ($(this).attr("checked") == 'checked') {
                $("input[name=checkbox]").attr("checked", true)
            } else {
                $("input[name=checkbox]").attr("checked", false)
            }
        });
    }

    function exportSchoolReportAll() {
        window.location.href = "<%=request.getContextPath()%>/schoolReport/exportSchoolReport?classId=" + $("#classNameSe").val()
            + "&deptId=" + $("#departmentsIdSel").val() + "&majorId=" + $("#majorIdSel").val() + "&studentName=" + $("#studentNameSe").val();
    }

    function exportSchoolReport() {
        var ids = "";
        $("input[name=checkbox]").each(function (index, item) {
            if ($(item).attr("checked") == 'checked') {
                ids += $(item).val() + ",";
            }
        });
        if (ids == "") {
            swal({
                title: "请选择要导出的学生！",
                type: "error"
            })
        } else {
            window.location.href = "<%=request.getContextPath()%>/schoolReport/exportSchoolReport?ids=" + ids.substring(0, ids.length - 1)
        }
    }
</script>
