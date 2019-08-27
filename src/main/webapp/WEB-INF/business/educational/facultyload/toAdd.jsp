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

            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学期
                    </div>
                    <div class="col-md-9">
                        <select id="addOrEdit_term" class="form-control" onchange="findTeachingTask();">
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>班级
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_cInfo" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${toEdit.className}"/>
                        <input id="addOrEdit_classId" type="hidden" value="${toEdit.classId}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程名称
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_cId" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${toEdit.courseName}"/>
                        <input id="addOrEdit_courseId" type="hidden" value="${toEdit.courseId}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        系部
                    </div>
                    <div class="col-md-9">
                        <input id="deptSel" type="text" value="${toEdit.deptName}"
                               class="validate[required,maxSize[50]] form-control" readonly/>
                        <input id="addOrEdit_deptId" type="hidden" value="${toEdit.deptId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        教师姓名
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_teaId" type="text" value="${toEdit.teacherName}"
                               class="validate[required,maxSize[50]] form-control" readonly/>
                        <input id="addOrEdit_teacherId" type="hidden" value="${toEdit.teacherId}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        班级人数
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_studentNum" type="number"
                               class="validate[required,maxSize[50]] form-control" readonly
                               value="${toEdit.studentNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        周课时
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_weekTime" type="number" class="validate[required,maxSize[50]] form-control"
                               readonly value="${toEdit.weekTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教学周数
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_weekNum" type="number" class="validate[required,maxSize[50]] form-control"
                               onkeyup="checkPainTime();" value="${toEdit.weekNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        计划课时
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_painTime" type="number" class="validate[required,maxSize[50]] form-control"
                               readonly value="${toEdit.painTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>停课课时
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_stopTime" type="text" class="validate[required,maxSize[50]] form-control"
                               onkeyup="checkRealTime();" value="${toEdit.stopTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        停课原因
                    </div>
                    <div class="col-md-9">
                        <textarea id="addOrEdit_stopInfo" class="form-control"
                                  style="resize: none;">${toEdit.stopInfo}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        实际课时
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_realTime" type="text" class="validate[required,maxSize[50]] form-control"
                               readonly value="${toEdit.realTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课酬标准
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_payRule" type="text" class="validate[required,maxSize[50]] form-control"
                               value="${toEdit.payRule}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        应付酬金
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_painPay" type="text" class="validate[required,maxSize[50]] form-control"
                               value="${toEdit.painPay}" onkeyup="checkRealPay();"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        扣税金额
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_deductionsPay" type="text"
                               class="validate[required,maxSize[50]] form-control" value="${toEdit.deductionsPay}"
                               onkeyup="checkRealPay();"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        实附酬金
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_realPay" type="text" class="validate[required,maxSize[50]] form-control"
                               readonly value="${toEdit.realPay}"/>
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
        var term = $("#addOrEdit_term").val();
        var deptId = $("#addOrEdit_deptId").val();
        var teacherId = $("#addOrEdit_teacherId").val();
        var courseId = $("#addOrEdit_courseId").val();
        var classId = $("#addOrEdit_classId").val();
        var studentNum = $("#addOrEdit_studentNum").val();
        var weekTime = $("#addOrEdit_weekTime").val();
        var weekNum = $("#addOrEdit_weekNum").val();
        var painTime = $("#addOrEdit_painTime").val();
        var stopTime = $("#addOrEdit_stopTime").val();
        var stopInfo = $("#addOrEdit_stopInfo").val();
        var realTime = $("#addOrEdit_realTime").val();
        var payRule = $("#addOrEdit_payRule").val();
        var painPay = $("#addOrEdit_painPay").val();
        var deductionsPay = $("#addOrEdit_deductionsPay").val();
        var realPay = $("#addOrEdit_realPay").val();

        if (term == "" || term == null) {
            swal({
                title: "请选择学期",
                type: "info"
            });
            return;
        }
        if (classId == "" || classId == null) {
            swal({
                title: "请输入相关班级",
                type: "info"
            });
            return;
        }
        if (courseId == "" || courseId == null) {
            swal({
                title: "请输入相关课程",
                type: "info"
            });
            return;
        }

        if (weekNum == "" || weekNum == null) {
            swal({
                title: "请输入教学周数",
                type: "info"
            });
            return;
        }
        if (weekTime == "" || weekTime == null || teacherId == null && teacherId == "" || deptId == "" || deptId == "") {
            swal({
                title: "相关课程计划周学时为空或不存在，请检查该老师的教学任务是否存在！",
                type: "info"
            });
            return;
        }
        if (stopTime == "" || stopTime == null) {
            swal({
                title: "请输入停课学时，没有可填0",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/facultyLoad/saveFacultyLoad", {
            id: $("#ttId").val(),
            term: term,
            teacherId: teacherId,
            deptId: deptId,
            courseId: courseId,
            classId: classId,
            studentNum: studentNum,
            weekTime: weekTime,
            weekNum: weekNum,
            painTime: painTime,
            stopTime: stopTime,
            stopInfo: stopInfo,
            realTime: realTime,
            payRule: payRule,
            painPay: painPay,
            deductionsPay: deductionsPay,
            realPay: realPay
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
                    type: "success"
                });
            }
        })
    }

    function findTeachingTask() {

        var term = $("#addOrEdit_term").val();
        var courseId = $("#addOrEdit_courseId").val();
        var classId = $("#addOrEdit_classId").val();

        if (term != null && term != "" && courseId != null && courseId != "" && classId != null && classId != "") {

            $.post("<%=request.getContextPath()%>/teachingTask/checkTeachingTask", {
                semester: term,
                courseId: courseId,
                classInfo: classId
            }, function (data) {

                if (data != null) {

                    $("#deptSel").val(data.departmentName);
                    $("#addOrEdit_deptId").val(data.department);

                    $("#addOrEdit_teaId").val(data.teacherName);
                    $("#addOrEdit_teacherId").val(data.teacherId);

                    $("#addOrEdit_studentNum").val(data.studentNum);
                    $("#addOrEdit_weekTime").val(data.weekTime);

                    checkPainTime();
                }
            });
        }
    }

    function checkPainTime() {

        var weekTime = $("#addOrEdit_weekTime").val();
        var weekNum = $("#addOrEdit_weekNum").val();

        if (weekTime != null && weekTime != "" && weekNum != null && weekNum != "") {

            $("#addOrEdit_painTime").val(weekTime * weekNum);
            checkRealTime();
        }
    }

    function checkRealTime() {

        var painTime = $("#addOrEdit_painTime").val();
        var stopTime = $("#addOrEdit_stopTime").val();

        if (Number(painTime) < Number(stopTime)) {

            $("#addOrEdit_stopTime").val("0");
            $("#addOrEdit_realTime").val(painTime);

            swal({
                title: "计划课时不能小于停课课时",
                type: "info"
            });
            return;
        }

        if (painTime != null && painTime != "" && stopTime != null && stopTime != "") {

            $("#addOrEdit_realTime").val(painTime - stopTime);
        }
    }

    function checkRealPay() {

        var painPay = $("#addOrEdit_painPay").val();
        var deductionsPay = $("#addOrEdit_deductionsPay").val();

        if (Number(painPay) < Number(deductionsPay)) {

            $("#addOrEdit_deductionsPay").val("0");
            $("#addOrEdit_realPay").val(painPay);

            swal({
                title: "应付薪酬不能小于扣税金额",
                type: "info"
            });
            return;
        }

        if (painPay != null && painPay != "" && deductionsPay != null && deductionsPay != "") {

            $("#addOrEdit_realPay").val(painPay - deductionsPay);
        }
    }

    $(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'addOrEdit_term', '${toEdit.term}');
        });

        $.get("<%=request.getContextPath()%>/common/getCoures", function (data) {
            $("#addOrEdit_cId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#addOrEdit_cId").val(ui.item.label.split("  ----  ")[0]);
                    $("#addOrEdit_cId").attr("keycode", ui.item.value);
                    $("#addOrEdit_courseId").val(ui.item.value);
                    findTeachingTask();
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
                    $("#addOrEdit_classId").val(ui.item.value);
                    findTeachingTask();
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


