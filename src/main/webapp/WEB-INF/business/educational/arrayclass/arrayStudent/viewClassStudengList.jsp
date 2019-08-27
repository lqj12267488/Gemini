<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
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
                                学生：
                            </div>
                            <div class="col-md-2">
                                <input id="studentSel"/>
                            </div>
                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-2">
                                <input id="classSel" ></input>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchStudent()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchStudentclear()">清空
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
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addClassStudent()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="classStudentGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="arrayCId" value="${arrayClassId}" hidden>
</div>
<script>
    var classStudentGrid;
    $(document).ready(function () {

        classStudentGrid = $("#classStudentGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClass/student/selectClassStudengList?arrayclassId='+ $("#arrayCId").val() ,
            },
            "destroy": true,
            "columns": [
                {"width": "20%", "data": "studentName", "title": "学生"},
                {"width": "10%", "data": "studentId", "title": "学号"},
                {"width": "15%", "data": "classIdShow", "title": "班级"},
                {"width": "15%", "data": "majorCodeShow", "title": "专业"},
                {"width": "15%", "data": "trainingLevelShow", "title": "方向"},
                {"width": "15%", "data": "departmentsIdShow", "title": "系部"},
                {"data": "studentId", "visible": false},
                {"data": "arrayclassId", "visible": false},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return  '<span class="icon-trash" title="删除" onclick=delClassStudeng("' + row.id + '","' + row.studentName + '")/>' ;
                    }
                }
            ],
            'order' : [[2,'desc'],[1,'desc']],
            "dom": 'rtlip',
            language: language
        });

    })

    function delClassStudeng(id,studentName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "学生姓名："+studentName+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/arrayClass/student/delClassTeacher", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#classStudentGrid').DataTable().ajax.reload();
            });
        })
    }

    function searchStudentclear() {
        $("#studentSel").val("");
        $("#classSel").val("");
        searchStudent();
    }

    function searchStudent() {
        var studentId = $("#studentSel").val();
        var classId = $("#classSel").val();;

        classStudentGrid.ajax.url('<%=request.getContextPath()%>/arrayClass/student/selectClassStudengList?arrayclassId='+ $("#arrayCId").val()+
            '&studentName='+studentId + '&classIdShow='+classId  ).load();
    }


    function addClassStudent(){
        $("#dialog").load("<%=request.getContextPath()%>/arrayClass/student/addClassStudent?arrayclassId="+ $("#arrayCId").val());
        $("#dialog").modal("show");

    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClass/student/getStudentClassList");
    }

</script>