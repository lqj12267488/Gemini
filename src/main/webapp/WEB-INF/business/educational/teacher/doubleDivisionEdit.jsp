<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="teacherId" hidden value="${doubleDivisionTeacher.teacherId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教师姓名
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="teacherNameSel" type="text" value="${doubleDivisionTeacher.teacherNameShow}"/>
                            <input id="perId" type="hidden" value="${doubleDivisionTeacher.teacherName}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        所属系部
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="departmentsIdSel" type="text" value="${doubleDivisionTeacher.departmentIdShow}" class="validate[required,maxSize[20]] form-control" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>级别
                    </div>
                    <div class="col-md-9">
                        <select id="teachingLevelShow"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学科
                    </div>
                    <div class="col-md-9">
                        <select id="subjectShow" type="text"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 发证时间
                    </div>
                    <div class="col-md-9">
                        <input id="issuingTime" type="date" value="${doubleDivisionTeacher.issuingTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>发证单位
                    </div>
                    <div class="col-md-9">
                        <input  type="text" id="issuingDept"  value="${doubleDivisionTeacher.issuingDept}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>有效期
                    </div>
                    <div class="col-md-9">
                        <input  type="text" id="validityTerm" placeholder="年月日起年月日止。或无" value="${doubleDivisionTeacher.validityTerm}" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    <%--$("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");--%>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#teacherNameSel").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherNameSel").val(ui.item.label.split(" ---- ")[0]);
                    $("#departmentsIdSel").val(ui.item.label.split(" ---- ")[1]);
                    $("#teacherNameSel").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        /*$.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#teacherNameSel").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherNameSel").val(ui.item.label);
                    $("#teacherNameSel").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })*/
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSJLJB", function (data) {
            addOption(data, 'teachingLevelShow', '${doubleDivisionTeacher.teachingLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " COURSE_ID",
                text: " COURSE_NAME ",
                tableName: "T_JW_COURSE"
            },
            function (data) {
                addOption(data, "subjectShow",'${doubleDivisionTeacher.subject}');
            });
        var courseId = $("#courseId").val();
        if(courseId==null || courseId==""){

        }else{
            $("#majorCode").attr("disabled","disabled").css("background-color","#2c5c82;");
            $("#departmentsId").attr("disabled","disabled").css("background-color","#2c5c82;");
            $("#coding").attr("readonly","readonly").css("background-color","#2c5c82;");
        }

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCLX&where=dic_code != '1'", function (data) {
            addOption(data, 'courseType', '${course.courseType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${course.departmentsId}');
        });
        if ('${course.majorCode}' != "") {
            var deptId = '${course.departmentsId}';
            $.get("<%=request.getContextPath()%>/course/getMajorByDeptId?deptId="+deptId, function (data) {
                addOption(data, 'majorCode','${course.majorCode}');
            });
        }else{
            $("#majorCodeSearch").append("<option value='' selected>请选择</option>")
        }
    });

    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/course/getMajorByDeptId?deptId="+deptId, function (data) {
            addOption(data, 'majorCode');
        });
    }
    function changeCoding() {
        var courseId = $("#courseId").val();
        var departmentsId = $("#departmentsId").val();
        var majorData = $("#majorCode").val();
        var majorCode=majorData.split(",")[0];
        var trainingLevel=majorData.split(",")[1];
        if(courseId==null || courseId==""){
            $.post("<%=request.getContextPath()%>/course/checkCoding", {
                departmentsId: departmentsId,
                majorCode: majorCode,
                trainingLevel: trainingLevel,
                courseId: courseId

            }, function (data) {
                var  coding=$("#coding").val(data);
            })
        }

    }

    function save() {
        var deptId=$("#perId").val().split(",")[0];
        var personId=$("#perId").val().split(",")[1];
        if(personId==undefined){
            deptId='${doubleDivisionTeacher.departmentId}';
            personId='${doubleDivisionTeacher.teacherName}';
        }
        var teacherId = $("#teacherId").val();
        var teachingLevel = $("#teachingLevelShow").val();
        var subject = $("#subjectShow").val();
        var issuingTime = $("#issuingTime").val();
        var issuingDept = $("#issuingDept").val();
        var validityTerm = $("#validityTerm").val();
        if (personId == "" || personId == undefined || personId == null) {
            swal({
                title: "请填写教师姓名！",
                type: "info"
            });
            return;
        }
        if (teachingLevel == "" || teachingLevel == undefined || teachingLevel == null) {
            swal({
                title: "请选择级别！",
                type: "info"
            });
            return;
        }
        if (subject == "" || subject == undefined || subject == null) {
            swal({
                title: "请选择学科！",
                type: "info"
            });
            return;
        }
        if (issuingTime == "" || issuingTime == undefined || issuingTime == null) {
            swal({
                title: "请填写发证时间！",
                type: "info"
            });
            return;
        }
        if (issuingDept == "" || issuingDept == undefined || issuingDept == null) {
            swal({
                title: "请填写发证单位！",
                type: "info"
            });
            return;
        }
        if (validityTerm == "" || validityTerm == undefined || validityTerm == null) {
            swal({
                title: "请填写有效期！",
                type: "info"
            });
            return;
        }

        if($("#teacherNameSel").attr("keycode")=="" || $("#teacherNameSel").attr("keycode") ==null){
            $("#teacherNameSel").attr("keycode",$("#perId").val())
        }
        $.post("<%=request.getContextPath()%>/teacher/doubleDivisionSave", {
                    teacherId: teacherId,
                    teacherName: personId,
                    departmentId:deptId,
                    teachingLevel: teachingLevel,
                    subject: subject,
                    issuingTime: issuingTime,
                    issuingDept: issuingDept,
                    validityTerm: validityTerm
                }, function (msg) {
                    // hideSaveLoading();
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    $("#dialog").modal('hide');
                    $('#table').DataTable().ajax.reload();
        })


    }
</script>




