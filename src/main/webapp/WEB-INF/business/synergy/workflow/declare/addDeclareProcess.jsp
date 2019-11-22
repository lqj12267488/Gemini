<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<div class="form-row">
    <div class="col-md-2 tar">
        申请人
    </div>
    <div class="col-md-4">
        <input id="f_requestEr" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${declare.requester}" readonly="readonly"/>
    </div>
    <div class="col-md-2 tar">
        申请部门
    </div>
    <div class="col-md-4">
        <input id="f_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${declare.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        申请时间
    </div>
    <div class="col-md-4">
        <input id="f_requestDate" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${declare.requestDate}" readonly="readonly"/>
    </div>
    <div class="col-md-2 tar">
        姓名
    </div>
    <div class="col-md-4">
        <input id="name" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.name}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        性别
    </div>
    <div class="col-md-4">
        <input id="sex" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.sex}"/>
    </div>
    <div class="col-md-2 tar">
        民族
    </div>
    <div class="col-md-4">
        <input id="nation" type="text"readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.nation}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        出生日期
    </div>
    <div class="col-md-4">
        <input id="birthday" type="date" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.birthday}"/>
    </div>
    <div class="col-md-2 tar">
        政治面貌
    </div>
    <div class="col-md-4">
        <input id="politicalStatus" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.politicalStatus}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        身份证号
    </div>
    <div class="col-md-4">
        <input id="idcard" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.idcard}"/>
    </div>
    <div class="col-md-2 tar">
        工作时间
    </div>
    <div class="col-md-4">
        <input id="workTime" type="date" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.workTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        专业
    </div>
    <div class="col-md-4">
        <input id="major"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.major}"/>
    </div>
    <div class="col-md-2 tar">
        入职时间
    </div>
    <div class="col-md-4">
        <input id="entryTime"  type="date" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.entryTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        工作部门
    </div>
    <div class="col-md-4">
        <input id="workDept" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.workDept}"/>
    </div>
    <div class="col-md-2 tar">
        行政职务
    </div>
    <div class="col-md-4">
        <input id="administrativePost" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.administrativePost}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        现任专业技术职务
    </div>
    <div class="col-md-4">
        <input id="technicalPosition" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.technicalPosition}"/>
    </div>
    <div class="col-md-2 tar">
        任职时间
    </div>
    <div class="col-md-4">
        <input id="appointmentTime" type="date" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.appointmentTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        拟申报职称层次
    </div>
    <div class="col-md-4">
        <input id="appliedLevel" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.appliedLevel}"/>
    </div>
    <div class="col-md-2 tar">
        从事专业时间
    </div>
    <div class="col-md-4">
        <input id="majorTime" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.majorTime}"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-2 tar">
        学位
    </div>
    <div class="col-md-4">
        <input id="academicDegree" type="text" readonly="readonly"
                class="validate[required,maxSize[20]] form-control"
                value="${declare.academicDegree}"/>
    </div>
    <div class="col-md-2 tar">
        学历
    </div>
    <div class="col-md-4">
        <input id="educationalLevel" type="text" readonly="readonly"
                class="validate[required,maxSize[20]] form-control"
                value="${declare.educationalLevel}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        毕业学校
    </div>
    <div class="col-md-4">
        <input id="school"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.school}"/>
    </div>
    <div class="col-md-2 tar">
        毕业时间
    </div>
    <div class="col-md-4">
        <input id="graduateTime"  type="date" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.graduateTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        职业资格证书类别及获取时间
    </div>
    <div class="col-md-4">
        <input id="acquisitionTime"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.acquisitionTime}"/>
    </div>
    <div class="col-md-2 tar">
        参加学术团体及任职
    </div>
    <div class="col-md-4">
        <input id="organizationsPositions"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.organizationsPositions}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        学术技术荣誉称号
    </div>
    <div class="col-md-4">
        <input id="academicTechnology"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.academicTechnology}"/>
    </div>
    <div class="col-md-2 tar">
        继续教育证书获取时间
    </div>
    <div class="col-md-4">
        <input id="continuingEducationTime"  type="date" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.continuingEducationTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        通讯地址
    </div>
    <div class="col-md-4">
        <input id="postalAddress"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.postalAddress}"/>
    </div>
    <div class="col-md-2 tar">
        邮政编码
    </div>
    <div class="col-md-4">
        <input id="postCode"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.postCode}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        办公电话
    </div>
    <div class="col-md-4">
        <input id="officePhone"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.officePhone}"/>
    </div>
    <div class="col-md-2 tar">
        手机
    </div>
    <div class="col-md-4">
        <input id="tel"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.tel}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        电子信箱
    </div>
    <div class="col-md-4">
        <input id="email"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.email}"/>
    </div>
    <div class="col-md-2 tar">
        工作年限
    </div>
    <div class="col-md-4">
        <input id="workingSeniority"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.workingSeniority}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        职称
    </div>
    <div class="col-md-4">
        <input id="positionalTitles"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.positionalTitles}"/>
    </div>
    <div class="col-md-2 tar">
        现任职务
    </div>
    <div class="col-md-4">
        <input id="presentPost"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.presentPost}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        聘任时间
    </div>
    <div class="col-md-4">
        <input id="engageTime"  type="date" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.engageTime}"/>
    </div>
    <div class="col-md-2 tar">
        现任岗位
    </div>
    <div class="col-md-4">
        <input id="incumbentPost"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.incumbentPost}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        聘任岗位
    </div>
    <div class="col-md-4">
        <input id="appointmentPost"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declare.appointmentPost}"/>
    </div>
    <div class="col-md-2 tar">
        申报人代表性成果
    </div>
    <div class="col-md-4">
        <textarea id="representativeAchievements"  type="text"
               class="validate[required,maxSize[20]] form-control" readonly="readonly">${declare.representativeAchievements}</textarea>
    </div>
</div>
<%--<div class="form-row">
    <div class="col-md-2 tar">
        已关联业务
    </div>
    <div class="col-md-4">
        <div class="side pull-right">
            <a href="#" onclick="fundAudit()"></a>
        </div>
        &lt;%&ndash;<div class="head bg-dot30" id="fuAudit" style="width: 100%;">
        </div>&ndash;%&gt;
    </div>
</div>--%>
<input id="h_id" hidden value="${declare.id}">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/declare/printFunds?id=${declare.id}">
<script>

</script>
