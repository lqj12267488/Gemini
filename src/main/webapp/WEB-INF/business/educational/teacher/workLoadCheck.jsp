<%--
  Created by wym.
  User: Admin
  Date: 2018/6/22
  Time: 9:19
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
                                <select id="departmentsId" onchange="changeMajor()"/>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <select id="major"/>
                            </div>
                            <div class="col-md-1 tar">
                                教师姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="teacherName" class="js-example-basic-single"></input>
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
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addExam()">新增
                        </button>
                        <br>
                    </div>
                    <table id="toResultTeacherTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${data.departmentsId}');
        });
        $("#major").append("<option value='' selected>请选择</option>")
        table = $("#toResultTeacherTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/workLoad/checkList',
            },
            "destroy": true,
            "columns": [
                {"data": "teacherId", "visible": false},
                {"data":"teacherName","title":"教师姓名"},
                {"data":"hours","title":"教师授课情况课时数"},
                {"data":"raceHours","title":"竞赛辅导班课时数"},
                {"data":"lectureClassHours","title":"讲座班级课时数"},
                {"data":"teachingSecretariesHours","title":"教学秘书课时数"},
                {"data":"otherHours","title":"其他工作课时数"},
                { "title": "操作",
                    "render": function (date,type,row) {
                        return '<a class="icon-search" title="查看" id="searchTeacherExamArrayResult"/>&ensp;&ensp;'+
                            '<span class="icon-edit" title="修改" onclick=editTeacherArray("' + row.teacherId + '")/>&ensp;&ensp;'+
                            '<span class="icon-trash" title="删除" onclick=delTeacherArray("' + row.teacherId + '")/>&ensp;&ensp;';
                    }
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            if(this.id == "searchTeacherExamArrayResult"){
                $("#right").load( "<%=request.getContextPath()%>/workLoad/checkContent?teacherId="+data.teacherId);
            }
        });
    })
    function editTeacherArray(teacherId) {
        $("#dialog").load("<%=request.getContextPath()%>/workLoad/checkContentEdit?teacherId=" + teacherId)
        $("#dialog").modal("show")
    }

    function delTeacherArray(teacherId) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/workLoad/delContentById", {
                teacherId: teacherId
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#toResultTeacherTable').DataTable().ajax.reload();
            });
        })
    }
    function searchclear() {
        $("#departmentsId").val("");
        $("#major").val("");
        $("#teacherName").val("");
        table.ajax.url("<%=request.getContextPath()%>/workLoad/checkOne").load();
    }

    function search() {
        var departmentsId = $("#departmentsId").val();
        var major =  $("#major").val();
        var teacherName =  $("#teacherName").val();
            table.ajax.url("<%=request.getContextPath()%>/workLoad/checkOne?departmentsId="+departmentsId+"&major="+major+"&teacherName="+teacherName).load();
    }
    function addExam() {
        $("#dialog").load("<%=request.getContextPath()%>/workLoad/toAdd")
        $("#dialog").modal("show")
    }
    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/common/getMajorByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'major');
        });
    }
</script>