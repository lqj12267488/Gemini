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
                        <span class="iconBtx">*</span>学校标识码
                    </div>
                    <div class="col-md-9">
                        <input id="schoolIdcodeEdit" value="${data.schoolIdcode}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学校名称(全称)
                    </div>
                    <div class="col-md-9">
                        <input id="schoolNameEdit" value="${data.schoolName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>所在地区（省、自治区、直辖市）
                    </div>
                    <div class="col-md-9">
                        <input id="provinceEdit" value="${data.province}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>所在城市
                    </div>
                    <div class="col-md-9">
                        <input id="cityEdit" value="${data.city}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>当前校名启用日期（年月）
                    </div>
                    <div class="col-md-9">
                        <input id="enableTimeEdit" value="${data.enableTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>建校日期（年月）
                    </div>
                    <div class="col-md-9">
                        <input id="establishTimeEdit" value="${data.establishTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>建校基础
                    </div>
                    <div class="col-md-9">
                        <input id="establishBasicsEdit" value="${data.establishBasics}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学校举办者性质
                    </div>
                    <div class="col-md-9">
                        <select id="natureEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学校举办者级别
                    </div>
                    <div class="col-md-9">
                        <select id="holdLevelEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学校性质类别
                    </div>
                    <div class="col-md-9">
                        <select id="schoolTypeEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>校训
                    </div>
                    <div class="col-md-9">
                        <input id="schoolMottoEdit" value="${data.schoolMotto}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>示范性高等职业院校性质
                    </div>
                    <div class="col-md-9">
                        <select id="exemplaryNatureEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>示范性高等职业院校级别
                    </div>
                    <div class="col-md-9">
                        <select id="exemplaryLevelEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>示范性高等职业院校立项部门
                    </div>
                    <div class="col-md-9">
                        <input id="establishmentDeptEdit" value="${data.establishmentDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>立项日期（年）
                    </div>
                    <div class="col-md-9">
                        <input id="establishmentTimeEdit" value="${data.establishmentTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>第一轮 评估日期（年月）
                    </div>
                    <div class="col-md-9">
                        <input id="assessmentOneTimeEdit" value="${data.assessmentOneTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>第一轮 评估结论
                    </div>
                    <div class="col-md-9">
                        <input id="evaluationConclusionOneEdit" value="${data.evaluationConclusionOne}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>第二轮 评估日期（年月）
                    </div>
                    <div class="col-md-9">
                        <input id="assessmentTwoTimeEdit" value="${data.assessmentTwoTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>第二轮 评估结论
                    </div>
                    <div class="col-md-9">
                        <input id="evaluationConclusionTwoEdit" value="${data.evaluationConclusionTwo}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>未接受评估
                    </div>
                    <div class="col-md-9">
                        <select id="unassessedEdit"/>
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
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXJBZXZ", function (data) {
                addOption(data, 'natureEdit','${data.nature}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXJBZJB", function (data) {
                addOption(data, 'holdLevelEdit','${data.holdLevel}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXXZLB", function (data) {
                addOption(data, 'schoolTypeEdit','${data.schoolType}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=SFXGDZYYXXZ", function (data) {
                addOption(data, 'exemplaryNatureEdit','${data.exemplaryNature}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=SFXGDZYYXJB", function (data) {
                addOption(data, 'exemplaryLevelEdit','${data.exemplaryLevel}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
                addOption(data, 'unassessedEdit','${data.unassessed}');
            });
    });

    function save() {
        if ($("#schoolIdcodeEdit").val() == "" || $("#schoolIdcodeEdit").val() == undefined || $("#schoolIdcodeEdit").val() == null) {
            swal({
                title: "请填写学校标识码！",
                type: "warning"
            });
            return;
        }
        if ($("#schoolNameEdit").val() == "" || $("#schoolNameEdit").val() == undefined || $("#schoolNameEdit").val() == null) {
            swal({
                title: "请填写学校名称(全称)！",
                type: "warning"
            });
            return;
        }
        if ($("#provinceEdit").val() == "" || $("#provinceEdit").val() == undefined || $("#provinceEdit").val() == null) {
            swal({
                title: "请填写所在地区（省、自治区、直辖市）！",
                type: "warning"
            });
            return;
        }
        if ($("#cityEdit").val() == "" || $("#cityEdit").val() == undefined || $("#cityEdit").val() == null) {
            swal({
                title: "请填写所在城市！",
                type: "warning"
            });
            return;
        }
        if ($("#enableTimeEdit").val() == "" || $("#enableTimeEdit").val() == undefined || $("#enableTimeEdit").val() == null) {
            swal({
                title: "请填写当前校名启用日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#establishTimeEdit").val() == "" || $("#establishTimeEdit").val() == undefined || $("#establishTimeEdit").val() == null) {
            swal({
                title: "请填写建校日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#establishBasicsEdit").val() == "" || $("#establishBasicsEdit").val() == undefined || $("#establishBasicsEdit").val() == null) {
            swal({
                title: "请填写建校基础！",
                type: "warning"
            });
            return;
        }
        if ($("#natureEdit").val() == "" || $("#natureEdit").val() == undefined || $("#natureEdit").val() == null) {
            swal({
                title: "请选择学校举办者性质！",
                type: "warning"
            });
            return;
        }
        if ($("#holdLevelEdit").val() == "" || $("#holdLevelEdit").val() == undefined || $("#holdLevelEdit").val() == null) {
            swal({
                title: "请选择学校举办者级别！",
                type: "warning"
            });
            return;
        }
        if ($("#schoolTypeEdit").val() == "" || $("#schoolTypeEdit").val() == undefined || $("#schoolTypeEdit").val() == null) {
            swal({
                title: "请选择学校性质类别！",
                type: "warning"
            });
            return;
        }
        if ($("#schoolMottoEdit").val() == "" || $("#schoolMottoEdit").val() == undefined || $("#schoolMottoEdit").val() == null) {
            swal({
                title: "请填写校训！",
                type: "warning"
            });
            return;
        }
        if ($("#exemplaryNatureEdit").val() == "" || $("#exemplaryNatureEdit").val() == undefined || $("#exemplaryNatureEdit").val() == null) {
            swal({
                title: "请选择示范性高等职业院校性质！",
                type: "warning"
            });
            return;
        }
        if ($("#exemplaryLevelEdit").val() == "" || $("#exemplaryLevelEdit").val() == undefined || $("#exemplaryLevelEdit").val() == null) {
            swal({
                title: "请选择示范性高等职业院校级别！",
                type: "warning"
            });
            return;
        }
        if ($("#establishmentDeptEdit").val() == "" || $("#establishmentDeptEdit").val() == undefined || $("#establishmentDeptEdit").val() == null) {
            swal({
                title: "请填写示范性高等职业院校立项部门！",
                type: "warning"
            });
            return;
        }
        if ($("#establishmentTimeEdit").val() == "" || $("#establishmentTimeEdit").val() == undefined || $("#establishmentTimeEdit").val() == null) {
            swal({
                title: "请填写立项日期（年）！",
                type: "warning"
            });
            return;
        }
        if ($("#assessmentOneTimeEdit").val() == "" || $("#assessmentOneTimeEdit").val() == undefined || $("#assessmentOneTimeEdit").val() == null) {
            swal({
                title: "请填写第一轮 评估日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#evaluationConclusionOneEdit").val() == "" || $("#evaluationConclusionOneEdit").val() == undefined || $("#evaluationConclusionOneEdit").val() == null) {
            swal({
                title: "请填写第一轮 评估结论！",
                type: "warning"
            });
            return;
        }
        if ($("#assessmentTwoTimeEdit").val() == "" || $("#assessmentTwoTimeEdit").val() == undefined || $("#assessmentTwoTimeEdit").val() == null) {
            swal({
                title: "请填写第二轮 评估日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#evaluationConclusionTwoEdit").val() == "" || $("#evaluationConclusionTwoEdit").val() == undefined || $("#evaluationConclusionTwoEdit").val() == null) {
            swal({
                title: "请填写第二轮 评估结论！",
                type: "warning"
            });
            return;
        }
        if ($("#unassessedEdit").val() == "" || $("#unassessedEdit").val() == undefined || $("#unassessedEdit").val() == null) {
            swal({
                title: "请选择未接受评估是/否！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/courtyardname/saveCourtyardName", {
            id: "${data.id}",
            schoolIdcode: $("#schoolIdcodeEdit").val(),
            schoolName: $("#schoolNameEdit").val(),
            province: $("#provinceEdit").val(),
            city: $("#cityEdit").val(),
            enableTime: $("#enableTimeEdit").val(),
            establishTime: $("#establishTimeEdit").val(),
            establishBasics: $("#establishBasicsEdit").val(),
            nature: $("#natureEdit").val(),
            holdLevel: $("#holdLevelEdit").val(),
            schoolType: $("#schoolTypeEdit").val(),
            schoolMotto: $("#schoolMottoEdit").val(),
            exemplaryNature: $("#exemplaryNatureEdit").val(),
            exemplaryLevel: $("#exemplaryLevelEdit").val(),
            establishmentDept: $("#establishmentDeptEdit").val(),
            establishmentTime: $("#establishmentTimeEdit").val(),
            assessmentOneTime: $("#assessmentOneTimeEdit").val(),
            evaluationConclusionOne: $("#evaluationConclusionOneEdit").val(),
            assessmentTwoTime: $("#assessmentTwoTimeEdit").val(),
            evaluationConclusionTwo: $("#evaluationConclusionTwoEdit").val(),
            unassessed: $("#unassessedEdit").val(),
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



