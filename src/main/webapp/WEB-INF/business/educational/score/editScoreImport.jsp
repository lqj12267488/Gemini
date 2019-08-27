<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input hidden="hidden" id="id" value="${scoreImport.id}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            考试名称
                        </div>
                        <div class="col-md-9">
                            <input id="t_scoreExamName" value="${scoreImport.scoreExamName}"readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            课程
                        </div>
                        <div class="col-md-9">
                            <input id="t_courseId" value="${scoreImport.courseId}"readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            系部
                        </div>
                        <div class="col-md-9">
                            <input id="f_departments" value="${scoreImport.departmentsId}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            专业
                        </div>
                        <div class="col-md-9">
                            <input id="f_majorCode" value="${scoreImport.majorCode}" readonly="readonly"/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-3 tar">
                            班级
                        </div>
                        <div class="col-md-9">
                            <input id="t_classId" value="${scoreImport.classId}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            录入教师
                        </div>
                        <div class="col-md-9">
                            <input id="t_personId" value="${scoreImport.personId}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            学生姓名
                        </div>
                        <div class="col-md-9">
                            <input id="t_studentId" value="${scoreImport.studentId}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            考试状态
                        </div>
                        <div class="col-md-9">
                            <select id="f_eStatus"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            成绩
                        </div>
                        <div class="col-md-9">
                            <input id="t_score"  value="${scoreImport.score}"/></select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>

</div>
<script>

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KSZT", function (data) {
            addOption(data, 'f_eStatus', '${scoreImport.examinationStatus}');
        });
    })


    function save() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_eStatus").val() == "" ||$("#f_eStatus").val() == undefined) {
            swal({title: "请选择考试状态！",type: "info"});
            return;
        }
        if(!reg.test($("#t_score").val())){
            swal({title: "成绩请填写整数！",type: "info"});
            return;
        }else if($("#t_score").val()>100) {
            swal({title: "成绩请填写100以下的整数！",type: "info"});
            return;
        }else if($("#t_score").val()<0){
            swal({title: "成绩请填写0以上的整数！",type: "info"});
            return;
        }else{

        }
        $.post("<%=request.getContextPath()%>/scoreImport/saveScoreImportTeacher", {
            id:$("#id").val(),
            examinationStatus:$("#f_eStatus").val(),
            score: $("#t_score").val()

        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#importGrid').DataTable().ajax.reload();
            }
        })


    }


</script>




