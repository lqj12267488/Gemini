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
                        <span class="iconBtx">*</span>序号
                    </div>
                    <div class="col-md-9">
                        <input id="ordernumberEdit" value="${data.ordernumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>社团代码
                    </div>
                    <div class="col-md-9">
                        <input id="communitycodeEdit" value="${data.communitycode}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>社团名称
                    </div>
                    <div class="col-md-9">
                        <input id="communitynameEdit" value="${data.communityname}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>社团类别
                    </div>
                    <div class="col-md-9">
                        <input id="communitycategoryEdit" value="${data.communitycategory}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>登记日期
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="registrationdateEdit" value="${data.registrationdateStr}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>批准单位
                    </div>
                    <div class="col-md-9">
                        <input id="approvaldepartmentEdit" value="${data.approvaldepartment}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>注册单位
                    </div>
                    <div class="col-md-9">
                        <input id="registrantorganizationEdit" value="${data.registrantorganization}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>现有成员
                    </div>
                    <div class="col-md-9">
                        <input id="existingmemberEdit" value="${data.existingmember}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>姓名
                    </div>
                    <div class="col-md-9">
                        <input id="nameEdit" value="${data.name}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>所在年级
                    </div>
                    <div class="col-md-9">
                        <input id="gradeEdit" value="${data.grade}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>活动经费
                    </div>
                    <div class="col-md-9">
                        <input id="moneyEdit" value="${data.money}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>是否设有学分(学时)
                    </div>
                    <div class="col-md-9">
                        <%--<input id="creditEdit" value="${data.credit}"/>--%>
                        <select id="creditEdit">
                            <option value="是">是</option>
                            <option value="否">否</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>是否有获奖项目
                    </div>
                    <div class="col-md-9">
                        <%--<input id="awardsEdit" value="${data.awards}"/>--%>
                        <select id="awardsEdit">
                            <option value="是">是</option>
                            <option value="否">否</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学校指导部门
                    </div>
                    <div class="col-md-9">
                        <input id="guidancedepartmentEdit" value="${data.guidancedepartment}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>指导教师名单
                    </div>
                    <div class="col-md-9">
                        <input id="instructorsEdit" value="${data.instructors}"/>
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

        $("#creditEdit").val("${data.credit}");
        $("#awardsEdit").val("${data.awards}");
    });

    function save() {
        if ($("#ordernumberEdit").val() == "" || $("#ordernumberEdit").val() == undefined || $("#ordernumberEdit").val() == null) {
            swal({
                title: "请填写序号！",
                type: "warning"
            });
            return;
        }
        if ($("#communitycodeEdit").val() == "" || $("#communitycodeEdit").val() == undefined || $("#communitycodeEdit").val() == null) {
            swal({
                title: "请填写社团代码！",
                type: "warning"
            });
            return;
        }
        if ($("#communitynameEdit").val() == "" || $("#communitynameEdit").val() == undefined || $("#communitynameEdit").val() == null) {
            swal({
                title: "请填写社团名称！",
                type: "warning"
            });
            return;
        }
        if ($("#communitycategoryEdit").val() == "" || $("#communitycategoryEdit").val() == undefined || $("#communitycategoryEdit").val() == null) {
            swal({
                title: "请填写社团类别！",
                type: "warning"
            });
            return;
        }
        if ($("#registrationdateEdit").val() == "" || $("#registrationdateEdit").val() == undefined || $("#registrationdateEdit").val() == null) {
            swal({
                title: "请填写登记日期！",
                type: "warning"
            });
            return;
        }
        if ($("#approvaldepartmentEdit").val() == "" || $("#approvaldepartmentEdit").val() == undefined || $("#approvaldepartmentEdit").val() == null) {
            swal({
                title: "请填写批准单位！",
                type: "warning"
            });
            return;
        }
        if ($("#registrantorganizationEdit").val() == "" || $("#registrantorganizationEdit").val() == undefined || $("#registrantorganizationEdit").val() == null) {
            swal({
                title: "请填写注册单位！",
                type: "warning"
            });
            return;
        }
        if ($("#existingmemberEdit").val() == "" || $("#existingmemberEdit").val() == undefined || $("#existingmemberEdit").val() == null) {
            swal({
                title: "请填写现有成员！",
                type: "warning"
            });
            return;
        }
        if ($("#nameEdit").val() == "" || $("#nameEdit").val() == undefined || $("#nameEdit").val() == null) {
            swal({
                title: "请填写姓名！",
                type: "warning"
            });
            return;
        }
        if ($("#gradeEdit").val() == "" || $("#gradeEdit").val() == undefined || $("#gradeEdit").val() == null) {
            swal({
                title: "请填写所在年级！",
                type: "warning"
            });
            return;
        }
        if ($("#moneyEdit").val() == "" || $("#moneyEdit").val() == undefined || $("#moneyEdit").val() == null) {
            swal({
                title: "请填写活动经费！",
                type: "warning"
            });
            return;
        }
        if ($("#creditEdit").val() == "" || $("#creditEdit").val() == undefined || $("#creditEdit").val() == null) {
            swal({
                title: "请填写是否设有学分(学时)！",
                type: "warning"
            });
            return;
        }
        if ($("#awardsEdit").val() == "" || $("#awardsEdit").val() == undefined || $("#awardsEdit").val() == null) {
            swal({
                title: "请填写是否有获奖项目！",
                type: "warning"
            });
            return;
        }
        if ($("#guidancedepartmentEdit").val() == "" || $("#guidancedepartmentEdit").val() == undefined || $("#guidancedepartmentEdit").val() == null) {
            swal({
                title: "请填写学校指导部门！",
                type: "warning"
            });
            return;
        }
        if ($("#instructorsEdit").val() == "" || $("#instructorsEdit").val() == undefined || $("#instructorsEdit").val() == null) {
            swal({
                title: "请填写指导教师名单！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/Associations/saveAssociations", {
            id: "${data.id}",
            ordernumber: $("#ordernumberEdit").val(),
            communitycode: $("#communitycodeEdit").val(),
            communityname: $("#communitynameEdit").val(),
            communitycategory: $("#communitycategoryEdit").val(),
            registrationdate: $("#registrationdateEdit").val(),
            approvaldepartment: $("#approvaldepartmentEdit").val(),
            registrantorganization: $("#registrantorganizationEdit").val(),
            existingmember: $("#existingmemberEdit").val(),
            name: $("#nameEdit").val(),
            grade: $("#gradeEdit").val(),
            money: $("#moneyEdit").val(),
            credit: $("#creditEdit").val(),
            awards: $("#awardsEdit").val(),
            guidancedepartment: $("#guidancedepartmentEdit").val(),
            instructors: $("#instructorsEdit").val(),
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



