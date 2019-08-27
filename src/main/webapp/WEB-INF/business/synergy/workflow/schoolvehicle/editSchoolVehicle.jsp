<%--校内车辆管理申请新增与修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/10
  Time: 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="requestDept" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolVehicle.requestDept}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="requester" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolVehicle.requester}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请时间
                    </div>
                    <div class="col-md-9">
                        <input id="requestTime" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolVehicle.requestTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        车辆品牌及型号
                    </div>
                    <div class="col-md-9">
                        <input id="vehicleModel" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="12" placeholder="最多输入12个字"
                               class="validate[required,maxSize[10]] form-control"
                               value="${schoolVehicle.vehicleModel}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        车牌号码
                    </div>
                    <div class="col-md-9">
                        <input id="vehicleNum" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="6" placeholder="最多输入6个汉字"
                               class="validate[required,maxSize[10]] form-control"
                               value="${schoolVehicle.vehicleNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        是否为本人车辆
                    </div>
                    <div class="col-md-9">
                        <select  id="vehicleIf" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark" maxlength="65" placeholder="最多输入65个字"
                                  class="validate[required,maxSize[100]] form-control">${schoolVehicle.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">
                保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">
                关闭</button>
        </div>
    </div>
    <input id="id" name="id" type="hidden" value="${schoolVehicle.id}">
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'vehicleIf','${schoolVehicle.vehicleIf}');
        });
    })
    /**功能：修改的申请信息保存
     * create by wq
     * @return mv界面
     */
    function save(){
        var requestTime = $("#requestTime").val();
        requestTime = requestTime.replace('T', '');
        if ($("#vehicleModel").val() == "" || $("#vehicleModel").val() == undefined) {
            swal({
                title: "请填写车辆品牌及型号！",
                type: "info"
            });
            return;
        }
        if ($("#vehicleNum").val() == "" || $("#vehicleNum").val() == undefined) {
            swal({
                title: "请填写车牌号码！",
                type: "info"
            });
            return;
        }
        if($("#vehicleIf").val()=="" || $("#vehicleIf").val() == undefined){
            swal({
                title: "请选择是否为本人车辆！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/schoolVehicle/saveSchoolVehicle",{
            id:$("#id").val(),
            vehicleModel: $("#vehicleModel").val(),
            vehicleNum:$("#vehicleNum").val(),
            vehicleIf:$("#vehicleIf").val(),
            requestTime:requestTime,
            remark:$("#remark").val()
        }, function (msg) {
            hideSaveLoading();
//          保存后刷新页面数据表
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#listGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }
</script>