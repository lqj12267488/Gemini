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
            <input id="timeTableId" hidden value="${data.timeTableId}"/>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentId" onchange="changeMajor()" value="${data.departmentId}"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 专业
                    </div>
                    <div class="col-md-9">
                        <select id="majorId" onchange="changeClass()" value="${data.majorId}"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 班级
                    </div>
                    <div class="col-md-9">
                        <select id="classId" value="${data.classId}"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 人数
                    </div>
                    <div class="col-md-9">
                        <input id="peopleNumber" type="text" placeholder="请输入人数" value="${data.peopleNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 教室
                    </div>
                    <div class="col-md-9">
                        <select id="classRom" placeholder="请输入教室 " value="${data.classRom}"></select>
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
        $("#majorId").append("<option value='' selected>请选择</option>");
        $("#classId").append("<option value='' selected>请选择</option>");
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentId', '${data.departmentId}');
        });
        $.get("<%=request.getContextPath()%>/timeTableDepartment/getMajorCodeByDeptId?id=" + "${data.departmentId}", function (data) {
            addOption(data, 'majorId','${data.majorId}');
        });
        $.get("<%=request.getContextPath()%>/timeTableDepartment/getClassIdByMajorCode?id=" + "${data.majorId}", function (data) {
            addOption(data, 'classId','${data.classId}');
        });

        //教室
        $.get("<%=request.getContextPath()%>/classroom/getClassroomList", function (data) {
            addClassRoomOption(data.data, 'classRom','${data.classRom}');
        });

    });

    function changeMajor() {
        var deptId = $("#departmentId").val();
        $.get("<%=request.getContextPath()%>/timeTableDepartment/getMajorCodeByDeptId?id=" + deptId, function (data) {
            addOption(data, 'majorId');
        });
    }


    function changeClass() {
        var majorId = $("#majorId").val();
        $.get("<%=request.getContextPath()%>/timeTableDepartment/getClassIdByMajorCode?id=" + majorId, function (data) {
            addOption(data, 'classId');
        });
    }


    function save() {
        var id = $("#id").val();
        var timeTableId = $("#timeTableId").val();
        var departmentId = $("#departmentId").val();
        var majorId = $("#majorId").val();
        var classId = $("#classId").val();
        var peopleNumber = $("#peopleNumber").val();
        var classRomId = $("#classRom").val();

        if (departmentId == "" || departmentId == undefined || departmentId == null) {
            swal({
                title: "请选择系部!",
                type: "info"
            });
            return;
        }
        if (majorId == "" || majorId == undefined || majorId == null) {
            swal({
                title: "请选择专业名称!",
                type: "info"
            });
            return;
        }
        if (classId == "" || classId == undefined || classId == null) {
            swal({
                title: "请选择班级 !",
                type: "info"
            });
            return;
        }
        if (peopleNumber == "" || peopleNumber == undefined || peopleNumber == null) {
            swal({
                title: "请填写人数 !",
                type: "info"
            });
            return;
        }
        if (classRomId == "" || classRomId == undefined || classRomId == null) {
            swal({
                title: "请选择教室!",
                type: "info"
            });
            return;
        }

        showSaveLoading();
        $.post("<%=request.getContextPath()%>/timeTableDepartment/saveTimeTableDepartment", {
            id: id,
            timeTableId: timeTableId,
            departmentId: departmentId,
            majorId: majorId,
            classId: classId,
            peopleNumber: peopleNumber,
            classRom: classRomId
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: msg.result});
            if (msg.status == '0') {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            } else {

            }
        })
    }

    /**
     * 添加教室下拉框选项
     * @param data
     * @param select
     * @param selected
     */
    function addClassRoomOption(data, select, selected) {
        $("#" + select).html("");
        if (selected === undefined) {
            $("#" + select).append("<option value='' selected>请选择</option>")
        } else {
            $("#" + select).append("<option value=''>请选择</option>")
        }

        $.each(data, function (index, content) {

            if (content.id === selected) {
                $("#" + select).append("<option value='" + content.id + "' selected>" + content.classroomName + "</option>")
            } else {
                $("#" + select).append("<option value='" + content.id + "'>" + content.classroomName + "</option>")
            }
        })
        if (data.length == 0) {
            $("#" + select).append("<option value=''>无数据</option>")
        }
    }
</script>



