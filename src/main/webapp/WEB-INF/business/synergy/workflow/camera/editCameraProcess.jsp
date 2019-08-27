<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/19
  Time: 11:03
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
        <input id="requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               readonly=“readonly”
               value="${camera.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="requester"
               class="validate[required,maxSize[100]] form-control"
               readonly=“readonly”
               value="${camera.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${camera.requestDate}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        拍摄时间
    </div>
    <div class="col-md-9">
        <input id="shootDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${camera.shootDate}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        拍摄地点
    </div>
    <div class="col-md-9">
        <input id="shootingLocation" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="65" placeholder="最多输入65个字"
               class="validate[required,maxSize[100]] form-control"
               value="${camera.shootingLocation}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        拍摄方法
    </div>
    <div class="col-md-9">
        <input id="shootingMethod" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="15" placeholder="最多输入15个字"
               class="validate[required,maxSize[100]] form-control"
               value="${camera.shootingMethod}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        摄影机机位数
    </div>
    <div class="col-md-9">
        <input id="machineNumber" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               placeholder="请输入数字"
               class="validate[required,maxSize[100]] form-control"
               value="${camera.machineNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        活动内容
    </div>
    <div class="col-md-9">
        <input id="content" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="165" placeholder="最多输入165个字"
               class="validate[required,maxSize[100]] form-control"
               value="${camera.content}"/>
    </div>
</div>
<input id="h_Id" hidden value="${camera.id}"/>
<input id="workflowCode" hidden value="T_BG_CAMERA_WF01">
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

    /**功能：修改的申请信保存
     * create by wq
     * @return mv界面
     */
    function save(){
        var a = $("#photographyid").val();
        var t_requestDate = $("#requestDate").val();
        var t_shootDate =$("#shootDate").val();
        t_requestDate = t_requestDate.replace('T','');
        t_shootDate = t_shootDate.replace('T','');
        var reg=/^[0-9]+.?[0-9]*$/;
        if($("#shootDate").val()=="" ||  $("#shootDate").val() =="0" || $("#shootDate").val() == undefined){
            swal({
                title: "请填写拍摄时间",
                type: "info"
            });
            //alert("请填写出拍摄时间");
            return;
        }
        if($("#shootingLocation").val()=="" ||  $("#shootingLocation").val() =="0" || $("#shootingLocation").val() == undefined){
            swal({
                title: "请填写拍摄地点",
                type: "info"
            });
            //alert("请填写出活动内容");
            return;
        }
        if($("#shootingMethod").val()=="" ||  $("#shootingMethod").val() =="0" || $("#shootingMethod").val() == undefined) {
            swal({
                title: "请填写拍摄方法",
                type: "info"
            });
            //alert("请填写出拍摄方法");
            return;
        }
        if($("#machineNumber").val()=="" ||  $("#machineNumber").val() =="0" || $("#machineNumber").val() == undefined){
            swal({
                title: "请填写摄影机机位数",
                type: "info"
            });
            //alert("请填写出摄影机机位数");
            return;
        }
        if(!reg.test($("#machineNumber").val())){
            swal({
                title: "摄影机机位数请填写数字",
                type: "info"
            });
            //alert("摄影机机位数请填写数字");
            return;
        }

        if($("#content").val()=="" ||  $("#content").val() =="0" || $("#content").val() == undefined){
            swal({
                title: "请填写活动内容",
                type: "info"
            });
            //alert("请填写出活动内容");
            return;
        }

        $.post("<%=request.getContextPath()%>/camera/saveCamera", {//post传参
            id: $("#h_Id").val(),//获取页面数据得值
            requestDept: $("#requestDept").val(),
            requester: $("#requester").val(),
            requestDate: t_requestDate,
            shootDate:t_shootDate,
            shootingMethod: $("#shootingMethod").val(),
            machineNumber: $("#machineNumber").val(),
            shootingLocation: $("#shootingLocation").val(),
            content: $("#content").val()
        }, function (msg) {
            if (msg.status == 1 ) {
                /*swal({
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


