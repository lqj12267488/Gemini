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
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        学生姓名
                    </div>
                    <div class="col-md-4">
                        <input id="name" type="text" value="${student.name}"/>
                    </div>
                    <div class="col-md-2 tar">
                        性别
                    </div>
                    <div class="col-md-4">
                        <select id="sex" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar" id="idcardAlert">
                        身份证号
                    </div>
                    <div class="col-md-4">
                        <input id="idcard" type="text" value="${student.idcard}"/>
                    </div>
                    <div class="col-md-2 tar">
                        出生日期
                    </div>
                    <div class="col-md-4">
                        <input id="birth" type="date" value="${student.birthday}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        入学年份
                    </div>
                    <div class="col-md-4">
                        <select id="joinY"  class="js-example-basic-single"/>
                    </div>
                    <div class="col-md-2 tar">
                        入学月份
                    </div>
                    <div class="col-md-4">
                        <select id="joinM"  class="js-example-basic-single"/>
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
                        备注
                    </div>
                    <div class="col-md-4">
                        <input id="remark" name="remark" value="${student.remark}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveClass()">保存</button>
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
<script>
    $(document).ready(function () {
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
            addOption(data, 'joinM', $("#month").val());
        });
        //入学年份
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'joinY', $("#year").val());
        });

    })

    $("#idcard").blur(function(){
        if($("#idcard").val()!=""){
            $.post("/student/checkIdCard?idcard="+$("#idcard").val(), function (data) {
                if($("#studentId").val() == ""){
                    if(data.status >0){
                        $("#idcardAlert").html('<a class="styleRed">您录入的身份证号已存在</a>');
                    }else{
                        $("#idcardAlert").html('');
                    }
                }else {
                    if(data.status >1){
                        $("#idcardAlert").html('<a class="styleRed">您录入的身份证号已存在</a>');
                    }else{
                        $("#idcardAlert").html('');
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
        var source = $("#source option:selected").val();
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
        var joinMonth= $("#joinM option:selected").val();

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
        if(reg.test($("#idcard").val()) === false)
        {
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

        /*
         if ($("#studentNumber").val() == "") {
         alert("请填写学籍号");
         return;
         }
         if ($("#nation option:selected").val() == "") {
         alert("请填写民族");
         return;
         }
         if ($("#address").val() == "") {
         alert("请填写住址");
         return;
         }
         if ($("#housePlace").val() == "") {
         alert("请填写户口所在地");
         return;
         }
         if ($("#houseProvince").val() == "") {
         alert("请填写户籍省");
         return;
         }
         if ($("#houseCity option:selected").val() == "") {
         alert("请填写户籍市");
         return;
         }
         if ($("#houseCounty").val() == "") {
         alert("请填写户籍县");
         return;
         }
         if ($("#politicalStatus").val() == "") {
         alert("请填写政治面貌");
         return;
         }
         */
        if ($("#homePhone").val() != "") {
            var telNum = /^1\d{10}$/;
            if ( telNum.test($("#homePhone").val()) === false ) {
                swal({
                    title: "家庭电话不正确!",
                    type: "info"
                });
                return;
            }
//            alert("请填写家庭电话");
//            return;
        }
        if ($("#tel").val() != "") {
            var phoneNum = /^1\d{10}$/;
            if (phoneNum.test($("#tel").val()) === false ) {
                swal({
                    title: "手机号码不正确!",
                    type: "info"
                });
                return;
            }
//            alert("请填写手机");
//            return;
        }

        if($("a").hasClass("styleRed")){
            swal({
                title: "您填写的身份证号已存在!",
                type: "info"
            });
            return;
        }

        var studentStatus ="";
        if( $("#studentStatusSHOW").val()=="") {
            studentStatus = $("#studentStatus option:selected").val();
        }else{
            studentStatus = $("#studentStatusvalue").val();
        }
        $.post("<%=request.getContextPath()%>/student/savaStudent", {
            classId: $("#classValue").val(),
            studentId: $("#studentId").val(),
            householdRegisterType: houseType,
            addressProvince: nowProvince,
            addressCity: nowCity,
            addressCounty: nowCounty,
            teachingPlace:teachingPlace,
            remark:remark,
            graduatedSchool:graduatedSchool,
            grantsFlag:grants,
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
            studentStatus: studentStatus

        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                //studentTable.ajax.reload();
            }
        })
    }

</script>
<style>
    .talign{
        text-align: left
    }
    .styleRed{
        color:red!important;
    }
</style>