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
                        姓名
                    </div>
                    <div class="col-md-9">
                        <input id="f_name" type="text" readonly
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.name}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        性别
                    </div>
                    <div class="col-md-9">
                        <select id="f_sex" class="validate[required,maxSize[20]] form-control" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        毕业院校
                    </div>
                    <div class="col-md-9">
                        <input id="f_graduateSchool" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.graduateSchool}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <input id="f_major" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.major}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        民族
                    </div>
                    <div class="col-md-9">
                        <select id="f_nation" class="validate[required,maxSize[20]] form-control" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        职称
                    </div>
                    <div class="col-md-9">
                        <input id="f_post" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.post}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学历
                    </div>
                    <div class="col-md-9">
                        <select id="f_education" class="validate[required,maxSize[20]] form-control" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        毕业时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_graduationTime" type="date" placeholder="请填写数字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.graduationTime}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        个人薪资要求
                    </div>
                    <div class="col-md-9">
                        <input id="f_personSalary" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.personSalary}" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        本人求职岗位
                    </div>
                    <div class="col-md-9">
                        <input id="f_job" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="60" placeholder="最多输入60个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${interviewers.job}" readonly/>
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



</script>

