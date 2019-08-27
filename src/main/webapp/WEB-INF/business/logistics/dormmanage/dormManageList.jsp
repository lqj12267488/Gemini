<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
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
                                楼宇
                            </div>
                            <div class="col-md-2">
                                <select id="edit_buildingId" onchange="onchangeBuilding()"/>
                            </div>
                            <div class="col-md-1 tar">
                                寝室
                            </div>
                            <div class="col-md-2">
                                <select id="edit_dorm" onchange="onchangeDorm()"/>
                            </div>

                            <div class="col-md-1 tar">
                                学生姓名
                            </div>
                            <div class="col-md-2">
                                <select id="edit_student"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                开始时间
                            </div>
                            <div class="col-md-2">
                                <input id="search_startTime" type="date"
                                       class="validate[required,maxSize[100]] form-control">
                            </div>
                            <div class="col-md-1 tar">
                                结束时间
                            </div>
                            <div class="col-md-2">
                                <input id="search_endTime" type="date"
                                       class="validate[required,maxSize[100]] form-control">
                            </div>
                            <div class="col-md-3 tar">

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
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addExam()">新增
                        </button>
                        <br>
                    </div>
                    <table id="examTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="person_id" value="${person_id}" hidden>
<script>
    var personId = $("#person_id").val();
    var table;
    $(document).ready(function () {
        table = $("#examTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/dormmanage/DormManageList?dormManageType=0',
            },
            "destroy": true,
            "columns": [
                {"data": "manageId", "visible": false},
                {"data": "dormitoryId", "visible": false},
                {"data": "teacherId", "visible": false},
                {"data": "buildingName", "title": "楼宇名称"},
                {"data": "dormName", "title": "楼宇寝室"},
                {"data": "studentName", "title": "学生姓名"},
                {"data": "startTime", "title": "开始时间"},
                {"data": "endTime", "title": "结束时间"},
                {"data": "teacherName", "title": "登记老师姓名"},
                {"data": "remark", "title": "备注"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=editExam("' + row.manageId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delExam("' + row.manageId + '","' + row.studentName + '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select b.id id , b.building_name text from t_jw_building b where b.id in " +
                "(select t.building_id from T_ZW_TEACHER_ORDEROFFICE t where t.teacher_id = '" + personId + "'))",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_buildingId", '${DormManage.buildingId}');
            });
    })

    function addExam() {
        $("#dialog").load("<%=request.getContextPath()%>/dormmanage/edit")
        $("#dialog").modal("show")
    }

    function editExam(manageId) {
        $("#dialog").load("<%=request.getContextPath()%>/dormmanage/edit?manageId=" + manageId)
        $("#dialog").modal("show")
    }

    function delExam(manageId, studentName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "学生姓名：" + studentName + "  删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/dormmanage/delete", {
                manageId: manageId
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#examTable').DataTable().ajax.reload();
            });
        })
    }

    function searchclear() {
        $("#search_endTime").val("");
        $("#search_startTime").val("");
        $("#edit_buildingId").val("");
        $("#edit_dorm").val("");
        $("#edit_student").val("");

        table.ajax.url("<%=request.getContextPath()%>/dormmanage/DormManageList?dormManageType=0").load();
    }

    function search() {
        var endTime = $("#search_endTime").val();
        var startTime = $("#search_startTime").val();
        var buildingId = $("#edit_buildingId").val();
        var dorm = $("#edit_dorm").val();
        var student = $("#edit_student").val();
        if (endTime != ""&&startTime!="") {
            var str = $("#search_endTime").val();  //命名一个变量保存获取的input里面的时间
            // 创建日期对象
            var date = new Date(str);
            //// 加一天
            date.setDate(date.getDate() + 1);
            endTime = date.getFullYear() + '-'
                // 因为js里month从0开始，所以要加1
                + (parseInt(date.getMonth()) + 1) + '-'
                + date.getDate();
        }

        table.ajax.url("<%=request.getContextPath()%>/dormmanage/DormManageList?dormManageType=0&type=1" + "&startTime=" + startTime + "&endTime=" + endTime + "&buildingId=" + buildingId + "&dormitoryId=" + dorm + "&studentId=" + student).load();
    }

    function onchangeBuilding() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select d.id id , d.dorm_name text from T_JW_DORM d where d.building_id ='" + $("#edit_buildingId").val() + "')",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_dorm", '${teacherPlanJob.buildingId}');
            });
    }

    function onchangeDorm() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select t.student_id id ,FUNC_GET_TABLEVALUE(t.student_id,'t_xg_student','student_id','name') text  from T_XG_DORM_ADJUST_RESULT t where t.dorm_id = '" + $("#edit_dorm").val() + "')",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_student", '${DormManage.studentId}');
            });
    }

</script>