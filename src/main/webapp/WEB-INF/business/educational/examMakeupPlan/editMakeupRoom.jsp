<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="examRoomId" hidden value="${examRoom.examRoomId}"/>
            <input id="examId" hidden value="${examId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>考场
                    </div>
                    <div class="col-md-9">
                        <div>
                            <select id="roomId"></select>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        容纳考生数量
                    </div>
                    <div class="col-md-9">
                        <input  type="number" id="studentNumber" name="studentNumber" value="${examRoom.studentNumber}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        监考老师
                    </div>
                    <div class="col-md-9">
                        <input  type="text" id="teacher1" name="studentNumber" value="${examRoom.teacher1}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        监考老师
                    </div>
                    <div class="col-md-9">
                        <input  type="text" id="teacher2" name="studentNumber" value="${examRoom.teacher2}" />
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
/*
        $.get("< %=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '$ {course.departmentsId}');
        });
*/
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " ID",
            text: " CLASS_ROOM_NAME ",
            tableName: " T_JW_CLASSROOM ",
            where: " WHERE 1 = 1 and ROOM_TYPE = '1'"
        },function (data) {
            var selected = '${examRoom.roomId}';
            if( selected == undefined || null == selected || selected=="" ){
                addOption(data, "roomId" );
            }else{
                $.each(data, function (index, content) {
                    if (content.id == '${examRoom.roomId}') {
                        $("#roomId").append("<option value='" + content.id + "' selected>" + content.text + "</option>")
                    }
                })
            }
        });

        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#teacher1").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacher1").val(ui.item.label);
                    $("#teacher1").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
            $("#teacher2").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacher2").val(ui.item.label);
                    $("#teacher2").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };

            if('${examRoom.teacher1Show}'!=""){
                $("#teacher1").val("${examRoom.teacher1Show}");
                $("#teacher1").attr("keycode", "${examRoom.dept1},${examRoom.teacher1}");
            }

            if('${examRoom.teacher2Show}'!=""){
                $("#teacher2").val("${examRoom.teacher2Show}");
                $("#teacher2").attr("keycode", "${examRoom.dept2},${examRoom.teacher2}");
            }

        })

    });


    function save() {
        var examRoomId = $("#examRoomId").val();
        var examId = $("#examId").val();
        var roomId = $("#roomId option:selected").val();
        var roomName = $("#roomId option:selected").text();

        var studentNumber = $("#studentNumber").val();
        if (roomId == "" || roomId == undefined || roomId == null) {
            swal({
                title: "请选择考场！",
                type: "info"
            });
            return;
        }
        if (studentNumber == "" || studentNumber == undefined || studentNumber == null) {
            swal({
                title: "请填写容纳考生数量！",
                type: "info"
            });
            return;
        }
        if (studentNumber <= 0) {
            swal({
                title: "容纳考生数量需要大于0！",
                type: "info"
            });
            return;
        }

        var teacher1 = $("#teacher1").attr("keycode");
        var dept1 = "";
        if (teacher1 == "" || teacher1 == undefined || teacher1 == null) {
            swal({
                title: "请填写监考教师！",
                type: "info"
            });
            return;
        }

        var teacher2 = $("#teacher2").attr("keycode");
        var dept2 = "";
        if (teacher2 == "" || teacher2 == undefined || teacher2 == null) {
            swal({
                title: "请填写监考教师！",
                type: "info"
            });
            return;
        }
        if(teacher1 == teacher2){
            swal({
                title: "两个监考教师不能重复！",
                type: "info"
            });
            return;
        }
        if (null != teacher1 && teacher1 != ""){
            var lis = teacher1.split(",");
            dept1 =lis[0];
            teacher1 = lis[1];
        }

        if (null != teacher2 && teacher2 != ""){
            var lis = teacher2.split(",");
            dept2 =lis[0];
            teacher2 = lis[1];
        }


        showSaveLoading();
        $.post("<%=request.getContextPath()%>/exam/makeup/saveRoom",{
            examRoomId: examRoomId,
            examId: examId,
            roomId: roomId,
            roomName: roomName,
            studentNumber: studentNumber,
            teacher1: teacher1,
            dept1: dept1,
            teacher2: teacher2,
            dept2: dept2,
        },function(msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: msg.result
            });
            if(msg.status =='1'){
                $("#dialog").modal('hide');
                $('#scoreRomeTable').DataTable().ajax.reload();
            }
        })
    }
</script>



