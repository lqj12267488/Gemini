<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/16
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 700px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            学生姓名
                        </div>
                        <div class="col-md-10">
                            <input id="studentId" type="text" value="${scoreImport.studentId}"readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            考试名称
                        </div>
                        <div class="col-md-10">
                            <input id="scoreExamId" type="text" value="${scoreImport.scoreExamId}"readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            学期
                        </div>
                        <div class="col-md-4">
                            <input id="termId" type="text" value="${scoreImport.termId}"readonly="readonly"/>
                        </div>
                        <div class="col-md-2 tar">
                            课程
                        </div>
                        <div class="col-md-4">
                            <input id="courseId" type="text" value="${scoreImport.courseId}"readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            系部
                        </div>
                        <div class="col-md-10">
                            <input id="departmentsId" type="text" value="${scoreImport.departmentsId}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            专业
                        </div>
                        <div class="col-md-10">
                            <input id="majorCode" type="text" value="${scoreImport.majorCode}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            班级
                        </div>
                        <div class="col-md-10">
                            <input id="classId" type="text" value="${scoreImport.classId}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            考试状态
                        </div>
                        <div class="col-md-4">
                            <select id="examinationStatus"></select>
                        </div>
                        <div class="col-md-2 tar">
                            成绩
                        </div>
                        <div class="col-md-4">
                            <input id="score" type="text" value="${scoreImport.score}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            补考状态
                        </div>
                        <div class="col-md-4">
                            <select id="makeupStatus"></select>
                        </div>
                        <div class="col-md-2 tar">
                            补考成绩
                        </div>
                        <div class="col-md-4">
                            <input id="makeupScore" type="text" value="${scoreImport.makeupScore}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            上次录入时间
                        </div>
                        <div class="col-md-10">
                            <input id="changeTime" type="text" value="${scoreImport.changeTime}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            上次录入教师
                        </div>
                        <div class="col-md-10">
                            <input id="changer" type="text" value="${scoreImport.changer}" readonly="readonly"/>
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
    <input hidden="hidden" id="id" value="${scoreImport.id}">
</div>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KSZT", function (data) {
            addOption(data, 'examinationStatus','${scoreImport.examinationStatus}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KSZT", function (data) {
            addOption(data, 'makeupStatus','${scoreImport.makeupStatus}');
        });
    })
    function save() {
        if ($("#makeupStatus").val() == "" ||$("#makeupStatus").val() == undefined) {
            swal({title: "请选择补考状态！",type: "info"});
            return;
        }
        if ($("#makeupScore").val() == "" ||$("#makeupScore").val() == undefined) {
            swal({title: "请输入补考成绩！",type: "info"});
            return;
        }
        var reg=new RegExp("^[0-9]{1,3}(.[0-9]{1})?$");
        if(!reg.test($("#makeupScore").val())){
            swal({title: "补考成绩格式不正确！",type: "info"});
            return;
        }
        $.post("<%=request.getContextPath()%>/scoreMakeup/saveScoreExam", {
            id:$("#id").val(),
            makeupStatus:$("#makeupStatus").val(),
            makeupScore:$("#makeupScore").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#listGrid').DataTable().ajax.reload();
                search();
            }
        })
    }
</script>
