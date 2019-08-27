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
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="hostId"  type="hidden" value="${teachingEvent.hostId}">
            <input id="hostDept"  type="hidden" value="${teachingEvent.hostDept}">
            <input id="departmentsIdSHOW" hidden value="${teachingEvent.departmentsId}">
            <input id="hostIdShow" hidden value="${teachingEvent.hostIdShow}">
            <input id="teachingEventId" name="teachingEventId" type="hidden" value="${teachingEvent.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 系部
                    </div>
                    <div class="col-md-9">
                        <select  id="departmentid" class="js-example-basic-single" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  活动名称
                    </div>
                    <div class="col-md-9">
                        <input id="eventname" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${teachingEvent.eventName}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="30" placeholder="最多输入30个字"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 主持人
                    </div>
                    <div class="col-md-9">
                        <input id="zchid" placeholder="请输入主持人姓名" value="${teachingEvent.hostIdShow}" type="text"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="startTime" value="${teachingEvent.startTime}" type="date" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="endTime" value="${teachingEvent.endTime}" type="date" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 活动内容
                    </div>
                    <div class="col-md-9">
                        <textarea id="eventContent" class="validate[required,maxSize[100]] form-control" maxlength="50" placeholder="最多输入50个字符">${teachingEvent.eventContent}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 活动效果
                    </div>
                    <div class="col-md-9">
                        <textarea id="eventEffect" class="validate[required,maxSize[100]] form-control" maxlength="50" placeholder="最多输入50个字符">${teachingEvent.eventEffect}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn"	 class="btn btn-success btn-clean" onclick="saveTeachingEvent()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>


<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " order by dept_id "
            },
            function (data) {
                addOption(data, "departmentid", $("#departmentsIdSHOW").val());
            })

        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#zchid").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#zchid").val(ui.item.label);
                    $("#zchid").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };

        })
    })



    function saveTeachingEvent() {
        var teachingEventId=$("#teachingEventId").val();
        var startTime =new Date($("#startTime").val().replace('T',' ')).getTime();
        var endTime= new Date($("#endTime").val().replace('T',' ')).getTime();
        var  deptAndEmp=$("#zchid").attr("keycode");
        var  deptid="";
        var  empid="";
         if(deptAndEmp =="" || deptAndEmp == undefined){
              empid=$("#hostId").val();
              deptid=$("#hostDept").val();
         }else{
             deptid=deptAndEmp.substring(0,6);
             empid=deptAndEmp.substring(7,deptAndEmp.length);
         }

        if ($("#departmentid option:selected").val() == "") {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if($("#eventname").val() =="" || $("#eventname").val() =="0" || $("#eventname").val() == undefined){
            swal({
                title: "请填写活动名称！",
                type: "info"
            });
            return;
        }
        if ($("#zchid").val() == "") {
            swal({
                title: "请输入主持人姓名！",
                type: "info"
            });
            return;
        }
        if(startTime>endTime){
            swal({
                title: "开始日期不能晚于结束日期！",
                type: "info"
            });
            return;
        }
        if($("#eventContent").val() =="" ||   $("#eventContent").val() == undefined){
            swal({
                title: "请填写活动内容！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/educational/teachingEvent/saveTeachingEvent", {
            id: $("#teachingEventId").val(),
            departmentsId: $("#departmentid option:selected").val(),
            eventName: $("#eventname").val(),
            hostDept: deptid,
            hostId: empid,
            startTime: $("#startTime").val(),
            endTime: $("#endTime").val(),
            eventContent: $("#eventContent").val(),
            eventEffect: $("#eventEffect").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1 ) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#eventTable').DataTable().ajax.reload();
            }
        })
    }

</script>

