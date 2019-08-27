<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/21
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
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
            <input id="leaveCancelid" name="leaveCancelid" type="hidden" value="${leave.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="dept" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${leave.requestDept}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="jbr" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${leave.requester}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDate" type="datetime-local" class="validate[required,maxSize[100]] form-control"
                               value="${leave.requestDate}" readonly="readonly" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        请假开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_startTime" type="date" onclick="cha()" class="validate[required,maxSize[100]] form-control"
                               value="${leave.startTime}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        请假结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_endTime" type="date" onclick="cha()" onblur="shijian()" class="validate[required,maxSize[100]] form-control"
                               value="${leave.endTime}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        请假天数
                    </div>
                    <div class="col-md-9">
                        <input  id="f_requestDays" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                                value="${leave.requestDays}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        请假类型
                    </div>
                    <div class="col-md-9">
                        <input  id="f_leaveType" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                                value="${leave.leaveType}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        请假原因
                    </div>
                    <div class="col-md-9">
                            <textarea id="f_reason"  class="validate[required,maxSize[100]] form-control"
                                      value="${leave.reason}" readonly="readonly">${leave.reason} </textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请销假部门
                    </div>
                    <div class="col-md-9">
                        <input id="x_cancelRequestDept" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${leave.cancelRequestDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请销假人
                    </div>
                    <div class="col-md-9">
                        <input id="x_cancelRequester" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${leave.cancelRequester}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请销假日期
                    </div>
                    <div class="col-md-9">
                        <input id="x_cancelRequestDate" value="${leave.cancelRequestDate}" type="datetime-local" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        销假开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="x_cancelStartTime" type="date" class="validate[required,maxSize[100]] form-control"
                               value="${leave.cancelStartTime}" onchange="chaa()"  />
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        销假结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="x_cancelEndTime" type="date" class="validate[required,maxSize[100]] form-control"
                               value="${leave.cancelEndTime}"  onchange="shijian();chaa()"  />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        实际请假天数
                    </div>
                    <div class="col-md-9">
                        <input  id="x_realDays"  class="validate[required,maxSize[100]] form-control"
                                value="${leave.realDays}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        销假原因
                    </div>
                    <div class="col-md-9">
                            <textarea id="x_cancelReason"  class="validate[required,maxSize[100]] form-control"
                                      value="${leave.cancelReason}">${leave.cancelReason}</textarea>
                    </div>
                </div>
                <%--<div class="form-row">
                    <button type="button" class="btn btn-default btn-clean" onclick="upload()">上传附件</button>
                </div>--%>

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
    $("#x_cancelStartTime").change(function (){
        if($("#x_cancelStartTime").val()<$("#f_startTime").val()){
            swal({
                title: "请选择销假开始时间需要在请假开始时间之后!",
                type: "info"
            });
            $("#x_cancelEndTime").val("");
            return;
        }
        if($("#x_cancelStartTime").val()>$("#f_startTime").val()){
            swal({
                title: "请选择销假开始时间需要在请假结束时间之前!",
                type: "info"
            });
            $("#x_cancelEndTime").val("");
            return;
        }
    })
    $("#x_cancelEndTime").change(function (){
        if($("#x_cancelEndTime").val()>$("#f_EndTime").val()){
            swal({
                title: "请选择销假结束时间需要在请假结束时间之前!",
                type: "info"
            });
            $("#x_cancelEndTime").val("");
            return;
        }
    })
    function shijian() {
        if( $("#x_cancelStartTime").val() > $("#x_cancelEndTime").val()){
            swal({
                title: "请选择销假开始时间需要在销假结束时间之前!",
                type: "info"
            });
            //alert("请选择销假开始时间需要在销假结束时间之前！");
            $("#x_cancelEndTime").val("");
            return;
        }
    }
    function chaa() {
        var start = new Date(document.getElementById("x_cancelStartTime").value.substring(0,10)).getTime();
        var end = new Date(document.getElementById("x_cancelEndTime").value.substring(0,10)).getTime();
        if (end >= start) {
            var cha = (end - start) / 60 / 60 / 24 / 1000+1;
            $("#x_realDays").val(cha + 1);
        }
        var yuan = document.getElementById("f_requestDays").value;
        document.getElementById("x_realDays").value=yuan-cha;

    }
    function upload() {
        $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_RS_LEAVE_CANCEL_WF');
        $('#dialogFile').modal('show');
    }

    function save() {
        var date = $("#x_cancelRequestDate").val();
        date = date.replace('T','');
        var startTime = $("#x_cancelStartTime").val();
        startTime = startTime.replace('T','');
        var endTime = $("#x_cancelEndTime").val();
        endTime = endTime.replace('T','');
        if ($("#x_cancelRequestDate").val() == "" || $("#x_cancelRequestDate").val() == "0") {
            swal({
                title: "请填写销假申请时间",
                type: "info"
            });
            //alert("请填写销假申请时间");
            return;
        }
        if ($("#x_cancelStartTime").val() == "" || $("#x_cancelStartTime").val() == "0") {
            swal({
                title: "请填写销假开始时间",
                type: "info"
            });
            //alert("请填写销假开始时间");
            return;
        }
        if ($("#x_cancelEndTime").val() == "" || $("#x_cancelEndTime").val() == "0") {
            swal({
                title: "请填写销假结束时间",
                type: "info"
            });
            //alert("请填写销假结束时间");
            return;
        }
        if($("#f_requestDate").val() > $("#x_cancelRequestDate").val()){
            swal({
                title: "请选择请假时间要在销假时间之前",
                type: "info"
            });
            //alert("请选择请假时间要在销假时间之前");
            return;
        }
        if( $("#x_cancelStartTime").val() > $("#x_cancelEndTime").val()){
            swal({
                title: "请选择销假开始时间需要在销假结束时间之前!",
                type: "info"
            });
            //alert("请选择销假开始时间需要在销假结束时间之前！");
            return;
        }
        if( $("#x_cancelEndTime").val() > $("#f_endTime").val()){
            swal({
                title: "请选择销假结束时间需要在请假结束时间之前!",
                type: "info"
            });
            //alert("请选择销假结束时间需要在请假结束时间之前！");
            return;
        }
        if($("#x_cancelReason").val() =="" ||  $("#x_cancelReason").val() =="0" || $("#x_cancelReason").val() == undefined){
            swal({
                title: "请填写销假原因",
                type: "info"
            });
            //alert("请填写请假原因");
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/leaveCancel/saveLeaveCancel", {
            leaveId:$("#leaveCancelid").val(),
            cancelRequestDate: date,
            cancelStartTime:startTime,
            cancelEndTime:endTime,
            realDays:$("#x_realDays").val(),
            cancelReason: $("#x_cancelReason").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1 ) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#leaveCancelGrid').DataTable().ajax.reload();
            }
        })
    }

</script>


