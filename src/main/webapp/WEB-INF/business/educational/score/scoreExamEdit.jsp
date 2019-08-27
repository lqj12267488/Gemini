<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/12
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学期
                    </div>
                    <div class="col-md-9">
                        <select  id="term"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        考试名称
                    </div>
                    <div class="col-md-9">
                        <input id="scoreExamName" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${scoreExam.scoreExamName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="startTime" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${scoreExam.startTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="endTime" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${scoreExam.endTime}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="save" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeView()">关闭</button>
        </div>
    </div>
    <input id="scoreExamId" value="${scoreExam.scoreExamId}" type="hidden" >
</div>

<script>
    $(document).ready(function (){
//系统字典项
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'term','${scoreExam.term}');
        });
        $("#term").change(function () {
            var term=$("#term");
            $("#scoreExamName") .val($("#term option:selected").text()+"成绩表");
        })
    })
    function save() {
        if ($("#term").val() == "" || $("#term").val() == undefined) {
            swal({title: "请选择学期！",type: "info"});
            return;
        }
        if ($("#scoreExamName").val() == "") {
            swal({title: "请填写考试名称！",type: "info"});
            return;
        }
        if ($("#startTime").val() == "" || $("#startTime").val() == undefined) {
            swal({title: "请填写精确的开始时间！",type: "info"});
            return;
        }
        if ($("#endTime").val() == "" || $("#endTime").val() == undefined) {
            swal({title: "请填写精确的结束时间！",type: "info"});
            return;
        }
        var startTime = $("#startTime").val();
        var endTime =$("#endTime").val();
        if(startTime>endTime){
            swal({title: "开始时间必须早于结束时间！",type: "info"});
            return;
        }
        startTime = startTime.replace('T','');
        endTime = endTime.replace('T','');
        $.post("<%=request.getContextPath()%>/scoreExam/saveScoreExam", {
            scoreExamId:$("#scoreExamId").val(),
            scoreExamName:$("#scoreExamName").val(),
            startTime:startTime,
            endTime:endTime,
            term:$("#term").val(),
        }, function (msg) {
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#scoreExamGrid').DataTable().ajax.reload();
        })
    }
</script>