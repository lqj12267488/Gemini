
<%--新增页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="otherAchievementsId" hidden value="${otherAchievementsId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        学期
                    </div>
                    <div class="col-md-9">
                        <select id="f_term" />
                    </div>
                </div>
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
                        <span class="iconBtx">*</span>
                        课程
                    </div>
                    <div class="col-md-9">
                    <select id="courseId" name="courseId" class="required" msg="请选择班级！">
                        <option value="">请选择专业</option>
                    </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 班级
                    </div>
                    <div class="col-md-9">
                        <select id="classId" name="classId" class="required" msg="请选择班级！">
                            <option value="">请选择专业</option>
                        </select>
                    </div>

                    </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        考核类型
                    </div>
                    <div class="col-md-9">
                        <input id="f_assessmentType" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="考查" readonly="true" />
                        <input id="f_eidtype" type="hidden" value="考查"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
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


        $.get("<%=request.getContextPath()%>/examTopic/getExamName", function (data) {
            $("#f_exam").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_exam").val(ui.item.label);
                    $("#f_exam").attr("keycode", ui.item.value);
                    $("#eid").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })


        $("#majorCode").change(function(){
            $.get("<%=request.getContextPath()%>/scoreCourse/getCourseByMajorShow?majorShow="+$("#majorCode").val(), function (data) {
                addOption(data, "courseId");
            })
        });



        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'f_term','${examTopic.semester}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"COURSE_ID",
            text:"COURSE_NAME",
            tableName:"T_JW_COURSE",
            where:" ",
            orderBy:""
        }, function (data) {
            addOption(data, 'f_course','${examTopic.examCourse}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"dept_id",
            text:"dept_name",
            tableName:"T_SYS_DEPT",
            where:"WHERE dept_type = 8 ",
            orderBy:""
        }, function (data) {
            addOption(data, 'f_department','${examTopic.departmentsId}');
        });
        $("#f_department").change(function () {
            if($("#f_department").val() != null){
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"major_code",
                    text:"major_name",
                    tableName:"T_XG_MAJOR",
                    where:"WHERE departments_id = '" + $("#f_department").val() +"' ",
                    orderBy:""
                }, function (data) {
                    addOption(data, 'f_major');
                });
            }
        })

        if("" != '${examTopic.majorCode}' ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"major_code",
                    text:"major_name",
                    tableName:"T_XG_MAJOR",
                    where:"",
                    orderBy:""
                }
                , function (data) {
                    addOption(data, 'f_major','${examTopic.majorCode}');
                });
        }
    })

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
        $.post("<%=request.getContextPath()%>/common/getClassIdByMajor", {
            majorCode: majorId.split(",")[0],
            trainingLevel: majorId.split(",")[1],
        }, function (data) {
            addOption(data, 'classId', '${data.classId}');
        });
        $.post("<%=request.getContextPath()%>/scoreCourse/getCourseByMajorShow", {
            majorShow: majorId.split(",")[0] + "," + majorId.split(",")[1],
        }, function (data) {
            addOption(data, 'courseId', '${data.courseId}');
        });
    }





    function save() {
        var reg = new RegExp("^[0-9]*$");
        if($("#f_term").val() == "" || $("#f_term").val() == "0" || $("#f_term").val() == undefined){
            swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }

        if ($("#deptId").val() == "" || $("#deptId").val() == "0" || $("#deptId").val() == undefined) {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }

        if ($("#majorCode").val() == "" || $("#majorCode").val() == "0" || $("#majorCode").val() == undefined) {
            swal({
                title: "请填写专业！",
                type: "info"
            });
            return;
        }


        if ($("#classId").val() == "" || $("#classId").val() == "0" || $("#classId").val() == undefined) {
            swal({
                title: "请填写班级！",
                type: "info"
            });
            return;
        }
        if ($("#courseId").val() == "" || $("#courseId").val() == "0" || $("#courseId").val() == undefined) {
            swal({
                title: "请填写课程！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/otherAchievements/saveOtherAchievements", {
            id: $("#examTopicid").val(),
            semester: $("#f_term").val(),
            department: $("#deptId").val(),
            classId: $("#classId").val(),
            curriculum: $("#courseId").val(),
            assessmentType: $("#f_assessmentType").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#scoreExamGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
       /* $('#scoreExamGrid').DataTable().ajax.reload();*/
    }

</script>