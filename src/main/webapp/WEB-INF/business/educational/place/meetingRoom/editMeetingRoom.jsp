<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/14
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%--新增页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="meetingRoomId" hidden value="${meetingRoom.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 会议室名称
                    </div>
                    <div class="col-md-9">
                        <input id="f_meetingRoomName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${meetingRoom.meetingRoomName}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  所在楼宇
                    </div>
                    <div class="col-md-9">
                        <select id="abuildingId"  class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 容纳人数
                    </div>
                    <div class="col-md-9">
                        <input id="f_peopleNumber" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${meetingRoom.peopleNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 房间号
                    </div>
                    <div class="col-md-9">
                        <input id="f_roomNumber" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${meetingRoom.roomNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  所在楼层
                    </div>
                    <div class="col-md-9">
                        <select id="efloorId"  class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="f_remark" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${meetingRoom.remark}" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " building_name ",
                tableName: "T_JW_BUILDING",
                where: " WHERE building_type in ('1','2','3','4','5','8')",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "abuildingId",'${meetingRoom.buildingId}');
            });
        $("#efloorId").append("<option value='' selected>请选择</option>");
        $.get("<%=request.getContextPath()%>/building/getFloorByBuildingId?id="+'${meetingRoom.buildingId}',function (data) {
            addOption(data, 'efloorId','${meetingRoom.floor}');
        });
        $("#abuildingId").change(function () {
            $.get("<%=request.getContextPath()%>/building/getFloorByBuildingId?id="+$("#abuildingId").val(),function (data) {
                addOption(data, 'efloorId');
            });
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SYZT", function (data) {
            addOption(data, 'euseStatusId', '${meetingRoom.useStatus}');
        });

    });
    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_meetingRoomName").val() == "" || $("#f_meetingRoomName").val() == "0" || $("#f_meetingRoomName").val() == undefined) {
            swal({
                title: "请填写会议室名称！",
                type: "info"
            });
            return;
        }
        if ($("#abuildingId").val() == "" || $("#abuildingId").val() == "0" || $("#abuildingId").val() == undefined) {
            swal({
                title: "请选择所在楼宇！",
                type: "info"
            });
            return;
        }
        if ($("#f_peopleNumber").val() == "" || $("#f_peopleNumber").val() == "0" || $("#f_peopleNumber").val() == undefined) {
            swal({
                title: "请填写容纳人数！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#f_peopleNumber").val())){
            swal({
                title: "容纳人数填写整数！",
                type: "info"
            });
            return;
        }
        if ($("#f_roomNumber").val() == "" || $("#f_roomNumber").val() == "0" || $("#f_roomNumber").val() == undefined) {
            swal({
                title: "请填写房间号！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#f_roomNumber").val())){
            swal({
                title: "房间号填写整数！",
                type: "info"
            });
            return;
        }
        if ($("#efloorId").val() == "" || $("#efloorId").val() == "0" || $("#efloorId").val() == undefined){
            swal({
                title: "请填写所在楼层！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/meetingRoom/checkName",{
            meetingRoomName: $("#f_meetingRoomName").val(),
            id:$("#meetingRoomId").val()
        },function(msg){
            if(msg.status == 1){
                swal({
                    title: "会议室名称重复，请重新填写！",
                    type: "error"
                });
            }else{
                showSaveLoading();
                $.post("<%=request.getContextPath()%>/meetingRoom/saveMeetingRoom", {
                    id: $("#meetingRoomId").val(),
                    meetingRoomName: $("#f_meetingRoomName").val(),
                    buildingId: $("#abuildingId option:selected").val(),
                    peopleNumber: $("#f_peopleNumber").val(),
                    roomNumber:$("#f_roomNumber").val(),
                    floor: $("#efloorId option:selected").val(),
                    remark: $("#f_remark").val()
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $("#dialog").modal('hide');
                        $('#meetingRoom').DataTable().ajax.reload();

                    }
                })
            }
        })
    }

</script>
