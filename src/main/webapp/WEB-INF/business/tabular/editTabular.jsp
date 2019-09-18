<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/27
  Time: 15:39
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
            <input id="id" hidden value="${tabular.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>表格名称：
                    </div>
                    <div class="col-md-9">
                        <input id="tabularName" placeholder="请填写表格名称" type="text"
                               value="${tabular.tabularName}"></input>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 表格种类：
                        </div>
                        <div class="col-md-9">
                            <select id="tabularType" class="js-example-basic-single"/></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        表格属性：
                    </div>
                    <div class="col-md-9">
                        <input id="tableAttribute" placeholder="请填写表格属性" type="text"
                               value="${tabular.tableAttribute}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 文件上传：
                        </div>
                        <div class="col-md-9">
                            <input id="fileUpload" type="file"/></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveTabular()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDict?name=BGZL", function (data) {
            addOption(data, 'tabularType', '${tabular.tabularType}');
        });
    });

    function saveTabular() {
        if ($("#fileUpload").val() == "") {
            swal({title: "请选择文件！", type: "info"});
            return;
        }
        var formData = new FormData();
        var fileUpload = document.getElementById("fileUpload");
        formData.append("file", fileUpload.files[0]);
        var fileUpload = $("#fileUpload").val();
        var fileUpload_end = fileUpload.split(".");

        if (fileUpload_end[1] == 'bat' || fileUpload_end[1] == "exe") {
            swal({title: "不可上传可执行文件！", type: "info"});
            return;
        }
        var id = $("#id").val();
        var tabularName = $("#tabularName").val();
        var tabularType = $("#tabularType option:selected").val();
        if (tabularName == "" || tabularName == null || tabularName == undefined) {
            swal({
                title: "请填写表格名称!",
                type: "info"
            });
            return;
        }

        if (tabularType == "" || tabularType == null || tabularType == undefined) {
            swal({
                title: "请选择表格种类！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/tabular/checkName", {
            tabularName: tabularName,
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: "名称重复，请重新填写！", type: "error"});
                return;
            } else {
                showSaveLoading();
                $.ajax({
                    url: '<%=request.getContextPath()%>/tabular/saveTabular' +
                    '?id=' + $("#id").val() +
                    '&tabularName=' + tabularName + '&tabularType=' + tabularType +'&tableAttribute=' + $("#tableAttribute").val(),
                    type: "post",
                    processData: false,
                    contentType: false,
                    data: formData,
                    success: function (msg) {
                        hideSaveLoading();
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $("#dialog").modal('hide');
                        $('#tabularGrid').DataTable().ajax.reload();
                    }
                });
            }
        })
    }
</script>