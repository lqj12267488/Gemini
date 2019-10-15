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
                        <span class="iconBtx">*</span>项目名称
                    </div>
                    <div class="col-md-9">
                        <input id="projectnameEdit" value="${data.projectname}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目类别
                    </div>
                    <div class="col-md-9">
                        <%--<input id="projectprogrammeEdit" value="${data.projectprogramme}"/>--%>
                        <select id="projectprogrammeEdit">
                            <option value="专业机构调整与专业认证">专业机构调整与专业认证</option>
                            <option value="精品课程">精品课程</option>
                            <option value="教材建设">教材建设</option>
                            <option value="实践教学与人才培养模式改革创新">实践教学与人才培养模式改革创新</option>
                            <option value="教学团队">教学团队</option>
                            <option value="教学名师奖">教学名师奖</option>
                            <option value="教学评估与教学状态基本数据公布">教学评估与教学状态基本数据公布</option>
                            <option value="对口支援西部地区高等学校">对口支援西部地区高等学校</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>级别
                    </div>
                    <div class="col-md-9">
                        <%--<input id="gradeEdit" value="${data.grade}"/>--%>
                        <select id="gradeEdit">
                            <option value="国家级">国家级</option>
                            <option value="省部级">省部级</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>批准日期
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="ratifydateEdit" value="${data.ratifydateStr}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>人员名单
                    </div>
                    <div class="col-md-9">
                        <input id="staffEdit" value="${data.staff}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>备注
                    </div>
                    <div class="col-md-9">
                        <input id="remarksEdit" value="${data.remarks}"/>
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
        $("#projectprogrammeEdit").val("${data.projectprogramme}")
        $("#gradeEdit").val("${data.grade}")

    });

    function save() {
        if ($("#ordernumberEdit").val() == "" || $("#ordernumberEdit").val() == undefined || $("#ordernumberEdit").val() == null) {
            swal({
                title: "请填写序号！",
                type: "warning"
            });
            return;
        }
        if ($("#projectnameEdit").val() == "" || $("#projectnameEdit").val() == undefined || $("#projectnameEdit").val() == null) {
            swal({
                title: "请填写项目名称！",
                type: "warning"
            });
            return;
        }
        if ($("#projectprogrammeEdit").val() == "" || $("#projectprogrammeEdit").val() == undefined || $("#projectprogrammeEdit").val() == null) {
            swal({
                title: "请填写项目类别！",
                type: "warning"
            });
            return;
        }
        if ($("#gradeEdit").val() == "" || $("#gradeEdit").val() == undefined || $("#gradeEdit").val() == null) {
            swal({
                title: "请填写级别！",
                type: "warning"
            });
            return;
        }
        if ($("#ratifydateEdit").val() == "" || $("#ratifydateEdit").val() == undefined || $("#ratifydateEdit").val() == null) {
            swal({
                title: "请填写批准日期！",
                type: "warning"
            });
            return;
        }
        if ($("#staffEdit").val() == "" || $("#staffEdit").val() == undefined || $("#staffEdit").val() == null) {
            swal({
                title: "请填写人员名单！",
                type: "warning"
            });
            return;
        }
        if ($("#remarksEdit").val() == "" || $("#remarksEdit").val() == undefined || $("#remarksEdit").val() == null) {
            swal({
                title: "请填写备注！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/Programme/saveProgramme", {
            id: "${data.id}",
            ordernumber: $("#ordernumberEdit").val(),
            projectname: $("#projectnameEdit").val(),
            projectprogramme: $("#projectprogrammeEdit").val(),
            grade: $("#gradeEdit").val(),
            ratifydate: $("#ratifydateEdit").val(),
            staff: $("#staffEdit").val(),
            remarks: $("#remarksEdit").val(),
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



