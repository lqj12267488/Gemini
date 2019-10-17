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
<div class="modal-dialog" style="width: 900px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix" >
            <div class="controls" id="data">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>实践基地名称
                    </div>
                    <div class="col-md-4">
                        <input id="praNameEdit" value="${data.praName}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    面向专业:
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        主要专业
                    </div>
                    <div class="col-md-4">
                        <input id="parMajorEdit" value="${data.parMajor}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        总数
                    </div>
                    <div class="col-md-4">
                        <input id="parTotalEdit" value="${data.parTotal}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    被列为实训基地项目:
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        支持部门
                    </div>
                    <div class="col-md-4">
                        <input id="parSupDeptEdit" value="${data.parSupDept}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        批准日期
                    </div>
                    <div class="col-md-4">
                        <input id="parSupTimeEdit" value="${data.parSupTime}" type="date" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        建筑面积
                    </div>
                    <div class="col-md-4">
                        <input id="parAreaEdit" value="${data.parArea}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    设备：
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                         设备总值
                    </div>
                    <div class="col-md-4">
                        <input id="parDevAllvalueEdit" value="${data.parDevAllvalue}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        当年新增设备值
                    </div>
                    <div class="col-md-4">
                        <input id="parDevNewvalueEdit" value="${data.parDevNewvalue}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        自主研制设备值
                    </div>
                    <div class="col-md-4">
                        <input id="selfDevValueEdit" value="${data.selfDevValue}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        社会捐赠设备值
                    </div>
                    <div class="col-md-4">
                        <input id="ssDevValueEdit" value="${data.ssDevValue}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        社会准捐赠设备值
                    </div>
                    <div class="col-md-4">
                        <input id="sswDevValueEdit" value="${data.sswDevValue}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        设备总数
                    </div>
                    <div class="col-md-4">
                        <input id="devNumEdit" value="${data.devNum}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        大型设备数
                    </div>
                    <div class="col-md-4">
                        <input id="devBigNumEdit" value="${data.devBigNum}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    实训项目:
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        总数
                    </div>
                    <div class="col-md-4">
                        <input id="parProNumEdit" value="${data.parProNum}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        主要项目名称
                    </div>
                    <div class="col-md-4">
                        <input id="mainParProEdit" value="${data.mainParPro}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                   学年使用频率（人时）:
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        校内
                    </div>
                    <div class="col-md-4">
                        <input id="schUseFreEdit" value="${data.schUseFre}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        社会
                    </div>
                    <div class="col-md-4">
                        <input id="ssUseFreEdit" value="${data.ssUseFre}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        工位数
                    </div>
                    <div class="col-md-4">
                        <input id="workNumEdit" value="${data.workNum}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        原材料（耗材）费用（万元）
                    </div>
                    <div class="col-md-4">
                        <input id="materCostEdit" value="${data.materCost}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                       设备维护费用
                    </div>
                    <div class="col-md-4">
                        <input id="devMaintCostEdit" value="${data.devMaintCost}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        专职管理人员（名）
                    </div>
                    <div class="col-md-4">
                        <input id="mgeNumEdit" value="${data.mgeNum}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        兼职管理人员（名）
                    </div>
                    <div class="col-md-4">
                        <input id="partMgeNumEdit" value="${data.partMgeNum}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button  id="save" type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        if ("${seeFlag}" == "1"){
            $("#data input").attr("readonly","readonly")
            $("#data select").attr("disabled","disabled")
            $("#save").hide();
        }else {
            $("#data input").removeAttr("readonly")
            $("#data select").removeAttr("disabled")
            $("#save").show();
        }
    });

    function save() {
        if ($("#praNameEdit").val() == "" || $("#praNameEdit").val() == undefined || $("#praNameEdit").val() == null) {
            swal({
                title: "请填写实践基地名称！",
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



