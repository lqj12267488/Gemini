<%--排课场地编辑界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/8/21
  Time: 17:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <span style="font-size: 14px">${head}</span>
            <input id="id" value="${arrayClassRoom.id}" hidden>
            <input id="w_arrayClassId" value="${arrayClassId}" hidden >
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        教室类型
                    </div>
                    <div class="col-md-9">
                        <select id="w_roomType" class="js-example-basic-single" onchange="changeEditRoom()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        教室名称
                    </div>
                    <div class="col-md-9">
                        <select id="w_roomId" class="js-example-basic-single"></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>

    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSLX", function (data) {
            addOption(data, 'w_roomType', '${arrayClassRoom.roomType}');
        });
        var roomType = '${arrayClassRoom.roomType}';
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " ID",
            text: " CLASS_ROOM_NAME ",
            tableName: " T_JW_CLASSROOM ",
            where: " WHERE 1 = 1 and ROOM_TYPE = '"+ roomType +"'"
        },function (data) {
            addOption(data, "w_roomId", '${arrayClassRoom.roomId}');
        });
    })
    function save() {
        var arrayClassId;
        if ($("#w_roomType").val() == "" || $("#w_roomType").val() == undefined) {
            swal({
                title: "请选择教室类型！",
                type: "info"
            });
            return;
        }
        if ($("#w_roomId").val() == "" || $("#w_roomId").val() == "0" || $("#w_roomId").val() == undefined) {
            swal({
                title: "请选择班级名称！",
                type: "info"
            });
            return;
        }
        if ($("#id").val() == "" || $("#id").val() == "0" || $("#id").val() == undefined) {
            arrayClassId=$("#w_arrayClassId").val();
        }else{
            arrayClassId='${arrayClassRoom.arrayClassId}';
        }

        showSaveLoading();

        $.post("<%=request.getContextPath()%>/arrayClassRoom/checkRoom",{
            id:$("#id").val(),
            arrayClassId: arrayClassId,
            roomId:$("#w_roomId").val()
        },function(msg){
            hideSaveLoading();

            if(msg.status == 1){
                swal({
                    title: "该教室已在排课计划中，请重新选择！",
                    type: "info"
                });
            }else{
                showSaveLoading();

                $.post("<%=request.getContextPath()%>/arrayClassRoom/saveArrayClassRoom", {
                    id: $("#id").val(),
                    arrayClassId: arrayClassId,
                    roomType: $("#w_roomType").val(),
                    roomId: $("#w_roomId").val(),
                    roomName: $("#w_roomId").val(),
                    peopleNumber: $("#w_roomId").val()
                }, function (msg) {
                    hideSaveLoading();

                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        $("#dialog").modal('hide');
                        $('#arrayClassRoomGrid').DataTable().ajax.reload();
                    }
                })
            }
        })
    }
    function changeEditRoom() {
        var roomType = $("#w_roomType").val();
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " ID",
            text: " CLASS_ROOM_NAME ",
            tableName: " T_JW_CLASSROOM ",
            where: " WHERE 1 = 1 and ROOM_TYPE = '"+ roomType +"'"
        },function (data) {
            addOption(data, "w_roomId");
        });
    }
</script>

