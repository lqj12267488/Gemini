<%--学校车辆外出使用管理-车辆管理员登记信息界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/6/29
  Time: 14:51
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
            <input id="s_Id" name="s_Id" type="hidden" value="${schoolCar.id}">
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
                        <input id="s_requestDept" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolCar.requestDept}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="s_requester" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolCar.requester}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请时间
                    </div>
                    <div class="col-md-9">
                        <input id="s_requestDate" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolCar.requestDate}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="s_startTime" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolCar.startTime}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="s_endTime" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolCar.endTime}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        始发地
                    </div>
                    <div class="col-md-9">
                        <input id="s_startPlace" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolCar.startPlace}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        目的地
                    </div>
                    <div class="col-md-9">
                        <input id="s_endPlace" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolCar.endPlace}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        使用车型
                    </div>
                    <div class="col-md-9">
                        <input id="s_carType" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolCar.carType}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请事由
                    </div>
                    <div class="col-md-9">
                        <textarea id="s_reason"
                                  class="validate[required,maxSize[100]] form-control" readonly="readonly">${schoolCar.reason}</textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        人数
                    </div>
                    <div class="col-md-9">
                        <input id="s_peopleNum" type="text"
                               class="validate[required,maxSize[10]] form-control"
                               value="${schoolCar.peopleNum}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="s_remark"
                                  class="validate[required,maxSize[100]] form-control" readonly="readonly">${schoolCar.remark}</textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        用车方式
                    </div>
                    <div class="col-md-9">
                        <input id="s_useType" type="text"  onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[10]] form-control"
                               value="${schoolCar.useType}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        行驶里程
                    </div>
                    <div class="col-md-9">
                        <input id="s_dMileage" type="text" placeholder="请输入数字"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[10]] form-control"
                               value="${schoolCar.drivenMileage}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        车辆损耗
                    </div>
                    <div class="col-md-9">
                        <textarea id="s_carLoss" maxlength="30" placeholder="最多输入30个字"
                                  class="validate[required,maxSize[100]] form-control">${schoolCar.carLoss}</textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        管理部门
                    </div>
                    <div class="col-md-9">
                        <input id="s_carManagerDept" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolCar.carManagerDept}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        管理员
                    </div>
                    <div class="col-md-9">
                        <input id="s_carManager" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolCar.carManager}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        登记时间
                    </div>
                    <div class="col-md-9">
                        <input id="s_checkTime" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${schoolCar.checkTime}" readonly="readonly"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="submit()">
                移交申请人确认</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">
                关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/schoolCar/getDept", function (data) {
            $("#s_carManagerDept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#s_carManagerDept").val(ui.item.label);
                    $("#s_carManagerDept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            }
        })
    })
    /**功能：登记信息保存
     * create by wq
     * @return mv界面
     */
    function submit(){
        var reg = /^[0-9]+.?[0-9]*$/;
        if ($("#s_useType").val() == "" || $("#s_useType").val() == "0" || $("#s_useType").val() == undefined) {
            swal({
                title: "请填写用车方式！",
                type: "info"
            });
            return;
        }
        if ($("#s_dMileage").val() == "" || $("#s_dMileage").val() == "0" || $("#s_dMileage").val() == undefined) {
            swal({
                title: "请填写行驶里程！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#s_dMileage").val())){
            swal({
                title: "行驶里程请填写数字！",
                type: "info"
            });
            return;
        }
        if ($("#s_carLoss").val() == "" || $("#s_carLoss").val() == "0" || $("#s_carLoss").val() == undefined) {
            swal({
                title: "请填写车辆损耗情况！",
                type: "info"
            });
            return;
        }
        var requestDate = $("#s_requestDate").val();
        requestDate = requestDate.replace('T', '');
        var date = $("#s_checkTime").val();
        date = date.replace('T', '');
        var startTime = $("#s_startTime").val();
        var endTime =$("#s_endTime").val();
        startTime = startTime.replace('T','');
        endTime = endTime.replace('T','');
        $.post("<%=request.getContextPath()%>/schoolCar/saveSchoolCarRegister",{
            id:$("#s_Id").val(),
            useType:$("#s_useType").val(),
            drivenMileage:$("#s_dMileage").val(),
            carLoss:$("#s_carLoss").val(),
            carManager:$("#s_carManager").val(),
            checkTime:date,
            carManagerDept:$("#s_carManagerDept").val(),
            checkFlag:1,
            requesterConfirmFlag:0
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#schoolCarGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }
</script>
