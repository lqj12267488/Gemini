<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/20
  Time: 8:43
  To change this template use File | Settings | File Templates.
--%>
<%--代办 修改页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input type="hidden" id="shopItemsReceiveid" value="${shopItemsReceive.id}">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDept" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${shopItemsReceive.requestDept}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="f_requester" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${shopItemsReceive.requester}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDate" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${shopItemsReceive.requestDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        标准(元/人)
                    </div>
                    <div class="col-md-9">
                        <input id="standard" type="text" onblur="product()" placeholder="请输入数字"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[20]] form-control"
                               value="${shopItemsReceive.standard}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        人数
                    </div>
                    <div class="col-md-9">
                        <input id="peopleNumber" type="text" onblur="product()" placeholder="请输入数字"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${shopItemsReceive.peopleNumber}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        总金额
                    </div>
                    <div class="col-md-9">
                        <input id="totalAmount"   type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${shopItemsReceive.totalAmount}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        用途
                    </div>
                    <div class="col-md-9">
                        <input id="use" type="text" placeholder="最多输入165个字"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[100]] form-control"
                               value="${shopItemsReceive.use}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark" type="text" placeholder="最多输入330个字"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[100]] form-control"
                               value="${shopItemsReceive.remark}" />
                    </div>
                </div>
<input id="workflowCode" hidden value="T_BG_SHOPITEMSRECEIVE_WF01">

<script>
    function product(){
        var a=document.getElementById("standard").value;
        var b=document.getElementById("peopleNumber").value;
        document.getElementById("totalAmount").value=a*b;
    }
    function save() {
        var reg = new RegExp("^[0-9]*$");
        var reg1 = /^[0-9]+.?[0-9]*$/;
        if ($("#f_requestDept").val() == "" || $("#f_requestDept").val() == "0" || $("#f_requestDept").val() == undefined) {
            swal({
                title: "请填写申请部门",
                type: "info"
            });
            //alert("请填写申请部门");
            return;
        }
        if ($("#f_requester").val() == "" || $("#f_requester").val() == "0" || $("#f_requester").val() == undefined) {
            swal({
                title: "请填写申请人",
                type: "info"
            });
            //alert("请填写申请人");
            return;
        }
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0") {
            swal({
                title: "请填写申请日期",
                type: "info"
            });
            //alert("请填写申请日期");
            return;
        }
        if(!reg1.test($("#standard").val())){
            swal({
                title: "标准(元/人)请输入数字",
                type: "info"
            });
            //alert("标准(元/人)请输入数字");
            return;
        }
        if(!reg.test($("#peopleNumber").val())){
            swal({
                title: "人数请填写整数",
                type: "info"
            });
            //alert("人数请填写整数");
            return;
        }
        if ($("#use").val() == "" || $("#use").val() == "0" || $("#use").val() == undefined) {
            swal({
                title: "请填写用途",
                type: "info"
            });
            //alert("请填写用途");
            return;
        }
        var c_requestDate = $("#f_requestDate").val().replace('T',' ');
        $.post("<%=request.getContextPath()%>/shopItemsReceive/saveShopItemsReceive", {
            id: $("#shopItemsReceiveid").val(),
            requestDept: $("#f_requestDept").val(),
            requester: $("#f_requester").val(),
            requestDate: c_requestDate,
            standard: $("#standard").val(),
            peopleNumber: $("#peopleNumber").val(),
            totalAmount:$("#totalAmount").val(),
            use: $("#use").val(),
            remark: $("#remark").val()
        }, function (msg) {
            if (msg.status == 1) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#shopItemsReceiveGrid').DataTable().ajax.reload();

            }
        })
        return true;
    }

</script>


