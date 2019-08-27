<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <input id="examId" name="examId" value="${examId}" hidden>
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${examName} > 设置考试场地</span>
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
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addRoom()">新增
                        </button>
                        <%--<button type="button" class="btn btn-default btn-clean"
                                onclick="batchAddExamRoom()">自动添加考场
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="autoWorkAddExamEmp()">自动设置监考教师
                        </button>--%>
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
<script>
    var table;
    $(document).ready(function () {

        table = $("#roomTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/exam/room/getExamRoomList?examId=${examId}',
            },
            "destroy": true,
            "columns": [
                {"data": "examRoomId", "visible": false},
                {"data": "examId", "visible": false},
                {"data": "roomId", "visible": false},
                {"data": "roomType", "title": "教室类型"},
                {"data": "roomName", "title": "考场名称"},
                {"data": "peopleNumber", "title": "场地容纳总人数"},
                {"data": "studentNumber", "title": "容纳考生数量"},
                {"data": "teacherNumber", "title": "监考教师数量"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=editRoom("' + row.examRoomId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delRoom("' + row.examRoomId + '","' + row.roomName + '","' + row.roomId + '","' + row.examId + '")/>&ensp;&ensp;';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });


    })
    //批量添加考场
    /*function batchAddExamRoom() {
        var examId=$('#examId').val();
        swal({
            title: "是否按照设定的考试班级批量添加考场?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("/exam/room/batchAddExamRoom", {
                examId:examId,
            }, function (data) {
                if(data.status==1){
                    swal({title: data.msg, type: "error"});
                    $('#roomTable').DataTable().ajax.reload();
                }else{
                    //('display','block');
                    swal({title: data.msg, type: "success"});
                    $('#roomTable').DataTable().ajax.reload();
                    //$("#layout").css('display','none');
                }
            });
        })
    }*/
    //手动设置监考教师
    /* function handWorkAddExamEmp(roomId,examId) {
         $.get("/exam/room/checkhandWorkAddExamEmp?examId={examId}", function (data) {
             if(data.status==1){
                 swal({title: data.msg, type: "error"});
             }else{
                 $("#dialog").load("/exam/room/handWorkAddExamEmp", {
                     examId: examId,
                     roomId: roomId
                 });
                 $("#dialog").modal("show");
             }

         })

     }*/

    //自动设置监考教师
    /*function autoWorkAddExamEmp() {
        var examId=$('#examId').val();
        swal({
            title: "是否按照设置的监考教师自动添加?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("/exam/room/autoWorkAddExamEmp", {
                examId:examId,
            }, function (data) {
                if(data.status==1 || data.status==2){
                    swal({title: data.msg, type: "error"});
                }else{
                    $("#layout").css('display','block');
                    swal({title: data.msg, type: "success"});
                    $('#roomTable').DataTable().ajax.reload();
                    $("#layout").css('display','none');
                }
            });
        })
    }*/
    function addRoom() {
        $("#dialog").load("<%=request.getContextPath()%>/exam/room/toAdd?examId=${examId}")
        $("#dialog").modal("show")
    }

    function editRoom(id) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/room/toEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function getClass(examRoomId, examId, roomId) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/class/toAddExamRoomClass", {
            examId: examId,
            examRoomId: examRoomId,
            roomId: roomId
        });
        $("#dialog").modal("show");
    }

    function getCourse(examRoomId, examId, roomId, roomName) {
        $.post("<%=request.getContextPath()%>/exam/room/getExamRoomClass", {
            examRoomId: examRoomId, examId: examId,
        }, function (boolean) {
            if (boolean == true) {
                swal({title: "没有考试班级，请先维护考试班级", type: "info"});
                return;
            } else {
                $("#right").load("<%=request.getContextPath()%>/exam/course/toCourse?examRoomId=" + examRoomId + "&roomId=" + roomId + "&examId=" + examId + "&roomName=" + roomName + "&examName=${examName}");
            }
        });


    }

    function delRoom(examRoomId, roomName, roomId, examId) {
        $.post("<%=request.getContextPath()%>/exam/room/getExamRoomCourseList", {
            examRoomId: examRoomId, examId: examId, roomId: roomId,
        }, function (boolean) {
            if (boolean == true) {
                swal({title: "考场名称:" + roomName + ",下有考试科目不能删除", type: "info"});
                return;
            } else {
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
                        id: examRoomId, roomId: roomId, examId: examId,
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
        });
    }

    function searchclear() {
        $("#kc_name").val("");
        table.ajax.url("<%=request.getContextPath()%>/exam/room/getExamRoomList?examId=${examId}").load();
    }

    function search() {
        var kc_name = $("#kc_name").val();
        if (kc_name == undefined || kc_name == null) {
            kc_name = "";
        }
        table.ajax.url("<%=request.getContextPath()%>/exam/room/getExamRoomList?roomName=" + kc_name + "&examId=${examId}").load();
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam/room");
    }
</script>