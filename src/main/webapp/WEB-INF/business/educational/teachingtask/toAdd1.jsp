<%--
  Created by IntelliJ IDEA.
  User: ZhangHao
  Date: 2018/3/15
  Time: 09:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="ttId" type="hidden" value="${toEdit.id}">
        </div>
        <div class="modal-body clearfix">

            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学年/学期
                    </div>
                    <div class="col-md-9">
                        <select id="addOrEdit_semester" class="form-control">
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            系部
                        </div>
                        <div class="col-md-9">
                            <select id="deptId" disabled="disabled"  class="validate[required,maxSize[50]] form-control" />
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教师姓名
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_teaId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${toEdit.teacherName}"/>
                        <input id="addOrEdit_teacherId" type="hidden" value="${toEdit.teacherId}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程名称
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_cId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${toEdit.courseName}"/>
                        <input id="addOrEdit_courseId" type="hidden" value="${toEdit.courseId}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        班级
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_cInfo" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${toEdit.className}"/>
                        <input id="addOrEdit_classInfo" type="hidden" value="${toEdit.classInfo}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        班级人数
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_studentNum" type="number" class="validate[required,maxSize[50]] form-control" value="${toEdit.studentNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        周学时
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_weekTime" type="number" class="validate[required,maxSize[50]] form-control" value="${toEdit.weekTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        已聘职称
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_employedTitle" type="text" class="validate[required,maxSize[50]] form-control" value="${toEdit.employedTitle}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        非本系（部）部门
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_otherDept" type="text" class="validate[required,maxSize[50]] form-control" value="${toEdit.otherDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>填表人
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_pBy" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${toEdit.preparedByName}"/>
                        <input id="addOrEdit_preparedBy" type="hidden" value="${toEdit.preparedBy}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>填表时间
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_preparedTime" type="date" class="validate[required,maxSize[50]] form-control" value="${toEdit.preparedTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考核方式
                    </div>
                    <div class="col-md-9">
                        <select id="examMethod" name="examMethod" class="required" msg="请选择考核方式！"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="addOrEdit_remarks" class="form-control" style="resize: none;">${toEdit.remarks}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    function save() {
        var semester = $("#addOrEdit_semester").val();
        var department = $("#deptId").val();
        var teacherId = $("#addOrEdit_teacherId").val();
        var courseId = $("#addOrEdit_courseId").val();
        var classInfo = $("#addOrEdit_classInfo").val();
        var studentNum = $("#addOrEdit_studentNum").val();
        var employedTitle = $("#addOrEdit_employedTitle").val();
        var otherDept = $("#addOrEdit_otherDept").val();
        var preparedBy = $("#addOrEdit_preparedBy").val();
        var preparedTime = $("#addOrEdit_preparedTime").val();
        var weekTime = $("#addOrEdit_weekTime").val();
        var remarks = $("#addOrEdit_remarks").val();

        if (semester == "" || semester == null) {
            swal({
                title: "请选择学年/学期",
                type: "info"
            });
            return;
        }
        if (department == "" || department == null) {
            swal({
                title: "请选择系部",
                type: "info"
            });
            return;
        }
        if (teacherId == "" || teacherId == null) {
            swal({
                title: "请输入教师名称",
                type: "info"
            });
            return;
        }
        if (preparedBy == "" || preparedBy == null) {
            swal({
                title: "请输入填表人",
                type: "info"
            });
            return;
        }
        if (preparedTime == "" || preparedTime == null) {
            swal({
                title: "请输入填表时间",
                type: "info"
            });
            return;
        }
        var examMethod = $("#examMethod").val();
        if (examMethod == "" || examMethod == null) {
            swal({
                title: "请选择考核方式",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/teachingTask/saveTeachingTask", {
            id: $("#ttId").val(),
            semester: semester,
            department: department,
            teacherId: teacherId,
            courseId: courseId,
            classInfo: classInfo,
            studentNum: studentNum,
            weekTime: weekTime,
            employedTitle: employedTitle,
            otherDept: otherDept,
            preparedBy: preparedBy,
            preparedTime: preparedTime,
            remarks: remarks,
            examMethod: examMethod
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#bMGrid').DataTable().ajax.reload();
            } else {
                swal({
                    title: msg.msg,
                    type: "error"
                });
            }
        })
    }

    $(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'deptId', '${toEdit.department}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'addOrEdit_semester', '${toEdit.semester}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCKSKHFF", function (data) {
            addOption(data, 'examMethod', '${toEdit.examMethod}');
        });

        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#addOrEdit_teaId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#addOrEdit_teaId").val(ui.item.label.split("  ----  ")[0]);
                    $("#addOrEdit_teaId").attr("keycode", ui.item.value);
                    $("#addOrEdit_teacherId").val(ui.item.value.split(",")[1]);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };

            $("#addOrEdit_pBy").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#addOrEdit_pBy").val(ui.item.label.split("  ----  ")[0]);
                    $("#addOrEdit_pBy").attr("keycode", ui.item.value);
                    $("#addOrEdit_preparedBy").val(ui.item.value.split(",")[1]);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/common/getCoures", function (data) {
            $("#addOrEdit_cId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#addOrEdit_cId").val(ui.item.label.split("  ----  ")[0]);
                    $("#addOrEdit_cId").attr("keycode", ui.item.value);
                    $("#addOrEdit_courseId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/common/getClassBean", function (data) {
            $("#addOrEdit_cInfo").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#addOrEdit_cInfo").val(ui.item.label);
                    $("#addOrEdit_cInfo").attr("keycode", ui.item.value);
                    $("#addOrEdit_classInfo").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })


    });
</script>


