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
            <input id="courseTeacherId" hidden value="${data.courseTeacherId}">
            <input id="timeTableDepartmentId" hidden value="${data.timeTableDepartmentId}"/>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 周时
                    </div>
                    <div class="col-md-9">
                        <div>
                            <select id="weeks">
                                <option value="周一">周一</option>
                                <option value="周二">周二</option>
                                <option value="周三">周三</option>
                                <option value="周四">周四</option>
                                <option value="周五">周五</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 课时
                    </div>
                    <div class="col-md-9">
                        <select id="courseNum">
                            <option value="1.2">1.2</option>
                            <option value="3.4">3.4</option>
                            <option value="5.6">5.6</option>
                            <option value="7.8">7.8</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 课程名称
                    </div>
                    <div class="col-md-9">
                        <%--<input id="courseName" type="text" placeholder="请输入课程名称" value="${data.courseName}"/>--%>
                        <input id="courseName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${data.courseName}"/>
                        <%--<input id="addOrEdit_courseId" type="hidden" value="${toEdit.courseId}">--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 授课老师
                    </div>
                    <div class="col-md-9">
                        <%--<input id="courseTeacher" type="text" placeholder="请输入授课老师" value="${data.courseTeacher}"/>--%>
                        <input id="courseTeacher" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${data.courseTeacher}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        特殊地点
                    </div>
                    <div class="col-md-9">
                        <select id="specialPlace"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 开始学周
                    </div>
                    <div class="col-md-9">
                        <input id="startWeek" type="number" placeholder="请输入开始学周" value="${data.startWeek}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 结束学周
                    </div>
                    <div class="col-md-9">
                        <input id="endWeek" type="number" placeholder="请输入结束学周" value="${data.endWeek}"/>
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
        var weeks = "${data.weeks}";
        var courseNum = "${data.courseNum}";
        $("#weeks").val(weeks);
        $("#courseNum").val(courseNum);
        $("#specialPlace").append("<option value='' selected>请选择</option>");
        $.get("<%=request.getContextPath()%>/timeTableSpecialPlace/getTimeTableSpecialPlaceList4Select", function (data) {
            addOption(data, 'specialPlace', '${data.specialPlace}');
        });


        $.get("<%=request.getContextPath()%>/common/getCoures", function (data) {
            $("#courseName").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#courseName").val(ui.item.label.split("  ----  ")[0]);
                    $("#courseName").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#courseTeacher").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#courseTeacher").val(ui.item.label.split(" ---- ")[0]);
                    $("#courseTeacher").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            }})

    });


    function save() {
        var id = $("#id").val();
        var timeTableDepartmentId = $("#timeTableDepartmentId").val();
        var weeks = $("#weeks").val();
        var courseNum = $("#courseNum").val();
        var courseName = $("#courseName").val();
        var specialPlace = $("#specialPlace").val();
        var startWeek = $("#startWeek").val();
        var endWeek = $("#endWeek").val();
        var courseTeacher = $("#courseTeacher").val();
        if (weeks == "" || weeks == undefined || weeks == null) {
            swal({
                title: "请填写周时!",
                type: "info"
            });
            return;
        }
        if (courseNum == "" || courseNum == undefined || courseNum == null) {
            swal({
                title: "请填写课时!",
                type: "info"
            });
            return;
        }
        if (courseName == "" || courseName == undefined || courseName == null) {
            swal({
                title: "请填写课程名称!",
                type: "info"
            });
            return;
        }
        var courseTeacherId;
        if (null == $("#id").val() || "" == $("#id").val()) {
            if ($("#courseTeacher").attr("keycode") == "" || $("#courseTeacher").attr("keycode") == null || $("#courseTeacher").attr("keycode") == undefined) {
                swal({
                    title: "请输入教材简写名称，在点选正确教材名称！",
                    type: "info"
                });
                $("#courseTeacher").val("");
                return;
            }else {
                courseTeacherId = $("#courseTeacher").attr("keycode").split(",")[1];
                courseTeacher = $("#courseTeacher").val();
            }
        } else {
            if (courseTeacher == "" || courseTeacher == undefined || courseTeacher == null) {
                swal({
                    title: "请输入教师姓名，在点选教师姓名！",
                    type: "info"
                });
                return;
            } else {
                if ($("#courseTeacher").attr("keycode") == "" || $("#courseTeacher").attr("keycode") == null || $("#courseTeacher").attr("keycode") == undefined) {
                    if($("#courseTeacher").val()=='${data.courseTeacher}'){
                        courseTeacherId = $("#courseTeacherId").val();
                        courseTeacher = $("#courseTeacher").val();
                    }else{
                        swal({
                            title: "请输入教师姓名，在点选教师姓名！",
                            type: "info"
                        });
                        $("#courseTeacher").val("");
                        return;
                    }
                } else {
                    courseTeacherId = $("#courseTeacher").attr("keycode").split(",")[1];
                    courseTeacher = $("#courseTeacher").val();
                }
            }
        }

        if (startWeek == "" || startWeek == undefined || startWeek == null) {
            swal({
                title: "请填写开始学周!",
                type: "info"
            });
            return;
        }
        if (endWeek == "" || endWeek == undefined || endWeek == null) {
            swal({
                title: "请填结束学周 !",
                type: "info"
            });
            return;
        }

        if ((endWeek != "" || endWeek != undefined) && (startWeek != "" || startWeek != undefined)&&(parseInt(startWeek)>parseInt(endWeek))){
            swal({
                title: "开始学周需小于结束学周 !",
                type: "info"
            });
            return;
        }


        showSaveLoading();
        $.post("<%=request.getContextPath()%>/timeTableCourse/saveTimeTableCourse", {
            id: id,
            timeTableDepartmentId: timeTableDepartmentId,
            weeks: weeks,
            courseNum: courseNum,
            courseName: courseName,
            courseTeacher: courseTeacher,
            specialPlace: specialPlace,
            endWeek: endWeek,
            startWeek: startWeek,
            courseTeacherId: courseTeacherId
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: msg.result});
            if (msg.status == '0') {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            } else {
                return;
            }
        })
    }


</script>



