<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2018/1/25
  Time: 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        创建部门
                    </div>
                    <div class="col-md-9">
                        <input id="createDept" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${archives.createDept}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        创建人
                    </div>
                    <div class="col-md-9">
                        <input id="creator" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${archives.creator}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="requestDate" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${archives.requestDate}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 一级类别
                    </div>
                    <div class="col-md-9">
                        <select id="oneLevel" disabled="disabled"  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 二级类别
                    </div>
                    <div class="col-md-9">
                        <select id="twoLevel" disabled="disabled"  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  档案类型
                    </div>
                    <div class="col-md-9">
                        <select id="fileType" disabled="disabled"  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  学校类别
                    </div>
                    <div class="col-md-9">
                        <select id="schoolType" disabled="disabled"  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  档案名称
                    </div>
                    <div class="col-md-9">
                        <input id="archivesName" readonly="readonly" type="text" class="validate[required,maxSize[100]] form-control"
                               placeholder="请填写详细档案名称"
                               value="${archives.archivesName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        文件形成时间
                    </div>
                    <div class="col-md-9">
                        <input readonly="readonly" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${archives.formatTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark" readonly="readonly" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${archives.remark}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        建议：
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark1" maxlength="200" placeholder="最多输入200个字"
                                  class="validate[required,maxSize[100]] form-control"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="auditBtn" class="btn btn-success btn-clean" onclick="auditBtn()">通过</button>
            <button type="button" id="rejectBtn" class="btn btn-default btn-clean" onclick="rejectBtn()">驳回</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
    <input id="archivesId" hidden value="${archives.archivesId}">
    <input id="archivesCode" hidden value="${archives.archivesCode}">
    <input id="editedId" hidden value="${archives.editedId}">
    <input id="requestFlag" hidden value="${archives.requestFlag}">
    <input id="role" hidden value="${role}">
</div>
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>
<script>
    var ptyh='${ptyh}';
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        var id = $("#archivesId").val();
        if ($("#archivesId").val() != '') {
            $("#fileType").attr("disabled", "disabled");
        }
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "TYPE_ID",
                text: "TYPE_NAME",
                tableName: "DZDA_TYPE",
                where: "WHERE PARENT_TYPE_ID='0'",
                orderby: "ORDER BY TYPE_ID"
            }
            , function (data) {
                addOption(data, 'oneLevel', '${archives.oneLevel}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "TYPE_ID",
                text: "TYPE_NAME",
                tableName: "DZDA_TYPE",
                orderby: "ORDER BY TYPE_ID"
            }
            , function (data) {
                addOption(data, 'twoLevel', '${archives.twoLevel}');
            });
        $("#twoLevel").append("<option value='' selected>请选择</option>");
        $("#oneLevel").change(function () {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: "TYPE_ID",
                    text: "TYPE_NAME",
                    tableName: "DZDA_TYPE",
                    where: "WHERE PARENT_TYPE_ID ='" + $("#oneLevel").val() + "'",
                    orderby: "ORDER BY TYPE_ID"
                }
                , function (data) {
                    addOption(data, 'twoLevel', '${archives.twoLevel}');
                });
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'yearCode', '${archives.yearCode}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DALX", function (data) {
            addOption(data, 'fileType', '${archives.fileType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXLB", function (data) {
            addOption(data, 'schoolType', '${archives.schoolType}');
        });

    })
    function auditBtn() {
        $.post("<%=request.getContextPath()%>/archives/saveArchivesRequest", {
            archivesId: $("#archivesId").val(),
            archivesName:$("#archivesName").val(),
            archivesCode:$("#archivesCode").val(),
            remark:$("#remark1").val(),
            requestFlag:"5",
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg, type: "success"
                }, function () {
                    window.location.reload()
                });
            }
        })
    }
    function rejectBtn() {
        if ($("#remark1").val() == "" || $("#remark1").val() == null || $("#remark1").val() == undefined) {
            swal({
                title: "请填写修改建议!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/archives/updateArchivesRemark", {
            archivesId: $("#archivesId").val(),
            archivesName:$("#archivesName").val(),
            archivesCode:$("#archivesCode").val(),
            remark:$("#remark1").val(),
            requestFlag:"4",
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg, type: "success"
                }, function () {
                    window.location.reload()
                });
            }
        })
    }
</script>
