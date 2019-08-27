<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/31
  Time: 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<button onclick="back()" class="btn btn-default btn-clean">返回</button>
<input id="id" hidden value="${studentArrayClassLook.id}">
 <input id="arrayId" hidden value="${studentArrayClassLook.arrayId}">

    <div class="form-row">
        <div class="col-md-2 tar">
            学生姓名
        </div>
        <div class="col-md-4">
            <input id="f_studentIdShow" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.studentIdShow}"/>
        </div>

        <div class="col-md-2 tar">
            系部
        </div>
        <div class="col-md-4">
            <input id="f_departmentsId" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.departmentsId}"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            专业
        </div>
        <div class="col-md-4">
            <input id="f_majorCode" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.majorCode}"/> </div>
        <div class="col-md-2 tar">
            专业方向
        </div>
        <div class="col-md-4">
            <input id="f_majorDirection" type="text" readonly="readonly"
                    class="validate[required,maxSize[20]] form-control"
                    value="${studentArrayClassLook.majorDirection}"/></div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            培养层次
        </div>
        <div class="col-md-4">
            <input id="f_trainingLevel" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.trainingLevel}"/>
        </div>
        <div class="col-md-2 tar">
            课程类型
        </div>
        <div class="col-md-4">
            <input id="f_courseTypeShow" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.courseTypeShow}"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            班级
        </div>
        <div class="col-md-4">
            <input id="f_classId" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.classId}"/>
        </div>
        <div class="col-md-2 tar">
            教室
        </div>
        <div class="col-md-4">
            <input id="f_roomIdShow" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.roomIdShow}"/>
        </div>
    </div>

    <div class="form-row">
        <div class="col-md-2 tar">
            课程
        </div>
        <div class="col-md-4">
            <input id="f_courseIdShow" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.courseIdShow}"/>
        </div>
        <div class="col-md-2 tar">
            教师
        </div>
        <div class="col-md-4">
            <input id="f_teacherPersonIdShow" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.teacherPersonIdShow}" />
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            教师组织机构
        </div>
        <div class="col-md-4">
            <input id="f_teacherDeptId" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.teacherDeptId}" />
        </div>
        <div class="col-md-2 tar">
            学周
        </div>
        <div class="col-md-4">
            <input id="f_area" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.weekTypeShow}" />
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            开始学周
        </div>
        <div class="col-md-4">
            <input id="f_startWeek" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.startWeek}"/>
        </div>
        <div class="col-md-2 tar">
            结束学周
        </div>
        <div class="col-md-4">
            <input id="f_endWeek" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.endWeek}"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            学时数
        </div>
        <div class="col-md-4">
            <input id="f_hours" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.hours}"/>
        </div>
        <div class="col-md-2 tar">
            相连课时数
        </div>
        <div class="col-md-4">
            <input id="f_connectHours" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.connectHours}"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-2 tar">
            星期
        </div>
        <div class="col-md-4">
            <input id="f_week" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.week}"/>
        </div>
        <div class="col-md-2 tar">
            学时类型
        </div>
        <div class="col-md-4">
            <input id="f_hoursType" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.hoursType}"/>
        </div>
    </div>

    <div class="form-row">
        <div class="col-md-2 tar">
            学时编码
        </div>
        <div class="col-md-4">
            <input id="f_hoursCode" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.hoursCode}"/>
        </div>
        <div class="col-md-2 tar">
            是否排课
        </div>
        <div class="col-md-4">
            <input id="f_arrayclassFlag" type="text" readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${studentArrayClassLook.arrayclassFlag}"/>
        </div>
    </div>




<script>
    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/studentView");
    }
</script>