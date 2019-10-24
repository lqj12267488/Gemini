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
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <span style="font-size: 14px;">新增</span>
        </div>
        <form id="form">
            <input name="id" value="${data.id}" hidden>
            <input name="examId" value="${empty id? data.examId:id}" hidden>
            <div class="modal-body clearfix">
                <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
                <div class="controls">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 系部
                        </div>
                        <div class="col-md-9">
                            <select id="deptId" name="departmentsId" class="required" msg="请选择系部！" onchange="changeDept()"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 专业
                        </div>
                        <div class="col-md-9">
                            <select id="majorCode" name="majorCode" class="required" msg="请选择专业！" onchange="changeMajor()">
                                <option value="">请选择系部</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 班级
                        </div>
                        <div class="col-md-9">
                            <select id="classId" name="classId" class="required" msg="请选择班级！" onchange="changeClass()">
                                <option value="">请选择专业</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 考试科目
                        </div>
                        <div class="col-md-9">
                            <select id="courseId" name="courseId" class="required" msg="请选择考试科目！"  onchange="changeCourse()">
                                <option value="">请选择班级</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 考试方式
                        </div>
                        <div class="col-md-9">
                            <select id="examTypes" name="examType" class="required" msg="请选择考试方式！">
                                <option>请选择</option>
                                <option value="1">普通</option>
                                <option value="3">机考</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 考核方式
                        </div>
                        <div class="col-md-9">
                            <select id="examMethod" name="examMethod"  msg="请选择考核方式！"
                                    class="validate[required,maxSize[100]] form-control required"
                                    disabled="disabled"></select>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script>

    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getDepartments", function (data) {
            addOption(data, 'deptId', '${data.departmentsId}');
        });
        if ('${data.departmentsId}' != '') {
            changeDept('${data.departmentsId}');
            changeMajor('${data.majorCode},${data.trainingLevel}');
        }
        $("#examTypes option[value=" + '${data.examType}' + "]").attr("selected", "selected");

        $.get("<%=request.getContextPath()%>/scoreCourse/getCourseByPlanAndClass?classInfo="+ '${data.classId}'+"&term="+'${term}',
            function (data) {
                addOption(data, 'courseId', '${data.courseId}');
            });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCKSKHFF", function (data) {
            addOption(data, 'examMethod', '${data.examMethod}');
        });
    });

    function changeDept(departmentsId) {
        var deptId = $("#deptId").val();
        if (departmentsId) {
            deptId = departmentsId;
        }
        $.post("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId", {
            deptId: deptId
        }, function (data) {
            addOption(data, 'majorCode', '${data.majorCode},${data.trainingLevel}');
        });
    }

    function changeMajor(majorCode) {
        var majorId = $("#majorCode").val();
        if (majorCode) {
            majorId = majorCode
        }
        $.post("<%=request.getContextPath()%>common/getClassByPlan", {
            majorCode: majorId.split(",")[0],
            trainingLevel: majorId.split(",")[1],
            term:"${term}"
        }, function (data) {
            addOption(data, 'classId', '${data.classId}');
        });
        <%--$.post("<%=request.getContextPath()%>/scoreCourse/getCourseByMajorShow", {--%>
            <%--majorShow: majorId.split(",")[0] + "," + majorId.split(",")[1],--%>
        <%--}, function (data) {--%>
            <%--addOption(data, 'courseId', '${data.courseId}');--%>
        <%--});--%>
    }

    //根据班级查询课程
    function changeClass() {
        var classInfo = $("#classId").val();
        $.get("<%=request.getContextPath()%>/scoreCourse/getCourseByPlanAndClass?classInfo="+classInfo+"&term="+'${term}',
         function (data) {
        addOption(data, 'courseId', '${data.courseId}');
        });
    }

    function changeCourse() {
        var courseId = $("#courseId").val();
        $.get("<%=request.getContextPath()%>/exam/getExamMethod?courseId="+courseId+"&termId="+"${term}",
            function (data) {
                $("#examMethod").val(data);
            });
    }
    function save() {
        var flag = true;
        $("form select,form input").each(function (index, item) {
            if ($(item).hasClass("required") && !$(item).val() && !$(item).val() != '') {
                swal({
                    title: $(item).attr("msg"),
                    type: "info"
                });
                flag = false;
                return false;
            }
        });
        if (flag) {
            showSaveLoading();
            $.post("<%=request.getContextPath()%>/exam/updateExamClass", $("#form").serialize(), function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                }, function () {
                    $('#grid').DataTable().ajax.reload();
                    $("#dialog").modal('hide');
                });
                hideSaveLoading();
            })
        }
    }
</script>



