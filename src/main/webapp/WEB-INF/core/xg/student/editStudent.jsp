<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 1200px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
            <input id="classValue" type="hidden" value="${classId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div>
                <div class="form-row">
                    <div class="col-md-6 tar">
                        <div class="form-row">
                            <div class="col-md-4 tar">
                                <span class="iconBtx">*</span> 学生姓名
                            </div>
                            <div class="col-md-8">
                                <input id="name" type="text" value="${student.name}"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4 tar">
                                <span class="iconBtx">*</span> 性别
                            </div>
                            <div class="col-md-8">
                                <select id="sex" class="js-example-basic-single"></select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4  tar" id="idcardAlert">
                                <span class="iconBtx">*</span> 身份证号
                            </div>
                            <div class="col-md-8">
                                <input id="idcard" type="text"
                                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                       maxlength="30" placeholder="请输入身份证号" value="${student.idcard}"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4 tar">
                                <span class="iconBtx">*</span> 出生日期
                            </div>
                            <div class="col-md-8">
                                <input id="birth" type="date" value="${student.birthday}"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div style="float: right;width: 354px;height: 150px;">
                            <div style="width: 218px;height: 150px;margin-top: -4px;">
                                <img id="photo"
                                     style="border: 1px dashed #ffffff;width: 136px;height: 172px;margin-top: 2px;margin-left: 58px"
                                     src="<%=request.getContextPath()%>${student.photo}">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 入学年份
                    </div>
                    <div class="col-md-4">
                        <select id="joinY" class="js-example-basic-single"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 入学月份
                    </div>
                    <div class="col-md-4">
                        <select id="joinM" class="js-example-basic-single"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar" id="studentNumberAlert">
                        学籍号
                    </div>
                    <div class="col-md-4">
                        <input id="studentNumber" type="text" value="${student.studentNumber}"/>
                    </div>
                    <div class="col-md-2 tar">
                        学籍状态
                    </div>
                    <div class="col-md-4" id="studentStatusDIV">
                        <select id="studentStatus" class="js-example-basic-single"></select>
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
                        国籍
                    </div>
                    <div class="col-md-4">
                        <select id="nationality" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        政治面貌
                    </div>
                    <div class="col-md-4">
                        <select id="politicalStatus" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        户籍性质
                    </div>
                    <div class="col-md-4">
                        <select id="houseType"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        户籍省
                    </div>
                    <div class="col-md-4">
                        <select id="houseProvince" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        现家庭所在省
                    </div>
                    <div class="col-md-4">
                        <select id="nowProvince" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        户籍市
                    </div>
                    <div class="col-md-4">
                        <select id="houseCity" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        现家庭所在市
                    </div>
                    <div class="col-md-4">
                        <select id="nowCity" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        户籍县
                    </div>
                    <div class="col-md-4">
                        <select id="houseCounty" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        现家庭所在县
                    </div>
                    <div class="col-md-4">
                        <select id="nowCounty" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        户籍详细地址
                    </div>
                    <div class="col-md-4">
                        <input id="housePlace" type="text" value="${student.householdRegisterPlace}"/>
                    </div>
                    <div class="col-md-2 tar">
                        现家庭住址
                    </div>
                    <div class="col-md-4">
                        <input id="address" type="text" value="${student.address}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        学生类型
                    </div>
                    <div class="col-md-4">
                        <select id="type" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        生源类型
                    </div>
                    <div class="col-md-4">
                        <select id="source" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        是否低保
                    </div>
                    <div class="col-md-4">
                        <select id="allowances" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        是否享受国家助学金
                    </div>
                    <div class="col-md-4">
                        <select id="grants" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        教学点名称
                    </div>
                    <div class="col-md-4">
                        <input id="teachingPlace" type="text" value="${student.teachingPlace}"/>
                    </div>
                    <div class="col-md-2 tar">
                        毕业学校
                    </div>
                    <div class="col-md-4">
                        <input id="graduatedSchool" type="text" value="${student.graduatedSchool}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        家庭电话
                    </div>
                    <div class="col-md-4">
                        <input id="homePhone" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${student.homePhone}"/>
                    </div>
                    <div class="col-md-2 tar">
                        手机
                    </div>
                    <div class="col-md-4">
                        <input id="tel" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${student.tel}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        港澳台侨胞
                    </div>
                    <div class="col-md-4">
                        <select id="overseas" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        学习形式
                    </div>
                    <div class="col-md-4">
                        <select id="studyModeDz" name="remark" value=""></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        考生号
                    </div>
                    <div class="col-md-4">
                        <input id="candidateNumberDz" class="js-example-basic-single"
                               value="${student.candidateNumberDz}"></input>
                    </div>
                    <div class="col-md-2 tar">
                        备注
                    </div>
                    <div class="col-md-4">
                        <input id="remark" name="remark" value="${student.remark}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        总分
                    </div>
                    <div class="col-md-4">
                        <input id="totalPoints" class="js-example-basic-single" value="${student.totalPoints}"></input>
                    </div>

                    <div class="col-md-2 tar">
                        招生方式
                    </div>
                    <div class="col-md-4">
                        <select id="admissionsWaySel" class="js-example-basic-single" value=""></select>
                    </div>

                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        来自军队
                    </div>
                    <div class="col-md-4">
                        <select id="fromArmySel" class="js-example-basic-single" value=""></select>
                    </div>

                    <div class="col-md-2 tar">
                        是否常住户口在农村
                    </div>
                    <div class="col-md-4">
                        <select id="ruralHouseholdRegistratioSel" class="js-example-basic-single" value=""></select>
                    </div>

                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        是否订单（定向）培养
                    </div>
                    <div class="col-md-4">
                        <select id="orderTrainingSel" class="js-example-basic-single" value=""></select>
                    </div>

                    <div class="col-md-2 tar">
                        是否建档立卡贫困家庭
                    </div>
                    <div class="col-md-4">
                        <select id="documentaryLikaPoorFamilieSel" class="js-example-basic-single" value=""></select>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                    学生是否在职
                    </div>
                    <div class="col-md-4">
                        <select id="duringEmploymentSel" class="js-example-basic-single" value=""></select>
                    </div>
                    <div class="col-md-2 tar">
                        入学总分
                    </div>
                    <div class="col-md-4">
                        <input id="totalEnrollmentScore" class="js-example-basic-single" value="${student.totalEnrollmentScore}"></input>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        入学形式
                    </div>
                    <div class="col-md-4">
                        <select id="enSchType" class="js-example-basic-single" value=""></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
           <%-- <button type="button" class="btn btn-success btn-clean" id="saveBtn1" onclick="testEvent()">读卡</button>--%>
            <button type="button" class="btn btn-success btn-clean" id="saveBtn" onclick="saveClass()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<input id="studentId" type="hidden" value="${student.studentId}">
<input id="sexSHOW" type="hidden" value="${student.sex}">
<input id="nationSHOW" type="hidden" value="${student.nation}">
<input id="nationalitySHOW" type="hidden" value="${student.nationality}">
<input id="studentStatusSHOW" type="hidden" value="${student.studentStatus}">
<input id="houseProvinceValue" type="hidden" value="${student.houseProvince}"/>
<input id="houseCityValue" type="hidden" value="${student.houseCity}"/>
<input id="houseCountyValue" type="hidden" value="${student.houseCounty}"/>
<input id="politicalStatusSHOW" type="hidden" value="${student.politicalStatus}"/>
<input id="householdRegisterType" type="hidden" value="${student.householdRegisterType}"/>
<input id="addressProvince" type="hidden" value="${student.addressProvince}"/>
<input id="addressCity" type="hidden" value="${student.addressCity}"/>
<input id="addressCounty" type="hidden" value="${student.addressCounty}"/>
<input id="allowancesFlag" type="hidden" value="${student.allowancesFlag}"/>
<input id="grantsFlag" type="hidden" value="${student.grantsFlag}"/>
<input id="overseasChinese" type="hidden" value="${student.overseasChinese}"/>
<input id="studentSource" type="hidden" value="${student.studentSource}"/>
<input id="studentType" type="hidden" value="${student.studentType}"/>
<input id="year" type="hidden" value="${student.joinYear}"/>
<input id="month" type="hidden" value="${student.joinMonth}"/>
<input id="fromArmy" type="hidden" value="${student.fromArmy}"/>
<input id="ruralHouseholdRegistratio" type="hidden" value="${student.ruralHouseholdRegistratio}"/>
<input id="orderTraining" type="hidden" value="${student.orderTraining}"/>
<input id="documentaryLikaPoorFamilie" type="hidden" value="${student.documentaryLikaPoorFamilie}"/>
<input id="duringEmployment" type="hidden" value="${student.duringEmployment}">
<object id="plugin0" type="application/x-syncard" width="0" height="0">
    <param name="onload" value="pluginLoaded"/>
</object>
<script>

    var img;

    function plugin0() {
        return document.getElementById('plugin0');
    }

    plugin = plugin0;

    function addEvent(obj, name, func) {
        if (obj.attachEvent) {
            obj.attachEvent("on" + name, func);
        } else {
            obj.addEventListener(name, func, false);
        }
    }

   /* function testEvent() {
        plugin().SetReadType(0);
        plugin().ReadCard();
        //存参
        if (plugin().Name != null && plugin().Name != undefined && plugin().Name != "") {
            $("#name").val(plugin().Name)
            $("#idType").val("1")
            $("#idcard").val(plugin().CardNo)
            $("#sex").val(plugin().Sex)
            $("#nation").val(plugin().Nation)
            var birthday = plugin().Born
            $("#birth").val(birthday.substring(0, 4) + "-" + birthday.substring(4, 6) + "-" + birthday.substring(6, 8))
            $("#photo").attr("src", "data:image/jpeg;base64," + plugin().Base64Photo)
            $("#housePlace").val(plugin().Address)
            img = plugin().Base64Photo.replace("data:image/Jpeg;base64,", "");
        }
        /!*var sex1 = plugin().Sex + "/" + plugin().SexL;
        var myElement1 = document.getElementById('ts101');
        myElement1.innerText = myElement1.textContent = sex1;
        var nation1 = plugin().Nation + "/" + plugin().NationL;
        var myElement2 = document.getElementById('ts201');
        myElement2.innerText = myElement2.textContent = nation1;
        var born1 = plugin().Born + "/" + plugin().BornL;
        var myElement3 = document.getElementById('ts301');
        myElement3.innerText = myElement3.textContent = born1;
        var address1 = plugin().Address;
        var myElement4 = document.getElementById('ts401');
        myElement4.innerText = myElement4.textContent = address1;
        var cardno1 = plugin().CardNo;
        var myElement5 = document.getElementById('ts501');
        myElement5.innerText = myElement5.textContent = cardno1;
        var police1 = plugin().Police;
        var myElement6 = document.getElementById('ts601');
        myElement6.innerText = myElement6.textContent = police1;
        var ustart1 = plugin().UserLifeB;
        var myElement7 = document.getElementById('ts701');
        myElement7.innerText = myElement7.textContent = ustart1;
        var uend1 = plugin().UserLifeE;
        var myElement8 = document.getElementById('ts801');
        myElement8.innerText = myElement8.textContent = uend1;
        var photoname1 = plugin().PhotoName;
        var myElement9 = document.getElementById('ts901');
        myElement9.innerText = myElement9.textContent = photoname1;
        var photobase = plugin().Base64Photo;
        var myElement10 = document.getElementById("image");
        myElement10.src = "data:image/jpeg;base64," + photobase;*!/


        /!*		    var state = plugin().NameL;
                    var myElement = document.getElementById('ts1001');
                    myElement.innerText = myElement.textContent = state;
        *!/
    }*/

    function pluginLoaded() {
        var CardState;
        PhotoSave();
        //开启自动读卡
        //AutoRead();
        addEvent(plugin(), 'OnStateChange', function (State) {
            CardState = plugin().State;
            if (CardState == 2) {
                $("#name").val(plugin().Name)
                /*myElement.innerText = myElement.textContent = namea1;
                var sex1 = plugin().Sex + "/" + plugin().SexL;
                var myElement1 = document.getElementById('ts101');
                myElement1.innerText = myElement1.textContent = sex1;
                var nation1 = plugin().Nation + "/" + plugin().NationL;
                var myElement2 = document.getElementById('ts201');
                myElement2.innerText = myElement2.textContent = nation1;
                var born1 = plugin().Born + "/" + plugin().BornL;
                var myElement3 = document.getElementById('ts301');
                myElement3.innerText = myElement3.textContent = born1;
                var address1 = plugin().Address;
                var myElement4 = document.getElementById('ts401');
                myElement4.innerText = myElement4.textContent = address1;
                var cardno1 = plugin().CardNo;
                var myElement5 = document.getElementById('ts501');
                myElement5.innerText = myElement5.textContent = cardno1;
                var police1 = plugin().Police;
                var myElement6 = document.getElementById('ts601');
                myElement6.innerText = myElement6.textContent = police1;
                var ustart1 = plugin().UserLifeB;
                var myElement7 = document.getElementById('ts701');
                myElement7.innerText = myElement7.textContent = ustart1;
                var uend1 = plugin().UserLifeE;
                var myElement8 = document.getElementById('ts801');
                myElement8.innerText = myElement8.textContent = uend1;
                var photoname1 = plugin().PhotoName;
                var myElement9 = document.getElementById('ts901');
                myElement9.innerText = myElement9.textContent = photoname1;
                var photobase = plugin().Base64Photo;
                var myElement10 = document.getElementById("image");
                myElement10.src = "data:image/jpeg;base64," + photobase;*/
                plugin().State = 0;// State=2代表读卡成功，由于不知道处理事件需要多长时间，因此成功之后
                                   // 就不再读卡，调用程序处理完成之后可以将State属性修改为0，插件将开始自动读卡
            }
        });
    }

    function AutoRead() {
        plugin().State = 0;
        plugin().SetReadType(1);
    }

    function StopAutoRead() {
        plugin().SetReadType(0);
    }

    function PhotoSave() {
        plugin().SetPhotoPath(2, "C:\\Users\\Public\\Documents");
    }
</script>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

        //入学形式
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=RXXS", function (data) {
            addOption(data, "enSchType", '${student.enSchType}');
        });

        //政治面貌
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZZMM", function (data) {
            addOption(data, "politicalStatus", $("#politicalStatusSHOW").val());
        });
        //户籍性质
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=HJXZ", function (data) {
            addOption(data, "houseType", $("#householdRegisterType").val());
        });
        //是否低保
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, "allowances", $("#allowancesFlag").val());
        });
        //是否享受国家助学金
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, "grants", $("#grantsFlag").val());
        });
        //学生类型
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSLX", function (data) {
            addOption(data, "type", $("#studentType").val());
        });
        //生源类别
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSLY", function (data) {
            addOption(data, "source", $("#studentSource").val());
        });

        //性别
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'sex', $("#sexSHOW").val());
        });
        //民族
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
            addOption(data, 'nation', $("#nationSHOW").val());
        });
        // 国籍
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GJ", function (data) {
            addOption(data, 'nationality', $("#nationalitySHOW").val());
        });
        //港澳台侨胞
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GATQB", function (data) {
            addOption(data, 'overseas', $("#overseasChinese").val());
        });
        //入学月份
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YF", function (data) {
            /*var month = '';
            if ($("#month").val().substring(0, 1) == '0') {
                month = $("#month").val().substring(1, 2)
            }
            addOption(data, 'joinM', month);*/
            addOption(data, 'joinM', $("#month").val());
        });

        //入学年份
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'joinY', $("#year").val());
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXXS", function (data) {
            addOption(data, 'studyModeDz', "${student.learnMode}");
        });
        //招生方式
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZSFS", function (data) {
            addOption(data, 'admissionsWaySel', "${student.admissionsWay}");
        });
        //来自军队
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=LZJD", function (data) {
            addOption(data, 'fromArmySel', $("#fromArmy").val());
        });
        //是否常住户口在农村
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'ruralHouseholdRegistratioSel', $("#ruralHouseholdRegistratio").val());
        });
        //是否订单（定向）培养
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'orderTrainingSel', $("#orderTraining").val());
        });
        //是否建档立卡贫困家庭
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'documentaryLikaPoorFamilieSel', $("#documentaryLikaPoorFamilie").val());
        });

        //是否在职
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'duringEmploymentSel', $("#duringEmployment").val());
        });
        var path = "<%=request.getContextPath()%>";
        addAdministrativeDivisions("houseProvince", $("#houseProvinceValue").val(),
            "houseCity", $("#houseCityValue").val(),
            "houseCounty", $("#houseCountyValue").val(), path);

        addAdministrativeDivisions("nowProvince", $("#addressProvince").val(),
            "nowCity", $("#addressCity").val(),
            "nowCounty", $("#addressCounty").val(), path);
        if ($("#studentId").val() == "") {
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSZT", function (data) {
                addOption(data, 'studentStatus', '1');
            });
        } else {
            $("#studentStatusDIV").html("");
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSZT", function (data) {
                $.each(data, function (index, content) {
                    if (content.id === $("#studentStatusSHOW").val()) {
                        $("#studentStatusDIV").html("<input type='text' readonly value='" + content.text + "' </input>" +
                            "<input type='hidden' id='studentStatusvalue' value='" + content.id + "' </input>");
                    }
                })
            });

        }

        if ($("#studentId").val() != "") {
            $("#idcard").attr("readonly", "readonly");
        }
    })

    $("#idcard").blur(function () {
        if ($("#idcard").val() != "") {
            $.post("<%=request.getContextPath()%>/student/checkIdCard?idcard=" + $("#idcard").val(), function (data) {
                if ($("#studentId").val() == "") {
                    if (data.status > 0) {
                        $("#idcardAlert").html('<a class="styleRed">您录入的身份证号已存在</a>');
                    } else {
                        $("#idcardAlert").html('身份证号');
                    }
                } else {
                    if (data.status > 1) {
                        $("#idcardAlert").html('<a class="styleRed">您录入的身份证号已存在</a>');
                    } else {
                        $("#idcardAlert").html('身份证号');
                    }
                }
            });
        }
    });

    $("#studentNumber").blur(function () {
        if ($("#studentNumber").val() != "") {
            $.post("/student/checkStudentNumber?studentNumber=" + $("#studentNumber").val(), function (data) {
                if ($("#studentId").val() == "") {
                    if (data.status > 0) {
                        $("#studentNumberAlert").html('<a class="styleRed">您录入的学籍号已存在</a>');
                    } else {
                        $("#studentNumberAlert").html('学籍号');
                    }
                } else {
                    if (data.status > 1) {
                        $("#studentNumberAlert").html('<a class="styleRed">您录入的学籍号已存在</a>');
                    } else {
                        $("#studentNumberAlert").html('学籍号');
                    }
                }
            });
        }
    });


    function saveClass() {

        var studentNumber = $("#studentNumber").val();
        var name = $("#name").val();
        var homePhone = $("#homePhone").val();
        var sex = $("#sex option:selected").val();
        var idcard = $("#idcard").val();
        var birth = $("#birth").val();
        var housePlace = $("#housePlace").val();
        var address = $("#address").val();
        var tel = $("#tel").val();
        var remark = $("#remark").val();
        var teachingPlace = $("#teachingPlace").val();
        var graduatedSchool = $("#graduatedSchool").val();
        var overseas = $("#overseas option:selected").val();
        var grants = $("#grants option:selected").val();
        var allowances = $("#allowances option:selected").val();
        var type = $("#type option:selected").val();
        var nationality = $("#nationality option:selected").val();
        var houseProvince = $("#houseProvince option:selected").val();
        var nation = $("#nation option:selected").val();
        var houseCity = $("#houseCity option:selected").val();
        var politicalStatus = $("#politicalStatus option:selected").val();
        var houseCounty = $("#houseCounty option:selected").val();
        var nowProvince = $("#nowProvince option:selected").val();
        var nowCity = $("#nowCity option:selected").val();
        var nowCounty = $("#nowCounty option:selected").val();
        var houseType = $("#houseType option:selected").val();
        var joinYear = $("#joinY option:selected").val();
        var joinMonth = $("#joinM option:selected").val();
        var candidateNumberDz = $("#candidateNumberDz").val();
        var learnMode = $("#studyModeDz").val();
        var totalPoints = $("#totalPoints").val();
        var source = $("#source option:selected").val();
        var fromArmy = $("#fromArmySel option:selected").val();
        var admissionsWay = $("#admissionsWaySel option:selected").val();
        var ruralHouseholdRegistratio = $("#ruralHouseholdRegistratioSel option:selected").val();
        var orderTraining = $("#orderTrainingSel option:selected").val();
        var documentaryLikaPoorFamilie = $("#documentaryLikaPoorFamilieSel option:selected").val();
        var duringEmployment = $("#duringEmploymentSel option:selected").val();
        var totalEnrollmentScore = $("#totalEnrollmentScore").val();
        if ($("#name").val() == "") {
            swal({
                title: "请填写学生姓名!",
                type: "info"
            });
            return;
        }
        if ($("#sex option:selected").val() == "") {
            swal({
                title: "请选择性别!",
                type: "info"
            });
            return;
        }
        if ($("#idcard").val() == "") {
            swal({
                title: "请填写身份证号!",
                type: "info"
            });
            return;
        }
        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if (reg.test($("#idcard").val()) === false) {
            swal({
                title: "身份证输入不合法!",
                type: "info"
            });
            return;
        }
        if ($("#birth").val() == "") {
            swal({
                title: "请填写出生日期!",
                type: "info"
            });
            return;
        }
        if ($("#joinY").val() == "") {
            swal({
                title: "请填写入学年份!",
                type: "info"
            });
            return;
        }
        if ($("#joinM").val() == "") {
            swal({
                title: "请填写入学月份!",
                type: "info"
            });
            return;
        }
        if ($("#homePhone").val() != "") {
            var telNum = /^0\d{2,3}-[1-9]\d{6,7}$/;  ///^1\d{10}$/;
            if (telNum.test($("#homePhone").val()) === false) {
                swal({
                    title: "家庭电话不正确!",
                    type: "info"
                });
                return;
            }
        }
        if ($("#tel").val() != "") {
            var phoneNum = /^1\d{10}$/;
            if (phoneNum.test($("#tel").val()) === false) {
                swal({
                    title: "手机号码不正确!",
                    type: "info"
                });
                return;
            }
        }

        if ($("a").hasClass("styleRed")) {
            swal({
                title: "您填写的身份证号已存在!",
                type: "info"
            });
            return;
        }

        var studentStatus = "";
        if ($("#studentStatusSHOW").val() == "") {
            studentStatus = $("#studentStatus option:selected").val();
        } else {
            studentStatus = $("#studentStatusvalue").val();
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/student/savaStudent", {
            classId: $("#classValue").val(),
            studentId: $("#studentId").val(),
            householdRegisterType: houseType,
            addressProvince: nowProvince,
            addressCity: nowCity,
            addressCounty: nowCounty,
            teachingPlace: teachingPlace,
            remark: remark,
            graduatedSchool: graduatedSchool,
            grantsFlag: grants,
            allowancesFlag: allowances,
            overseasChinese: overseas,
            studentSource: source,
            studentType: type,
            birthday: birth,
            name: name,
            sex: sex,
            idcard: idcard,
            joinYear: joinYear,
            joinMonth: joinMonth,
            studentNumber: studentNumber,
            nationality: nationality,
            nation: nation,
            address: address,
            householdRegisterPlace: housePlace,
            houseProvince: houseProvince,
            houseCity: houseCity,
            houseCounty: houseCounty,
            politicalStatus: politicalStatus,
            homePhone: homePhone,
            tel: tel,
            studentStatus: studentStatus,
            img: img,
            candidateNumberDz: candidateNumberDz,
            learnMode: learnMode,
            totalPoints: totalPoints,
            fromArmy: fromArmy,
            admissionsWay: admissionsWay,
            ruralHouseholdRegistratio: ruralHouseholdRegistratio,
            orderTraining: orderTraining,
            documentaryLikaPoorFamilie: documentaryLikaPoorFamilie,
            duringEmployment: duringEmployment,
            totalEnrollmentScore: totalEnrollmentScore,
            enSchType:$("#enSchType").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#studentGrid').DataTable().ajax.reload();
            }
        })
    }

</script>
<style>
    .talign {
        text-align: left
    }

    .styleRed {
        color: red !important;
    }
</style>