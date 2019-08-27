<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<div class="modal-dialog" style="width: 1200px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <input id="studentId" name="studentId" type="hidden" value="${enrollmentstudent.studentId}">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                       学籍号
                    </div>
                    <div class="col-md-4">
                        <input id="hiddenStudentNumber" type="text" readonly value="${enrollmentstudent.studentNumber}"/>
                    </div>
                    <div class="col-md-2 tar">
                        学生姓名
                    </div>
                    <div class="col-md-4">
                        <input id="hiddenName" type="text" readonly value="${enrollmentstudent.name}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        身份证号
                    </div>
                    <div class="col-md-4">
                        <input  id="hiddenIdcard" type="text" readonly value="${enrollmentstudent.idcard}"/>
                    </div>
                    <div class="col-md-2 tar">
                        性别
                    </div>
                    <div class="col-md-4">
                        <select   id="hiddenSex"></select>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        入学年份
                    </div>
                    <div class="col-md-4">
                        <select   id="joinYear"  name="joinYear"/>
                    </div>
                    <div class="col-md-2 tar">
                        入学月份
                    </div>
                    <div class="col-md-4">
                        <select id="joinMonth" name="joinMonth"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        国籍
                    </div>
                    <div class="col-md-4">
                        <select id="hiddenNationality" ></select>
                    </div>
                    <div class="col-md-2 tar">
                        户籍省
                    </div>
                    <div class="col-md-4">
                        <select id="hiddenProvince"></select>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        民族
                    </div>
                    <div class="col-md-4">
                        <select id="hiddenNation"></select>
                    </div>
                    <div class="col-md-2 tar">
                        户籍市
                    </div>
                    <div class="col-md-4">
                        <select id="hiddenCity"></select>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        政治面貌
                    </div>
                    <div class="col-md-4">
                        <select id="hiddenPoliticalStatus"></select>
                    </div>
                    <div class="col-md-2 tar">
                        户籍县
                    </div>
                    <div class="col-md-4">
                        <select id="hiddenCounty" ></select>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        系部
                    </div>
                    <div class="col-md-4">
                        <select id="hiddenDid"></select>
                    </div>
                    <div class="col-md-2 tar">
                        专业
                    </div>
                    <div class="col-md-4">
                        <select id="hiddenMid" ></select>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        班级
                    </div>
                    <div class="col-md-4">
                        <select id="hiddenCid"></select>
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

<input id="sexSHOW" type="hidden" value="${enrollmentstudent.sex}">
<input id="joinYearSHOW" type="hidden" value="${enrollmentstudent.joinYear}">
<input id="joinMonthSHOW" type="hidden" value="${enrollmentstudent.joinMonth}">
<input id="nationSHOW" type="hidden" value="${enrollmentstudent.nation}">
<input id="nationalitySHOW" type="hidden" value="${enrollmentstudent.nationality}">
<input id="studentStatusSHOW" type="hidden" value="${enrollmentstudent.studentStatus}">
<input id="houseProvinceValue" type="hidden" value="${enrollmentstudent.houseProvince}"/>
<input id="houseCityValue" type="hidden" value="${enrollmentstudent.houseCity}"/>
<input id="houseCountyValue" type="hidden" value="${enrollmentstudent.houseCounty}"/>
<input id="departmentsIdValue" type="hidden" value="${enrollmentstudent.departmentsId}"/>
<input id="majorCodeValue" type="hidden" value="${enrollmentstudent.majorCode}"/>
<input id="trainingLevelValue" type="hidden" value="${enrollmentstudent.trainingLevel}"/>
<input id="majorDirectionValue" type="hidden" value="${enrollmentstudent.majorDirection}"/>
<input id="classIdValue" type="hidden" value="${enrollmentstudent.classId}"/>
<input id="politicalStatusSHOW" type="hidden" value="${enrollmentstudent.politicalStatus}"/>


<script>
    $(document).ready(function () {
        $("#hiddenStudentNumber").attr("readonly","readonly").css("background-color","#2c5c82;");
        $("#hiddenName").attr("readonly","readonly").css("background-color","#2c5c82;");
        $("#hiddenIdcard").attr("readonly","readonly").css("background-color","#2c5c82;");
        $("#hiddenSex").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#hiddenNation").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#hiddenNationality").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#hiddenPoliticalStatus").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#joinYear").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#joinMonth").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#hiddenDid").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#hiddenMid").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#hiddenCid").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#hiddenProvince").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#hiddenCity").attr("disabled","disabled").css("background-color","#2c5c82;");
        $("#hiddenCounty").attr("disabled","disabled").css("background-color","#2c5c82;");
        //性别 sex
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'hiddenSex', $("#sexSHOW").val());
        });
        //民族 nation
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
            addOption(data, 'hiddenNation', $("#nationSHOW").val());
        });
        // 国籍 nationality
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GJ", function (data) {
            addOption(data, 'hiddenNationality', $("#nationalitySHOW").val());
        });
        //政治面貌 hiddenPoliticalStatus
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZZMM", function (data) {
            addOption(data, "hiddenPoliticalStatus", $("#politicalStatusSHOW").val());
        });
        //入学年份
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'joinYear',$("#joinYearSHOW").val());
        });
        //入学月份
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YF", function (data) {
            addOption(data, 'joinMonth',$("#joinMonthSHOW").val());
        });
        //系部回显
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 "
            },
            function (data) {
                addOption(data, "hiddenDid",$("#departmentsIdValue").val());
            });
        //专业回显
       $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " major_code || ',' || major_direction  || ',' || training_level",
                text: " major_name ||  '--' || FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') ",
                tableName: "T_XG_MAJOR",
                where: "",
                orderby: ""
            },
            function (data) {
                var detailVar=$("#majorCodeValue").val()+","+$("#majorDirectionValue").val()+","+$("#trainingLevelValue").val();
                addOption(data, "hiddenMid",detailVar);
            });
        //班级回显
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: "class_id",
                text: "class_name ",
                tableName: "T_XG_CLASS",
                where: "",
                orderby: ""
            },
            function (data) {
                addOption(data, "hiddenCid",$("#classIdValue").val());
            });
        //省份回显
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " name ",
                tableName: "T_SYS_ADMINISTRATIVE_DIVISIONS ",
                where: " WHERE valid_flag = '1' and  type = '1' ",
                orderby: " order by show_order ",
            },
            function (data) {
                addOption(data, "hiddenProvince",$("#houseProvinceValue").val());
            });
        //市回显
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " name ",
                tableName: "T_SYS_ADMINISTRATIVE_DIVISIONS ",
                where: " WHERE valid_flag = '1' and  type = '2' ",
                orderby: " order by show_order ",
            },
            function (data) {
                addOption(data, "hiddenCity",$("#houseCityValue").val());
            });
        //县回显
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " name ",
                tableName: "T_SYS_ADMINISTRATIVE_DIVISIONS ",
                where: " WHERE valid_flag = '1' and  type = '3' ",
                orderby: " order by show_order ",
            },
            function (data) {
                addOption(data, "hiddenCounty",$("#houseCountyValue").val());
            });

    })

</script>

<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>