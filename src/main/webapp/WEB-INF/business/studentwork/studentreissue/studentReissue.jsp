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
                                身份证号：
                            </div>
                            <div class="col-md-2">
                                <input id="s_idcard" type="text"/>
                            </div>
                        </div>
                        <div>
                            <div class="col-md-1 tar">
                                学号：
                            </div>
                            <div class="col-md-2">
                                <input id="s_studentNum" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
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
                        <table id="studentReissueGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_XG_STUDENT_REISSUE_WF">
<input id="workflowCode" hidden value="T_XG_STUDENT_REISSUE_WF01">
<input id="businessId" hidden>
<input id="studentIdShow" hidden value="${studentReissue.studentId}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var studentReissueTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/studentReissue/autoCompleteDept", function (data) {
            $("#s_class").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#s_class").val(ui.item.label);
                    $("#s_class").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/studentReissue/autoCompleteEmployee", function (data) {
            $("#s_major").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#s_major").val(ui.item.label);
                    $("#s_major").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        search();
        studentReissueTable.on('click', 'tr a', function () {
            var data = studentReissueTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editstudentReissue") {
                $("#dialog").load("<%=request.getContextPath()%>/studentReissue/getStudentReissueById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delstudentReissue") {
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
                    $.get("<%=request.getContextPath()%>/studentReissue/deleteStudentReissueById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#studentReissueGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();
            }
            if (this.id == "upload") {
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_XG_STUDENT_REISSUE_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/studentReissue/editStudentReissue");
        $("#dialog").modal("show");

    }

    function searchClear() {
        $("#s_idcard").val("");
        $("#date").val("");
        $("#s_student").val("");
        $("#s_studentNum").val("");
        $("#s_major").val("");
        $("#s_class").val("");
        search();
    }

    function search() {
        var date = $("#date").val();
        if (date != "")
            date = date;
        var requesters = $("#s_student").val();
        var idacars = $("#s_idcard").val();
        var studentNumbers = $("#s_studentNum").val();
        var majorCodes = $("#s_major").val();
        var classIds = $("#s_class").val();
        studentReissueTable = $("#studentReissueGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/studentReissue/getStudentReissueList',
                "data": {
                    requestDate: date,
                    studentNumber: studentNumbers,
                    studentId: requesters,
                    majorCode: majorCodes,
                    classId: classIds,
                    idcard:idacars
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "6%", "data": "requestDate", "title": "申请日期"},
                {"width": "6%", "data": "studentId", "title": "学生姓名"},
                {"width": "6%", "data": "nation", "title": "民族"},
                {"width": "6%", "data": "sex", "title": "性别"},
                {"width": "7%", "data": "classId", "title": "班级"},
                {"width": "7%", "data": "majorCode", "title": "专业"},
                {"width": "7%", "data": "studentNumber", "title": "学号"},
                {"width": "7%", "data": "idcard", "title": "身份证号"},
                {"width": "7%", "data": "rideZone", "title": "乘车区间"},
                {"width": "7%", "data": "familyAddress", "title": "家庭地址"},
                {"width": "7%", "data": "phone", "title": "电话"},
                {"width": "7%", "data": "nativePlace", "title": "籍贯"},
                {"width": "7%", "data": "requestProject", "title": "申请项目"},
                {"width": "7%", "data": "requestReason", "title": "申请理由"},
                {
                    "width": "6%", "title": "操作", "render": function () {
                        return "<a id='editstudentReissue' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delstudentReissue' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
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
                tableName: "T_XG_STUDENT_REISSUE_WF",
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
                    $('#studentReissueGrid').DataTable().ajax.reload();
                }
            })
    }
</script>
