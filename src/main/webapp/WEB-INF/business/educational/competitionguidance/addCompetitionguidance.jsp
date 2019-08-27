<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <form id="dataForm" method="post" enctype="multipart/form-data">
        <div class="modal-content block-fill-white">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <span style="font-size: 14px">${head}</span>
            </div>
            <input id="id" name="id" hidden value="${id}">
            <div class="modal-body clearfix">
                <div id="layout"
                     style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
                <div class="controls">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            教师姓名
                        </div>
                        <div class="col-md-9">
                            <input id="teacherName" name="teacherName" type="text"
                                   value="${competitionGuidance.teacherName}"/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            所属系部
                        </div>
                        <div class="col-md-9">
                            <select id="departmentId" name="departmentId"/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            竞赛项目
                        </div>
                        <div class="col-md-9">
                            <input id="competitionName" name="competitionName" type="text"
                                   value="${competitionGuidance.competitionName}" placeholder="请填写名称"/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            竞赛级别
                        </div>
                        <div class="col-md-9">
                            <select id="competitionLevel" name="competitionLevel"/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            主办单位
                        </div>
                        <div class="col-md-9">
                            <input id="hostUnit" name="hostUnit" type="text" value="${competitionGuidance.hostUnit}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            辅导内容
                        </div>
                        <div class="col-md-9">
                            <input id="counsellingContent" name="counsellingContent" type="text"
                                   value="${competitionGuidance.counsellingContent}" placeholder="简写"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            学期
                        </div>
                        <div class="col-md-9">
                            <select id="semester" name="semester"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            专业
                        </div>
                        <div class="col-md-9">
                            <select id="majorId" name="majorId"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            班级
                        </div>
                        <div class="col-md-9">
                            <input id="classId" name="classId" type="text" value="${competitionGuidance.classId}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            学历层次
                        </div>
                        <div class="col-md-9">
                            <select id="educationalLevel" name="educationalLevel"
                                    value="${competitionGuidance.educationalLevel}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            参赛人数
                        </div>
                        <div class="col-md-9">
                            <input id="competitionNumber" name="competitionNumber" type="number"
                                   value="${competitionGuidance.competitionNumber}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            培训人数
                        </div>
                        <div class="col-md-9">
                            <input id="trainingNumber" name="trainingNumber" type="number"
                                   value="${competitionGuidance.trainingNumber}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            课时数
                        </div>
                        <div class="col-md-9">
                            <input id="classHours" name="classHours" type="number"
                                   value="${competitionGuidance.classHours}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            授课地点
                        </div>
                        <div class="col-md-9">
                            <input id="place" name="place" type="text" value="${competitionGuidance.place}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            竞赛成绩
                        </div>
                        <div class="col-md-9">
                            <input id="competitionPerformance" name="competitionPerformance" type="text"
                                   value="${competitionGuidance.competitionPerformance}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            附件上传
                        </div>
                        <div class="col-md-9">
                            <input name="file" id="file" type="button" value="点击上传" onclick="addFiles()"/>
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
    </form>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'semester','${competitionGuidance.semester}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
        id:"dept_id",
        text:"dept_name",
        tableName:"T_SYS_DEPT",
        where:"WHERE dept_type = 8 ",
        orderBy:""
        }, function (data) {
        addOption(data, 'departmentId','${competitionGuidance.departmentId}');
        });
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#teacherName").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherName").val(ui.item.label);
                    $("#teacherName").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>").append("<a>" + item.label + "</a>").appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSJB", function (data) {
            addOption(data, 'competitionLevel', '${competitionGuidance.competitionLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XL", function (data) {
            addOption(data, 'educationalLevel', '${competitionGuidance.educationalLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYLX", function (data) {
            addOption(data, 'majorId', '${competitionGuidance.majorId}');
        });
    });

    function save() {
        // var teacherName = $("#teacherName").val();
        var teacherName = $("#teacherName").attr("keycode").split(",")[1];
        var deptId =  $("#teacherName").attr("keycode").split(",")[0];
        var departmentId = $("#departmentId").val();
        var competitionName = $("#competitionName").val();
        var competitionLevel = $("#competitionLevel").val();
        var hostUnit = $("#hostUnit").val();
        var counsellingContent = $("#counsellingContent").val();
        var semester = $("#semester").val();
        var majorId = $("#majorId").val();
        var classId = $("#classId").val();
        var educationalLevel = $("#educationalLevel").val();
        var classNumber = $("#competitionNumber").val();
        var trainingNumber = $("#trainingNumber").val();
        var classHours = $("#classHours").val();
        var place = $("#place").val();
        var competitionPerformance = $("#competitionPerformance").val();
        var id = $("#id").val();
        if ($("#teacherName").val() == "" || $("#teacherName").val() == null || $("#teacherName").val() == undefined) {
            swal({
                title: "请填写教师姓名！",
                type: "info"
            });
            return;
        }
        if (departmentId == "" || departmentId == undefined) {
            swal({
                title: "请填写所属系部！",
                type: "info"
            });
            return;
        }
        if (competitionName == "" || competitionName == null || competitionName == undefined) {
            swal({
                title: "请填写竞赛项目！",
                type: "info"
            });
            return;
        }
        if (competitionLevel == "" || competitionLevel == null || competitionLevel == undefined) {
            swal({
                title: "请选择竞赛级别！",
                type: "info"
            });
            return;
        }
        if (hostUnit == "" || hostUnit == null || hostUnit == undefined) {
            swal({
                title: "请填写主办单位！",
                type: "info"
            });
            return;
        }
        if (counsellingContent == "" || counsellingContent == null || counsellingContent == undefined) {
            swal({
                title: "请填写辅导内容！",
                type: "info"
            });
            return;
        }
        if (semester == "" || semester == null || semester == undefined) {
            swal({
                title: "请填写学期！",
                type: "info"
            });
            return;
        }
        if (majorId == "" || majorId == null || majorId == undefined) {
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if (classId == "" || classId == null || classId == undefined) {
            swal({
                title: "请填写班级！",
                type: "info"
            });
            return;
        }
        if (educationalLevel == "" || educationalLevel == null || educationalLevel == undefined) {
            swal({
                title: "请填写学习层次！",
                type: "info"
            });
            return;
        }
        if (classNumber == "" || classNumber == null || classNumber == undefined) {
            swal({
                title: "请填写参赛人数！",
                type: "info"
            });
            return;
        }
        if (trainingNumber == "" || trainingNumber == null || trainingNumber == undefined) {
            swal({
                title: "请填写培训人数！",
                type: "info"
            });
            return;
        }
        if (classHours == "" || classHours == null || classHours == undefined) {
            swal({
                title: "请填写课时数！",
                type: "info"
            });
            return;
        }
        if (place == "" || place == null || place == undefined) {
            swal({
                title: "请填写授课地点！",
                type: "info"
            });
            return;
        }
        if (competitionPerformance == "" || competitionPerformance == null || competitionPerformance == undefined) {
            swal({
                title: "请填写竞赛成绩！",
                type: "info"
            });
            return;
        }
        // var from = new FormData(document.getElementById("dataForm"));

        $.post("<%=request.getContextPath()%>/competitionGuidance/competitionGuidanceAdd", {
            id:id,
            teacherName: teacherName,
            deptId:deptId,
            departmentId: departmentId,
            competitionName: competitionName,
            competitionLevel: competitionLevel,
            semester: semester,
            majorId: majorId,
            classId: classId,
            educationalLevel: educationalLevel,
            counsellingContent: counsellingContent,
            hostUnit: hostUnit,
            competitionNumber: classNumber,
            trainingNumber: trainingNumber,
            classHours: classHours,
            place: place,
            competitionPerformance: competitionPerformance
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#competitionGuidance').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

    function addFiles() {
        var id = $("#id").val();
        $("#dialogFile").load("<%=request.getContextPath()%>/files/filesUpload?businessId=" + id + "&businessType=TEST&tableName=T_JW_COMPETITION_GUIDANCE");
        $("#dialogFile").modal("show");
    }
</script>

