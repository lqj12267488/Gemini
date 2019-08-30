<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 18:17
  To change this template use File | Settings | File Templates.
--%>

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
                                申请日期：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                学生姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="s_student" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                学号：
                            </div>
                            <div class="col-md-2">
                                <input id="s_studentNum" type="text"/>
                            </div>
                        </div>
                        <div>
                            <div class="col-md-1 tar">
                                就读专业：
                            </div>
                            <div class="col-md-2">
                                <input id="s_major" type="text">
                            </div>
                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-2">
                                <input id="s_class" type="text">
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="studentProveGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_XG_STUDENT_PROVE_WF">
<input id="workflowCode" hidden>
<input id="businessId" hidden>
<input id="studentIdShow" hidden value="${studentProve.studentId}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var studentProveTable;
    $(document).ready(function () {
        search();
        studentProveTable.on('click', 'tr a', function () {
            var data = studentProveTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editstudentProve") {
                $("#dialog").load("<%=request.getContextPath()%>/studentProve/getStudentProveById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delstudentProve") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "学生姓名：" + data.studentId + "的请假\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/studentProve/deleteStudentProveById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#studentProveGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();
            }
            if (this.id == "upload") {
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_XG_STUDENT_PROVE_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/studentProve/editStudentProve");
        $("#dialog").modal("show");

    }

    function searchClear() {
        $("#date").val("");
        $("#s_student").val("");
        $("#s_studentNum").val("");
        $("#s_major").val("");
        $("#s_classId").val("");
        search();
    }

    function search() {
        var date = $("#date").val();
        if (date != "")
            date = date;
        var requesters = $("#s_student").val();
        var studentNumbers = $("#s_studentNum").val();
        var majorCodes = $("#s_major").val();
        var classIds = $("#s_classId").val();
        studentProveTable = $("#studentProveGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/studentProve/getStudentProveList',
                "data": {
                    requestDate: date,
                    studentNumber: studentNumbers,
                    studentId: requesters,
                    majorCode: majorCodes,
                    classId: classIds,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "11%", "data": "requestDate", "title": "申请日期"},
                {"width": "11%", "data": "studentId", "title": "学生姓名"},
                {"width": "11%", "data": "studentNumber", "title": "学号"},
                {"width": "11%", "data": "majorCode", "title": "就读专业"},
                {"width": "11%", "data": "classId", "title": "班级"},
                {"width": "11%", "data": "proveReason", "title": "证明原因"},
                {"width": "12%", "data": "receiveCompany", "title": "证明接收单位"},
                {
                    "width": "11%", "title": "操作", "render": function () {
                        return "<a id='editstudentProve' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delstudentProve' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='submit' class='icon-upload-alt' title='提交'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    function getAuditer() {
        $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer")
    }

    function audit() {
        var personId;
        var handleName;
        var select = $("#personId").html();
        if (select != undefined) {
            if (handleName == undefined) {
                handleName = $("#personId option:selected").text();
            }
            if (personId == undefined) {
                personId = $("#personId option:selected").val();
            }
        } else {
            if (handleName == undefined) {
                handleName = $("#name").val();
            }
            if (personId == undefined) {
                personId = $("#personIds").val();
            }

        }
        if (personId == '' || personId == null || personId == "" || personId == undefined) {
            swal({
                title: "请选择办理人!",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_XG_STUDENT_PROVE_WF",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName,
            },
            function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    $("#dialog").modal("hide");
                    $('#studentProveGrid').DataTable().ajax.reload();
                }
            })
    }
</script>
