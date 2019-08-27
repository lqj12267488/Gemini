<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">

    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="studentOrderId" name="studentOrderId" hidden value="${studentPlanJob.studentOrderId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 学生名称
                    </div>
                    <div class="col-md-9">
                        <select id="studentId" value="${exam.examName}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="30" placeholder="最多输入30个字"/>
                    </div>
                </div>
                <div id="deptPproperty"  class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  楼宇名称
                    </div>
                    <div class="col-md-9">
                        <select id="buildingId" value="${exam.termShow}"/>
                    </div>
                </div>
                <div  id="majorPproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="officeStartTime" value="${studentPlanJob.officeStartTime}" type="datetime-local" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div id="coursePproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="officeEndTime" value="${studentPlanJob.officeEndTime}" type="datetime-local" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " building_name ",
                tableName: "T_JW_BUILDING",
                where: " WHERE building_type ='6'",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "buildingId",'${studentPlanJob.buildingId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " student_id",
                text: " student_name ",
                tableName: "T_ZW_STUDENTDORM t",
                where: " WHERE t.valid_flag = '1'",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "studentId",'${studentPlanJob.studentId}');
            });
    });

    function save() {
        var studentId = $("#studentId").val();
        var buildingId = $("#buildingId").val();
        var officeStartTime = $("#officeStartTime").val();

        var officeEndTime = $("#officeEndTime").val();

/*        var nowTime=new Date($("#now").val()).getTime();
        var startTime =new Date($("#startTime").val().replace('T',' ')).getTime();
        var endTime= new Date($("#endTime").val().replace('T',' ')).getTime();*/
        if (studentId == "" || studentId == undefined || studentId == null) {
            swal({
                title: "请选择学生！",
                type: "info"
            });
            return;
        }
        if (buildingId == "" || buildingId == undefined || buildingId == null) {
            swal({
                title: "请选择楼宇！",
                type: "info"
            });
            return;
        }
        if(officeStartTime=="" || officeStartTime == undefined || officeStartTime == null){
            swal({
                title: "请选择开始时间！",
                type: "info"
            });
            return;
        }
        if(officeEndTime=="" || officeEndTime == undefined || officeEndTime == null){
            swal({
                title: "请选择结束时间！",
                type: "info"
            });
            return;
        }
        if(officeStartTime>officeEndTime){
            swal({
                title: "开始日期不能晚于结束日期！",
                type: "info"
            });
            return;
        }


        var officeStartTime1=  officeStartTime.replace("T"," ");
        var officeEndTime1=  officeEndTime.replace("T"," ");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/dormmanage/studentPlanJob/save", {
            studentOrderId:$("#studentOrderId").val(),
            studentId: $("#studentId").val(),
            buildingId:$("#buildingId").val(),
            officeStartTime:officeStartTime1,
            officeEndTime:officeEndTime1
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#examTable').DataTable().ajax.reload();
        })
    }
</script>


