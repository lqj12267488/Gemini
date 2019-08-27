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
            <input id="skillid" hidden value="${skill.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        项目名称
                    </div>
                    <div class="col-md-9">
                        <input id="f_projectName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${skill.projectName}" />
                    </div>
                </div>


                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        鉴定时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_appraisalTime" type="month"
                               class="validate[required,maxSize[20]] form-control"
                               value="${skill.appraisalTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        承办单位
                    </div>
                    <div class="col-md-9">
                        <input id="f_reason" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="60" placeholder="最多输入60个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${skill.appraisalCompany}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        项目级别
                    </div>
                    <div class="col-md-9">
                        <input id="f_level" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="60" placeholder="最多输入60个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${skill.projectLevel}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        发证机关
                    </div>
                    <div class="col-md-9">
                        <input id="issuingOffice" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="60" placeholder="最多输入60个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${skill.issuingOffice}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        鉴定人数
                    </div>
                    <div class="col-md-9">
                        <input id="f_peopleNum"  type="text" placeholder="请填写数字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${skill.appraisalNumber}"/>
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

    })

    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_projectName").val() == "" || $("#f_projectName").val() == "0" || $("#f_projectName").val() == undefined) {
            swal({
                title: "请填写项目名称！",
                type: "info"
            });
            return;
        }
        if ($("#f_appraisalTime").val() == "" || $("#f_appraisalTime").val() == "0" || $("#f_appraisalTime").val() == undefined) {
            swal({
                title: "请填写鉴定时间！",
                type: "info"
            });
            return;
        }


        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0") {
            swal({
                title: "请填写鉴定单位！",
                type: "info"
            });
            return;
        }
        if ($("#f_level").val() == "" || $("#f_level").val() == "0") {
            swal({
                title: "请填写项目级别！",
                type: "info"
            });
            return;
        }
        if ($("#issuingOffice").val() == "" || $("#issuingOffice").val() == "0") {
            swal({
                title: "请填写发证机关！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#f_peopleNum").val()) || $("#f_peopleNum").val() == "" || $("#f_peopleNum").val() == "0" || $("#f_peopleNum").val() == undefined){
            swal({
                title: "鉴定人数请填写整数！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/skill/saveSkill", {
            id: $("#skillid").val(),
            projectName: $("#f_projectName").val(),
            appraisalTime: $("#f_appraisalTime").val(),
            appraisalCompany: $("#f_reason").val(),
            appraisalNumber: $("#f_peopleNum").val(),
            projectLevel:$("#f_level").val(),
            issuingOffice:$("#issuingOffice").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#skill').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>

