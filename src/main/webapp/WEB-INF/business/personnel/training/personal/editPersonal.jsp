<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
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
<div class="modal-dialog" style="width: 1000px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="id" name="id" type="hidden" value="${personalTraining.id}">
            <input id="now" name="now" type="hidden" value="${now}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >

                <div class="form-row">
                    <div class="col-md-2 tar">
                        申请部门
                    </div>
                    <div class="col-md-4">
                        <input id="requestDept" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${personalTraining.requestDept}"/>
                    </div>
                    <div class="col-md-2 tar">
                        经办人
                    </div>
                    <div class="col-md-4">
                        <input id="requester" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${personalTraining.requester}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  申请日期
                    </div>
                    <div class="col-md-4">
                        <input id="requestDate" value="${personalTraining.requestDate}" type="date" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 培训类别
                    </div>
                    <div class="col-md-4">
                        <select  id="trainingType" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>培训日期
                    </div>
                    <div class="col-md-4">
                        <input id="trainingDate" type="date" onchange="checkStart()"
                               value="${personalTraining.trainingDate}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 培训周期(天)
                    </div>
                    <div class="col-md-4">
                        <input id="trainingDays" value="${personalTraining.trainingDays}" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>培训地点
                    </div>
                    <div class="col-md-4">
                        <input id="trainingPlace"  onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"value="${personalTraining.trainingPlace}" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 主办方
                    </div>
                    <div class="col-md-4">
                        <input id="trainingOrganizers" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${personalTraining.trainingOrganizers}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 项目
                    </div>
                    <div class="col-md-4">
                        <input id="trainingProject"  onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${personalTraining.trainingProject}" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 培训项目名称
                    </div>
                    <div class="col-md-4">
                        <input id="trainingProjectName"  onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${personalTraining.trainingProjectName}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>培训人数
                    </div>
                    <div class="col-md-4">
                        <input id="trainingPeopleNumber" value="${personalTraining.trainingPeopleNumber}" readonly/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 费用(元/人)
                    </div>
                    <div class="col-md-4">
                        <input id="trainingFee" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${personalTraining.trainingFee}" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>培训目的
                    </div>
                    <div class="col-md-10">
                        <input id="trainingPurpose" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${personalTraining.trainingPurpose}" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" id="saveBtn" onclick="saveTraining()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PXLB", function (data) {
            addOption(data, 'trainingType','${personalTraining.trainingType}');
        });
    })

    function checkStart() {
        var now = $("#now").val();
        var nowTime=new Date($("#now").val()).getTime();
        var startTime =new Date($("#trainingDate").val()).getTime();
        if(startTime<nowTime){
            swal({
                title: "培训开始时间应在"+now+"之后",
                type: "info"
            });
            //alert("培训开始时间应在"+now+"之后");
            return;
        }
    }

    function saveTraining() {
        var trainingType = $("#trainingType option:selected").val()
        var trainingDate = $("#trainingDate").val();
        var trainingPlace = $("#trainingPlace").val();
        var trainingDays = $("#trainingDays").val();
        var trainingOrganizers = $("#trainingOrganizers").val();
        var trainingProject = $("#trainingProject").val();
        var trainingProjectName = $("#trainingProjectName").val();
        var trainingPurpose = $("#trainingPurpose").val();
        var trainingFee = $("#trainingFee").val();
        var now = $("#now").val();
        var nowTime=new Date($("#now").val()).getTime();
        var startTime =new Date($("#trainingDate").val()).getTime();
        var trainingPeopleNumber = $("#trainingPeopleNumber").val();
        var reg = new RegExp("^[0-9]*$");
        var reg1 = /^[0-9]+.?[0-9]*$/;
        if($("#requestDate").val() ==""  || $("#requestDate").val() == undefined){
            swal({
                title: "请选择申请日期",
                type: "info"
            });
            //alert("请选择申请日期");
            return;
        }
        if($("#trainingType").val() =="" || $("#trainingType").val() == undefined){
            swal({
                title: "请选择培训类别",
                type: "info"
            });
            //alert("请选择培训类别");
            return;
        }
        if(trainingDate ==""  || trainingDate == undefined){
            swal({
                title: "请选择培训日期",
                type: "info"
            });
            //alert("请选择培训日期");
            return;
        }else{
            if(startTime<nowTime){
                swal({
                    title: "培训日期应在"+now+"之后",
                    type: "info"
                });
                //alert("培训日期应在"+now+"之后");
                return;
            }
        }

        if(trainingDays ==""  || trainingDays == undefined){
            swal({
                title: "请填写培训周期",
                type: "info"
            });
            //alert("请填写培训周期");
            return;
        }else{
            if (!reg.test(trainingDays)) {
                swal({
                    title: "培训周期请填写整数",
                    type: "info"
                });
                //alert("培训周期请填写整数");
                return;
            }
        }
        if(trainingPlace ==""  || trainingPlace == undefined){
            swal({
                title: "请填写培训地点",
                type: "info"
            });
            //alert("请填写培训地点");
            return;
        }
        if(trainingOrganizers ==""  || trainingOrganizers== undefined){
            swal({
                title: "请填写主办方",
                type: "info"
            });
            //alert("请填写主办方");
            return;
        }
        if(trainingProject==""  || trainingProject == undefined){
            swal({
                title: "请填写项目",
                type: "info"
            });
            //alert("请填写项目");
            return;
        }
        if(trainingProjectName ==""  || trainingProjectName == undefined){
            swal({
                title: "请填写项目名称",
                type: "info"
            });
            //alert("请填写项目名称");
            return;
        }

        if(trainingPeopleNumber=="" || trainingPeopleNumber == undefined){
            swal({
                title: "请填写培训人数",
                type: "info"
            });
            //alert("请填写培训人数");
            return;
        }else{
            if (!reg.test(trainingPeopleNumber)) {
                swal({
                    title: "培训人数请填写整数",
                    type: "info"
                });
                //alert("培训人数请填写整数");
                return;
            }
        }
        if(trainingFee ==""  || trainingFee== undefined){
            swal({
                title: "请填写培训费用",
                type: "info"
            });
            //alert("请填写培训费用");
            return;
        }else{
            if (!reg1.test(trainingFee)) {
                swal({
                    title: "培训费用请填写数字",
                    type: "info"
                });
                //alert("培训费用请填写数字");
                return;
            }
        }
        if(trainingPurpose==""  || trainingPurpose == undefined){
            swal({
                title: "请填写培训目的",
                type: "info"
            });
            //alert("请填写培训目的");
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/training/personal/saveTraining", {
            id: $("#id").val(),
            requestDate:$("#requestDate").val(),
            trainingType: trainingType,
            trainingDays:$("#trainingDays").val(),
            trainingDate: trainingDate,
            trainingPlace: trainingPlace,
            trainingOrganizers: trainingOrganizers,
            trainingProject: trainingProject,
            trainingProjectName: trainingProjectName,
            trainingPurpose: trainingPurpose,
            trainingFee: trainingFee,
            trainingPeopleNumber: trainingPeopleNumber
        }, function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
            //alert(msg.msg);
            $("#dialog").modal('hide');
            $('#personalTrainingGrid').DataTable().ajax.reload();

        })
    }

</script>

