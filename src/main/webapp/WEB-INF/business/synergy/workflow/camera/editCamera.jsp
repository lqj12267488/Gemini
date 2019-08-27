<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/19
  Time: 11:01
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
            <input id="cameraid" type="hidden" value="${camera.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
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
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    function saveDept() {
        var a = $("#cameraid").val();
        var t_requestDate = $("#requestDate").val();
        var t_shootDate =$("#shootDate").val();
        t_requestDate = t_requestDate.replace('T','');
        t_shootDate  = t_shootDate.replace('T','');
        var reg=/^[0-9]+.?[0-9]*$/;
        if($("#requestDept").val()=="" ||  $("#requestDept").val() =="0" || $("#requestDept").val() == undefined){
            swal({
                title: "请填写申请部门",
                type: "info"
            });
            //alert("请填写申请部门");
            return;
        }
        if($("#requester").val()=="" ||  $("#requester").val() =="0" || $("#requester").val() == undefined){
            swal({
                title: "请填写申请人",
                type: "info"
            });
            //alert("请填写申请人");
            return;
        }
        if($("#requestDate").val()=="" ||  $("#requestDate").val() =="0" || $("#requestDate").val() == undefined){
            swal({
                title: "请填写申请日期",
                type: "info"
            });
            //alert("请填写申请日期");
            return;
        }
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
            //alert("请填写出拍摄时间");
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
                title: "摄像机机位数请填写数字",
                type: "info"
            });
            //alert("摄像机机位数请填写数字");
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
            id: $("#cameraid").val(),//获取页面数据得值
            requestDept: $("#requestDept").val(),
            requester: $("#requester").val(),
            requestDate: t_requestDate,
            shootDate:t_shootDate,
            shootingMethod: $("#shootingMethod").val(),
            machineNumber: $("#machineNumber").val(),
            shootingLocation: $("#shootingLocation").val(),
            content: $("#content").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1 ) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#zzTable').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }
</script>
