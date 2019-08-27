<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/14
  Time: 8:52
  To change this template use File | Settings | File Templates.
--%>
<%--楼宇场地维护首页--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">

                    <div class="content block-fill-white">

                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学期：
                            </div>
                            <div class="col-md-2">
                                <select id="s_semester"/>
                            </div>
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="f_departmentId"/>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <select id="prize"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                考试名称：
                            </div>
                            <div class="col-md-2">
                                <input id="s_name"/>
                            </div>
                            <div class="col-md-1 tar">
                                考试科目：
                            </div>
                            <div class="col-md-2">
                                <select id="s_course"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addExamTopic()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="examTopic" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_JW_EXAM_TOPIC">
<input id="businessId" hidden>
<script>

    var roleTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 's_semester');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"COURSE_ID",
            text:"COURSE_NAME",
            tableName:"T_JW_COURSE",
            where:" ",
            orderBy:""
        }, function (data) {
            addOption(data, 's_course');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"dept_id",
            text:"dept_name",
            tableName:"T_SYS_DEPT",
            where:"WHERE dept_type = 8 ",
            orderBy:""
        }, function (data) {
            addOption(data, 'f_departmentId');
        });
        $("#f_departmentId").change(function () {
            if($("#f_departmentId").val() != ""){
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"major_code",
                    text:"major_name",
                    tableName:"T_XG_MAJOR",
                    where:"WHERE departments_id = '" + $("#f_departmentId").val() +"' ",
                    orderBy:""
                }, function (data) {
                    addOption(data, 'prize');
                });
            }

        })
        search();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var projectName = data.examId;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/examTopic/getExamTopicById?id=" + id);
                $("#dialog").modal("show");
            }
            if(this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_JW_EXAM_TOPIC');
                $('#dialogFile').modal('show');
            }
            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "项目名称："+projectName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/examTopic/deleteExamTopicById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#examTopic').DataTable().ajax.reload();
                        }
                    })

                });

            }

        });
    });
    function addExamTopic() {
        $("#dialog").load("<%=request.getContextPath()%>/examTopic/addExamTopic");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#s_name").val("");
        $("#s_course").val("");
        $("#s_course option:selected").val("");
        $("#s_semester").val("");
        $("#s_semester option:selected").val("");
        $("#prize").val("");
        $("#prize option:selected").val("");
        $("#f_departmentId").val("");
        $("#f_departmentId option:selected").val("");
        search();
    }

    function search() {
        roleTable = $("#examTopic").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/examTopic/getExamTopicList',
                "data": {
                    semester:$("#s_semester option:selected").val(),
                    examCourse:$("#s_course option:selected").val(),
                    examId:$("#s_name").val(),
                    departmentsId:$("#f_departmentId option:selected").val(),
                    majorCode:$("#prize option:selected").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "15%", "data": "examId", "title": "考试名称"},
                {"width": "15%", "data": "departmentsId", "title": "系部"},
                {"width": "15%", "data": "majorCode", "title": "专业"},
                {"width": "15%", "data": "examCourse", "title": "考试科目"},
                {"width": "15%", "data": "semester", "title": "学期"},
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='upload' class='icon-cloud-upload' title='上传'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [1,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });

    }
</script>


