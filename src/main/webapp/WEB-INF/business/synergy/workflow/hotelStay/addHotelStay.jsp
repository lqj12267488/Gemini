<%--学校商友酒店住宿管理新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/6/20
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
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
            <input id="h_Id" name="h_Id" type="hidden" value="${hotelStay.id}">
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
                        <input id="h_requestDept" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${hotelStay.requestDept}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        经办人
                    </div>
                    <div class="col-md-9">
                        <input id="h_requester" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${hotelStay.requester}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请时间
                    </div>
                    <div class="col-md-9">
                        <input id="h_requestDate" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${hotelStay.requestDate}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        事由
                    </div>
                    <div class="col-md-9">
                        <textarea id="h_reason" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${hotelStay.reason}">${hotelStay.reason}</textarea>
                    </div>
                </div>

                <div class="changeNum">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            住宿人数
                        </div>
                        <div class="col-md-9">
                            <input id="h_peopleNumber" type="text" placeholder="请输入数字"
                                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${hotelStay.peopleNumber}"/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            入住时间
                        </div>
                        <div class="col-md-9">
                            <input id="h_checkInTime" type="datetime-local"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${hotelStay.checkInTime}"/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            离店时间
                        </div>
                        <div class="col-md-9">
                            <input id="h_checkOutTime" type="datetime-local"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${hotelStay.checkOutTime}"/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            住宿标准(元/天)
                        </div>
                        <div class="col-md-9">
                            <input id="h_price" type="text" placeholder="请输入数字"
                                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${hotelStay.price}"/>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        住宿天数
                    </div>
                    <div class="col-md-9">
                        <input id="h_stayDays" type="text"
                               class="validate[required,maxSize[20]] form-control" readonly="readonly"
                               value="${hotelStay.stayDays}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        合计
                    </div>
                    <div class="col-md-9">
                        <textarea id="h_totalAmount" readonly="readonly"
                                  class="validate[required,maxSize[100]] form-control"
                        >${hotelStay.totalAmount}</textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="h_remark" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control">${hotelStay.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">
                保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">
                关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/hotelStay/getDept", function (data) {
            $("#h_requestDept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#h_requestDept").val(ui.item.label);
                    $("#h_requestDept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            }
        })
    })
    var days;
    /**功能：校验住宿人数，住宿天数，住宿标准是否为数字，并计算出总金额
     * create by wq
     * @return mv界面
     */
    $(".changeNum input").on('change', function () {
        var reg = /^[0-9]+.?[0-9]*$/;
        var checkInTime = $("#h_checkInTime").val();
        var checkOutTime = $("#h_checkOutTime").val();
        var checkInHour = new Date(checkInTime.replace('T', ' ')).getHours();
        var checkOutHour = new Date(checkOutTime.replace('T', ' ')).getHours();
        checkInTime = new Date(checkInTime.replace('T', ' ')).getTime();
        checkOutTime = new Date(checkOutTime.replace('T', ' ')).getTime();
        days = checkOutTime - checkInTime;
        days = parseInt(days / (1000 * 60 * 60 * 24));
        if (checkInHour < 12 && checkOutHour < 12) {
            days += 1;
        } else if (checkInHour > 12 && checkOutHour > 12) {
            days += 1;
        } else if (checkInHour < 12 && checkOutHour > 12) {
            days += 2;
        }
        document.getElementById("h_stayDays").value = days;
        var peopleNumber = $("#h_peopleNumber").val();
        var price = $("#h_price").val();
        var stayDays = $("#h_stayDays").val();
        var totalAmount = document.getElementById("h_totalAmount");
        totalAmount.value = price * stayDays * peopleNumber;
    });

    /**功能：修改的申请信保存
     * create by wq
     * @return mv界面
     */
    function save() {
        var date = $("#h_requestDate").val();
        date = date.replace('T', '');
        var reg = new RegExp("^[0-9]*$");
        var reg2 = new RegExp("^\\d+(\\.\\d+)?$");
        var reg3 = new RegExp("^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,2})?$");
        var daysFlag = 1;
        if ($("#h_reason").val() == "" || $("#h_reason").val() == "0" || $("#h_reason").val() == undefined) {
            swal({
                title: "请填写事由",
                type: "info"
            });
            //alert("请填写事由");
            return;
        }
        if ($("#h_peopleNumber").val() == "" || $("#h_peopleNumber").val() == "0" || $("#h_peopleNumber").val() == undefined) {
            swal({
                title: "请填写住宿人数",
                type: "info"
            });
            //alert("请填写入住人数");
            return;
        }
        if (!reg.test($("#h_peopleNumber").val())) {
            swal({
                title: "入住人数请填写整数",
                type: "info"
            });
            //alert("入住人数请填写整数");
            return;
        }
        if ($("#h_checkInTime").val() == "" || $("#h_checkInTime").val() == "0" || $("#h_checkInTime").val() == undefined) {
            swal({
                title: "请填写精确的入住时间",
                type: "info"
            });
            //alert("请填写精确的入住时间");
            daysFlag = 0;
            return;
        }
        if ($("#h_checkOutTime").val() == "" || $("#h_checkOutTime").val() == "0" || $("#h_checkOutTime").val() == undefined) {
            swal({
                title: "请填写精确的离店时间",
                type: "info"
            });
            //alert("请填写精确的离店时间");
            daysFlag = 0;
            return;
        }
        if ($("#h_price").val() == "" || $("#h_price").val() == undefined) {
            swal({
                title: "请填写住宿标准",
                type: "info"
            });
            //alert("请填写住宿标准");
            return;
        }
        if (!reg.test($("#h_price").val())) {
            swal({
                title: "住宿标准请填写数字",
                type: "info"
            });
            //alert("住宿标准请填写数字");
            return;
        }
        if ($("#h_stayDays").val() == "" || $("#h_stayDays").val() == "0" || $("#h_stayDays").val() == undefined) {
            swal({
                title: "总分数只能为数字",
                type: "info"
            });
            //alert("住宿天数不能为空");
            return;
        }
        var checkInTime = $("#h_checkInTime").val();
        var checkOutTime = $("#h_checkOutTime").val();
        if (checkInTime > checkOutTime) {
            swal({
                title: "开始时间必须早于结束时间",
                type: "info"
            });
            //alert("开始时间必须早于结束时间");
            return;
        }
        checkInTime = checkInTime.replace('T', '');
        checkOutTime = checkOutTime.replace('T', '');
        $.post("<%=request.getContextPath()%>/hotelStay/saveHotelStay", {
            id: $("#h_Id").val(),
            requestDept: $("#h_requestDept").val(),
            requester: $("#h_requester").val(),
            requestDate: date,
            reason: $("#h_reason").val(),
            peopleNumber: $("#h_peopleNumber").val(),
            checkInTime: checkInTime,
            checkOutTime: checkOutTime,
            price: $("#h_price").val(),
            stayDays: $("#h_stayDays").val(),
            totalAmount: $("#h_totalAmount").val(),
            remark: $("#h_remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#hotelStayGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }
</script>
