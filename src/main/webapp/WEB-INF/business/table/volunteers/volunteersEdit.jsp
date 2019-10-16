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
                        <span class="iconBtx">*</span>学校分管部门
                    </div>
                    <div class="col-md-9">
                        <input id="departmentEdit" value="${data.department}"/>
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
                        <span class="iconBtx">*</span>成立日期
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="founddateEdit" value="${data.founddateStr}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>总数
                    </div>
                    <div class="col-md-9">
                        <input id="sumEdit" value="${data.sum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教工数
                    </div>
                    <div class="col-md-9">
                        <input id="teachingstaffnumberEdit" value="${data.teachingstaffnumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学生数
                    </div>
                    <div class="col-md-9">
                        <input id="studentnumberEdit" value="${data.studentnumber}"/>
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
                        <span class="iconBtx">*</span>单位职务
                    </div>
                    <div class="col-md-9">
                        <input id="jobEdit" value="${data.job}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>主要活动内容
                    </div>
                    <div class="col-md-9">
                        <input id="activitycontentEdit" value="${data.activitycontent}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>总数(人次)
                    </div>
                    <div class="col-md-9">
                        <input id="personsumEdit" value="${data.personsum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>获得证书数
                    </div>
                    <div class="col-md-9">
                        <input id="certificatenumberEdit" value="${data.certificatenumber}"/>
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
        if ($("#departmentEdit").val() == "" || $("#departmentEdit").val() == undefined || $("#departmentEdit").val() == null) {
            swal({
                title: "请填写学校分管部门！",
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
        if ($("#founddateEdit").val() == "" || $("#founddateEdit").val() == undefined || $("#founddateEdit").val() == null) {
            swal({
                title: "请填写成立日期！",
                type: "warning"
            });
            return;
        }
        if ($("#sumEdit").val() == "" || $("#sumEdit").val() == undefined || $("#sumEdit").val() == null) {
            swal({
                title: "请填写总数！",
                type: "warning"
            });
            return;
        }
        if ($("#teachingstaffnumberEdit").val() == "" || $("#teachingstaffnumberEdit").val() == undefined || $("#teachingstaffnumberEdit").val() == null) {
            swal({
                title: "请填写教工数！",
                type: "warning"
            });
            return;
        }
        if ($("#studentnumberEdit").val() == "" || $("#studentnumberEdit").val() == undefined || $("#studentnumberEdit").val() == null) {
            swal({
                title: "请填写学生数！",
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
        if ($("#jobEdit").val() == "" || $("#jobEdit").val() == undefined || $("#jobEdit").val() == null) {
            swal({
                title: "请填写单位职务！",
                type: "warning"
            });
            return;
        }
        if ($("#activitycontentEdit").val() == "" || $("#activitycontentEdit").val() == undefined || $("#activitycontentEdit").val() == null) {
            swal({
                title: "请填写主要活动内容！",
                type: "warning"
            });
            return;
        }
        if ($("#personsumEdit").val() == "" || $("#personsumEdit").val() == undefined || $("#personsumEdit").val() == null) {
            swal({
                title: "请填写总数(人次)！",
                type: "warning"
            });
            return;
        }
        if ($("#certificatenumberEdit").val() == "" || $("#certificatenumberEdit").val() == undefined || $("#certificatenumberEdit").val() == null) {
            swal({
                title: "请填写获得证书数！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/volunteers/saveVolunteers", {
            id: "${data.id}",
            department: $("#departmentEdit").val(),
            communitycode: $("#communitycodeEdit").val(),
            communityname: $("#communitynameEdit").val(),
            founddate: $("#founddateEdit").val(),
            sum: $("#sumEdit").val(),
            teachingstaffnumber: $("#teachingstaffnumberEdit").val(),
            studentnumber: $("#studentnumberEdit").val(),
            name: $("#nameEdit").val(),
            job: $("#jobEdit").val(),
            activitycontent: $("#activitycontentEdit").val(),
            personsum: $("#personsumEdit").val(),
            certificatenumber: $("#certificatenumberEdit").val(),
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



