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
                                教师姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="teacherName" class="js-example-basic-single"></input>
                            </div>
                            <div class="col-md-1 tar">
                                学历：
                            </div>
                            <div class="col-md-2">
                                <select id="education"/>
                            </div>
                            <div class="col-md-1 tar">
                                学位：
                            </div>
                            <div class="col-md-2">
                                <select id="degee" type="text"/>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XL", function (data) {
            addOption(data, 'education');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XW", function (data) {
            addOption(data, 'degee');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PXJB", function (data) {
            addOption(data, 'trainingLevel');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${data.departmentsId}');
        });
        $("#major").append("<option value='' selected>请选择</option>")
        table = $("#toResultTeacherTable").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/teacher/getEducationImproveList',

            },
            "destroy": true,
            "columns": [
                {"data": "teacherId", "visible": false},
                {"data": "createTime", "visible": false},
                {
                    "data": "teacherName",
                    "title": "教师姓名",
                    "render": function (data, type, row) {
                        return '<span onclick=toShowTeacherCondition("' + row.personId + '")>'+row.teacherName+'</span>';
                    }
                },
                {"data":"education","title":"学历"},
                {"data":"degee","title":"学位"},
                {"data":"finishSchool","title":"毕业院校"},
                {"data":"majorShow","title":"专业"},
                {"data":"getTime","title":"获得时间"},
                { "title": "操作",
                    "render": function (date,type,row) {
                        return '<span class="icon-edit" title="修改" onclick=editTeacherArray("' + row.teacherId + '")/>&ensp;&ensp;'+
                            '<span class="icon-trash" title="删除" onclick=delTeacherArray("' + row.teacherId + '")/>&ensp;&ensp;';
                    }
                }
            ],
            'order' : [1,'desc'],
             paging: true,
            "dom": 'rtlip',
            "language": language
        });
    })
    function editTeacherArray(teacherId) {
        $("#dialog").load("<%=request.getContextPath()%>/teacher/educationImproveToAdd?teacherId=" + teacherId)
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
            $.post("<%=request.getContextPath()%>/teacher/delEducationImprove", {
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
        $("#teacherName").val("");
        $("#education").val("");
        $("#degee").val("");
        table.ajax.url("<%=request.getContextPath()%>/teacher/getEducationImproveList").load();
    }

    function search() {
        var teacherName = $("#teacherName").val();
        var education =  $("#education").val();
        var degee =  $("#degee").val();
        table.ajax.url("<%=request.getContextPath()%>/teacher/getEducationImproveList?teacherName="+teacherName+"&education="+education+"&degee="+degee).load();
    }
    function addExam() {
        $("#dialog").load("<%=request.getContextPath()%>/teacher/educationImproveToAdd")
        $("#dialog").modal("show")
    }
    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/common/getMajorByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'major');
        });
    }

    /**
     * 弹出教师自然状态页面
     */
    function toShowTeacherCondition(id) {
        $("#dialog").load("${pageContext.request.contextPath}/teacher/showTeacherCondition?teacherId="+id);
        $("#dialog").show();
    }
</script>