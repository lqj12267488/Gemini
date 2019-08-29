<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
            <div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="name" value="${data.name}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="sex" value="${data.sex}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="nation" value="${data.nation}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="language" value="${data.language}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="idcard" value="${data.idcard}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="birthday" value="${data.birthday}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="departmentsId" value="${data.departmentsId}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="majorCode" value="${data.majorCode}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="province" value="${data.province}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="city" value="${data.city}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="county" value="${data.county}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="registerType" value="${data.registerType}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="registerOrigin" value="${data.registerOrigin}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="examinationCardNumber" value="${data.examinationCardNumber}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="examScore" value="${data.examScore}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="examType" value="${data.examType}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="graduatedSchool" value="${data.graduatedSchool}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="graduationDate" value="${data.graduationDate}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="idcardImg" value="${data.idcardImg}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="examinationImg" value="${data.examinationImg}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="scoreImg" value="${data.scoreImg}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="hukouImg" value="${data.hukouImg}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="graduatedImg" value="${data.graduatedImg}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="fatherTel" value="${data.fatherTel}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="motherTel" value="${data.motherTel}"/>
</div>
</div><div class="form-row">
<div class="col-md-3 tar">
name
</div>
<div class="col-md-9">
<input id="remark" value="${data.remark}"/>
</div>
</div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {

    });


    function save() {
    var id = $("#id").val();
var name = $("#name").val();
var sex = $("#sex").val();
var nation = $("#nation").val();
var language = $("#language").val();
var idcard = $("#idcard").val();
var birthday = $("#birthday").val();
var departmentsId = $("#departmentsId").val();
var majorCode = $("#majorCode").val();
var province = $("#province").val();
var city = $("#city").val();
var county = $("#county").val();
var registerType = $("#registerType").val();
var registerOrigin = $("#registerOrigin").val();
var examinationCardNumber = $("#examinationCardNumber").val();
var examScore = $("#examScore").val();
var examType = $("#examType").val();
var graduatedSchool = $("#graduatedSchool").val();
var graduationDate = $("#graduationDate").val();
var idcardImg = $("#idcardImg").val();
var examinationImg = $("#examinationImg").val();
var scoreImg = $("#scoreImg").val();
var hukouImg = $("#hukouImg").val();
var graduatedImg = $("#graduatedImg").val();
var fatherTel = $("#fatherTel").val();
var motherTel = $("#motherTel").val();
var remark = $("#remark").val();
if (id == "" || id == undefined || id == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (name == "" || name == undefined || name == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (sex == "" || sex == undefined || sex == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (nation == "" || nation == undefined || nation == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (language == "" || language == undefined || language == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (idcard == "" || idcard == undefined || idcard == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (birthday == "" || birthday == undefined || birthday == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (departmentsId == "" || departmentsId == undefined || departmentsId == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (majorCode == "" || majorCode == undefined || majorCode == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (province == "" || province == undefined || province == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (city == "" || city == undefined || city == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (county == "" || county == undefined || county == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (registerType == "" || registerType == undefined || registerType == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (registerOrigin == "" || registerOrigin == undefined || registerOrigin == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (examinationCardNumber == "" || examinationCardNumber == undefined || examinationCardNumber == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (examScore == "" || examScore == undefined || examScore == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (examType == "" || examType == undefined || examType == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (graduatedSchool == "" || graduatedSchool == undefined || graduatedSchool == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (graduationDate == "" || graduationDate == undefined || graduationDate == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (idcardImg == "" || idcardImg == undefined || idcardImg == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (examinationImg == "" || examinationImg == undefined || examinationImg == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (scoreImg == "" || scoreImg == undefined || scoreImg == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (hukouImg == "" || hukouImg == undefined || hukouImg == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (graduatedImg == "" || graduatedImg == undefined || graduatedImg == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (fatherTel == "" || fatherTel == undefined || fatherTel == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (motherTel == "" || motherTel == undefined || motherTel == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}
if (remark == "" || remark == undefined || remark == null) {
	swal({
                	title: "请选择网站类型！",
                	type: "info"
            	});
	return;
}

        $.post("<%=request.getContextPath()%>/onlineregister/saveOnlineRegister", {
        id:id,
name:name,
sex:sex,
nation:nation,
language:language,
idcard:idcard,
birthday:birthday,
departmentsId:departmentsId,
majorCode:majorCode,
province:province,
city:city,
county:county,
registerType:registerType,
registerOrigin:registerOrigin,
examinationCardNumber:examinationCardNumber,
examScore:examScore,
examType:examType,
graduatedSchool:graduatedSchool,
graduationDate:graduationDate,
idcardImg:idcardImg,
examinationImg:examinationImg,
scoreImg:scoreImg,
hukouImg:hukouImg,
graduatedImg:graduatedImg,
fatherTel:fatherTel,
motherTel:motherTel,
remark:remark,
}, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            });
        })
    }
</script>



