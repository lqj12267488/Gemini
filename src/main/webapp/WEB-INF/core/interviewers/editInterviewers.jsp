<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%--新增页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="interviewersid" hidden value="${interviewers.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        姓名
                    </div>
                    <div class="col-md-9">
                        <input id="f_name" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.name}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        性别
                    </div>
                    <div class="col-md-9">
                        <select id="f_sex" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        毕业院校
                    </div>
                    <div class="col-md-9">
                        <input id="f_graduateSchool" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.graduateSchool}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        专业
                    </div>
                    <div class="col-md-9">
                        <input id="f_major" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.major}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        民族
                    </div>
                    <div class="col-md-9">
                        <select id="f_nation" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        职称
                    </div>
                    <div class="col-md-9">
                        <input id="f_post" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.post}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        学历
                    </div>
                    <div class="col-md-9">
                        <select id="f_education" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        毕业时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_graduationTime" type="date" placeholder="请填写数字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.graduationTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        个人薪资要求
                    </div>
                    <div class="col-md-9">
                        <input id="f_personSalary" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.personSalary}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        本人求职岗位
                    </div>
                    <div class="col-md-9">
                        <input id="f_job" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="60" placeholder="最多输入60个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.job}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学期
                    </div>
                    <div class="col-md-9">
                        <select id="f_term" disabled="disabled" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'f_term', '${interviewers.term}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XL", function (data) {
            addOption(data, 'f_education', '${interviewers.education}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
            addOption(data, 'f_nation', '${interviewers.nation}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'f_sex', '${interviewers.sex}');
        });

    })

    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_name").val() == "" || $("#f_name").val() == undefined) {
            swal({
                title: "请填写姓名！",
                type: "info"
            });
            return;
        }
        if ($("#f_sex").val() == "" || $("#f_sex").val() == undefined) {
            swal({
                title: "请选择性别！",
                type: "info"
            });
            return;
        }
        if ($("#f_graduateSchool").val() == "" || $("#f_graduateSchool").val() == undefined) {
            swal({
                title: "请填写毕业院校！",
                type: "info"
            });
            return;
        }
        if ($("#f_major").val() == "" || $("#f_major").val() == undefined) {
            swal({
                title: "请填写专业！",
                type: "info"
            });
            return;
        }
        if ($("#f_nation").val() == "" || $("#f_nation").val() == undefined) {
            swal({
                title: "请选择民族！",
                type: "info"
            });
            return;
        }
        if ($("#f_post").val() == "" || $("#f_post").val() == undefined) {
            swal({
                title: "请填写职称！",
                type: "info"
            });
            return;
        }
        if ($("#f_education").val() == "" || $("#f_education").val() == undefined) {
            swal({
                title: "请选择民学历！",
                type: "info"
            });
            return;
        }
        if ($("#f_graduationTime").val() == "" || $("#f_graduationTime").val() == undefined) {
            swal({
                title: "请填写毕业时间！",
                type: "info"
            });
            return;
        }
        if ($("#f_personSalary").val() == "" || $("#f_personSalary").val() == undefined) {
            swal({
                title: "请填写个人薪资要求！",
                type: "info"
            });
            return;
        }
        if ($("#f_job").val() == "" || $("#f_job").val() == undefined) {
            swal({
                title: "请填写本人求职岗位！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/interviewers/saveInterviewers", {
            id: $("#interviewersid").val(),
            name: $("#f_name").val(),
            sex: $("#f_sex option:selected").val(),
            graduateSchool: $("#f_graduateSchool").val(),
            major: $("#f_major").val(),
            nation: $("#f_nation option:selected").val(),
            post: $("#f_post").val(),
            education: $("#f_education option:selected").val(),
            graduationTime: $("#f_graduationTime").val(),
            personSalary: $("#f_personSalary").val(),
            job: $("#f_job").val(),
            term: $("#f_term option:selected").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#interviewers').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>

