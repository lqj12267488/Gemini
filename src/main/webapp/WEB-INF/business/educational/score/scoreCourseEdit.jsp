<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/12
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程类型
                    </div>
                    <div class="col-md-9">
                        <select id="courseType" class="js-example-basic-single"
                                onchange="hideOtherProperty()"></select>
                    </div>
                </div>
                <div class="form-row" id="h_departmentsId">
                    <div class="col-md-3 tar">
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsId" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row" id="h_majorShow">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="majorShow" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程名称
                    </div>
                    <div class="col-md-9">
                        <select id="courseId" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        考试类型
                    </div>
                    <div class="col-md-9">
                        <select id="courseFlag" class="js-example-basic-single"
                                onchange="hideCourseFlag()"></select>
                    </div>
                </div>
                <div class="form-row" id="examDiv" >
                    <div class="col-md-3 tar">
                        总分
                    </div>
                    <div class="col-md-9">
                        <input id="totalScore" type="text" value="100"/>
                    </div>
                </div>
                <div class="form-row" id="examDiv2" >
                    <div class="col-md-3 tar">
                        及格分
                    </div>
                    <div class="col-md-9">
                        <input id="passScore" type="text" value="60"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="save" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeView()">关闭</button>
        </div>
    </div>
    <input id="dept" value="${scoreCourse.departmentsId}" type="hidden" >
    <input id="major" value="${scoreCourse.majorCode}" type="hidden" >
    <input id="type" value="${scoreCourse.courseType}" type="hidden" >
    <input id="scoreExamId" value="${scoreCourse.scoreExamId}" type="hidden" >
    <input id="subjectId" value="${scoreCourse.subjectId}" type="hidden" >
</div>

<script>
    $(document).ready(function (){
        var courseType = $("#type").val();
        if ("1" == courseType) {
            $("#h_departmentsId").hide();
            $("#h_majorShow").hide();
        } else {
            $("#h_departmentsId").show();
            $("#h_majorShow").show();
        }
        if($("#subjectId").val()!=""){
            $("#totalScore").val(${scoreCourse.totalScore});
            $("#passScore").val(${scoreCourse.passScore});
        }
//系统字典项
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KSLX", function (data) {
            addOption(data, 'courseFlag', '${scoreCourse.courseFlag}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCLX", function (data) {
            addOption(data, 'courseType', '${scoreCourse.courseType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId','${scoreCourse.departmentsId}');
        });
//通过系部id获取专业-层次下拉列表

        $("#departmentsId").change(function(){
            $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId="+$("#departmentsId").val(),function (data) {
                addOption(data, "majorShow");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId="+$("#dept").val(),function (data) {
            addOption(data, "majorShow",'${scoreCourse.majorCode}');
        })
//通过专业-层次id获取课程下拉列表
        $("#majorShow").change(function(){
            $.get("<%=request.getContextPath()%>/scoreCourse/getCourseByMajorShow?majorShow="+$("#majorShow").val(), function (data) {
                addOption(data, "courseId");
            })
        });
        if(courseType!="1"){
            $.get("<%=request.getContextPath()%>/scoreCourse/getCourseByMajorShow?majorShow="+$("#major").val(), function (data) {
                addOption(data, "courseId", '${scoreCourse.courseId}');
            })
        }
//通过课程类型获取课程下拉列表
        $("#courseType").change(function(){
            $.get("<%=request.getContextPath()%>/scoreCourse/getCourseByType?courseType="+$("#courseType").val(), function (data) {
                addOption(data, "courseId");
            })
        });
        if(courseType=="1"){
            $.get("<%=request.getContextPath()%>/scoreCourse/getCourseByType?courseType="+$("#type").val(), function (data) {
                addOption(data, "courseId", '${scoreCourse.courseId}');
            })
        }

        hideCourseFlag();

    })

    function hideCourseFlag() {
        var courseFlag = $("#courseFlag").val();
        if( courseFlag =='01'){
            $("#examDiv").show();
            $("#examDiv2").show();
        }else{
            $("#examDiv").hide();
            $("#examDiv2").hide();
        }
    }

    function save() {
        if ($("#courseType").val() == "" || $("#departmentsId").val() == undefined) {
            swal({title: "请选择课程类型！",type: "info"});
            return;
        }
        if ("1" == $("#courseType").val()) {

        } else {
            if ($("#departmentsId").val() == "" || $("#departmentsId").val() == undefined) {
                swal({title: "请选择系部！",type: "info"});
                return;
            }
            if ($("#majorShow").val() == "" || $("#majorShow").val() == undefined) {
                swal({title: "请选择专业！",type: "info"});
                return;
            }
        }
        if ($("#courseId").val() == "" || $("#courseId").val() == undefined) {
            swal({title: "请选择课程！",type: "info"});
            return;
        }
        if ($("#courseFlag").val() == "" || $("#courseFlag").val() == undefined) {
            swal({title: "请选择考试类型！",type: "info"});
            return;
        }
        if($("#courseFlag").val() == "01"){
            var reg=new RegExp("^[0-9]{0,3}$");
            if (!reg.test($("#totalScore").val())) {
                swal({title: "请填写正确的总分数！",type: "info"});
                return;
            }
            if (!reg.test($("#passScore").val())) {
                swal({title: "请填写正确的及格分数！",type: "info"});
                return;
            }
        }else{
            $("#totalScore").val("");
            $("#passScore").val("");
        }
        var majorShow =$("#majorShow").val();
        var majorList = majorShow.split(",");
        $.post("<%=request.getContextPath()%>/scoreCourse/saveScoreCourse", {
            subjectId:$("#subjectId").val(),
            scoreExamId:$("#scoreExamId").val(),
            scoreExamName:$("#scoreExamName").val(),
            departmentsId: $("#departmentsId").val(),
            majorCode: majorList[0],
            trainingLevel: majorList[1],
            courseType:$("#courseType").val(),
            courseId:$("#courseId").val(),
            totalScore: $("#totalScore").val(),
            passScore: $("#passScore").val(),
            courseFlag: $("#courseFlag").val(),
        }, function (msg) {
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#listGrid').DataTable().ajax.reload();
        })
    }
    function hideOtherProperty() {
        var courseType = $("#courseType").val();
        if ("1" == courseType) {
            $("#h_departmentsId").hide();
            $("#h_majorShow").hide();
        } else {
            $("#h_departmentsId").show();
            $("#h_majorShow").show();
        }
    }
</script>
