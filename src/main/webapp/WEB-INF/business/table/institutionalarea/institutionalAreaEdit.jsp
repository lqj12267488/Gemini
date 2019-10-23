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
            <input id="flag" type="hidden" value="${flag}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>占地面积
                    </div>
                    <div class="col-md-9">
                        <input id="areaCoveredEdit" value="${data.areaCovered}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>绿化用地面积
                    </div>
                    <div class="col-md-9">
                        <input id="greenLandAreaEdit" value="${data.greenLandArea}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>校舍总建筑面积
                    </div>
                    <div class="col-md-9">
                        <input id="buildingAreaEdit" value="${data.buildingArea}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学校产权校舍建筑面积
                    </div>
                    <div class="col-md-9">
                        <input id="schoolPropertyAreaEdit" value="${data.schoolPropertyArea}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>当年新增校舍
                    </div>
                    <div class="col-md-9">
                        <input id="schoolBuildingEdit" value="${data.schoolBuilding}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>非学校产权校舍建筑面积
                    </div>
                    <div class="col-md-9">
                        <input id="wrongSchoolPropertyEdit" value="${data.wrongSchoolProperty}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教学科研及辅助用房
                    </div>
                    <div class="col-md-9">
                        <input id="scientificAuxiliaryEdit" value="${data.scientificAuxiliary}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教室
                    </div>
                    <div class="col-md-9">
                        <input id="classroomEdit" value="${data.classroom}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>图书馆
                    </div>
                    <div class="col-md-9">
                        <input id="libraryEdit" value="${data.library}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>实验室、实习场所
                    </div>
                    <div class="col-md-9">
                        <input id="laboratoriesPlacesEdit" value="${data.laboratoriesPlaces}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专用科研用房
                    </div>
                    <div class="col-md-9">
                        <input id="researchRoomEdit" value="${data.researchRoom}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>体育馆
                    </div>
                    <div class="col-md-9">
                        <input id="gymnasiumEdit" value="${data.gymnasium}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>会堂
                    </div>
                    <div class="col-md-9">
                        <input id="hallEdit" value="${data.hall}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>行政办公用房
                    </div>
                    <div class="col-md-9">
                        <input id="administrativeOfficeEdit" value="${data.administrativeOffice}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>生活用房
                    </div>
                    <div class="col-md-9">
                        <input id="collegeAreaRoomEdit" value="${data.collegeAreaRoom}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学生宿舍（公寓）
                    </div>
                    <div class="col-md-9">
                        <input id="studentDormitoryEdit" value="${data.studentDormitory}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学生食堂
                    </div>
                    <div class="col-md-9">
                        <input id="studentCanteenEdit" value="${data.studentCanteen}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教工宿舍（公寓）
                    </div>
                    <div class="col-md-9">
                        <input id="teachingDormitoryEdit" value="${data.teachingDormitory}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教工食堂
                    </div>
                    <div class="col-md-9">
                        <input id="staffCanEdit" value="${data.staffCan}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>生活福利及附属用房
                    </div>
                    <div class="col-md-9">
                        <input id="lifeWelfareEdit" value="${data.lifeWelfare}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教工住宅
                    </div>
                    <div class="col-md-9">
                        <input id="facultyHousingEdit" value="${data.facultyHousing}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>其他用房
                    </div>
                    <div class="col-md-9">
                        <input id="otherRoomsEdit" value="${data.otherRooms}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>年份
                    </div>
                    <div class="col-md-9">
                        <select id="years" value="${data.year}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="save" type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'years');
        });
        if($("#flag").val()=='on'){
            $("#save").hide();
            $("input").attr('readonly','readonly');
            $("select").attr('disabled','disabled');
        }
    });

    function save() {
        if ($("#areaCoveredEdit").val() == "" || $("#areaCoveredEdit").val() == undefined || $("#areaCoveredEdit").val() == null) {
            swal({
                title: "请填写占地面积！",
                type: "warning"
            });
            return;
        }
        if ($("#greenLandAreaEdit").val() == "" || $("#greenLandAreaEdit").val() == undefined || $("#greenLandAreaEdit").val() == null) {
            swal({
                title: "请填写绿化用地面积！",
                type: "warning"
            });
            return;
        }
        if ($("#buildingAreaEdit").val() == "" || $("#buildingAreaEdit").val() == undefined || $("#buildingAreaEdit").val() == null) {
            swal({
                title: "请填写校舍总建筑面积！",
                type: "warning"
            });
            return;
        }
        if ($("#schoolPropertyAreaEdit").val() == "" || $("#schoolPropertyAreaEdit").val() == undefined || $("#schoolPropertyAreaEdit").val() == null) {
            swal({
                title: "请填写学校产权校舍建筑面积！",
                type: "warning"
            });
            return;
        }
        if ($("#schoolBuildingEdit").val() == "" || $("#schoolBuildingEdit").val() == undefined || $("#schoolBuildingEdit").val() == null) {
            swal({
                title: "请填写当年新增校舍！",
                type: "warning"
            });
            return;
        }
        if ($("#wrongSchoolPropertyEdit").val() == "" || $("#wrongSchoolPropertyEdit").val() == undefined || $("#wrongSchoolPropertyEdit").val() == null) {
            swal({
                title: "请填写非学校产权校舍建筑面积！",
                type: "warning"
            });
            return;
        }
        if ($("#scientificAuxiliaryEdit").val() == "" || $("#scientificAuxiliaryEdit").val() == undefined || $("#scientificAuxiliaryEdit").val() == null) {
            swal({
                title: "请填写教学科研及辅助用房！",
                type: "warning"
            });
            return;
        }
        if ($("#classroomEdit").val() == "" || $("#classroomEdit").val() == undefined || $("#classroomEdit").val() == null) {
            swal({
                title: "请填写教室！",
                type: "warning"
            });
            return;
        }
        if ($("#libraryEdit").val() == "" || $("#libraryEdit").val() == undefined || $("#libraryEdit").val() == null) {
            swal({
                title: "请填写图书馆！",
                type: "warning"
            });
            return;
        }
        if ($("#laboratoriesPlacesEdit").val() == "" || $("#laboratoriesPlacesEdit").val() == undefined || $("#laboratoriesPlacesEdit").val() == null) {
            swal({
                title: "请填写实验室、实习场所！",
                type: "warning"
            });
            return;
        }
        if ($("#researchRoomEdit").val() == "" || $("#researchRoomEdit").val() == undefined || $("#researchRoomEdit").val() == null) {
            swal({
                title: "请填写专用科研用房！",
                type: "warning"
            });
            return;
        }
        if ($("#gymnasiumEdit").val() == "" || $("#gymnasiumEdit").val() == undefined || $("#gymnasiumEdit").val() == null) {
            swal({
                title: "请填写体育馆！",
                type: "warning"
            });
            return;
        }
        if ($("#hallEdit").val() == "" || $("#hallEdit").val() == undefined || $("#hallEdit").val() == null) {
            swal({
                title: "请填写会堂！",
                type: "warning"
            });
            return;
        }
        if ($("#administrativeOfficeEdit").val() == "" || $("#administrativeOfficeEdit").val() == undefined || $("#administrativeOfficeEdit").val() == null) {
            swal({
                title: "请填写行政办公用房！",
                type: "warning"
            });
            return;
        }
        if ($("#collegeAreaRoomEdit").val() == "" || $("#collegeAreaRoomEdit").val() == undefined || $("#collegeAreaRoomEdit").val() == null) {
            swal({
                title: "请填写生活用房！",
                type: "warning"
            });
            return;
        }
        if ($("#studentDormitoryEdit").val() == "" || $("#studentDormitoryEdit").val() == undefined || $("#studentDormitoryEdit").val() == null) {
            swal({
                title: "请填写学生宿舍（公寓）！",
                type: "warning"
            });
            return;
        }
        if ($("#studentCanteenEdit").val() == "" || $("#studentCanteenEdit").val() == undefined || $("#studentCanteenEdit").val() == null) {
            swal({
                title: "请填写学生食堂！",
                type: "warning"
            });
            return;
        }
        if ($("#teachingDormitoryEdit").val() == "" || $("#teachingDormitoryEdit").val() == undefined || $("#teachingDormitoryEdit").val() == null) {
            swal({
                title: "请填写教工宿舍（公寓）！",
                type: "warning"
            });
            return;
        }
        if ($("#staffCanEdit").val() == "" || $("#staffCanEdit").val() == undefined || $("#staffCanEdit").val() == null) {
            swal({
                title: "请填写教工食堂！",
                type: "warning"
            });
            return;
        }
        if ($("#lifeWelfareEdit").val() == "" || $("#lifeWelfareEdit").val() == undefined || $("#lifeWelfareEdit").val() == null) {
            swal({
                title: "请填写生活福利及附属用房！",
                type: "warning"
            });
            return;
        }
        if ($("#facultyHousingEdit").val() == "" || $("#facultyHousingEdit").val() == undefined || $("#facultyHousingEdit").val() == null) {
            swal({
                title: "请填写教工住宅！",
                type: "warning"
            });
            return;
        }
        if ($("#otherRoomsEdit").val() == "" || $("#otherRoomsEdit").val() == undefined || $("#otherRoomsEdit").val() == null) {
            swal({
                title: "请填写其他用房！",
                type: "warning"
            });
            return;
        }
        if ($("#years").val() == "" || $("#years").val() == undefined || $("#years").val() == null) {
            swal({
                title: "请选择年度！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/institutionalarea/saveInstitutionalArea", {
            id: "${data.id}",
            areaCovered: $("#areaCoveredEdit").val(),
            greenLandArea: $("#greenLandAreaEdit").val(),
            buildingArea: $("#buildingAreaEdit").val(),
            schoolPropertyArea: $("#schoolPropertyAreaEdit").val(),
            schoolBuilding: $("#schoolBuildingEdit").val(),
            wrongSchoolProperty: $("#wrongSchoolPropertyEdit").val(),
            scientificAuxiliary: $("#scientificAuxiliaryEdit").val(),
            classroom: $("#classroomEdit").val(),
            library: $("#libraryEdit").val(),
            laboratoriesPlaces: $("#laboratoriesPlacesEdit").val(),
            researchRoom: $("#researchRoomEdit").val(),
            gymnasium: $("#gymnasiumEdit").val(),
            hall: $("#hallEdit").val(),
            administrativeOffice: $("#administrativeOfficeEdit").val(),
            collegeAreaRoom: $("#collegeAreaRoomEdit").val(),
            studentDormitory: $("#studentDormitoryEdit").val(),
            studentCanteen: $("#studentCanteenEdit").val(),
            teachingDormitory: $("#teachingDormitoryEdit").val(),
            staffCan: $("#staffCanEdit").val(),
            lifeWelfare: $("#lifeWelfareEdit").val(),
            facultyHousing: $("#facultyHousingEdit").val(),
            otherRooms: $("#otherRoomsEdit").val(),
            year:$("#years").val(),
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



