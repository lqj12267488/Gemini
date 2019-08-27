<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/27
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="studentId" hidden value="${league.studentId}">
            <input id="classId" hidden value="${league.classId}">
            <input id="id" hidden value="${league.id}">
            <input id="branchId" type="hidden" value="${league.branchId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 团员证号：
                    </div>
                    <div class="col-md-9">
                        <input id="membersNumber" type="text" value="${league.leagueMembersNumber}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 姓名：
                    </div>
                    <div class="col-md-9">
                        <input id="studentName"
                                class="js-example-basic-single" value="${league.studentName}" ></input>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 团内职务：
                    </div>
                    <div class="col-md-9">
                        <select id="memberDuties" class="js-example-basic-single" value="${league.memberDutiesId}" ></select>
                    </div>
                </div>
                <div class="form-row" id="joinParty">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 入团时间：
                    </div>
                    <div class="col-md-9">
                        <input id="joinleagueTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${league.joinleagueTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark" type="text"
                                  class="validate[required,maxSize[20]] form-control"
                                  value="${league.remark}">${league.remark}</textarea>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveLeague()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        var id = $("#id").val();
        if (id != '') {
            $("#studentName").attr("disabled", "disabled");
        }
        autoComplateOption("studentName", "<%=request.getContextPath()%>/common/getStudentClassByName");
        /*$.get("<%=request.getContextPath()%>/common/getStudentClass", function (data) {
            $("#studentName").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#studentName").val(ui.item.label);
                    $("#studentName").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })*/
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TNZW", function (data) {
            addOption(data, 'memberDuties', '${league.memberDutiesId}');
        });
    })
    function saveLeague() {
        var id=$("#id").val();
        var branchId=$("#branchId").val();
        var membersNumber = $("#membersNumber").val();
        var memberDuties = $("#memberDuties option:selected").val();
        var joinleagueTime = $("#joinleagueTime").val().replace('T',' ');
        var studentId;
        var classId;
        var studentName = $("#studentName").val();
        var studentClass = $("#studentName").attr("keycode");
        if (studentName == "" || studentName == null || studentName == undefined) {
            swal({
                title: "请填写姓名！",
                type: "info"
            });
            return;
        } else {
            if (studentClass == "" || studentClass == null || studentClass == undefined) {
                studentId = $("#studentId").val();
                classId = $("#classId").val();
            } else {
                var headT = $("#studentName").attr("keycode");
                var studentList = headT.split(",");
                studentId = studentList[1];
                classId = studentList[0];
            }
        }
        $.post("<%=request.getContextPath()%>/league/checkName", {
            studentId: studentId,
            id: $("#id").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "error"});
            }else{
                showSaveLoading();
                $.post("<%=request.getContextPath()%>/league/saveLeague", {
                    id:id,
                    branchId: branchId,
                    membersNumber: $("#membersNumber").val(),
                    studentId: studentId,
                    classId: classId,
                    memberDuties: $("#memberDuties option:selected").val(),
                    joinleagueTime: joinleagueTime,
                    remark: $("#remark").val()
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        $("#dialog").modal('hide');
                        $('#leagueGrid').DataTable().ajax.reload();
                    }
                })
            }
        });
    }
</script>


