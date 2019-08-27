<%--学校商友酒店住宿管理待办修改页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/6/22
  Time: 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
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

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        住宿人数
    </div>
    <div class="col-md-9">
        <input id="h_peopleNumber" type="text" placeholder="请输入数字"
               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               class="validate[required,maxSize[100]] form-control"
               value="${hotelStay.peopleNumber}" onblur="totalAmount()"/>
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
        住宿标准（元/天）
    </div>
    <div class="col-md-9">
        <input id="h_price" type="text" placeholder="请输入数字"
               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               class="validate[required,maxSize[100]] form-control"
               value="${hotelStay.price}" onclick="computeDays()" onblur="totalAmount()"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        住宿天数
    </div>
    <div class="col-md-9">
        <input id="h_stayDays" type="text"
               class="validate[required,maxSize[20]] form-control" onclick="computeDays()"
               value="${hotelStay.stayDays}" readonly="readonly"/>
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
                                  onclick="totalAmount()">${hotelStay.totalAmount}</textarea>
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
<input id="h_Id" hidden value="${hotelStay.id}"/>
<input id="workflowCode" hidden value="T_BG_HOTELSTAY_WF01">
<script>
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
    /**功能：校验住宿人数，住宿天数，住宿标准是否为数字，并计算出总金额
     * create by wq
     * @return mv界面
     */
    function totalAmount(){
        var reg = new RegExp("^[0-9]*$");
        if ($("#h_peopleNumber").val() == "" || $("#h_peopleNumber").val() == "0" || $("#h_peopleNumber").val() == undefined) {
            swal({
                title: "请填写入住人数",
                type: "info"
            });
            //alert("请填写入住人数");
            return;
        }
        if(!reg.test($("#h_peopleNumber").val())){
            swal({
                title: "入住人数请填写整数",
                type: "info"
            });
            //alert("入住人数请填写整数");
            return;
        }
        if ($("#h_price").val() == "" || $("#h_price").val() == "0" || $("#h_price").val() == undefined) {
            swal({
                title: "请填写住宿标准",
                type: "info"
            });
            //alert("请填写住宿标准");
            return;
        }
        if(!reg.test($("#h_price").val())){
            swal({
                title: "住宿标准请填写数字",
                type: "info"
            });
            //alert("住宿标准请填写数字");
            return;
        }
        if ($("#h_stayDays").val() == "" || $("#h_stayDays").val() == "0" || $("#h_stayDays").val() == undefined) {
            swal({
                title: "请单击【住宿天数】输入框计算住宿天数",
                type: "info"
            });
            //alert("请单击【住宿天数】输入框计算住宿天数");
            return;
        }
        var peopleNumber=$("#h_peopleNumber").val();
        var price=$("#h_price").val();
        var stayDays=$("#h_stayDays").val();
        var totalAmount=document.getElementById("h_totalAmount");
        totalAmount.value=price*stayDays*peopleNumber;
    }
    /**功能：校验入住时间和离店时间是否为精确时间，并计算出住宿天数
     * create by wq
     * @return mv界面
     */
    function computeDays(){
        if ($("#h_checkInTime").val() == "" || $("#h_checkInTime").val() == "0" || $("#h_checkInTime").val() == undefined) {
            swal({
                title: "请填写精确的入住时间",
                type: "info"
            });
            //alert("请填写精确的入住时间");
            return;
        }
        if ($("#h_checkOutTime").val() == "" || $("#h_checkOutTime").val() == "0" || $("#h_checkOutTime").val() == undefined) {
            swal({
                title: "请填写精确的离店时间",
                type: "info"
            });
            //alert("请填写精确的离店时间");
            return;
        }
        var checkInTime = $("#h_checkInTime").val();
        var checkOutTime =$("#h_checkOutTime").val();
        if(checkInTime>checkOutTime){
            swal({
                title: "开始时间必须早于结束时间",
                type: "info"
            });
            //alert("开始时间必须早于结束时间");
            return;
        }
        checkInTime = new Date(checkInTime.replace('T', ' ')).getTime();
        checkOutTime = new Date(checkOutTime.replace('T', ' ')).getTime();
        var days=checkOutTime-checkInTime;
        days=parseInt(days/(1000*60*60*24)+1);
        document.getElementById("h_stayDays").value=days;
    }
    /**功能：修改的申请信保存
     * create by wq
     * @return mv界面
     */
    function save(){
        var date = $("#h_requestDate").val();
        date = date.replace('T', '');
        var reg = /^[0-9]+.?[0-9]*$/;
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
                title: "请填写入住人数",
                type: "info"
            });
            //alert("请填写入住人数");
            return;
        }
        if(!reg.test($("#h_peopleNumber").val())){
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
            return;
        }
        if ($("#h_checkOutTime").val() == "" || $("#h_checkOutTime").val() == "0" || $("#h_checkOutTime").val() == undefined) {
            swal({
                title: "请填写精确的离店时间",
                type: "info"
            });
            //alert("请填写精确的离店时间");
            return;
        }
        if ($("#h_price").val() == "" || $("#h_price").val() == "0" || $("#h_price").val() == undefined) {
            swal({
                title: "请填写住宿标准",
                type: "info"
            });
            //alert("请填写住宿标准");
            return;
        }
        if(!reg.test($("#h_price").val())){
            swal({
                title: "住宿标准请填写数字",
                type: "info"
            });
            //alert("住宿标准请填写数字");
            return;
        }
        if ($("#h_stayDays").val() == "" || $("#h_stayDays").val() == "0" || $("#h_stayDays").val() == undefined) {
            swal({
                title: "请填写住宿天数",
                type: "info"
            });
            //alert("请填写住宿天数");
            return;
        }
        if(!reg.test($("#h_stayDays").val())){
            swal({
                title: "住宿天数请填写数字",
                type: "info"
            });
            //alert("住宿天数请填写数字");
            return;
        }
        if ($("#h_totalAmount").val() == "" || $("#h_totalAmount").val() == "0" || $("#h_totalAmount").val() == undefined) {
            swal({
                title: "请填写合计金额",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#h_totalAmount").val())){
            swal({
                title: "合计金额请填写数字",
                type: "info"
            });
            //alert("合计金额请填写数字");
            return;
        }
        var checkInTime = $("#h_checkInTime").val();
        var checkOutTime =$("#h_checkOutTime").val();
        if(checkInTime>checkOutTime){
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
            id:$("#h_Id").val(),
            requestDept: $("#h_requestDept").val(),
            requester: $("#h_requester").val(),
            requestDate:date,
            reason: $("#h_reason").val(),
            peopleNumber: $("#h_peopleNumber").val(),
            checkInTime:checkInTime,
            checkOutTime:checkOutTime,
            price:$("#h_price").val(),
            stayDays:$("#h_stayDays").val(),
            totalAmount:$("#h_totalAmount").val(),
            remark:$("#h_remark").val()
        }, function (msg) {
            if (msg.status == 1) {
               /* swal({
                    title: msg.msg,
                    type: "success"
                });*/
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#hotelStayGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }
</script>
