<%--教室场地维护新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/15
  Time: 10:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="c_id" hidden value="${classroom.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>   教室名称
                    </div>
                    <div class="col-md-9">
                        <input id="c_classroomName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${classroom.classroomName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  所在楼宇
                    </div>
                    <div class="col-md-9">
                        <select  id="c_building" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  所在楼层
                    </div>
                    <div class="col-md-9">
                        <select  id="c_floor" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>   教室类型
                    </div>
                    <div class="col-md-9">
                        <select  id="c_roomType" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>   容纳人数
                    </div>
                    <div class="col-md-9">
                        <input id="c_peopleNumber" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${classroom.peopleNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="c_remark" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${classroom.remark}"/>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
        id:"id",
        text:"building_name",
        tableName:"T_JW_BUILDING",
        where:"WHERE valid_flag ='1' AND building_type in ('3','4','5','8')",
        orderBy:"ORDER BY building_name"}
        , function (data) {
            addOption(data, 'c_building','${classroom.buildingId}');
        });
        $("#c_floor").append("<option value='' selected>请选择</option>");
        $.get("<%=request.getContextPath()%>/building/getFloorByBuildingId?id="+'${classroom.buildingId}',function (data) {
            addOption(data, 'c_floor','${classroom.floor}');
        });
        $("#c_building").change(function () {
            $.get("<%=request.getContextPath()%>/building/getFloorByBuildingId?id="+$("#c_building").val(),function (data) {
                addOption(data, 'c_floor');
            });
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSLX", function (data) {
            addOption(data, 'c_roomType','${classroom.roomType}');
        });
    })
    function save() {
        var reg = /^[0-9]+?[0-9]*$/;
        if( $("#c_classroomName").val() =="" ||  $("#c_classroomName").val() =="0" || $("#c_classroomName").val() == undefined){
            swal({
                title: "请填写教室名称！",
                type: "info"
            });
            return;
        }
        if($("#c_building option:selected").val()=="" ||  $("#c_building option:selected").val() =="0" || $("#c_building option:selected").val() == undefined){
            swal({
                title: "请填写所在楼宇！",
                type: "info"
            });
            return;
        }
        if($("#c_floor option:selected").val()=="" ||  $("#c_floor option:selected").val() =="0" || $("#c_floor option:selected").val() == undefined){
            swal({
                title: "请选择所在楼层！",
                type: "info"
            });
            return;
        }
        if($("#c_roomType option:selected").val()=="" || $("#c_roomType option:selected").val() == undefined){
            swal({
                title: "请选择教室类型！",
                type: "info"
            });
            return;
        }
        if($("#c_peopleNumber").val()=="" ||  $("#c_peopleNumber").val() =="0" || $("#c_peopleNumber").val() == undefined){
            swal({
                title: "请填写容纳人数！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#c_peopleNumber").val())){
            swal({
                title: "容纳人数请填写整数！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/classroom/checkName",{
            classroomName: $("#c_classroomName").val(),
            id:$("#c_id").val()
        },function(msg){
            if(msg.status == 1){
                swal({
                    title: "教室名称重复，请重新填写！",
                    type: "error"
                });
            }else{
                showSaveLoading();
                $.post("<%=request.getContextPath()%>/classroom/saveClassroom", {
                    id: $("#c_id").val(),
                    classroomName: $("#c_classroomName").val(),
                    buildingId: $("#c_building option:selected").val(),
                    floor: $("#c_floor option:selected").val(),
                    roomType:$("#c_roomType option:selected").val(),
                    peopleNumber: $("#c_peopleNumber").val(),
                    remark: $("#c_remark").val(),
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1 ) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $("#dialog").modal('hide');
                        $('#classroomGrid').DataTable().ajax.reload();
                    }
                })
            }
        })
    }
</script>
