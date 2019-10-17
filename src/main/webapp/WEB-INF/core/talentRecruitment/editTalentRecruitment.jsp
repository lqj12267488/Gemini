<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:19
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
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="talentRecruitmentid" name="talentRecruitmentid" type="hidden" value="${talentRecruitment.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">

                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDept" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${talentRecruitment.requestDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="f_requester" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${talentRecruitment.requester}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDate" value="${talentRecruitment.requestDate}" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        职务
                    </div>
                    <div class="col-md-9">
                        <input id="f_post" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${talentRecruitment.post}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        招聘岗位
                    </div>
                    <div class="col-md-9">
                        <input id="f_recruitmentPosts" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${talentRecruitment.recruitmentPosts}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请到岗日期
                    </div>
                    <div class="col-md-9">
                        <input id="f_stationDate" type="date" class="validate[required,maxSize[100]] form-control"
                               value="${talentRecruitment.stationDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        招聘人数
                    </div>
                    <div class="col-md-9">
                        <input id="f_recruitment" type="number" min="1" oninput="value=value.replace(/[^\d]/g,'')"
                               class="validate[required,maxSize[100]] form-control"
                               value="${talentRecruitment.recruitment}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        招聘原由
                    </div>
                    <div class="col-md-9">
                        <select id="f_recruitmentReason" class="validate[required,maxSize[100]] form-control"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        性别
                    </div>
                    <div class="col-md-9">
                        <input id="f_sex" type="checkbox" name="check" value="1" style="float: left;width: 60px;"/>
                        <div style="float: left">男</div>
                        <input id="f_boyNumber" type="text" value="${talentRecruitment.boyNumber}" class="validate[required,maxSize[100]] form-control" readOnly="readonly" style="float: left;width: 60px;">
                        <div style="float: left">名</div>
                        <input id="f_sex1" type="checkbox" name="check" value="2" style="float: left;width: 60px;"/>
                        <div style="float: left">女</div>
                        <input id="f_girlNumber" type="text" value="${talentRecruitment.girlNumber}" class="validate[required,maxSize[100]] form-control" readOnly="readonly" style="float: left;width: 60px;">
                        <div style="float: left">名</div>
                        <input id="f_sex2" type="checkbox" name="check" value="3" style="float: left;width: 60px;"/>
                        <div style="float: left">不限</div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        婚姻状况
                    </div>
                    <div class="col-md-9">
                        <select id="f_maritalStatus" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        年龄
                    </div>
                    <div class="col-md-9">
                        <input id="f_ageStart" type="number" min="1" oninput="value=value.replace(/[^\d]/g,'')"  value="${talentRecruitment.ageStart}" style="width: 170px;float: left">
                        <div style="float: left">岁至</div>
                        <input id="f_ageEnd" type="number" min="1" oninput="value=value.replace(/[^\d]/g,'')"  value="${talentRecruitment.ageEnd}" style="width: 170px;float: left">
                        <div style="float: left">岁</div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        政治面貌
                    </div>
                    <div class="col-md-9">
                        <select id="f_politicalOutlook" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        语言要求
                    </div>
                    <div class="col-md-9">
                        <input id="f_languageRequirements" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${talentRecruitment.languageRequirements}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学历
                    </div>
                    <div class="col-md-9">
                        <select id="f_education" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业限制
                    </div>
                    <div class="col-md-9">
                        <select id="f_professionalRestrictions" class="validate[required,maxSize[100]] form-control"/>

                        <input id="f_near" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${talentRecruitment.near}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        工作年限
                    </div>
                    <div class="col-md-9">
                        <select id="f_workingLife" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        相关资格证书
                    </div>
                    <div class="col-md-9">
                        <input id="f_relevantCertificate" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${talentRecruitment.relevantCertificate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        岗位职责
                    </div>
                    <div class="col-md-9">
                        <input id="f_jobResponsibilities" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${talentRecruitment.jobResponsibilities}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        其他要求
                    </div>
                    <div class="col-md-9">
                        <input id="f_otherRequirements" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${talentRecruitment.otherRequirements}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveTalentRecruitment()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        if(null != '${talentRecruitment.sex}'){
            $('${talentRecruitment.sex}'.split(",")).each(function (i,dom){
                $(":checkbox[value='"+dom+"']").prop("checked",true);
                $(":checkbox[id='"+dom+"']").prop("checked",true);
            });
            if ($("#f_sex").is(':checked') == true) {
                $("#f_boyNumber").attr("readOnly",false);
            }
            if ($("#f_sex1").is(':checked') == true) {
                $("#f_girlNumber").attr("readOnly",false);
            }
        }
        if(""=='${talentRecruitment.near}'|| null == '${talentRecruitment.near}'){
            $("#f_near").hide();
        }
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZPYY", function (data) {
            addOption(data, "f_recruitmentReason", '${talentRecruitment.recruitmentReason}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=RCZPHYZK", function (data) {
            addOption(data, "f_maritalStatus", '${talentRecruitment.maritalStatus}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZZMM", function (data) {
            addOption(data, "f_politicalOutlook", '${talentRecruitment.politicalOutlook}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYXZ", function (data) {
            addOption(data, "f_professionalRestrictions", '${talentRecruitment.professionalRestrictions}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GZNX", function (data) {
            addOption(data, "f_workingLife", '${talentRecruitment.workingLife}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=RCZPXL", function (data) {
            addOption(data, "f_education", '${talentRecruitment.education}');
        });

    })
    $("#f_professionalRestrictions").change(function () {
        if("3"==$("#f_professionalRestrictions").val()){
            $("#f_near").show();
        }else{
            $("#f_near").hide();
        }
    })
    $("#f_sex").change(function () {
        if ($("#f_sex").is(':checked') == true) {
            $("#f_sex2").removeAttr("checked");
            $("#f_boyNumber").attr("readOnly",false);
        }else{
            $("#f_boyNumber").val("");
            $("#f_boyNumber").attr("readOnly",true);
        }
    })
    $("#f_sex1").change(function () {
        if ($("#f_sex1").is(':checked') == true) {
            $("#f_sex2").removeAttr("checked");
            $("#f_girlNumber").attr("readOnly",false);
        }else{
            $("#f_girlNumber").val("");
            $("#f_girlNumber").attr("readOnly",true);
        }
    })
    $("#f_sex2").change(function () {
        if ($("#f_sex2").is(':checked') == true) {
            $("#f_sex1").removeAttr("checked");
            $("#f_sex").removeAttr("checked");
            $("#f_boyNumber").val("");
            $("#f_boyNumber").attr("readOnly",true);
            $("#f_girlNumber").val("");
            $("#f_girlNumber").attr("readOnly",true);
        }
    })
    function saveTalentRecruitment() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        if(parseInt($("#f_ageEnd").val())<parseInt($("#f_ageStart").val())){
            swal({
                title: "年龄填写错误，请重新填写!",
                type: "info"
            });
            $("#f_ageEnd").val("");
            return;
        }
        var sex = "";
        $.each($('input:checkbox:checked'),function(){
            sex+= $(this).val()+","
        });
        sex = sex.substring(0,sex.length-1);
        $.post("<%=request.getContextPath()%>/talentRecruitment/saveTalentRecruitment", {
            id: $("#talentRecruitmentid").val(),
            requestDate: date,
            post:$("#f_post").val(),
            recruitmentPosts:$("#f_recruitmentPosts").val(),
            stationDate:$("#f_stationDate").val(),
            recruitment:$("#f_recruitment").val(),
            recruitmentReason:$("#f_recruitmentReason option:selected").val(),
            boyNumber:$("#f_boyNumber").val(),
            girlNumber:$("#f_girlNumber").val(),
            sex:sex,
            maritalStatus:$("#f_maritalStatus option:selected").val(),
            ageStart:$("#f_ageStart").val(),
            ageEnd:$("#f_ageEnd").val(),
            politicalOutlook:$("#f_politicalOutlook option:selected").val(),
            languageRequirements:$("#f_languageRequirements").val(),
            education:$("#f_education").val(),
            professionalRestrictions:$("#f_professionalRestrictions option:selected").val(),
            near:$("#f_near").val(),
            workingLife:$("#f_workingLife option:selected").val(),
            relevantCertificate:$("#f_relevantCertificate").val(),
            jobResponsibilities:$("#f_jobResponsibilities").val(),
            otherRequirements:$("#f_otherRequirements").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#talentRecruitmentGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>


