<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <input id="examId" name="examId" value="${examId}" hidden>
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${examName} > 设置监考教师</span>
                </div>
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                考场名称：
                            </div>
                            <div class="col-md-2">
                                <input id="kc_name" class="js-example-basic-single"></input>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <br>
                    </div>
                    <table id="roomTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                    <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center">
                        <img src="<%=request.getContextPath()%>/../../../libs/img/app/loading.gif" style="height: 50px;text-align: center"/>
                        <h3>正在操作中，请稍后……</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="setTeacher" tabindex="111" role="dialog" aria-labelledby="setTeacher" aria-hidden="false" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" onclick='$("#setTeacher").modal("hide")' aria-hidden="true">×</button>
                <h4 class="modal-title">替换教师</h4>
            </div>
            <div class="modal-body clearfix">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 姓名
                    </div>
                    <div class="col-md-9">
                        <input id="examTeacherId" hidden>
                        <select id="teacherId"></select>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default btn-clean" onclick="updateTeacher()">保存</button>
                <button class="btn btn-default btn-clean" onclick='$("#setTeacher").modal("hide")'>关闭</button>
            </div>
        </div>
    </div>
</div>

<script>

    var table;
    $(document).ready(function () {
        table = $("#roomTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/exam/course/getExamCourseRoomTeacherList?examId=${examId}',
            },
            "destroy": true,
            "columns": [
                {"data": "examId", "visible": false},
                {"data": "roomId", "visible": false},
                {"data": "roomShow", "title": "考场名称"},
                {"data": "departmentShow", "title": "部门"},
                {"data": "teacherPersonIdShow", "title": "监考教师"},
                {"data": "date", "title": "日期"},
                {"data": "startTime", "title": "开始时间"},
                {"data": "endTime", "title": "结束时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改监考教师" ' +
                            'onclick=setTeacher("' + row.id + '","' + row.examId + '")/>&ensp;&ensp;'
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    });

    function setTeacher(id, examId) {
        $.get("<%=request.getContextPath()%>/eaxm/getTeacher?id=" + id + "&examId=" + examId, function (data) {
            addOption(data, "teacherId");
            $("#examTeacherId").val(id);
            $("#setTeacher").modal("show");
            $(".modal-backdrop").removeClass("modal-backdrop");
        });
    }

    function updateTeacher() {
        var id = $("#examTeacherId").val();
        var teacherId = $("#teacherId").val();
        if (teacherId == '' || teacherId == undefined) {
            swal({
                title: "请选择教师",
                type: "info"
            });
            return;
        }
        $.get("<%=request.getContextPath()%>/eaxm/updateTeacher?id=" + id + "&teacherId=" + teacherId, function (data) {
            swal({
                title: data.msg,
                type: "info"
            });
            $("#setTeacher").modal("hide");
            $('#roomTable').DataTable().ajax.reload();
        });
    }

    //自动设置监考教师
    function autoWorkAddExamEmp() {
        var examId = $('#examId').val();
        swal({
            title: "是否按照设置的监考教师自动添加?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/exam/room/autoWorkAddExamEmp", {
                examId: examId,
            }, function (data) {
                if (data.status == 1 || data.status == 2) {
                    swal({title: data.msg, type: "error"});
                } else {
                    $("#layout").css('display', 'block');
                    swal({title: data.msg, type: "success"});
                    $('#roomTable').DataTable().ajax.reload();
                    $("#layout").css('display', 'none');
                }
            });
        })
    }

    function addRoom() {
        $("#dialog").load("<%=request.getContextPath()%>/exam/room/toAdd?examId=${examId}")
        $("#dialog").modal("show")
    }

    function editRoom(examRoomId, roomId, examId) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/room/handWorkAddExamEmp?roomId=" + roomId + "&examId=" + examId)
        $("#dialog").modal("show")
    }

    function delRoom(id, roomName, roomId, examId) {
        swal({
            title: "您确定要删除本条信息?",
            text: "考场名称：" + roomName + "\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/exam/room/del", {
                id: id, examId: examId, roomId: roomId,
            }, function (data) {
                if (data.status == 1) {
                    swal({title: data.msg, type: "error"});
                } else {
                    swal({title: data.msg, type: "success"});
                    $('#roomTable').DataTable().ajax.reload();
                }
            });
        })
    }

    function searchclear() {
        $("#kc_name").val("");
        table.ajax.url("<%=request.getContextPath()%>/exam/course/getExamCourseRoomTeacherList?examId=${examId}").load();
    }

    function search() {
        var kc_name = $("#kc_name").val();
        if (kc_name == undefined || kc_name == null) {
            kc_name = "";
        }

        table.ajax.url("<%=request.getContextPath()%>/exam/course/getExamCourseRoomTeacherList?roomShow=" + kc_name + "&examId=${examId}").load();
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam/teacher");
    }
</script>