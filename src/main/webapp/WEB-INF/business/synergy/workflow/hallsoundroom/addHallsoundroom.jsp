<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
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
            </div>
            <div class="modal-body clearfix"> 
            
                    <div class="controls" >

                        <div class="form-row">
                            <div class="col-md-3 tar">
                                会议内容
                            </div>
                            <div class="col-md-9">
                                <input id="meetingcontent" type="text"
                                       class="validate[required,maxSize[100]] form-control"
                                       value="${hallsoundroom.meetingcontent}"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-3 tar">
                                使用开始时间
                            </div>
                            <div class="col-md-9">
                                <input id="starttime" type="datetime-local"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-3 tar">
                                使用结束时间
                            </div>
                            <div class="col-md-9">
                                <input id="endtime" type="datetime-local"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-3 tar">
                                使用设备
                            </div>
                            <div class="col-md-9">
                                <input id="usedevice" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-3 tar">
                                申请人
                            </div>
                            <div class="col-md-9">
                                <input id="requester" type="text"
                                       class="validate[required,maxSize[20]] form-control"
                                       value="${hallsoundroom.requester}" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-3 tar">
                                申请部门
                            </div>
                            <div class="col-md-9">
                                <input id="requestdept" type="text"
                                       class="validate[required,maxSize[20]] form-control"
                                       value="${hallsoundroom.requestdept}" readonly="readonly" />
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-3 tar">
                                申请日期
                            </div>
                            <div class="col-md-9">
                                <input id="requestdate" type="datetime-local"
                                       class="validate[required,maxSize[20]] form-control"
                                       value="${hallsoundroom.requestdate}" readonly/>
                            </div>
                        </div>
                        
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
                <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
            </div>
    </div>
</div>
<script>
    function saveDept() {
        if( $("#requestdept").val() =="" ||  $("#requestdept").val() =="0" || $("#requestdept").val() == undefined){
            alert("请填写申请部门");
            return;
        }
        if($("#meetingcontent").val()=="" ||  $("#meetingcontent").val() =="0" || $("#meetingcontent").val() == undefined){
            alert("请填写会议内容");
            return;
        }
        if($("#starttime").val()=="" ||  $("#starttime").val() =="0" || $("#starttime").val() == undefined){
            alert("请选择精确的开始时间");
            return;
        }
        if($("#endtime").val()=="" ||  $("#endtime").val() =="0" || $("#endtime").val() == undefined){
            alert("请选择精确的结束时间");
            return;
        }
        if($("#usedevice").val()=="" ||  $("#usedevice").val() =="0" || $("#usedevice").val() == undefined){
            alert("请选择设备");
            return;
        }
        if($("#requester").val()=="" ||  $("#requester").val() =="0" || $("#requester").val() == undefined){
            alert("请填写申请人");
            return;
        }
        if($("#requestdate").val()=="" ||  $("#requestdate").val() =="0" || $("#requestdate").val() == undefined){
            alert("请选择申请日期");
            return;
        }
        var v_starttime = new Date($("#starttime").val().replace('T',' ')).getTime();
        var v_endtime = new Date($("#endtime").val().replace('T',' ')).getTime();
        var v_requestdate = new Date($("#requestdate").val().replace('T',' ')).getTime();
        if(v_starttime>v_endtime){
           alert("开始时间必须早于结束时间");
           return;
        }
        if(v_requestdate>v_requestdate){
            alert("申请时间必须早于开始时间");
            return;
        }
        var c_requestdate = $("#requestdate").val().replace('T',' ');
        var c_starttime = $("#starttime").val().replace('T',' ');
        var c_endtime = $("#endtime").val().replace('T',' ');
        $.post("/hallsoundroom/saveHallsoundroom", {
            requestdept: $("#requestdept").val(),
            meetingcontent: $("#meetingcontent").val(),
            starttime: c_starttime,
            endtime: c_endtime,
            usedevice: $("#usedevice").val(),
            requestdate: c_requestdate
        }, function (msg) {
            if (msg.status == 1 ) {
                alert(msg.msg);
                $("#dialog").modal('hide');
                $('#hallsoundroomGrid').DataTable().ajax.reload();
            }
        })
    }

</script>