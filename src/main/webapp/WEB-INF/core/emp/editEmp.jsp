<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 800px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">修改</h4>
        </div>
        <div class="modal-body clearfix" style="font-size: 15px;">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>姓名
                    </div>
                    <div class="col-md-3">
                        <input id="name" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[20]] form-control" value="${emp.name}"/>
                    </div>
                    <div style="float: right;width: 354px;height: 150px;">
                        <div style="width: 218px;height: 150px;margin-top: -4px;">
                            <img id="photo" style="border: 1px dashed #ffffff
                            ;width: 136px;height: 172px;margin-top: 2px;margin-left: 58px"
                                 src="<%=request.getContextPath()%>/idcardimg/bg.png">
                        </div>
                    </div>

                    <div class="col-md-2 tar" style="margin-top: 2%">
                        岗位
                    </div>
                    <div class="col-md-3" style="margin-top: 2%">
                        <select id="jobSel" class="js-example-basic-single" />
                    </div>

                    <div class="col-md-2 tar" style="margin-top: 2%">
                        <span class="iconBtx">*</span>性别
                    </div>
                    <div class="col-md-3" style="margin-top: 2%">
                        <select id="sex" class="js-example-basic-single"></select>
                    </div>

                    <div class="col-md-2 tar" style="margin-top: 2%">
                        <span class="iconBtx">*</span>入职日期
                    </div>
                    <div class="col-md-3" style="margin-top: 2%">
                        <input id="rz" type="date" class="js-example-basic-single" value="${emp.entryDate}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx"></span>户口所属地区
                    </div>
                    <div class="col-md-3">
                        <select id="permanent_residence_local" type="text"/>
                    </div>

                    <div class="col-md-2 tar">
                        民族
                    </div>
                    <div class="col-md-3">
                        <select id="nation" class="js-example-basic-single"></select>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx"></span>户口所在地
                    </div>
                    <div class="col-md-3">
                        <input id="hkszdqSel" type="text" value="${emp.permanentResidence}"/>
                    </div>
                    <div class="col-md-2 tar">
                        学位
                    </div>
                    <div class="col-md-3">
                        <select id="academic_degree" class="js-example-basic-single"></select>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        婚姻状况
                    </div>
                    <div class="col-md-3">
                        <select id="maritalStatus" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx"></span>出生日期
                    </div>
                    <div class="col-md-3">
                        <input id="birthday" type="date" class="js-example-basic-single" value="${emp.birthday}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        是否政审
                    </div>
                    <div class="col-md-3">
                        <select id="sfzs" class="js-example-basic-single"></select>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>证件类型
                    </div>
                    <div class="col-md-3">
                        <select id="idType" class="js-example-basic-single"></select>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        地址
                    </div>
                    <div class="col-md-3">
                        <input id="address" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${emp.address}"/>
                    </div>
                    <div class="col-md-2 tar" id="idTypeCode">
                        <span class="iconBtx">*</span>证件号
                    </div>
                    <div class="col-md-3" >
                        <input id="idCard" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,minSize[5],maxSize[10]] form-control" value="${emp.idCard}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        政治面貌
                    </div>
                    <div class="col-md-3">
                        <select id="politicalStatus" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>联系方式
                    </div>
                    <div class="col-md-3">
                        <input id="tel" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${emp.tel}"/>
                    </div>
                </div>
                <div class="form-row">

                    <div class="col-md-2 tar">
                        学历
                    </div>
                    <div class="col-md-3">
                        <select id="educational_level" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        教育方式
                    </div>
                    <div class="col-md-3">
                        <select id="education_technique" class="js-example-basic-single"></select>
                    </div>

                </div>
                <div class="form-row">

                    <div class="col-md-2 tar">
                        毕业院校
                    </div>
                    <div class="col-md-3">
                        <input id="graduate_school" class="js-example-basic-single" value="${emp.graduateSchool}"></input>
                    </div>
                    <div class="col-md-2 tar">
                        毕业时间
                    </div>
                    <div class="col-md-3">
                        <input id="graduate_time" class="js-example-basic-single" type="date" value="${emp.graduateTime}"></input>
                    </div>
                </div>
                <div class="form-row">

                    <div class="col-md-2 tar">
                        专业
                    </div>
                    <div class="col-md-3">
                        <input id="majorSel" class="js-example-basic-single" type="text" value="${emp.major}"></input>
                    </div>
                    <div class="col-md-2 tar">
                        职务
                    </div>
                    <div class="col-md-3">
                        <input id="post" class="js-example-basic-single" type="text" value="${emp.post}"></input>
                    </div>
                </div>
                <div class="form-row">

                    <div class="col-md-2 tar">
                        职级
                    </div>
                    <div class="col-md-3">
                        <select id="class_positions" class="js-example-basic-single" type="text"></select>
                    </div>
                    <div class="col-md-2 tar">
                        职称
                    </div>
                    <div class="col-md-3">
                        <input id="positional_titles" class="js-example-basic-single" type="text" value="${emp.positionalTitles}"></input>
                    </div>
                </div>

                <div class="form-row">

                    <div class="col-md-2 tar">
                        职称级别
                    </div>
                    <div class="col-md-3">
                        <select id="positional_level" class="js-example-basic-single" type="text"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>教职工编号
                    </div>
                    <div class="col-md-3">
                        <input id="staffId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${emp.staffId}"/>
                    </div>

                </div>

                <div class="form-row">

                    <div class="col-md-2 tar">
                        曾用名
                    </div>
                    <div class="col-md-3">
                        <input id="usedName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${emp.usedName}"/>
                    </div>
                    <div class="col-md-2 tar">
                        国籍
                    </div>
                    <div class="col-md-3">
                        <select id="nationality" class="js-example-basic-single"></select>
                    </div>

                </div>

                <div class="form-row">

                    <div class="col-md-2 tar">
                        出生地
                    </div>
                    <div class="col-md-3">
                        <input id="birthPlace" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${emp.birthPlace}"/>
                    </div>
                    <div class="col-md-2 tar">
                        籍贯省
                    </div>
                    <div class="col-md-3">
                        <select id="nativePlaceProvince" class="js-example-basic-single">
                        </select>
                    </div>

                </div>

                <div class="form-row">

                    <div class="col-md-2 tar">
                        籍贯市
                    </div>
                    <div class="col-md-3">
                        <select id="nativePlaceCity" class="js-example-basic-single">
                            <option value="">请选择</option>
                        </select>
                    </div>
                    <div class="col-md-2 tar">
                        籍贯县(区)
                    </div>
                    <div class="col-md-3">
                        <select id="nativePlaceCounty" class="js-example-basic-single">
                            <option value="">请选择</option>
                        </select>
                    </div>

                </div>
                <div class="form-row">

                    <div class="col-md-2 tar">
                        健康状况
                    </div>
                    <div class="col-md-3">
                        <select id="healthStatus" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 参加工作时间
                    </div>
                    <div class="col-md-3">
                        <input id="workTime" type="date" value="${emp.workTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>来校时间
                    </div>
                    <div class="col-md-3">
                        <input id="toSchoolTime" type="date" value="${emp.toSchoolTime}"/>
                    </div>
                    <div class="col-md-2 tar">
                        教职工所属
                    </div>
                    <div class="col-md-3">
                        <select id="staffBelongs" class="js-example-basic-single"></select>
                    </div>

                </div>

                <div class="form-row">

                    <div class="col-md-2 tar">
                        教职工来源
                    </div>
                    <div class="col-md-3">
                        <select id="staffSource" class="js-example-basic-single">
                            <option value="">请选择所属</option>
                        </select>
                    </div>
                    <div class="col-md-2 tar">
                        教职工类别
                    </div>
                    <div class="col-md-3">
                        <select id="staffType" class="js-example-basic-single"></select>
                    </div>

                </div>

                <div class="form-row">

                    <div class="col-md-2 tar">
                        是否在编
                    </div>
                    <div class="col-md-3">
                        <select id="staffFlag" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        签订合同情况
                    </div>
                    <div class="col-md-3">
                        <select id="contractType" class="js-example-basic-single"></select>
                    </div>

                </div>

                <div class="form-row">

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>人员状态
                    </div>
                    <div class="col-md-3">
                        <select id="staffStatus" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        用人形式
                    </div>
                    <div class="col-md-3">
                        <select id="employeForm" class="js-example-basic-single"></select>
                    </div>

                </div>
                <div class="form-row">

                    <div class="col-md-2 tar">
                        信息技术应用能力
                    </div>
                    <div class="col-md-3">
                        <select id="technicalSkills" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        是否双师型教师
                    </div>
                    <div class="col-md-3">
                        <select id="doubleTypeFlag" class="js-example-basic-single"></select>
                    </div>

                </div>
                <div class="form-row">

                    <div class="col-md-2 tar">
                        是否具备职业技能等级证书
                    </div>
                    <div class="col-md-3">
                        <select id="credentialsFlag" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        是否是特级教师
                    </div>
                    <div class="col-md-3">
                        <select id="stuntTeacherFlag" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">

                    <div class="col-md-2 tar">
                        企业工作(实践)时长
                    </div>
                    <div class="col-md-3">
                        <select id="workYear" class="js-example-basic-single"></select>
                    </div>

                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        备注
                    </div>
                    <div class="col-md-8">
                    <textarea id="remarkSel" style="height: 100px"
                              type="text" class="validate[required,maxSize[20]] form-control">${emp.remark} </textarea>

                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="updateEmp()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="personId" value="${emp.personId}" hidden>
<input id="nationSHOW" value="${emp.nation}" hidden>
<input id="nativePlaceProvinceSHOW" value="${emp.nativePlaceProvince}" hidden>
<input id="nativePlaceCitySHOW" value="${emp.nativePlaceCity}" hidden>
<input id="nativePlaceCountySHOW" value="${emp.nativePlaceCounty}" hidden>
<input id="nationalitySHOW" value="${emp.nationality}" hidden>
<input id="idTypeSHOW" value="${emp.idType}" hidden>
<input id="politicalStatusSHOW" value="${emp.politicalStatus}" hidden>
<input id="maritalStatusSHOW" value="${emp.maritalStatus}" hidden>
<input id="sexSHOW" value="${emp.sex}" hidden>
<input id="healthStatusSHOW" value="${emp.healthStatus}" hidden>
<input id="staffSourceSHOW" value="${emp.staffSource}" hidden>
<input id="staffTypeSHOW" value="${emp.staffType}" hidden>
<input id="employeFormSHOW" value="${emp.employeForm}" hidden>
<input id="contractTypeSHOW" value="${emp.contractType}" hidden>
<input id="technicalSkillsSHOW" value="${emp.technicalSkills}" hidden>
<input id="workYearSHOW" value="${emp.workYear}" hidden>
<input id="staffStatusSHOW" value="${emp.staffStatus}" hidden>
<input id="staffBelongsSHOW" value="${emp.staffBelongs}" hidden>
<input id="staffFlagSHOW" value="${emp.staffFlag}" hidden>
<input id="doubleTypeFlagSHOW" value="${emp.doubleTypeFlag}" hidden>
<input id="credentialsFlagSHOW" value="${emp.credentialsFlag}" hidden>
<input id="stuntTeacherFlagSHOW" value="${emp.stuntTeacherFlag}" hidden>
<input id="examinePoliticalSHOW" value="${emp.examinePolitical}" hidden>
<input id="educationalLevelSHOW" value="${emp.educationalLevel}" hidden>
<input id="educationTechniqueSHOW" value="${emp.educationTechnique}" hidden>
<input id="jobSHOW" value="${emp.job}" hidden>
<input id="permanentResidenceLocalShow" value="${emp.permanentResidenceLocal}" hidden>
<input id="academicDegreeShow" value="${emp.academicDegree}" hidden>
<input id="classPositionsShow" value="${emp.classPositions}" hidden>
<input id="positionalLevelShow" value="${emp.positionalLevel}" hidden>
<input id="dt" name="startdate"  type="text" hidden value=<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>></input>
<%--<input id="staffIdSHOW" value="${emp.staffId}" hidden>--%>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $("#idType").change(function () {
            if ($("#idType option:selected").val() != "") {
                $("#idTypeCode").html($("<span class='iconBtx'>*</span> "+"#idType option:selected").text() + "号");
            }
        });
        var path = '<%=request.getContextPath()%>';
        addAdministrativeDivisions("nativePlaceProvince", $("#nativePlaceProvinceSHOW").val(),
            "nativePlaceCity", $("#nativePlaceCitySHOW").val(),
            "nativePlaceCounty", $("#nativePlaceCountySHOW").val(), path);
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
            addOption(data, "nation", $("#nationSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GJ", function (data) {
            addOption(data, "nationality", $("#nationalitySHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SFZJLX", function (data) {
            addOption(data, "idType", $("#idTypeSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZZMM", function (data) {
            addOption(data, "politicalStatus", $("#politicalStatusSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=HYZK", function (data) {
            addOption(data, "maritalStatus", $("#maritalStatusSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'sex', $("#sexSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JKZK", function (data) {
            addOption(data, 'healthStatus', $("#healthStatusSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGLB", function (data) {
            addOption(data, 'staffType', $("#staffTypeSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YRXS", function (data) {
            addOption(data, 'employeForm', $("#employeFormSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=QDHTQK", function (data) {
            addOption(data, 'contractType', $("#contractTypeSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXJSYYNL", function (data) {
            addOption(data, 'technicalSkills', $("#technicalSkillsSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=QYGZSC", function (data) {
            addOption(data, 'workYear', $("#workYearSHOW").val());
        });
                $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGZT", function (data) {
                    addOption(data, 'staffStatus',$("#staffStatusSHOW").val());
                });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGSS", function (data) {
            addOption(data, 'staffBelongs', $("#staffBelongsSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'sfzs',$("#examinePoliticalSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=WHCD", function (data) {
            addOption(data, 'educational_level',$("#educationalLevelSHOW").val());
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYFS", function (data) {
            addOption(data, 'education_technique',$("#educationTechniqueSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GW", function (data) {
            addOption(data, 'jobSel',$("#jobSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=HKSSDQ", function (data) {
            addOption(data, 'permanent_residence_local',$("#permanentResidenceLocalShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XW", function (data) {
            addOption(data, 'academic_degree',$("#academicDegreeShow").val());
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZJ", function (data) {
            addOption(data, 'class_positions',$("#classPositionsShow").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZCJB", function (data) {
            addOption(data, 'positional_level',$("#positionalLevelShow").val());
        });
        if (null != $("#staffBelongsSHOW").val() && "" != $("#staffBelongsSHOW").val()) {
            var staffBelongsSHOW = $("#staffBelongsSHOW").val();
            if (staffBelongsSHOW == 1) {
                $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGLY2", function (data) {
                    addOption(data, 'staffSource', $("#staffSourceSHOW").val());
                });
            } else if (staffBelongsSHOW == 2) {
                $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGLY", function (data) {
                    addOption(data, 'staffSource', $("#staffSourceSHOW").val());
                });
            }
        }
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'staffFlag', $("#staffFlagSHOW").val());
            addOption(data, 'doubleTypeFlag', $("#doubleTypeFlagSHOW").val());
            addOption(data, 'credentialsFlag', $("#credentialsFlagSHOW").val());
            addOption(data, 'stuntTeacherFlag', $("#stuntTeacherFlagSHOW").val());
        });

    })

    $("#staffBelongs").change(function () {
        var staffBelongsSHOW = $("#staffBelongs").val();
        /*alert($("#staffBelongs").val());*/
        if (staffBelongsSHOW == 1) {
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGLY2", function (data) {
                addOption(data, 'staffSource');
            });
        } else if (staffBelongsSHOW == 2) {
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGLY", function (data) {
                addOption(data, 'staffSource');
            });
        } else {
            $("#staffSource").val("");
        }
    });


    function updateEmp() {
        if ($("#name").val() == "" || $("#name").val() == null) {
            swal({
                title: "请填写人员姓名",
                type: "info"
            });
            //alert("请填写人员姓名");
            return;
        }
      /*  if ($("#deptId").val() == "" || $("#deptId").val() == null) {
            swal({
                title: "请在左侧选择部门后再进行人员添加",
                type: "info"
            });
            //alert("请在左侧选择部门后再进行人员添加");
            return;
        }*/
        if ($("#sex option:selected").val() == "" || $("#sex option:selected").val() == null) {
            swal({
                title: "请选择人员性别",
                type: "info"
            });
            //alert("请选择人员性别");
            return;
        }
        if ($("#rz").val() == "" || $("#rz").val() == null) {
            swal({
                title: "请选择入职日期",
                type: "info"
            });
            //alert("请选择人员出生日期");
            return;
        }
        if ($("#idType option:selected").val() == "" || $("#idType option:selected").val() == null) {
            swal({
                title: "请选择证件类型",
                type: "info"
            });
            //alert("请选择人员性别");
            return;
        }
        if ($("#idCard").val() == "" || $("#idCard").val() == null) {
            swal({
                title: "请填写证件号码",
                type: "info"
            });
            //alert("请填写身份证号码");
            return;
        }
        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if ($("#idType option:selected").val() == '1' && reg.test($("#idCard").val()) === false) {
            swal({
                title: "身份证输入不合法",
                type: "info"
            });
            //alert("身份证输入不合法");
            return;
        }
        if ($("#tel").val() == "" || $("#tel").val() == null) {
            swal({
                title: "请填写联系方式",
                type: "info"
            });
            return;
        }

        if ($("#tel").val() != "") {
//            alert("请填写联系人电话");
//            return;
            var phoneNum = /^1\d{10}$/;
            var telNum = /^0\d{2,3}-[1-9]\d{6,7}$/ // /^0\d{2,3}-?\d{7,8}$/;
            if (phoneNum.test($("#tel").val()) === false && telNum.test($("#tel").val()) === false) {
                swal({
                    title: "联系人电话不正确",
                    type: "info"
                });
                //alert("联系人电话不正确");
                return;
            }
        }
        if ($("#staffId").val() == "" || $("#staffId").val() == null) {
            swal({
                title: "请填写教职工编号",
                type: "info"
            });
            return;
        }
        var reg = new RegExp("^[0-9]*$");
        if(!reg.test($("#staffId").val())){
            swal({
                title: "教职工编号请填写整数",
                type: "info"
            });
            return;
        }

        var toSchoolTime = new Date($("#toSchoolTime").val()).getTime();
        var workTime = new Date($("#workTime").val()).getTime();

        if (workTime == "" ) {
            swal({
                title: "请选择参加工作时间",
                type: "info"
            });
            return;
        }
        if (toSchoolTime == "" ) {
            swal({
                title: "请选择来校时间",
                type: "info"
            });
            return;
        }
        if (toSchoolTime < workTime) {
            swal({
                title: "参加工作时间不得晚于来校时间",
                type: "info"
            });
            return;
        }
        if ($("#staffStatus").val() == "" || $("#staffStatus").val() == null) {
            swal({
                title: "请选择人员状态",
                type: "info"
            });
            return;
        }
        $("#saveLoadingHeight").css('height','200px');

        showSaveLoading();
        $.ajax({
            url:"<%=request.getContextPath()%>/emp/updateEmp",
            type:"post",
            dataType:"json",
            contentType:'application/json;charset=UTF-8',
            data:
                JSON.stringify({
                    "name": $("#name").val(),
                    "deptId": $("#deptId").val(),
                    "idCard": $("#idCard").val(),
                    "nation": $("#nation option:selected").val(),
                    "sex": $("#sex option:selected").val(),
                    "birthday": $("#birthday").val(),
                    "address": $("#address").val(),
                    "tel": $("#tel").val(),
                    "nationality": $("#nationality option:selected").val(),
                    "staffId": $("#staffId").val(),
                    "usedName": $("#usedName").val(),
                    "idType": $("#idType option:selected").val(),
                    "nativePlaceProvince": $("#nativePlaceProvince option:selected").val(),
                    "nativePlaceCity": $("#nativePlaceCity option:selected").val(),
                    "nativePlaceCounty": $("#nativePlaceCounty option:selected").val(),
                    "birthPlace": $("#birthPlace").val(),
                    "politicalStatus": $("#politicalStatus option:selected").val(),
                    "maritalStatus": $("#maritalStatus option:selected").val(),
                    "healthStatus": $("#healthStatus option:selected").val(),
                    "workTime": workTime,
                    "toSchoolTime": toSchoolTime,
                    "staffSource": $("#staffSource option:selected").val(),
                    "staffType": $("#staffType option:selected").val(),
                    "staffFlag": $("#staffFlag option:selected").val(),
                    "employeForm": $("#employeForm option:selected").val(),
                    "contractType": $("#contractType option:selected").val(),
                    "technicalSkills": $("#technicalSkills option:selected").val(),
                    "doubleTypeFlag": $("#doubleTypeFlag option:selected").val(),
                    "credentialsFlag": $("#credentialsFlag option:selected").val(),
                    "stuntTeacherFlag": $("#stuntTeacherFlag option:selected").val(),
                    "workYear": $("#workYear option:selected").val(),
                    "staffStatus": $("#staffStatus option:selected").val(),
                    "staffBelongs": $("#staffBelongs option:selected").val(),
                    "job": $("#jobSel option:selected").val(),
                    /*"nativePlace": $("#jg").val(),*/
                    "entryDate": $("#rz").val(),
                    "permanentResidence": $("#hkszdqSel").val(),
                    "permanentResidenceLocal": $("#permanent_residence_local option:selected").val(),
                    //levels: $("#levelSel").val(),
                    "examinePolitical": $("#sfzs option:selected").val(),
                    "educationalLevel": $("#educational_level option:selected").val(),
                    "educationTechnique": $("#education_technique option:selected").val(),
                    "graduateSchool": $("#graduate_school").val(),
                    "graduateTime": $("#graduate_time").val(),
                    "major": $("#majorSel").val(),
                    "positionalTitles": $("#positional_titles").val(),
                    "post": $("#post").val(),
                    "positionalLevel":$("#positional_level option:selected").val(),
                    "classPositions":$("#class_positions option:selected").val(),
                    "remark":$("#remarkSel").val(),
                    "academicDegree": $("#academic_degree option:selected").val(),
                    "personId": $("#personId").val(),
                })
            , success: function (msg) {
                hideSaveLoading();
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    //alert(msg.msg);
                    $("#dialog").modal("hide");
                    deptTable.ajax.reload();
                } else {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                }
            }

        })
    }


</script>