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
                               value="${archives.createDept}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        创建人
                    </div>
                    <div class="col-md-9">
                        <input id="creator" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${archives.creator}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="requestDate" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${archives.requestDate}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 文件形成时间
                    </div>
                    <div class="col-md-9">
                        <input id="formatTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${archives.formatTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 一级类别
                    </div>
                    <div class="col-md-9">
                        <select id="oneLevel"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 二级类别
                    </div>
                    <div class="col-md-9">
                        <select id="twoLevel"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  档案类型
                    </div>
                    <div class="col-md-9">
                        <select id="fileType"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  学校类别
                    </div>
                    <div class="col-md-9">
                        <select id="schoolType"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  档案名称
                    </div>
                    <div class="col-md-9">
                        <input id="archivesName" type="text" class="validate[required,maxSize[100]] form-control"
                               placeholder="请填写详细档案名称"
                               value="${archives.archivesName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${archives.remark}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
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
    function save() {
        var formatTime = $("#formatTime").val();
        if (formatTime.substring(4,5) != '-'){
            swal({
                title: "时间格式不正确，年份应为四位数!月份应为两位数！日期应为两位数！",
                type: "info"
            });
            return;
        }
        if ($("#formatTime").val() == "" || $("#formatTime").val() == null || $("#formatTime").val() == undefined) {
            swal({
                title: "请填写文件形成时间!",
                type: "info"
            });
            return;
        }
        if ($("#requestDate").val() == "" || $("#requestDate").val() == null || $("#requestDate").val() == undefined) {
            swal({
                title: "请选择年份!",
                type: "info"
            });
            return;
        }
        if ($("#oneLevel").val() == "" || $("#oneLevel").val() == null || $("#oneLevel").val() == undefined) {
            swal({
                title: "请选择一级类别!",
                type: "info"
            });
            return;
        }
        if ($("#twoLevel").val() == "" || $("#twoLevel").val() == null || $("#twoLevel").val() == undefined) {
            swal({
                title: "请选择二级类别!",
                type: "info"
            });
            return;
        }
        if ($("#fileType").val() == "" || $("#fileType").val() == null || $("#fileType").val() == undefined) {
            swal({
                title: "请选择档案类型!",
                type: "info"
            });
            return;
        }
        if ($("#schoolType").val() == "" || $("#schoolType").val() == null || $("#schoolType").val() == undefined) {
            swal({
                title: "请选择学校类别!",
                type: "info"
            });
            return;
        }
        if ($("#archivesName").val() == "" || $("#archivesName").val() == null || $("#archivesName").val() == undefined) {
            swal({
                title: "请填写档案名称!",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/archives/saveArchives", {
            archivesId:$("#archivesId").val(),
            formatTime:$("#formatTime").val(),
            archivesCode:$("#archivesCode").val(),
            requestDate: $("#requestDate").val(),
            oneLevel: $("#oneLevel").val(),
            twoLevel: $("#twoLevel").val(),
            fileType: $("#fileType").val(),
            editedId: $("#editedId").val(),
            archivesName: $("#archivesName").val(),
            role: $("#role").val(),
            schoolType:$("#schoolType").val(),
            requestFlag:$("#requestFlag").val(),
            remark:$("#remark").val(),
            ptyh:ptyh
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#listGrid').DataTable().ajax.reload();
            }
        })
    }
</script>
