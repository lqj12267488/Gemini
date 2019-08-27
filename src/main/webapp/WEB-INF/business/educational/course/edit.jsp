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
            <input id="courseId" hidden value="${course.courseId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="courseName" type="text" value="${course.courseName}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程类型
                    </div>
                    <div class="col-md-9">
                        <select id="courseType"/>
                    </div>
                </div>
                <div class="form-row" >
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsId" onchange="changeMajor()"/>
                    </div>
                </div>
                <div class="form-row" >
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 专业
                    </div>
                    <div class="col-md-9">
                        <select id="majorCode" onchange="changeCoding()"/>
                    </div>
                </div>
                <div class="form-row" >
                    <div class="col-md-3 tar">
                        课程代码
                    </div>
                    <div class="col-md-9">
                        <input  type="text" id="coding" name="coding" value="${course.courseCode}"   readonly/>
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
                        <input  type="text" id="prescribedPeriods" name="prescribedPeriods" value="${course.prescribedPeriods}"
                                onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "maxlength="2" placeholder="最多输入2个数字" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>实践课程课时数
                    </div>
                    <div class="col-md-9">
                        <input  type="text" id="practiceClass" name="practiceClass" value="${course.practiceClass}"
                                onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false; "maxlength="2" placeholder="最多输入2个数字" />
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
                        <select  id="teachingMethod"  />
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
        var courseId = $("#courseId").val();
        if(courseId==null || courseId==""){

        }else{
            $("#majorCode").attr("disabled","disabled").css("background-color","#2c5c82;");
            $("#departmentsId").attr("disabled","disabled").css("background-color","#2c5c82;");
            $("#coding").attr("readonly","readonly").css("background-color","#2c5c82;");
        }
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYSKFS", function (data) {
            addOption(data, 'teachingMethod', '${course.teachingMethod}');
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
        var courseId = $("#courseId").val();
        var courseName = $("#courseName").val();
        var courseType = $("#courseType").val();
        var departmentsId = $("#departmentsId").val();
        var major = $("#majorCode").val();
        var coding = $("#coding").val();
        var courseProperties = $("#courseProperties").val();
        var prescribedPeriods = $("#prescribedPeriods").val();
        var practiceClass = $("#practiceClass").val();
        var coreCurriculum = $("#coreCurriculum").val();
        var schoolEnterpriseCooperation = $("#schoolEnterpriseCooperation").val();
        var excellentCourse = $("#excellentCourse").val();
        var venue = $("#venue").val();
        var teachingMethod = $("#teachingMethod").val();
        var testMethod = $("#testMethod").val();
        var classCertifiate = $("#classCertifiate").val();


        if (courseName == "" || courseName == undefined || courseName == null) {
            swal({
                title: "请填写课程名称！",
                type: "info"
            });
            return;
        }
        if (courseType == "" || courseType == undefined || courseType == null) {
            swal({
                title: "请选择课程类型！",
                type: "info"
            });
            return;
        }
        if (departmentsId == "" || departmentsId == undefined || departmentsId == null) {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if (major == "" || major == undefined || major == null) {
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if (courseProperties == "" || courseProperties == undefined || courseProperties == null) {
            swal({
                title: "请选择课程属性！",
                type: "info"
            });
            return;
        }
        if (prescribedPeriods == "" || prescribedPeriods == undefined || prescribedPeriods == null) {
            swal({
                title: "请填写规定课时！",
                type: "info"
            });
            return;
        }
        if (practiceClass == "" || practiceClass == undefined || practiceClass == null) {
            swal({
                title: "请填写实践课时！",
                type: "info"
            });
            return;
        }
        if (coreCurriculum == "" || coreCurriculum == undefined || coreCurriculum == null) {
            swal({
                title: "请选择是否核心课程！",
                type: "info"
            });
            return;
        }
        if (schoolEnterpriseCooperation == "" || schoolEnterpriseCooperation == undefined || schoolEnterpriseCooperation == null) {
            swal({
                title: "请选择是否校企合作！",
                type: "info"
            });
            return;
        }
        if (excellentCourse == "" || excellentCourse == undefined || excellentCourse == null) {
            swal({
                title: "请选择是否精品课程！",
                type: "info"
            });
            return;
        }
        if (venue == "" || venue == undefined || venue == null) {
            swal({
                title: "请选择授课地点！",
                type: "info"
            });
            return;
        }
        if (teachingMethod == "" || teachingMethod == undefined || teachingMethod == null) {
            swal({
                title: "请选择授课方式！",
                type: "info"
            });
            return;
        }
        if (testMethod == "" || testMethod == undefined || testMethod == null) {
            swal({
                title: "请选择考试方式！",
                type: "info"
            });
            return;
        }
        if (classCertifiate == "" || classCertifiate == undefined || classCertifiate == null) {
            swal({
                title: "请选择是否课证融通课程！",
                type: "info"
            });
            return;
        }
        var arr = major.split(",");
        $.post("<%=request.getContextPath()%>/course/checkCourseName",{
            courseId: courseId,
            courseName: courseName,
            courseType: courseType,
            departmentsId: departmentsId,
            majorCode: arr[0],
            trainingLevel: arr[1]
        },function(msg1) {
            if (msg1.status == 1) {
                var al = "课程信息已存在，请确认后重新输入";
                swal({
                    title: al + msg1.msg,
                    type: "error"
                });
            } else {
                showSaveLoading();
                $.post("<%=request.getContextPath()%>/course/save", {
                    courseId: courseId,
                    courseName: courseName,
                    courseType: courseType,
                    courseCode: coding,
                    departmentsId: departmentsId,
                    majorCode: arr[0],
                    trainingLevel: arr[1],
                    courseProperties:courseProperties,
                    prescribedPeriods:prescribedPeriods,
                    practiceClass:practiceClass,
                    coreCurriculum:coreCurriculum,
                    schoolEnterpriseCooperation:schoolEnterpriseCooperation,
                    excellentCourse:excellentCourse,
                    venue:venue,
                    teachingMethod:teachingMethod,
                    testMethod:testMethod,
                    classCertifiate:classCertifiate
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
            }
        })
    }
</script>



