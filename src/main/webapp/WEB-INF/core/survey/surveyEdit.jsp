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
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="surveyId" hidden value="${data.surveyId}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">

                <div class="form-row">
                    <div class="col-md-3 tar">
                        年份
                    </div>
                    <div class="col-md-9">
                        <select id="f_years"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        主题
                    </div>
                    <div class="col-md-9">
                        <input id="surveyTitle" value="${data.surveyTitle}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="startTime" type="date" value="${data.startTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="endTime" type="date"  value="${data.endTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        问题类型
                    </div>
                    <div class="col-md-9">
                        <select id="surveyType" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark" value="${data.remark}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DCLX", function (data) {
            addOption(data, 'surveyType','${data.surveyType}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'f_years','${data.years}');
        });
    });


    function save() {
        var surveyId = $("#surveyId").val();
        var surveyTitle = $("#surveyTitle").val();
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var surveyType = $("#surveyType").val();
        var remark = $("#remark").val();
        var years = $("#f_years").val();
        if (years == "" || years == undefined || years == null) {
            swal({title: "请选择年份！",type: "info"});
            return;
        }
        if (surveyTitle == "" || surveyTitle == undefined || surveyTitle == null) {
            swal({title: "请填写主题！",type: "info"});
            return;
        }
        if (startTime == "" || startTime == undefined || startTime == null) {
            swal({title: "请填写开始时间！",type: "info"});
            return;
        }
        if (endTime == "" || endTime == undefined || endTime == null) {
            swal({title: "请填写结束时间！",type: "info"});
            return;
        }
        if (surveyType == "" || surveyType == undefined || surveyType == null) {
            swal({title: "请选择调查类型！",type: "info"});
            return;
        }
        var startTimeVal =new Date(startTime).getTime();
        var endTimeVal =new Date(endTime).getTime();
        if(startTimeVal>endTimeVal){
            swal({
                title: "开始日期不能晚于结束日期！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/survey/saveSurvey", {
            surveyId:surveyId,
            surveyTitle:surveyTitle,
            startTime:startTime,
            endTime:endTime,
            surveyType:surveyType,
            remark:remark,
            years:years
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#surveytable').DataTable().ajax.reload();
            });
        })
    }
</script>



