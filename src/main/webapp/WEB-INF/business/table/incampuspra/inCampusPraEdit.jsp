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
                        <span class="iconBtx">*</span>实践基地名称
                    </div>
                    <div class="col-md-9">
                        <input id="praNameEdit" value="${data.praName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>主要专业
                    </div>
                    <div class="col-md-9">
                        <input id="parMajorEdit" value="${data.parMajor}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>总数
                    </div>
                    <div class="col-md-9">
                        <input id="parTotalEdit" value="${data.parTotal}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>支持部门
                    </div>
                    <div class="col-md-9">
                        <input id="parSupDeptEdit" value="${data.parSupDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>批准日期
                    </div>
                    <div class="col-md-9">
                        <input id="parSupTimeEdit" value="${data.parSupTime}" type="date"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>建筑面积
                    </div>
                    <div class="col-md-9">
                        <input id="parAreaEdit" value="${data.parArea}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>设备总值
                    </div>
                    <div class="col-md-9">
                        <input id="parDevAllvalueEdit" value="${data.parDevAllvalue}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>当年新增设备值
                    </div>
                    <div class="col-md-9">
                        <input id="parDevNewvalueEdit" value="${data.parDevNewvalue}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>自主研制设备值
                    </div>
                    <div class="col-md-9">
                        <input id="selfDevValueEdit" value="${data.selfDevValue}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>社会捐赠设备值
                    </div>
                    <div class="col-md-9">
                        <input id="ssDevValueEdit" value="${data.ssDevValue}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>社会准捐赠设备值
                    </div>
                    <div class="col-md-9">
                        <input id="sswDevValueEdit" value="${data.sswDevValue}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>设备总数
                    </div>
                    <div class="col-md-9">
                        <input id="devNumEdit" value="${data.devNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>大型设备数
                    </div>
                    <div class="col-md-9">
                        <input id="devBigNumEdit" value="${data.devBigNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>实训项目总数
                    </div>
                    <div class="col-md-9">
                        <input id="parProNumEdit" value="${data.parProNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>主要项目名称
                    </div>
                    <div class="col-md-9">
                        <input id="mainParProEdit" value="${data.mainParPro}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学年使用频率（人时）校内
                    </div>
                    <div class="col-md-9">
                        <input id="schUseFreEdit" value="${data.schUseFre}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>社会使用频率（人时）校内
                    </div>
                    <div class="col-md-9">
                        <input id="ssUseFreEdit" value="${data.ssUseFre}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>工位数
                    </div>
                    <div class="col-md-9">
                        <input id="workNumEdit" value="${data.workNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>原材料（耗材）费用（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="materCostEdit" value="${data.materCost}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>设备维护费用
                    </div>
                    <div class="col-md-9">
                        <input id="devMaintCostEdit" value="${data.devMaintCost}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专职管理人员（名）
                    </div>
                    <div class="col-md-9">
                        <input id="mgeNumEdit" value="${data.mgeNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>兼职管理人员（名）
                    </div>
                    <div class="col-md-9">
                        <input id="partMgeNumEdit" value="${data.partMgeNum}"/>
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
        if ($("#praNameEdit").val() == "" || $("#praNameEdit").val() == undefined || $("#praNameEdit").val() == null) {
            swal({
                title: "请填写实践基地名称！",
                type: "warning"
            });
            return;
        }
        if ($("#parMajorEdit").val() == "" || $("#parMajorEdit").val() == undefined || $("#parMajorEdit").val() == null) {
            swal({
                title: "请填写主要专业！",
                type: "warning"
            });
            return;
        }
        if ($("#parTotalEdit").val() == "" || $("#parTotalEdit").val() == undefined || $("#parTotalEdit").val() == null) {
            swal({
                title: "请填写总数！",
                type: "warning"
            });
            return;
        }
        if ($("#parSupDeptEdit").val() == "" || $("#parSupDeptEdit").val() == undefined || $("#parSupDeptEdit").val() == null) {
            swal({
                title: "请填写支持部门！",
                type: "warning"
            });
            return;
        }
        if ($("#parSupTimeEdit").val() == "" || $("#parSupTimeEdit").val() == undefined || $("#parSupTimeEdit").val() == null) {
            swal({
                title: "请填写批准日期！",
                type: "warning"
            });
            return;
        }
        if ($("#parAreaEdit").val() == "" || $("#parAreaEdit").val() == undefined || $("#parAreaEdit").val() == null) {
            swal({
                title: "请填写建筑面积！",
                type: "warning"
            });
            return;
        }
        if ($("#parDevAllvalueEdit").val() == "" || $("#parDevAllvalueEdit").val() == undefined || $("#parDevAllvalueEdit").val() == null) {
            swal({
                title: "请填写设备总值！",
                type: "warning"
            });
            return;
        }
        if ($("#parDevNewvalueEdit").val() == "" || $("#parDevNewvalueEdit").val() == undefined || $("#parDevNewvalueEdit").val() == null) {
            swal({
                title: "请填写当年新增设备值！",
                type: "warning"
            });
            return;
        }
        if ($("#selfDevValueEdit").val() == "" || $("#selfDevValueEdit").val() == undefined || $("#selfDevValueEdit").val() == null) {
            swal({
                title: "请填写自主研制设备值！",
                type: "warning"
            });
            return;
        }
        if ($("#ssDevValueEdit").val() == "" || $("#ssDevValueEdit").val() == undefined || $("#ssDevValueEdit").val() == null) {
            swal({
                title: "请填写社会捐赠设备值！",
                type: "warning"
            });
            return;
        }
        if ($("#sswDevValueEdit").val() == "" || $("#sswDevValueEdit").val() == undefined || $("#sswDevValueEdit").val() == null) {
            swal({
                title: "请填写社会准捐赠设备值！",
                type: "warning"
            });
            return;
        }
        if ($("#devNumEdit").val() == "" || $("#devNumEdit").val() == undefined || $("#devNumEdit").val() == null) {
            swal({
                title: "请填写设备总数！",
                type: "warning"
            });
            return;
        }
        if ($("#devBigNumEdit").val() == "" || $("#devBigNumEdit").val() == undefined || $("#devBigNumEdit").val() == null) {
            swal({
                title: "请填写大型设备数！",
                type: "warning"
            });
            return;
        }
        if ($("#parProNumEdit").val() == "" || $("#parProNumEdit").val() == undefined || $("#parProNumEdit").val() == null) {
            swal({
                title: "请填写实训项目总数！",
                type: "warning"
            });
            return;
        }
        if ($("#mainParProEdit").val() == "" || $("#mainParProEdit").val() == undefined || $("#mainParProEdit").val() == null) {
            swal({
                title: "请填写主要项目名称！",
                type: "warning"
            });
            return;
        }
        if ($("#schUseFreEdit").val() == "" || $("#schUseFreEdit").val() == undefined || $("#schUseFreEdit").val() == null) {
            swal({
                title: "请填写学年使用频率（人时）校内！",
                type: "warning"
            });
            return;
        }
        if ($("#ssUseFreEdit").val() == "" || $("#ssUseFreEdit").val() == undefined || $("#ssUseFreEdit").val() == null) {
            swal({
                title: "请填写社会使用频率（人时）校内！",
                type: "warning"
            });
            return;
        }
        if ($("#workNumEdit").val() == "" || $("#workNumEdit").val() == undefined || $("#workNumEdit").val() == null) {
            swal({
                title: "请填写工位数！",
                type: "warning"
            });
            return;
        }
        if ($("#materCostEdit").val() == "" || $("#materCostEdit").val() == undefined || $("#materCostEdit").val() == null) {
            swal({
                title: "请填写原材料（耗材）费用（万元）！",
                type: "warning"
            });
            return;
        }
        if ($("#devMaintCostEdit").val() == "" || $("#devMaintCostEdit").val() == undefined || $("#devMaintCostEdit").val() == null) {
            swal({
                title: "请填写设备维护费用！",
                type: "warning"
            });
            return;
        }
        if ($("#mgeNumEdit").val() == "" || $("#mgeNumEdit").val() == undefined || $("#mgeNumEdit").val() == null) {
            swal({
                title: "请填写专职管理人员（名）！",
                type: "warning"
            });
            return;
        }
        if ($("#partMgeNumEdit").val() == "" || $("#partMgeNumEdit").val() == undefined || $("#partMgeNumEdit").val() == null) {
            swal({
                title: "请填写兼职管理人员（名）！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/InCampusPra/saveInCampusPra", {
            id: "${data.id}",
            praName: $("#praNameEdit").val(),
            parMajor: $("#parMajorEdit").val(),
            parTotal: $("#parTotalEdit").val(),
            parSupDept: $("#parSupDeptEdit").val(),
            parSupTime: $("#parSupTimeEdit").val(),
            parArea: $("#parAreaEdit").val(),
            parDevAllvalue: $("#parDevAllvalueEdit").val(),
            parDevNewvalue: $("#parDevNewvalueEdit").val(),
            selfDevValue: $("#selfDevValueEdit").val(),
            ssDevValue: $("#ssDevValueEdit").val(),
            sswDevValue: $("#sswDevValueEdit").val(),
            devNum: $("#devNumEdit").val(),
            devBigNum: $("#devBigNumEdit").val(),
            parProNum: $("#parProNumEdit").val(),
            mainParPro: $("#mainParProEdit").val(),
            schUseFre: $("#schUseFreEdit").val(),
            ssUseFre: $("#ssUseFreEdit").val(),
            workNum: $("#workNumEdit").val(),
            materCost: $("#materCostEdit").val(),
            devMaintCost: $("#devMaintCostEdit").val(),
            mgeNum: $("#mgeNumEdit").val(),
            partMgeNum: $("#partMgeNumEdit").val(),
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



