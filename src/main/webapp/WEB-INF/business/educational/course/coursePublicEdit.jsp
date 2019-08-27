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
    <div class="block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="courseId" hidden value="${course.courseId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="courseName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;
                                " maxlength="20" placeholder="最多输入20个字" value="${course.courseName}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程类型
                    </div>
                    <div class="col-md-9">
                        <select id="courseTypes"/>
                    </div>
                </div>


                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程属性
                    </div>
                    <div class="col-md-9">
                        <select id="courseProperties"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教学计划规定课时数
                    </div>
                    <div class="col-md-9">
                        <input type="text" id="prescribedPeriods" name="prescribedPeriods"
                               value="${course.prescribedPeriods}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; " maxlength="2"
                               placeholder="最多输入2个数字"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>实践课程课时数
                    </div>
                    <div class="col-md-9">
                        <input type="text" id="practiceClass" name="practiceClass" value="${course.practiceClass}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; " maxlength="2"
                               placeholder="最多输入2个数字"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>是否专业核心课程
                    </div>
                    <div class="col-md-9">
                        <select id="coreCurriculum"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>是否校企合作开发课程
                    </div>
                    <div class="col-md-9">
                        <select id="schoolEnterpriseCooperation"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>精品课程
                    </div>
                    <div class="col-md-9">
                        <select id="excellentCourse"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>主要授课地点
                    </div>
                    <div class="col-md-9">
                        <select id="venue"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>主要授课方式
                    </div>
                    <div class="col-md-9">
                        <SELECT id="teachingMethod" name="prescribedPeriods"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>考试/考核主要方法
                    </div>
                    <div class="col-md-9">
                        <select id="testMethod"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>是否课证融通课程
                    </div>
                    <div class="col-md-9">
                        <select id="classCertifiate"/>
                    </div>
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
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYSKFS", function (data) {
            addOption(data, 'teachingMethod', '${course.teachingMethod}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCJSLX", function (data) {
            addOption(data, 'courseTypes', '${course.courseType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCJSSX", function (data) {
            addOption(data, 'courseProperties', '${course.courseProperties}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCJPKC", function (data) {
            addOption(data, 'excellentCourse', '${course.excellentCourse}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCSKDD", function (data) {
            addOption(data, 'venue', '${course.venue}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCKSKHFF", function (data) {
            addOption(data, 'testMethod', '${course.testMethod}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCSF", function (data) {
            addOption(data, 'classCertifiate', '${course.classCertifiate}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCSF", function (data) {
            addOption(data, 'coreCurriculum', '${course.coreCurriculum}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCSF", function (data) {
            addOption(data, 'schoolEnterpriseCooperation', '${course.schoolEnterpriseCooperation}');
        });


    });

    function save() {
        var courseId = $("#courseId").val();
        var courseName = $("#courseName").val();
        if (courseName == "" || courseName == undefined || courseName == null) {
            swal({
                title: "请填写课程名称！",
                type: "info"
            });
            return;
        }
        if ($("#classTypes option:selected").val() == "") {
            swal({
                title: "请选择课程类型！",
                type: "info"
            });
            return;
        }
        if ($("#courseProperties option:selected").val() == "") {
            swal({
                title: "请选择课程属性！",
                type: "info"
            });
            return;
        }
        if ($("#prescribedPeriods").val() == "") {
            swal({
                title: "请填写规定课时！",
                type: "info"
            });
            return;
        }
        var reg1 = /^[0-9]+.?[0-9]*$/;
        if(!reg1.test($("#prescribedPeriods").val())){
            swal({
                title: "规定课时请填写数字！",
                type: "info"
            });
            return;
        }
        if ($("#practiceClass").val() == "") {
            swal({
                title: "请填写实践课时！",
                type: "info"
            });
            return;
        }
        if(!reg1.test($("#practiceClass").val())){
            swal({
                title: "实践课时请填写数字！",
                type: "info"
            });
            return;
        }
        if ($("#coreCurriculum option:selected").val() == "") {
            swal({
                title: "请选择是否核心课程！",
                type: "info"
            });
            return;
        }
        if ($("#schoolEnterpriseCooperation option:selected").val() == "") {
            swal({
                title: "请选择是否校企合作！",
                type: "info"
            });
            return;
        }
        if ($("#excellentCourse option:selected").val() == "") {
            swal({
                title: "请选择精品课程！",
                type: "info"
            });
            return;
        }
        if ($("#venue option:selected").val() == "") {
            swal({
                title: "请选择授课地点！",
                type: "info"
            });
            return;
        }
        if ($("#teachingMethod option:selected").val() == "") {
            swal({
                title: "请选择主要授课方式！",
                type: "info"
            });
            return;
        }

        if ($("#testMethod option:selected").val() == "") {
            swal({
                title: "请选择考试/考核主要方法！",
                type: "info"
            });
            return;
        }
        if ($("#classCertifiate option:selected").val() == "") {
            swal({
                title: "请选择是否课证融合！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/course/save", {
            courseId: courseId,
            courseName: courseName,
            courseType: '1',
            courseProperties: $("#courseProperties option:selected").val(),
            coreCurriculum: $("#coreCurriculum option:selected").val(),
            schoolEnterpriseCooperation: $("#schoolEnterpriseCooperation option:selected").val(),
            excellentCourse: $("#excellentCourse option:selected").val(),
            venue: $("#venue option:selected").val(),
            testMethod: $("#testMethod option:selected").val(),
            classCertifiate: $("#classCertifiate option:selected").val(),
            prescribedPeriods: $("#prescribedPeriods").val(),
            practiceClass: $("#practiceClass").val(),
            teachingMethod: $("#teachingMethod option:selected").val(),
        }, function (msg) {
            hideSaveLoading();
            if(msg.status===1){
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            }else{
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            }
        })


        /*$.post("<%=request.getContextPath()%>/course/checkCourseName", {
            courseId: courseId,
            courseName: courseName,
            courseType: '1',
        }, function (msg1) {
            if (msg1.status == 1) {
                var al = "课程名称已存在，请确认后重新输入";
                swal({
                    title: al + msg1.msg,
                    type: "error"
                });
            } else {
                /!*showSaveLoading();
                $.post("<%=request.getContextPath()%>/course/save", {
                    courseId: courseId,
                    courseName: courseName,
                    courseType: '1',
                    courseProperties: $("#courseProperties option:selected").val(),
                    coreCurriculum: $("#coreCurriculum option:selected").val(),
                    schoolEnterpriseCooperation: $("#schoolEnterpriseCooperation option:selected").val(),
                    excellentCourse: $("#excellentCourse option:selected").val(),
                    venue: $("#venue option:selected").val(),
                    testMethod: $("#testMethod option:selected").val(),
                    classCertifiate: $("#classCertifiate option:selected").val(),
                    prescribedPeriods: $("#prescribedPeriods").val(),
                    practiceClass: $("#practiceClass").val(),
                    teachingMethod: $("#teachingMethod option:selected").val(),
                }, function (msg) {
                    hideSaveLoading();
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    $("#dialog").modal('hide');
                    $('#table').DataTable().ajax.reload();
                })*!/
            }
        })*/
    }

</script>



