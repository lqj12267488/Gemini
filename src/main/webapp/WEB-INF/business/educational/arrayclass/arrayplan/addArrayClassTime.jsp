<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
            <span style="font-size: 14px">${head}</span>
            <input id="id" hidden value="${arrayClassTime.id}">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        学时名称
                    </div>
                    <div class="col-md-9">
                        <input id="a_hourName" value="${arrayClassTime.hoursName}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="a_startTime" type="time" value="${arrayClassTime.startTime}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="a_endTime" type="time" value="${arrayClassTime.endTime}">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    function save() {
        if ($("#a_hourName").val() == "" || $("#a_hourName").val() == "0" || $("#a_hourName").val() == undefined) {
            swal({
                title: "请填写学时名称！",
                type: "info"
            });
            return;
        }
        if ($("#a_startTime").val() == "" || $("#a_startTime").val() == "0" || $("#a_startTime").val() == undefined) {
            swal({
                title: "请填写开始时间！",
                type: "info"
            });
            return;
        }
        if ($("#a_endTime").val() == "" || $("#a_endTime").val() == "0" || $("#a_endTime").val() == undefined) {
            swal({
                title: "请填写结束时间！",
                type: "info"
            });
            return;
        }
        if ($("#a_startTime").val() >= $("#a_endTime").val()){
            swal({
                title: "开始时间应早于结束时间！",
                type: "info"
            });
            return;
        }
        showSaveLoading();

        $.post("<%=request.getContextPath()%>/arrayClass/saveArrayClassTime", {
            id: $("#id").val(),
            arrayClassId :'${arrayClassId}',
            hoursName: $("#a_hourName").val(),
            startTime: $("#a_startTime").val(),
            hoursCode: '${arrayClassTime.hoursCode}',
            endTime:$("#a_endTime").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#arrayClassTimeGrid').DataTable().ajax.reload();
            }else if(msg.status == 3){
                swal({title: msg.msg, type: "info"});
            }else{
                swal({title: msg.msg, type: "info"});
            }
        })
    }

</script>


