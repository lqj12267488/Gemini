<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 18:00
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="form-row">
    <div class="col-md-3 tar" style="float: left;">
        申请时间
    </div>
    <div class="col-md-7" style="margin-top: 4px;">
        <input id="f_requestDate" type="datetime-local" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.requestDate}"/>
    </div>
    <div style="float: right;width: 230px;height: 160px;">
        <div style="width: 160px;height: 160px;margin-top: -4px;">
                    <img onclick="showInputFile()"
                         style="width: 130px;height: 172px;margin-top: 4px;margin-left: 46px"
                         src="data:image/png;base64,${studentReissue.img}"
                         height="150"
                         width="110" alt="" id="userImg1">
        </div>
    </div>
    <div class="col-md-3 tar" style="float: left;">
        学生姓名
    </div>
    <div class="col-md-7" style="margin-top: 4px;">
        <input id="studentId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.studentId}" readonly="readonly"/>
    </div>
    <div class="col-md-3 tar" style="float: left;">
        民族
    </div>
    <div class="col-md-7" style="margin-top: 4px;">
        <input id="f_nation" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.nation}" readonly="readonly"/>
    </div>
    <div class="col-md-3 tar" style="float: left;">
        性别
    </div>
    <div class="col-md-7" style="margin-top: 4px;">
        <input id="f_sex" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.sex}" readonly="readonly"/>
    </div>
    <div class="col-md-3 tar" style="float: left;">
        班级
    </div>
    <div class="col-md-7" style="margin-top: 4px;">
        <input id="classId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.classId}" readonly="readonly"/>
    </div>
</div>
<%--<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="datetime-local" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.requestDate}"/>
    </div>
</div>--%>
<%--<div class="form-row">
    <div class="col-md-3 tar">
        学生姓名
    </div>
    <div class="col-md-9">
        <input id="studentId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.studentId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        民族
    </div>
    <div class="col-md-9">
        <input id="f_nation" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.nation}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        性别
    </div>
    <div class="col-md-9">
        <input id="f_sex" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.sex}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        班级
    </div>
    <div class="col-md-9">
        <input id="classId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.classId}" readonly="readonly"/>
    </div>
</div>--%>
<div class="form-row">
    <div class="col-md-3 tar">
        专业
    </div>
    <div class="col-md-9">
        <input id="majorCode" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.majorCode}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学号
    </div>
    <div class="col-md-9">
        <input id="studentNumber" type="text" readonly="readonly"
               value="${studentReissue.studentNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        身份证号
    </div>
    <div class="col-md-9">
        <input id="f_idcard" type="text" readonly="readonly" value="${studentReissue.idcard}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        乘车区间
    </div>
    <div class="col-md-9">
        <input id="f_rideZone" readonly="readonly"value="${studentReissue.rideZone}"></input>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        家庭地址
    </div>
    <div class="col-md-9">
        <input id="f_familyAddress" readonly="readonly"value="${studentReissue.familyAddress}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        新疆省
    </div>
    <div class="col-md-9">
        <input id="f_xinjiangProvinc" readonly="readonly" value="${studentReissue.province}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        地区（州）
    </div>
    <div class="col-md-9">
        <input id="f_regional"  readonly="readonly" value="${studentReissue.regional}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        市（县）
    </div>
    <div class="col-md-9">
        <input id="f_city" readonly="readonly" value="${studentReissue.city}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请项目
    </div>
    <div class="col-md-9">
        <input id="f_requestProject" readonly="readonly" value="${studentReissue.requestProject}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请理由
    </div>
    <div class="col-md-9">
        <input id="f_requestReason" readonly="readonly" value="${studentReissue.requestReason}"/>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/studentReissue/printStudentReissue?id=${studentReissue.id}">

<script>


</script>

