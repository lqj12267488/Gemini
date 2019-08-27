<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/14
  Time: 9:53
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
            <input id="buildingId" hidden value="${building.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 楼宇名称
                    </div>
                    <div class="col-md-9">
                        <input id="f_buildingName" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${building.buildingName}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        楼宇类型
                    </div>
                    <div class="col-md-9">
                        <select id="buildingTypeId" disabled="disabled"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        楼宇面积（㎡）
                    </div>
                    <div class="col-md-9">
                        <input id="f_area" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${building.area}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar" >
                        楼层数
                    </div>
                    <div class="col-md-9">
                        <select id="f_floorNumber" disabled="disabled"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        房间数
                    </div>
                    <div class="col-md-9">
                        <input id="f_roomNumber" type="text" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${building.roomNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 地址
                    </div>
                    <div class="col-md-9">
                        <input id="f_address" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${building.address}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="f_remark" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${building.remark}" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $(document).ready(function () {
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=LYLX", function (data) {
                addOption(data, 'buildingTypeId', '${building.buildingType}');
            });
        })
        $(document).ready(function () {
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=LC", function (data) {
                addOption(data, 'f_floorNumber', '${building.floorNumber}');
            });
        })
    })
    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        var reg1 = /^[0-9]+.?[0-9]*$/;
        if ($("#f_buildingName").val() == "" || $("#f_buildingName").val() == "0" || $("#f_buildingName").val() == undefined) {
            swal({
                title: "请填写楼宇名称！",
                type: "info"
            });
            return;
        }
        if ($("#f_address").val() == "" || $("#f_address").val() == "0" || $("#f_address").val() == undefined) {
            swal({
                title: "请填写地址！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/building/checkName",{
            buildingName: $("#f_buildingName").val(),
            id:$("#buildingId").val()
        },function(msg){
            if(msg.status == 1){
                swal({
                    title: "楼宇名称重复，请重新填写!",
                    type: "error"
                });
            }else{
                showSaveLoading();
                $.post("<%=request.getContextPath()%>/building/saveBuilding", {
                    id: $("#buildingId").val(),
                    buildingName: $("#f_buildingName").val(),
                    buildingType: $("#buildingTypeId option:selected").val(),
                    area: $("#f_area").val(),
                    floorNumber:$("#f_floorNumber").val(),
                    roomNumber: $("#f_roomNumber").val(),
                    address: $("#f_address").val(),
                    remark: $("#f_remark").val()
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $("#dialog").modal('hide');
                        $('#building').DataTable().ajax.reload();

                    }
                })
            }
        })
    }

</script>
