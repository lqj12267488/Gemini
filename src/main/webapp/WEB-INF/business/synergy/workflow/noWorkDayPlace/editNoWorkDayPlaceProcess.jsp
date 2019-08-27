<%--非工作日学校场所使用管理待办修改页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/19
  Time: 19:11
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
        <input id="n_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${noWorkDayPlace.requestDept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="n_requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${noWorkDayPlace.requester}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请时间
    </div>
    <div class="col-md-9">
        <input id="n_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${noWorkDayPlace.requestDate}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        开始时间
    </div>
    <div class="col-md-9">
        <input id="n_startTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${noWorkDayPlace.startTime}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        结束时间
    </div>
    <div class="col-md-9">
        <input id="n_endTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${noWorkDayPlace.endTime}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        活动内容
    </div>
    <div class="col-md-9">
                        <textarea id="n_content" maxlength="165" placeholder="最多输入165个字"
                                  class="validate[required,maxSize[100]] form-control">${noWorkDayPlace.content}</textarea>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        参与人数
    </div>
    <div class="col-md-9">
        <input id="n_peopleNumber" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               class="validate[required,maxSize[10]] form-control" placeholder="请输入数字"
               class="validate[required,maxSize[10]] form-control"
               value="${noWorkDayPlace.peopleNumber}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        使用场所
    </div>
    <div class="col-md-9">
        <select  id="n_usePlace" />
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        使用性质
    </div>
    <div class="col-md-9">
        <select  id="n_useProperty" />
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="n_remark" maxlength="165" placeholder="最多输入165个字"
                                  class="validate[required,maxSize[100]] form-control">${noWorkDayPlace.remark}</textarea>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        使用规范
    </div>
    <div class="col-md-9">
                        <textarea id="n_standard" style="height: 200px"
                                  class="validate[required,maxSize[100]] form-control"
                                  readonly="readonly">${standard.standardContent}</textarea>
    </div>
</div>
<input id="n_Id" hidden value="${noWorkDayPlace.id}"/>
<input id="workflowCode" hidden value="T_BG_NOWORKDAYPLACE_WF01">

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SYCS", function (data) {
            addOption(data, 'n_usePlace','${noWorkDayPlace.usePlace}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SYXZ", function (data) {
            addOption(data, 'n_useProperty','${noWorkDayPlace.useProperty}');
        });
    })
    /**功能：修改的申请信息保存
     * create by wq
     * @return mv界面
     */
    function save(){
        var date = $("#n_requestDate").val();
        date = date.replace('T', '');
        var reg = new RegExp("^[0-9]*$");
        if ($("#n_startTime").val() == "" || $("#n_startTime").val() == "0" || $("#n_startTime").val() == undefined) {
             swal({
                title: "请填写精确的开始时间!",
                type: "info"
            });
            return;
        }
        if ($("#n_endTime").val() == "" || $("#n_endTime").val() == "0" || $("#n_endTime").val() == undefined) {
            swal({
                title: "请填写精确的结束时间!",
                type: "info"
            });
            return;
        }
        if ($("#n_content").val() == "" || $("#n_content").val() == "0" || $("#n_content").val() == undefined) {
            swal({
                title: "请填写活动内容!",
                type: "info"
            });
            return;
        }
        if ($("#n_peopleNumber").val() == "" || $("#n_peopleNumber").val() == "0" || $("#n_peopleNumber").val() == undefined) {
            swal({
                title: "请填写参与人数!",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#n_peopleNumber").val())){
            swal({
                title: "参与人数请填写数字!",
                type: "info"
            });
            return;
        }
        if($("#n_usePlace").val()=="" ||  $("#n_usePlace").val() =="0" || $("#n_usePlace").val() == undefined){
            swal({
                title: "请选择使用场所!",
                type: "info"
            });
            return;
        }
        if($("#n_useProperty").val()=="" ||  $("#n_useProperty").val() =="0" || $("#n_useProperty").val() == undefined){
            swal({
                title: "请选择使用性质!",
                type: "info"
            });
            return;
        }
        var startTime = $("#n_startTime").val();
        var endTime =$("#n_endTime").val();
        if(startTime>endTime){
            swal({
                title: "开始时间必须早于结束时间!",
                type: "info"
            });
            return;
        }
        startTime = startTime.replace('T','');
        endTime = endTime.replace('T','');
        $.post("<%=request.getContextPath()%>/noWorkDayPlace/saveNoWorkDayPlace", {
            id:$("#n_Id").val(),
            requestDept: $("#n_requestDept").val(),
            requester: $("#n_requester").val(),
            requestDate:date,
            startTime:startTime,
            endTime:endTime,
            content: $("#n_content").val(),
            peopleNumber: $("#n_peopleNumber").val(),
            usePlace:$("#n_usePlace").val(),
            useProperty:$("#n_useProperty").val(),
            remark:$("#n_remark").val()
        }, function (msg) {
//          保存后刷新页面数据表
            if (msg.status == 1) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                $("#dialog").modal('hide');
                $('#noWorkDayPlaceGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }
</script>
