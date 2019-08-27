<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 1200px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">修改</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>姓名
                    </div>
                    <div class="col-md-4">
                        <input id="name" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${emp.name}"
                               class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        曾用名
                    </div>
                    <div class="col-md-4">
                        <input id="usedName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${emp.usedName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>证件类型
                    </div>
                    <div class="col-md-4">
                        <select id="idType" class="js-example-basic-single" disabled="true"></select>
                    </div>
                    <div class="col-md-2 tar" id="idTypeCode">
                        <span class="iconBtx">*</span>证件号
                    </div>
                    <div class="col-md-4">
                        <input id="idCard" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${emp.idCard}"
                               class="validate[required,minSize[5],maxSize[10]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        民族
                    </div>
                    <div class="col-md-4">
                        <select id="nation" class="js-example-basic-single"></select>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>性别
                    </div>
                    <div class="col-md-4">
                        <select id="sex" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>出生日期
                    </div>
                    <div class="col-md-4">
                        <input id="birthday" type="date" value="${emp.birthday}"/>
                    </div>
                    <div class="col-md-2 tar">
                        地址
                    </div>
                    <div class="col-md-4">
                        <input id="address" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${emp.address}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>联系方式
                    </div>
                    <div class="col-md-4">
                        <input id="tel" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${emp.tel}"/>
                    </div>
                    <div class="col-md-2 tar">
                        国籍
                    </div>
                    <div class="col-md-4">
                        <select id="nationality" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>教职工编号
                    </div>
                    <div class="col-md-4">
                        <input id="staffId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${emp.staffId}"/>
                    </div>
                    <div class="col-md-2 tar">
                        出生地
                    </div>
                    <div class="col-md-4">
                        <input id="birthPlace" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${emp.birthPlace}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        籍贯省
                    </div>
                    <div class="col-md-4">
                        <select id="nativePlaceProvince" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        籍贯市
                    </div>
                    <div class="col-md-4">
                        <select id="nativePlaceCity" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        籍贯县(区)
                    </div>
                    <div class="col-md-4">
                        <select id="nativePlaceCounty" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        政治面貌
                    </div>
                    <div class="col-md-4">
                        <select id="politicalStatus" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        婚姻状况
                    </div>
                    <div class="col-md-4">
                        <select id="maritalStatus" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        健康状况
                    </div>
                    <div class="col-md-4">
                        <select id="healthStatus" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>参加工作时间
                    </div>
                    <div class="col-md-4">
                        <input id="workTime" type="date" value="${emp.workTime}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>来校时间
                    </div>
                    <div class="col-md-4">
                        <input id="toSchoolTime" type="date" value="${emp.toSchoolTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        教职工所属
                    </div>
                    <div class="col-md-4">
                        <select id="staffBelongs" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        教职工来源
                    </div>
                    <div class="col-md-4">
                        <select id="staffSource" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        教职工类别
                    </div>
                    <div class="col-md-4">
                        <select id="staffType" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        是否在编
                    </div>
                    <div class="col-md-4">
                        <select id="staffFlag" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        签订合同情况
                    </div>
                    <div class="col-md-4">
                        <select id="contractType" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>人员状态
                    </div>
                    <div class="col-md-4">
                        <select id="staffStatus" class="js-example-basic-single" disabled></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        用人形式
                    </div>
                    <div class="col-md-4">
                        <select id="employeForm" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        信息技术应用能力
                    </div>
                    <div class="col-md-4">
                        <select id="technicalSkills" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        是否双师型教师
                    </div>
                    <div class="col-md-4">
                        <select id="doubleTypeFlag" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        是否具备职业技能等级证书
                    </div>
                    <div class="col-md-4">
                        <select id="credentialsFlag" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        是否是特级教师
                    </div>
                    <div class="col-md-4">
                        <select id="stuntTeacherFlag" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        企业工作(实践)时长
                    </div>
                    <div class="col-md-4">
                        <select id="workYear" class="js-example-basic-single"></select>
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
        if ($("#idCard").val() == "" || $("#idCard").val() == null) {
            swal({
                title: "请填写身份证号码",
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
        if ($("#sex option:selected").val() == "" || $("#sex option:selected").val() == null) {
            swal({
                title: "请选择人员性别",
                type: "info"
            });
            //alert("请选择人员性别");
            return;
        }
        if ($("#birthday").val() == "" || $("#birthday").val() == null) {
            swal({
                title: "请选择人员出生日期",
                type: "info"
            });
            return;
        }
        var date = new Date();
        var nowDate = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
        if (nowDate <= $("#birthday").val()) {
            swal({title: "出生日期应早于当前日期", type: "info"});
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

            var phoneNum = /^1\d{10}$/;
            var telNum = /^0\d{2,3}-[1-9]\d{6,7}$/;
            if (phoneNum.test($("#tel").val()) === false && telNum.test($("#tel").val()) === false) {
                swal({
                    title: "联系方式电话不正确",
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
        var workTime = $("#workTime").val();
        var toSchoolTime = $("#toSchoolTime").val();
        if (workTime == "") {
            swal({
                title: "请选择参加工作时间",
                type: "info"
            });
            return;
        }
        if (toSchoolTime == "") {
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
        $.post("<%=request.getContextPath()%>/emp/updateEmp", {
            personId: $("#personId").val(),
            name: $("#name").val(),
            idCard: $("#idCard").val(),
            nation: $("#nation option:selected").val(),
            sex: $("#sex option:selected").val(),
            birthday: $("#birthday").val(),
            address: $("#address").val(),
            tel: $("#tel").val(),
            nationality: $("#nationality option:selected").val(),
            staffId: $("#staffId").val(),
            usedName: $("#usedName").val(),
            idType: $("#idType option:selected").val(),
            nativePlaceProvince: $("#nativePlaceProvince option:selected").val(),
            nativePlaceCity: $("#nativePlaceCity option:selected").val(),
            nativePlaceCounty: $("#nativePlaceCounty option:selected").val(),
            birthPlace: $("#birthPlace").val(),
            politicalStatus: $("#politicalStatus option:selected").val(),
            maritalStatus: $("#maritalStatus option:selected").val(),
            healthStatus: $("#healthStatus option:selected").val(),
            workTime: workTime,
            toSchoolTime: toSchoolTime,
            staffSource: $("#staffSource option:selected").val(),
            staffType: $("#staffType option:selected").val(),
            staffFlag: $("#staffFlag option:selected").val(),
            employeForm: $("#employeForm option:selected").val(),
            contractType: $("#contractType option:selected").val(),
            technicalSkills: $("#technicalSkills option:selected").val(),
            doubleTypeFlag: $("#doubleTypeFlag option:selected").val(),
            credentialsFlag: $("#credentialsFlag option:selected").val(),
            stuntTeacherFlag: $("#stuntTeacherFlag option:selected").val(),
            workYear: $("#workYear option:selected").val(),
            staffStatus: $("#staffStatus option:selected").val(),
            staffBelongs: $("#staffBelongs option:selected").val()
        }, function (msg) {
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
        })
    }


</script>