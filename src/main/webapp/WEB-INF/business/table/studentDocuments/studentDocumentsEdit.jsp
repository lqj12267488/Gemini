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
                        <span class="iconBtx">*</span>文件名称及文号
                    </div>
                    <div class="col-md-9">
                        <input id="filenameEdit" value="${data.filename}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>发布日期
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="releasedateEdit" value="${data.releasedateStr}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>发布部门
                    </div>
                    <div class="col-md-9">
                        <input id="releasedeptEdit" value="${data.releasedept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>变更情况
                    </div>
                    <div class="col-md-9">
                        <%--<input id="alterationEdit" value="${data.alteration}"/>--%>
                        <select id="alterationEdit">
                            <option value="新增">新增</option>
                            <option value="修改">修改</option>
                            <option value="取消">取消</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>变更日期
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="alterationdateEdit" value="${data.alterationdateStr}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>负责部门
                    </div>
                    <div class="col-md-9">
                        <input id="responsibledeptEdit" value="${data.responsibledept}"/>
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
        $("#alterationEdit").val("${data.alteration}");
    });

    function save() {
        if ($("#ordernumberEdit").val() == "" || $("#ordernumberEdit").val() == undefined || $("#ordernumberEdit").val() == null) {
            swal({
                title: "请填写序号！",
                type: "warning"
            });
            return;
        }
        if ($("#filenameEdit").val() == "" || $("#filenameEdit").val() == undefined || $("#filenameEdit").val() == null) {
            swal({
                title: "请填写文件名称及文号！",
                type: "warning"
            });
            return;
        }
        if ($("#releasedateEdit").val() == "" || $("#releasedateEdit").val() == undefined || $("#releasedateEdit").val() == null) {
            swal({
                title: "请填写发布日期！",
                type: "warning"
            });
            return;
        }
        if ($("#releasedeptEdit").val() == "" || $("#releasedeptEdit").val() == undefined || $("#releasedeptEdit").val() == null) {
            swal({
                title: "请填写发布部门！",
                type: "warning"
            });
            return;
        }
        if ($("#alterationEdit").val() == "" || $("#alterationEdit").val() == undefined || $("#alterationEdit").val() == null) {
            swal({
                title: "请填写变更情况！",
                type: "warning"
            });
            return;
        }
        if ($("#alterationdateEdit").val() == "" || $("#alterationdateEdit").val() == undefined || $("#alterationdateEdit").val() == null) {
            swal({
                title: "请填写变更日期！",
                type: "warning"
            });
            return;
        }
        if ($("#responsibledeptEdit").val() == "" || $("#responsibledeptEdit").val() == undefined || $("#responsibledeptEdit").val() == null) {
            swal({
                title: "请填写负责部门！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/StudentDocuments/saveStudentDocuments", {
            id: "${data.id}",
            ordernumber: $("#ordernumberEdit").val(),
            filename: $("#filenameEdit").val(),
            releasedate: $("#releasedateEdit").val(),
            releasedept: $("#releasedeptEdit").val(),
            alteration: $("#alterationEdit").val(),
            alterationdate: $("#alterationdateEdit").val(),
            responsibledept: $("#responsibledeptEdit").val(),
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



