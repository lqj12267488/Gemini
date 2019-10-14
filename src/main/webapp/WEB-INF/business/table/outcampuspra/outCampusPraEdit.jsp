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
                        <span class="iconBtx">*</span>基地名称
                    </div>
                    <div class="col-md-9">
                        <input id="opraNameEdit" value="${data.opraName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>依托单位名称
                    </div>
                    <div class="col-md-9">
                        <input id="opraUnitEdit" value="${data.opraUnit}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>在岗职工总数
                    </div>
                    <div class="col-md-9">
                        <input id="opraEmpNumEdit" value="${data.opraEmpNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>建立日期
                    </div>
                    <div class="col-md-9">
                        <input id="buildTimeEdit" value="${data.buildTime}" type="date"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>面向专业总数
                    </div>
                    <div class="col-md-9">
                        <input id="opraMajorNumEdit" value="${data.opraMajorNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>主要专业
                    </div>
                    <div class="col-md-9">
                        <input id="mainOpraMajorEdit" value="${data.mainOpraMajor}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>实习实训项目	总数
                    </div>
                    <div class="col-md-9">
                        <input id="opraProNumEdit" value="${data.opraProNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>主要项目(全称)
                    </div>
                    <div class="col-md-9">
                        <input id="opraProNameEdit" value="${data.opraProName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>接待学生量（人次）
                    </div>
                    <div class="col-md-9">
                        <input id="opraStdNumEdit" value="${data.opraStdNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>基地使用天数
                    </div>
                    <div class="col-md-9">
                        <input id="baseUseDayEdit" value="${data.baseUseDay}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>接收半年顶岗实习学生树
                    </div>
                    <div class="col-md-9">
                        <input id="internNumEdit" value="${data.internNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>是否有住宿条件
                    </div>
                    <div class="col-md-9">
                        <input id="sfDormEdit" value="${data.sfDorm}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>基地是否方法学生实习补贴
                    </div>
                    <div class="col-md-9">
                        <input id="sfSubEdit" value="${data.sfSub}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学校向基地支付专项实习经费（元/生）
                    </div>
                    <div class="col-md-9">
                        <input id="itnCostEdit" value="${data.itnCost}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学校派指导教师/学生管理人员(人次)
                    </div>
                    <div class="col-md-9">
                        <input id="sendMgeEdit" value="${data.sendMge}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>接收应届毕业生就业数
                    </div>
                    <div class="col-md-9">
                        <input id="accGradEdit" value="${data.accGrad}"/>
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
        if ($("#opraUnitEdit").val() == "" || $("#opraUnitEdit").val() == undefined || $("#opraUnitEdit").val() == null) {
            swal({
                title: "请填写依托单位	名称！",
                type: "warning"
            });
            return;
        }
        if ($("#opraEmpNumEdit").val() == "" || $("#opraEmpNumEdit").val() == undefined || $("#opraEmpNumEdit").val() == null) {
            swal({
                title: "请填写在岗职工总数！",
                type: "warning"
            });
            return;
        }
        if ($("#buildTimeEdit").val() == "" || $("#buildTimeEdit").val() == undefined || $("#buildTimeEdit").val() == null) {
            swal({
                title: "请填写建立日期！",
                type: "warning"
            });
            return;
        }
        if ($("#opraMajorNumEdit").val() == "" || $("#opraMajorNumEdit").val() == undefined || $("#opraMajorNumEdit").val() == null) {
            swal({
                title: "请填写面向专业总数！",
                type: "warning"
            });
            return;
        }
        if ($("#mainOpraMajorEdit").val() == "" || $("#mainOpraMajorEdit").val() == undefined || $("#mainOpraMajorEdit").val() == null) {
            swal({
                title: "请填写主要专业！",
                type: "warning"
            });
            return;
        }
        if ($("#opraProNumEdit").val() == "" || $("#opraProNumEdit").val() == undefined || $("#opraProNumEdit").val() == null) {
            swal({
                title: "请填写实习实训项目	总数！",
                type: "warning"
            });
            return;
        }
        if ($("#opraProNameEdit").val() == "" || $("#opraProNameEdit").val() == undefined || $("#opraProNameEdit").val() == null) {
            swal({
                title: "请填写主要项目(全称)！",
                type: "warning"
            });
            return;
        }
        if ($("#opraStdNumEdit").val() == "" || $("#opraStdNumEdit").val() == undefined || $("#opraStdNumEdit").val() == null) {
            swal({
                title: "请填写接待学生量（人次）！",
                type: "warning"
            });
            return;
        }
        if ($("#baseUseDayEdit").val() == "" || $("#baseUseDayEdit").val() == undefined || $("#baseUseDayEdit").val() == null) {
            swal({
                title: "请填写基地使用天数！",
                type: "warning"
            });
            return;
        }
        if ($("#internNumEdit").val() == "" || $("#internNumEdit").val() == undefined || $("#internNumEdit").val() == null) {
            swal({
                title: "请填写接收半年顶岗实习学生树！",
                type: "warning"
            });
            return;
        }
        if ($("#sfDormEdit").val() == "" || $("#sfDormEdit").val() == undefined || $("#sfDormEdit").val() == null) {
            swal({
                title: "请填写是否有住宿条件！",
                type: "warning"
            });
            return;
        }
        if ($("#sfSubEdit").val() == "" || $("#sfSubEdit").val() == undefined || $("#sfSubEdit").val() == null) {
            swal({
                title: "请填写基地是否方法学生实习补贴！",
                type: "warning"
            });
            return;
        }
        if ($("#itnCostEdit").val() == "" || $("#itnCostEdit").val() == undefined || $("#itnCostEdit").val() == null) {
            swal({
                title: "请填写学校向基地支付专项实习经费（元/生）！",
                type: "warning"
            });
            return;
        }
        if ($("#sendMgeEdit").val() == "" || $("#sendMgeEdit").val() == undefined || $("#sendMgeEdit").val() == null) {
            swal({
                title: "请填写学校派指导教师/学生管理人员(人次)！",
                type: "warning"
            });
            return;
        }
        if ($("#accGradEdit").val() == "" || $("#accGradEdit").val() == undefined || $("#accGradEdit").val() == null) {
            swal({
                title: "请填写接收应届毕业生就业数！",
                type: "warning"
            });
            return;
        }
        if ($("#opraNameEdit").val() == "" || $("#opraNameEdit").val() == undefined || $("#opraNameEdit").val() == null) {
            swal({
                title: "请填写基地名称！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/OutCampusPra/saveOutCampusPra", {
            id: "${data.id}",
            opraUnit: $("#opraUnitEdit").val(),
            opraEmpNum: $("#opraEmpNumEdit").val(),
            buildTime: $("#buildTimeEdit").val(),
            opraMajorNum: $("#opraMajorNumEdit").val(),
            mainOpraMajor: $("#mainOpraMajorEdit").val(),
            opraProNum: $("#opraProNumEdit").val(),
            opraProName: $("#opraProNameEdit").val(),
            opraStdNum: $("#opraStdNumEdit").val(),
            baseUseDay: $("#baseUseDayEdit").val(),
            internNum: $("#internNumEdit").val(),
            sfDorm: $("#sfDormEdit").val(),
            sfSub: $("#sfSubEdit").val(),
            itnCost: $("#itnCostEdit").val(),
            sendMge: $("#sendMgeEdit").val(),
            accGrad: $("#accGradEdit").val(),
            opraName: $("#opraNameEdit").val(),
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



