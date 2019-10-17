<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="s_requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="s_requester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="s_requestDate" value="${talentRecruitment.requestDate}" readonly="readonly" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        职务
    </div>
    <div class="col-md-9">
        <input id="s_post" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.post}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        招聘岗位
    </div>
    <div class="col-md-9">
        <input id="s_recruitmentPosts" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.recruitmentPosts}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请到岗日期
    </div>
    <div class="col-md-9">
        <input id="s_stationDate" type="date" readonly="readonly" class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.stationDate}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        招聘人数
    </div>
    <div class="col-md-9">
        <input id="s_recruitment" type="number" min="1" oninput="value=value.replace(/[^\d]/g,'')"
               class="validate[required,maxSize[100]] form-control" readonly="readonly"
               value="${talentRecruitment.recruitment}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        招聘原由
    </div>
    <div class="col-md-9">
        <input id="s_recruitmentReason" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.recruitmentReasonShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        性别
    </div>
    <div class="col-md-9">
        <input id="s_sex" type="checkbox" name="check" value="1" style="float: left;width: 60px;" onclick="return false;"/>
        <div style="float: left">男</div>
        <input id="s_boyNumber" readonly="readonly" type="text" value="${talentRecruitment.boyNumber}" class="validate[required,maxSize[100]] form-control" readOnly="readonly" style="float: left;width: 60px;">
        <div style="float: left">名</div>
        <input id="s_sex1" onclick="return false;" type="checkbox" name="check" value="2" style="float: left;width: 60px;"/>
        <div style="float: left">女</div>
        <input id="s_girlNumber" readonly="readonly" type="text" value="${talentRecruitment.girlNumber}" class="validate[required,maxSize[100]] form-control" readOnly="readonly" style="float: left;width: 60px;">
        <div style="float: left">名</div>
        <input id="s_sex2" onclick="return false;" type="checkbox" name="check" value="3" style="float: left;width: 60px;"/>
        <div style="float: left">不限</div>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        婚姻状况
    </div>
    <div class="col-md-9">
        <input id="s_maritalStatus" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.maritalStatusShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        年龄
    </div>
    <div class="col-md-9">
        <input id="s_ageStart" readonly="readonly" class="validate[required,maxSize[100]] form-control" type="number" min="1" oninput="value=value.replace(/[^\d]/g,'')"  value="${talentRecruitment.ageStart}" style="width: 170px;float: left">
        <div style="float: left">岁至</div>
        <input id="s_ageEnd" readonly="readonly"  class="validate[required,maxSize[100]] form-control" type="number" min="1" oninput="value=value.replace(/[^\d]/g,'')"  value="${talentRecruitment.ageEnd}" style="width: 170px;float: left">
        <div style="float: left">岁</div>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        政治面貌
    </div>
    <div class="col-md-9">
        <input id="s_politicalOutlook" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.politicalOutlookShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        语言要求
    </div>
    <div class="col-md-9">
        <input id="s_languageRequirements" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.languageRequirements}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学历
    </div>
    <div class="col-md-9">
        <input id="s_education" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.educationShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        专业限制
    </div>
    <div class="col-md-9">
        <input id="s_professionalRestrictions" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.professionalRestrictionsShow}"/>
        <input id="s_near" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.near}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        工作年限
    </div>
    <div class="col-md-9">
        <input id="s_workingLife" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.workingLifeShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        相关资格证书
    </div>
    <div class="col-md-9">
        <input id="s_relevantCertificate" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.relevantCertificate}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        岗位职责
    </div>
    <div class="col-md-9">
        <input id="s_jobResponsibilities" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.jobResponsibilities}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        其他要求
    </div>
    <div class="col-md-9">
        <input id="s_otherRequirements" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${talentRecruitment.otherRequirements}"/>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/talentRecruitment/printTalentRecruitment?id=${talentRecruitment.id}">
<script>
    $(document).ready(function () {
        if(null != '${talentRecruitment.sex}'){
            $('${talentRecruitment.sex}'.split(",")).each(function (i,dom){
                $(":checkbox[value='"+dom+"']").prop("checked",true);
                $(":checkbox[id='"+dom+"']").prop("checked",true);
            });
        }
        if(""=='${talentRecruitment.near}'|| null == '${talentRecruitment.near}'){
            $("#s_near").hide();
        }
    })
</script>
