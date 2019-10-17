<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <form id="scores">
                        <div class="form-row">
                             <div class="col-md-2 tar">
                                学校标识码：
                            </div>
                            <div class="col-md-4">
                                <input id="schoolIdcodeSel" value="${data.schoolIdcode}">
                            </div>
                            <div class="col-md-2 tar">
                                学校名称(全称)：
                            </div>
                            <div class="col-md-4">
                                <input id="schoolNameSel" value="${data.schoolName}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                所在地区（省、自治区、直辖市）：
                            </div>
                            <div class="col-md-4">
                                <select id="arcadProvinceEdit" ></select>
                            </div>
                            <div class="col-md-2 tar">
                                所在城市：
                            </div>
                            <div class="col-md-4">
                                <select id="arcadCityEdit" />
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                当前校名启用日期（年月）：
                            </div>
                            <div class="col-md-4">
                                <input id="enableTimeSel" type="month" value="${data.enableTime}">
                            </div>
                            <div class="col-md-2 tar">
                                建校日期（年月）：
                            </div>
                            <div class="col-md-4">
                                <input id="establishTimeSel" type="month" value="${data.establishTime}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                建校基础：
                            </div>
                            <div class="col-md-4">
                                <input id="establishBasicsSel"  value="${data.establishBasics}">
                            </div>
                            <div class="col-md-2 tar">
                                学校举办者性质：
                            </div>
                            <div class="col-md-4">
                                <select id="natureSel"></select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                学校举办者级别：
                            </div>
                            <div class="col-md-4">
                                <select id="holdLevelSel"></select>
                            </div>
                            <div class="col-md-2 tar">
                                学校性质类别：
                            </div>
                            <div class="col-md-4">
                                <select id="schoolTypeSel"></select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                校训：
                            </div>
                            <div class="col-md-4">
                                <input id="schoolMottoSel" value="${data.schoolMotto}">
                            </div>
                            <div class="col-md-2 tar">
                                示范性高等职业院校性质：
                            </div>
                            <div class="col-md-4">
                                <select id="exemplaryNatureSel"></select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                示范性高等职业院校级别：
                            </div>
                            <div class="col-md-4">
                                <select id="exemplaryLevelSel"></select>
                            </div>
                            <div class="col-md-2 tar">
                                示范性高等职业院校立项部门：
                            </div>
                            <div class="col-md-4">
                                <input id="establishmentDeptSel"  value="${data.establishmentDept}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                立项日期（年）：
                            </div>
                            <div class="col-md-4">
                                <input id="establishmentTimeSel" type="year"  value="${data.establishmentTime}">
                            </div>
                            <div class="col-md-2 tar">
                                第一轮 评估日期（年月）：
                            </div>
                            <div class="col-md-4">
                                <input id="assessmentOneTimeSel" type="month"  value="${data.assessmentOneTime}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                第一轮 评估结论：
                            </div>
                            <div class="col-md-4">
                                <input id="evaluationConclusionOneSel"  value="${data.evaluationConclusionOne}">
                            </div>
                            <div class="col-md-2 tar">
                                第二轮 评估日期 （年月）：
                            </div>
                            <div class="col-md-4">
                                <input id="assessmentTwoTimeSel" type="month"  value="${data.assessmentTwoTime}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                第二轮 评估结论：
                            </div>
                            <div class="col-md-4">
                                <input id="evaluationConclusionTwoSel"  value="${data.evaluationConclusionTwo}">
                            </div>
                            <div class="col-md-2 tar">
                                未接受评估：
                            </div>
                            <div class="col-md-4">
                                <select id="unassessedSel"></select>
                            </div>
                        </div>
                        </form>
                        <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="id" hidden value="${data.id}"/>
<script>
    $(document).ready(function () {
        addAdministrativeDivisions("arcadProvinceEdit", "${data.province}", "arcadCityEdit", "${data.city}", "arcadCountyEdit", "${data.arcadCounty}", path);
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXJBZXZ", function (data) {
            addOption(data, 'natureSel','${data.nature}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXJBZJB", function (data) {
            addOption(data, 'holdLevelSel','${data.holdLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXXZLB", function (data) {
            addOption(data, 'schoolTypeSel','${data.schoolType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SFXGDZYYXXZ", function (data) {
            addOption(data, 'exemplaryNatureSel','${data.exemplaryNature}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SFXGDZYYXJB", function (data) {
            addOption(data, 'exemplaryLevelSel','${data.exemplaryLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'unassessedSel','${data.unassessed}');
        });
    })
    function save() {
        if ($("#schoolIdcodeSel").val() == "" || $("#schoolIdcodeSel").val() == undefined || $("#schoolIdcodeSel").val() == null) {
            swal({
                title: "请填写学校标识码！",
                type: "warning"
            });
            return;
        }
        if ($("#schoolNameSel").val() == "" || $("#schoolNameSel").val() == undefined || $("#schoolNameSel").val() == null) {
            swal({
                title: "请填写学校名称(全称)！",
                type: "warning"
            });
            return;
        }
        if ($("#arcadProvinceEdit").val() == "" || $("#arcadProvinceEdit").val() == undefined || $("#arcadProvinceEdit").val() == null) {
            swal({
                title: "请填写所在地区（省、自治区、直辖市）！",
                type: "warning"
            });
            return;
        }
        if ($("#arcadCityEdit").val() == "" || $("#arcadCityEdit").val() == undefined || $("#arcadCityEdit").val() == null) {
            swal({
                title: "请填写所在城市！",
                type: "warning"
            });
            return;
        }
        if ($("#enableTimeSel").val() == "" || $("#enableTimeSel").val() == undefined || $("#enableTimeSel").val() == null) {
            swal({
                title: "请填写当前校名启用日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#establishTimeSel").val() == "" || $("#establishTimeSel").val() == undefined || $("#establishTimeSel").val() == null) {
            swal({
                title: "请填写建校日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#establishBasicsSel").val() == "" || $("#establishBasicsSel").val() == undefined || $("#establishBasicsSel").val() == null) {
            swal({
                title: "请填写建校基础！",
                type: "warning"
            });
            return;
        }
        if ($("#natureSel").val() == "" || $("#natureSel").val() == undefined || $("#natureSel").val() == null) {
            swal({
                title: "请选择学校举办者性质！",
                type: "warning"
            });
            return;
        }
        if ($("#holdLevelSel").val() == "" || $("#holdLevelSel").val() == undefined || $("#holdLevelSel").val() == null) {
            swal({
                title: "请选择学校举办者级别！",
                type: "warning"
            });
            return;
        }
        if ($("#schoolTypeSel").val() == "" || $("#schoolTypeSel").val() == undefined || $("#schoolTypeSel").val() == null) {
            swal({
                title: "请选择学校性质类别！",
                type: "warning"
            });
            return;
        }
        if ($("#schoolMottoSel").val() == "" || $("#schoolMottoSel").val() == undefined || $("#schoolMottoSel").val() == null) {
            swal({
                title: "请填写校训！",
                type: "warning"
            });
            return;
        }
        if ($("#exemplaryNatureSel").val() == "" || $("#exemplaryNatureSel").val() == undefined || $("#exemplaryNatureSel").val() == null) {
            swal({
                title: "请选择示范性高等职业院校性质！",
                type: "warning"
            });
            return;
        }
        if ($("#exemplaryLevelSel").val() == "" || $("#exemplaryLevelSel").val() == undefined || $("#exemplaryLevelSel").val() == null) {
            swal({
                title: "请选择示范性高等职业院校级别！",
                type: "warning"
            });
            return;
        }
        if ($("#establishmentDeptSel").val() == "" || $("#establishmentDeptSel").val() == undefined || $("#establishmentDeptSel").val() == null) {
            swal({
                title: "请填写示范性高等职业院校立项部门！",
                type: "warning"
            });
            return;
        }
        if ($("#establishmentTimeSel").val() == "" || $("#establishmentTimeSel").val() == undefined || $("#establishmentTimeSel").val() == null) {
            swal({
                title: "请填写立项日期（年）！",
                type: "warning"
            });
            return;
        }
        if ($("#assessmentOneTimeSel").val() == "" || $("#assessmentOneTimeSel").val() == undefined || $("#assessmentOneTimeSel").val() == null) {
            swal({
                title: "请填写第一轮 评估日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#evaluationConclusionOneSel").val() == "" || $("#evaluationConclusionOneSel").val() == undefined || $("#evaluationConclusionOneSel").val() == null) {
            swal({
                title: "请填写第一轮 评估结论！",
                type: "warning"
            });
            return;
        }
        if ($("#assessmentTwoTimeSel").val() == "" || $("#assessmentTwoTimeSel").val() == undefined || $("#assessmentTwoTimeSel").val() == null) {
            swal({
                title: "请填写第二轮 评估日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#evaluationConclusionTwoSel").val() == "" || $("#evaluationConclusionTwoSel").val() == undefined || $("#evaluationConclusionTwoSel").val() == null) {
            swal({
                title: "请填写第二轮 评估结论！",
                type: "warning"
            });
            return;
        }
        if ($("#unassessedSel").val() == "" || $("#unassessedSel").val() == undefined || $("#unassessedSel").val() == null) {
            swal({
                title: "请选择未接受评估！",
                type: "warning"
            });
            return;
        }
        var scores = $("#scores").serializeArray();
        $.post("<%=request.getContextPath()%>/courtyardname/saveCourtyardName", scores, function (msg) {
            swal({title: msg.msg, type: "success"});
            search();
        })
    }
    function save() {

        $.post("<%=request.getContextPath()%>/courtyardname/saveCourtyardName", {
            id: "${data.id}",
            schoolIdcode: $("#schoolIdcodeSel").val(),
            schoolName: $("#schoolNameSel").val(),
            province: $("#provinceSel").val(),
            city: $("#citySel").val(),
            enableTime: $("#enableTimeSel").val(),
            establishTime: $("#establishTimeSel").val(),
            establishBasics: $("#establishBasicsSel").val(),
            nature: $("#natureSel").val(),
            holdLevel: $("#holdLevelSel").val(),
            schoolType: $("#schoolTypeSel").val(),
            schoolMotto: $("#schoolMottoSel").val(),
            exemplaryNature: $("#exemplaryNatureSel").val(),
            exemplaryLevel: $("#exemplaryLevelSel").val(),
            establishmentDept: $("#establishmentDeptSel").val(),
            establishmentTime: $("#establishmentTimeSel").val(),
            assessmentOneTime: $("#assessmentOneTimeSel").val(),
            evaluationConclusionOne: $("#evaluationConclusionOneSel").val(),
            assessmentTwoTime: $("#assessmentTwoTimeSel").val(),
            evaluationConclusionTwo: $("#evaluationConclusionTwoSel").val(),
            unassessed: $("#unassessedSel").val(),
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
            });
        })
    }
</script>