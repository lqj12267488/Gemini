<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/18
  Time: 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<button onclick="back()" class="btn btn-default btn-clean">返回</button>
    <div class="form-row">
        <div class="col-md-2 tar">
            系部
        </div>
        <div class="col-md-4">
            <input id="f_departmentsId" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.departmentsIdShow}"/>
        </div>
        <div class="col-md-2 tar">
            专业
        </div>
        <div class="col-md-4">
            <input id="f_majorCode" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.majorCodeShow}"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            班级名称
        </div>
        <div class="col-md-4">
            <input id="f_classId" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.classIdShow}"/>
        </div>
        <div class="col-md-2 tar">
            培养层次
        </div>
        <div class="col-md-4">
            <input id="f_trainingLevel" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.trainingLevelShow}"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            学生
        </div>
        <div class="col-md-4">
            <input id="f_studentId" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.studentIdShow}"/>
        </div>
        <div class="col-md-2 tar">
            工资
        </div>
        <div class="col-md-4">
            <input id="f_salary" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.salaryShow}"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            性别
        </div>
        <div class="col-md-4">
            <input id="f_sex" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.sexShow}"/>
        </div>
        <div class="col-md-2 tar">
            身份证号
        </div>
        <div class="col-md-4">
            <input id="f_idcard" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.idcard}"/>
        </div>
    </div>

    <div class="form-row">
        <div class="col-md-2 tar">
            就业单位
        </div>
        <div class="col-md-4">
            <input id="f_employmentUnitId" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.employmentUnitIdShow}"/>
        </div>
        <div class="col-md-2 tar">
            就业岗位
        </div>
        <div class="col-md-4">
            <input id="f_employmentPositions" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.employmentPositions}" />
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            就业年份
        </div>
        <div class="col-md-4">
            <input id="f_employmentYear" type="date" class="validate[required,maxSize[100]] form-control"
                   value="${employmentManage.employmentYear}" readonly="readonly" />
        </div>
        <div class="col-md-2 tar">
            地区
        </div>
        <div class="col-md-4">
            <input id="f_area" type="text"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.area}" readonly="readonly"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            就业形式
        </div>
        <div class="col-md-4">
            <input id="f_employmentType" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.employmentTypeShow}"/>
        </div>
        <div class="col-md-2 tar">
            专业对口否
        </div>
        <div class="col-md-4">
            <input id="f_majorMatchFlag" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.majorMatchFlagShow}"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            学生电话
        </div>
        <div class="col-md-4">
            <input id="f_tel" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.tel}"/>
        </div>
        <div class="col-md-2 tar">
            是否签订合同
        </div>
        <div class="col-md-4">
            <input id="f_signContract" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.signContractShow}"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            就业保险类型
        </div>
        <div class="col-md-4">
            <input id="f_employmentInsuranceType" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.employmentInsuranceTypeShow}"/>
        </div>
        <div class="col-md-2 tar">
            就业满意度
        </div>
        <div class="col-md-4">
            <input id="f_employmentSatisfaction" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${employmentManage.employmentSatisfactionShow}"/>
        </div>
    </div>
<script>
    function back() {
        $("#right").load("<%=request.getContextPath()%>/employments/manage");
    }
</script>