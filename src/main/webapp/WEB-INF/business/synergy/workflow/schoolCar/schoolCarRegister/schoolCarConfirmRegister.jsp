<%--学校车辆外出使用管理-申请人确认登记信息界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/4
  Time: 15:38
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
                        <input id="s_useType" type="text"
                               class="validate[required,maxSize[10]] form-control"
                               value="${schoolCar.useType}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        行驶里程
                    </div>
                    <div class="col-md-9">
                        <input id="s_dMileage" type="text"
                               class="validate[required,maxSize[10]] form-control"
                               value="${schoolCar.drivenMileage}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        车辆损耗
                    </div>
                    <div class="col-md-9">
                        <textarea id="s_carLoss"
                                  class="validate[required,maxSize[100]] form-control" readonly="readonly">${schoolCar.carLoss}</textarea>
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
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="confirm()">
                确认登记信息</button>
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
    function confirm(){
        var requestDate = $("#s_requestDate").val();
        requestDate = requestDate.replace('T', '');
        var date = $("#s_checkTime").val();
        date = date.replace('T', '');
        var startTime = $("#s_startTime").val();
        var endTime =$("#s_endTime").val();
        startTime = startTime.replace('T','');
        endTime = endTime.replace('T','');
        $.post("<%=request.getContextPath()%>/schoolCar/confirmSchoolCarRegister",{
            id:$("#s_Id").val(),
            checkFlag:1,
            requesterConfirmFlag:1
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
