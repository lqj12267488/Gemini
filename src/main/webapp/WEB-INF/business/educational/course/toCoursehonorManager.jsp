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
     <input  id="courseHonorId"  name="courseHonorId" value="${courseHonorId}"  hidden  />
    <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addCoursehonor()">
                            新增
                        </button>
                       &nbsp;&nbsp;
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="coursehonor" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="businessId" hidden>
<script>

    var couresTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"COURSE_ID",
            text:"CLASS_NAME",
            tableName:"T_JW_COURSECONSTR",
            where:" ",
            orderBy:""
        }, function (data) {
            addOption(data, 'courseName');
        });
        $.get("<%=request.getContextPath()%>/common/getUserDict?name=RYMC", function (data) {
            addOption(data, 'honorName');
        });
        search();

        courseTable.on('click', 'tr a', function () {
            var data = courseTable.row($(this).parent()).data();
            var id = data.courseHonorId;
            var chid= data.id;
            var courseName = data.courseName;
            if (this.id == "uHonor") {
                $("#dialog").load("<%=request.getContextPath()%>/coursehonor/editCoursehonorManageById?id=" + chid);
                $("#dialog").modal("show");
            }
            if(this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_JW_EXAM_TOPIC');
                $('#dialogFile').modal('show');
            }
            if (this.id == "manage") {
                $("#dialog").load("<%=request.getContextPath()%>/coursehonor/toCoursehonorManager?id=" + id);
                $("#dialog").modal("show");
            }

            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "课程名称："+courseName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/coursehonor/deleteCoursehonorManageById?id=" + chid, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#coursehonor').DataTable().ajax.reload();
                        }
                    })

                });

            }

        });
    });
    function addCoursehonor() {
        $("#dialog").load("<%=request.getContextPath()%>/coursehonor/addCoursehonorManage?id"+$("#courseHonorId").val());
        $("#dialog").modal("show");
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/coursehonor/coursehonorList");
        $("#right").modal("show");
    }

    function search() {
        courseTable = $("#coursehonor").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/coursehonor/getCoursehonorManagelList',
                "data": {
                    courseHonorId:$("#courseHonorId").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "courseHonorId", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "12%", "data": "honorLevel",  "title": "荣誉等级"},
                {"width": "12%", "data": "ownTime",     "title": "获得时间"},
                {"width": "12%", "data": "validTime",   "title": "有效期"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uHonor' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";

                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });

    }
</script>