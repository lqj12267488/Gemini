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
                                培训级别：
                            </div>
                            <div class="col-md-2">
                                <select id="trainingLevel"/>
                            </div>
                            <div class="col-md-1 tar">
                                培训内容：
                            </div>
                            <div class="col-md-2">
                                <input id="trainingContent"/>
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
                "url": '<%=request.getContextPath()%>/teacher/trainingList',
            },
            "destroy": true,
            "columns": [
                {"data": "teacherId", "visible": false},
                {
                    "data": "teacherName",
                    "title": "教师姓名",
                    "render": function (data, type, row) {
                        return '<span onclick=toShowTeacherCondition("' + row.personId + '")>'+row.teacherName+'</span>';
                    }
                },
                {"data":"trainingLevelShow","title":"培训级别"},
                {"data":"trainingContent","title":"培训内容"},
                {"data":"trainingDate","title":"培训日期"},
                {"data":"trainingDay","title":"培训天数"},
                {"data":"trainingPlace","title":"培训地点"},
                {"data":"trainingConclusion","title":"培训结论"},
                { "title": "操作",
                    "render": function (date,type,row) {
                        return '<span class="icon-edit" title="修改" onclick=editTeacherArray("' + row.teacherId + '")/>&ensp;&ensp;'+
                            '<a id="upload" class="icon-cloud-upload" title="上传心得和证书" onclick=addFiles("' + row.teacherId + '")></a>&nbsp;&nbsp;&nbsp;'+
                            '<span class="icon-trash" title="删除" onclick=delTeacherArray("' + row.teacherId + '")/>&ensp;&ensp;';
                    }
                }
            ],
             paging: true,
            "dom": 'rtlip',
            "language": language
        });
        <%--table.on('click', 'tr a', function () {--%>
            <%--var data = table.row($(this).parent()).data();--%>
            <%--if(this.id == "searchTeacherExamArrayResult"){--%>
                <%--$("#right").load( "<%=request.getContextPath()%>/workLoad/checkContent?teacherId="+data.teacherId);--%>
            <%--}--%>
        <%--});--%>
    })
    function editTeacherArray(teacherId) {
        $("#dialog").load("<%=request.getContextPath()%>/teacher/teacherTrainingtoAdd?teacherId=" + teacherId)
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
            $.post("<%=request.getContextPath()%>/teacher/delTeacherTrainingById", {
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
        $("#trainingLevel").val("");
        $("#trainingContent").val("");
        table.ajax.url("<%=request.getContextPath()%>/teacher/trainingList").load();
    }

    function search() {
        var teacherName = $("#teacherName").val();
        var trainingLevel =  $("#trainingLevel").val();
        var trainingContent =  $("#trainingContent").val();
        table.ajax.url("<%=request.getContextPath()%>/teacher/trainingList?teacherName="+teacherName+"&trainingLevel="+trainingLevel+"&trainingContent="+trainingContent).load();
    }
    function addExam() {
        $("#dialog").load("<%=request.getContextPath()%>/teacher/teacherTrainingtoAdd")
        $("#dialog").modal("show")
    }
    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/common/getMajorByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'major');
        });
    }
    function addFiles(teacherId) {
        $("#dialogFile").load("<%=request.getContextPath()%>/files/filesUploadCompetition?businessId="+teacherId+"&businessType=&tableName=");
        $("#dialogFile").modal("show");
    }

    /**
     * 弹出教师自然状态页面
     */
    function toShowTeacherCondition(id) {
        $("#dialog").load("${pageContext.request.contextPath}/teacher/showTeacherCondition?teacherId="+id);
        $("#dialog").show();
    }
</script>
