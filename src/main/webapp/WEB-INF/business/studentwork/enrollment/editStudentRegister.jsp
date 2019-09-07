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
            <input id="studentId" name="studentId" type="hidden" value="${enrollmentstudent.studentId}">
            <input type="hidden" name="majorCodeShow" id="majorCodeShow" value="${enrollmentstudent.majorCode}">
            <input type="hidden" name="majorDirectionShow" id="majorDirectionShow"
                   value="${enrollmentstudent.majorDirection}">
            <input type="hidden" name="trainingLevelShow" id="trainingLevelShow"
                   value="${enrollmentstudent.trainingLevel}">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-6">
                        <div class="form-row">
                            <div class="col-md-4 tar">
                                <span class="iconBtx">*</span>考生类别
                            </div>
                            <div class="col-md-8">
                                <select id="category"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4 tar">
                                <span class="iconBtx">*</span> 准考证号
                            </div>
                            <div class="col-md-8">
                                <input id="ticketCard" type="text" onblur="checkEnrollmentTicketCard()"
                                       value="${enrollmentstudent.ticketCard}"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4 tar">
                                <span class="iconBtx">*</span>系部
                            </div>
                            <div class="col-md-8">
                                <select id="did"></select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4 tar">
                                <span class="iconBtx">*</span>专业
                            </div>
                            <div class="col-md-8">
                                <select id="mid"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6" style="float: right;width: 354px;height: 150px;">
                        <div style="width: 218px;height: 150px;margin-top: -4px;">
                            <img id="photo" style="border: 1px dashed #ffffff
                            ;width: 136px;height: 172px;margin-top: 2px;margin-left: 58px"
                                 src="<%=request.getContextPath()%>${enrollmentstudent.idCardPhotoUrl}">
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>学生姓名
                    </div>
                    <div class="col-md-4">
                        <input id="name" type="text" value="${enrollmentstudent.name}"/>
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
                        <span class="iconBtx">*</span>学制
                    </div>
                    <div class="col-md-4">
                       <select id="programDuration"   class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>层次
                    </div>
                    <div class="col-md-4">
                        <select id="gradation"    class="js-example-basic-single"></select>
                    </div>
                </div>


                <div class="form-row">
                    <div class="col-md-2 tar" id="idcardAlert">
                        <span class="iconBtx">*</span>身份证号
                    </div>
                    <div class="col-md-4">
                        <input id="idcard" type="text" onblur="checkEnrollmentIdCard()"
                               value="${enrollmentstudent.idcard}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>出生日期
                    </div>
                    <div class="col-md-4">
                        <input id="birth" type="date" value="${enrollmentstudent.birthday}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>入学年份
                    </div>
                    <div class="col-md-4">
                        <input type="text" readonly id="joinYear" name="joinYear"
                               value="${enrollmentstudent.joinYear}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>入学月份
                    </div>
                    <div class="col-md-4">
                        <select id="month" name="month" class="js-example-basic-single"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        学籍状态
                    </div>
                    <div class="col-md-4" id="studentStatusDIV">
                        <input id="studentStatus" readonly name="studentStatus" value="在籍"></input>
                    </div>
                    <div class="col-md-2 tar">
                        学籍号
                    </div>
                    <div class="col-md-4">
                        <input id="studentNumber" type="text" value="${enrollmentstudent.studentNumber}"/>
                    </div>
                </div>


                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 国籍
                    </div>
                    <div class="col-md-4">
                        <select id="nationality" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>户籍省
                    </div>
                    <div class="col-md-4">
                        <select id="houseProvince" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>民族
                    </div>
                    <div class="col-md-4">
                        <select id="nation" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>户籍市
                    </div>
                    <div class="col-md-4">
                        <select id="houseCity" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>政治面貌
                    </div>
                    <div class="col-md-4">
                        <select id="politicalStatus" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>户籍县
                    </div>
                    <div class="col-md-4">
                        <select id="houseCounty" class="js-example-basic-single"></select>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 学生类别
                    </div>
                    <div class="col-md-4">
                        <select id="kind"></select>
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
                        <span class="iconBtx">*</span> 报到状态
                    </div>
                    <div class="col-md-4">
                        <select id="f_reportStatus"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>是否填报志愿
                    </div>
                    <div class="col-md-4">
                        <select id="fill" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        是否住宿
                    </div>
                    <div class="col-md-4">
                        <select id="stay" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        运动服号
                    </div>
                    <div class="col-md-4">
                        <select id="clothes" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        是否特型
                    </div>
                    <div class="col-md-4">
                        <select id="special" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        身高(cm)
                    </div>
                    <div class="col-md-4">
                        <input id="height" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${enrollmentstudent.height}"/>
                    </div>
                    <div class="col-md-2 tar">
                        体重(kg)
                    </div>
                    <div class="col-md-4">
                        <input id="weight" class="js-example-basic-single" value="${enrollmentstudent.weight}"></input>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 是否有毕业证
                    </div>
                    <div class="col-md-4">
                        <select id="finishCard" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        毕业学校
                    </div>
                    <div class="col-md-4">
                        <input id="finishSchool" type="text" value="${enrollmentstudent.finishSchool}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        初/高中班级
                    </div>
                    <div class="col-md-4">
                        <input id="middleClass" type="text" value="${enrollmentstudent.middleClass}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 中/高考成绩
                    </div>
                    <div class="col-md-4">
                        <input id="middleScore" type="text" value="${enrollmentstudent.middleScore}"></input>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        家庭电话
                    </div>
                    <div class="col-md-4">
                        <input id="homePhone" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${enrollmentstudent.homePhone}"/>
                    </div>
                    <div class="col-md-2 tar">
                        手机
                    </div>
                    <div class="col-md-4">
                        <input id="tel" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${enrollmentstudent.tel}"/>
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
                        招生方式
                    </div>
                    <div class="col-md-4">
                        <select id="admissionsWaySel" class="js-example-basic-single" value=""></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        生源类型
                    </div>
                    <div class="col-md-4">
                        <select id="studentSourceSel" class="js-example-basic-single" value=""></select>
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
                        现家庭住址
                    </div>
                    <div class="col-md-10">
                        <input id="address" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${enrollmentstudent.address}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        户口所在地
                    </div>
                    <div class="col-md-10">
                        <input id="housePlace" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${enrollmentstudent.housePlace}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="testEvent()">读卡</button>
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveEnrollmentStudent()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<input id="sexSHOW" type="hidden" value="${enrollmentstudent.sex}">
<input id="joinMonthSHOW" type="hidden" value="${enrollmentstudent.joinMonth}">
<input id="nationSHOW" type="hidden" value="${enrollmentstudent.nation}">
<input id="nationalitySHOW" type="hidden" value="${enrollmentstudent.nationality}">
<input id="studentStatusSHOW" type="hidden" value="${enrollmentstudent.studentStatus}">
<input id="houseProvinceValue" type="hidden" value="${enrollmentstudent.houseProvince}"/>
<input id="houseCityValue" type="hidden" value="${enrollmentstudent.houseCity}"/>
<input id="houseCountyValue" type="hidden" value="${enrollmentstudent.houseCounty}"/>
<input id="departmentsIdValue" type="hidden" value="${enrollmentstudent.departmentsId}"/>
<input id="politicalStatusSHOW" type="hidden" value="${enrollmentstudent.politicalStatus}"/>
<input id="studentCategory" type="text" value="${enrollmentstudent.studentCategory}"/>
<input id="studentKind" type="hidden" value="${enrollmentstudent.studentKind}"/>
<input id="fillStatus" type="hidden" value="${enrollmentstudent.fillStatus}"/>
<input id="clothesNumber" type="hidden" value="${enrollmentstudent.clothesNumber}"/>
<input id="specialStatus" type="hidden" value="${enrollmentstudent.specialStatus}"/>
<input id="finishCardStatus" type="hidden" value="${enrollmentstudent.finishCardStatus}"/>
<input id="stayingStatus" type="hidden" value="${enrollmentstudent.stayingStatus}"/>
<input id="householdRegisterType" type="hidden" value="${enrollmentstudent.householdRegisterType}"/>
<input id="programDurationSHOW" type="hidden" value="${enrollmentstudent.programDuration}"/>
<input id="gradationSHOW" type="hidden" value="${enrollmentstudent.gradation}"/>
<input id="reportStatus" type="hidden" value="${enrollmentstudent.reportStatus}"/>
<input id="fromArmy" type="hidden" value="${student.fromArmy}"/>
<input id="ruralHouseholdRegistratio" type="hidden" value="${student.ruralHouseholdRegistratio}"/>
<input id="orderTraining" type="hidden" value="${student.orderTraining}"/>
<input id="documentaryLikaPoorFamilie" type="hidden" value="${student.documentaryLikaPoorFamilie}"/>
<input id="studentSource" type="hidden" value="${student.studentSource}"/>
<object id="plugin0" type="application/x-syncard" width="0" height="0">
    <param name="onload" value="pluginLoaded"/>
</object>
<script type="text/javascript">
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

    function testEvent() {
        plugin().SetReadType(0);
        plugin().ReadCard();
        //存参
        if (plugin().Name != null && plugin().Name != undefined && plugin().Name != "") {
            $("#name").val(plugin().Name)
            $("#idcard").val(plugin().CardNo)
            $("#sex").val(plugin().Sex)
            $("#nation").val(plugin().Nation)
            var birthday = plugin().Born
            $("#birth").val(birthday.substring(0, 4) + "-" + birthday.substring(4, 6) + "-" + birthday.substring(6, 8))
            $("#photo").attr("src", "data:image/jpeg;base64," + plugin().Base64Photo)
            $("#housePlace").val(plugin().Address)
            img = plugin().Base64Photo.replace("data:image/Jpeg;base64,", "");
        }
        /*var sex1 = plugin().Sex + "/" + plugin().SexL;
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


        /*		    var state = plugin().NameL;
                    var myElement = document.getElementById('ts1001');
                    myElement.innerText = myElement.textContent = state;
        */
    }

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
        var studentId = $("#studentId").val();
        if (studentId == null || studentId == "") {

        } else {
            $("#idcard").attr("readonly", "readonly");
        }

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZZMM", function (data) {
            addOption(data, "politicalStatus", $("#politicalStatusSHOW").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KSLB", function (data) {
            addOption(data, "category", $("#studentCategory").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=HJXZ", function (data) {
            addOption(data, "houseType", $("#householdRegisterType").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BDZT", function (data) {
            addOption(data, "f_reportStatus", $("#reportStatus").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSLB", function (data) {
            addOption(data, "kind", $("#studentKind").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, "fill", $("#fillStatus").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, "stay", $("#stayingStatus").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, "finishCard", $("#finishCardStatus").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, "special", $("#specialStatus").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YFXH", function (data) {
            addOption(data, "clothes", $("#clothesNumber").val());
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
        //生源类别
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSLY", function (data) {
            addOption(data, "studentSourceSel", $("#studentSource").val());
        });


        var did = $("#did option:selected").val();
        var studentId = $("#studentId").val()
        if (did == null || did == undefined) {
            $("#mid").html("<option value=''>请选择系部</option>");
        }
        //系部
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "did", $("#departmentsIdValue").val());
            });
        if (studentId != null) {
            //专业回显
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: "(select distinct major_code || ',' || major_direction  || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1)",
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    var up_major = $("#majorCodeShow").val() + "," + $("#majorDirectionShow").val() + "," + $("#trainingLevelShow").val();
                    addOption(data, "mid", up_major);
                });
        }

     /*   $("#did").change(function () {
            if ($("#did").val() != null) {
                $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: "major_code",
                    text: "major_name",
                    tableName: "T_XG_MAJOR",
                    where: "WHERE departments_id = '" + $("#did").val() + "' ",
                    orderBy: ""
                }, function (data) {
                    addOption(data, 'mid');
                });
            }
        })*/
        $("#did").change(function () {
            var major_sql = "(select distinct major_code || ',' || major_direction  || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if ($("#did option:selected").val() != "") {
                major_sql += " and departments_id ='" + $("#did option:selected").val() + "' ";
            }
            major_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: major_sql,
                    where: " ",
                    orderby: " order by value "

                },
                function (data) {
                    addOption(data, "mid");
                })
        });
        var path = "<%=request.getContextPath()%>";
        //性别 sex
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'sex', $("#sexSHOW").val());
        });
        //民族 nation
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
            addOption(data, 'nation', $("#nationSHOW").val());
        });
        // 国籍 nationality
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GJ", function (data) {
            addOption(data, 'nationality', $("#nationalitySHOW").val());
        });
        //入学月份
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YF", function (data) {
            addOption(data, 'month', $("#joinMonthSHOW").val());
        });

        //学制
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XZ", function (data) {
            addOption(data, 'programDuration', $("#programDurationSHOW").val());
        });
        //层次
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=CC", function (data) {
            addOption(data, 'gradation', $("#gradationSHOW").val());
        });



        addAdministrativeDivisions("houseProvince", $("#houseProvinceValue").val(),
            "houseCity", $("#houseCityValue").val(),
            "houseCounty", $("#houseCountyValue").val(), path);

        if ($("#studentId").val() != "") {
            $("#idcard").attr("readonly", "readonly");
        }
    })


    function checkEnrollmentIdCard() {
        var studentId = $("#studentId").val();
        var idcard = $("#idcard").val();
        if (studentId == null || studentId == "") {
            $.post("<%=request.getContextPath()%>/enrollment/checkEnrollmentIdCard?idcard=" + idcard, function (data) {
                if (data.status == 1) {
                    swal({
                        title: "身份证号已存在!",
                        type: "info"
                    });
                }

            });
        }

    }

    function checkEnrollmentTicketCard() {
        var ticketCard = $("#ticketCard").val();
        var reg1 = /^[0-9]+.?[0-9]*$/;
        if (!reg1.test(ticketCard)) {
            swal({
                title: "准考证号请输入数字!",
                type: "info"
            });
            return;
        }
    }

    function saveEnrollmentStudent() {
        var category = $("#category option:selected").val();
        var ticketCard = $("#ticketCard").val();
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var name = $("#name").val();
        var sex = $("#sex option:selected").val();
        var idcard = $("#idcard").val();
        var birth = $("#birth").val();
        var month = $("#month option:selected").val();
        var studentNumber = $("#studentNumber").val();
        var nationality = $("#nationality option:selected").val();
        var houseProvince = $("#houseProvince option:selected").val();
        var nation = $("#nation option:selected").val();
        var houseCity = $("#houseCity option:selected").val();
        var politicalStatus = $("#politicalStatus option:selected").val();
        var houseCounty = $("#houseCounty option:selected").val();
        var kind = $("#kind option:selected").val();
        var houseType = $("#houseType option:selected").val();
        var reportStatus = $("#f_reportStatus option:selected").val();
        var fill = $("#fill option:selected").val();
        var stay = $("#stay option:selected").val();
        var clothes = $("#clothes option:selected").val();
        var special = $("#special option:selected").val();
        var height = $("#height").val();
        var weight = $("#weight").val();
        var finishCard = $("#finishCard option:selected").val();
        var finishSchool = $("#finishSchool").val();
        var middleClass = $("#middleClass").val();
        var middleScore = $("#middleScore").val();
        var homePhone = $("#homePhone").val();
        var tel = $("#tel").val();
        var address = $("#address").val();
        var housePlace = $("#housePlace").val();
        var programDuration=$("#programDuration option:selected").val();
        var gradation=$("#gradation option:selected").val();
        //专业截串
        var majorCode = mid.split(",")[0];
        var majorDirection = mid.split(",")[1];
        var trainingLevel = mid.split(",")[2];

        var studentSource = $("#studentSourceSel option:selected").val();
        var fromArmy = $("#fromArmySel option:selected").val();
        var admissionsWay = $("#admissionsWaySel option:selected").val();
        var ruralHouseholdRegistratio = $("#ruralHouseholdRegistratioSel option:selected").val();
        var orderTraining = $("#orderTrainingSel option:selected").val();
        var documentaryLikaPoorFamilie = $("#documentaryLikaPoorFamilieSel option:selected").val();
        if (category == "") {
            swal({
                title: "请选择考生类别!",
                type: "info"
            });
            return;
        }
        if (ticketCard == "") {
            swal({
                title: "请填写准考证号!",
                type: "info"
            });
            return;
        }
        if (did == "") {
            swal({
                title: "请选择系部!",
                type: "info"
            });
            return;
        }
        if (mid == "") {
            swal({
                title: "请选择专业!",
                type: "info"
            });
            return;
        }
        if (name == "") {
            swal({
                title: "请填写学生姓名!",
                type: "info"
            });
            return;
        }
        if (sex == "") {
            swal({
                title: "请填写性别!",
                type: "info"
            });
            return;
        }
        if ($("#studentId").val() == null) {
            if (idcard == "") {
                swal({
                    title: "请填写身份证号!",
                    type: "info"
                });
                return;
            } else {
                var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
                if (reg.test(idcard) === false) {
                    swal({
                        title: "身份证号输入不合法!",
                        type: "info"
                    });
                    return;
                }

            }
        }
        if (birth == "") {
            swal({
                title: "请选择出生日期!",
                type: "info"
            });
            return;
        }
        if (month == "") {
            swal({
                title: "请选择入学月份!",
                type: "info"
            });
            return;
        }


        if (nationality == "") {
            swal({
                title: "请选择国籍!",
                type: "info"
            });
            return;
        }
        if (houseProvince == "") {
            swal({
                title: "请选择省份!",
                type: "info"
            });
            return;
        }
        if (nation == "") {
            swal({
                title: "请填写民族!",
                type: "info"
            });
            return;
        }
        if (houseCity == "") {
            swal({
                title: "请选择市!",
                type: "info"
            });
            return;
        }
        if (politicalStatus == "") {
            swal({
                title: "请选择政治面貌!",
                type: "info"
            });
            return;
        }
        if (houseCounty == "") {
            swal({
                title: "请选择县!",
                type: "info"
            });
            return;
        }
        if (kind == "") {
            swal({
                title: "请选择学生类别!",
                type: "info"
            });
            return;
        }

        if (reportStatus === "") {
            swal({
                title: "请选择报到状态!",
                type: "info"
            });
            return;
        }
        if (fill == "") {
            swal({
                title: "请选择是否填报志愿!",
                type: "info"
            });
            return;
        }


        if (finishCard === "") {
            swal({
                title: "请选择是否有毕业证!",
                type: "info"
            });
            return;
        }


        if (middleScore == "") {
            swal({
                title: "请填写中考成绩!",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/enrollment/savaEnrollmentStudent", {
            studentCategory: category,
            finishSchool: finishSchool,
            middleClass: middleClass,
            middleScore: middleScore,
            studentKind: kind,
            ticketCard: ticketCard,
            fillStatus: fill,
            weight: weight,
            height: height,
            clothesNumber: clothes,
            specialStatus: special,
            finishCardStatus: finishCard,
            stayingStatus: stay,
            studentId: $("#studentId").val(),
            birthday: birth,
            name: name,
            sex: sex,
            idcard: idcard,
            householdRegisterType: houseType,
            reportStatus: reportStatus,
            studentNumber: studentNumber,
            nationality: nationality,
            address: address,
            nation: nation,
            departmentsId: did,
            joinMonth: month,
            majorCode: majorCode,
            majorDirection: majorDirection,
            trainingLevel: trainingLevel,
            housePlace: housePlace,
            houseProvince: houseProvince,
            houseCity: houseCity,
            houseCounty: houseCounty,
            politicalStatus: politicalStatus,
            homePhone: homePhone,
            programDuration:programDuration,
            gradation:gradation,
            tel: tel,
            img: img,
            fromArmy: fromArmy,
            admissionsWay: admissionsWay,
            ruralHouseholdRegistratio: ruralHouseholdRegistratio,
            orderTraining: orderTraining,
            documentaryLikaPoorFamilie: documentaryLikaPoorFamilie,
            studentSource: studentSource
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#studentEnrollmentGrid').DataTable().ajax.reload();
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
