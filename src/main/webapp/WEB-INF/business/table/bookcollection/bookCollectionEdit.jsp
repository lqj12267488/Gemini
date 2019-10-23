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
                        <span class="iconBtx">*</span>总册数
                    </div>
                    <div class="col-md-9">
                        <input id="totalNumberEdit" value="${data.totalNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>本学年新增数
                    </div>
                    <div class="col-md-9">
                        <input id="schoolYearAddEdit" value="${data.schoolYearAdd}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>中文纸质专业期刊
                    </div>
                    <div class="col-md-9">
                        <input id="chinesePaperJournalEdit" value="${data.chinesePaperJournal}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>外文纸质专业期刊
                    </div>
                    <div class="col-md-9">
                        <input id="foreignPaperJournalsEdit" value="${data.foreignPaperJournals}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>电子专业期刊
                    </div>
                    <div class="col-md-9">
                        <input id="electronicJournalEdit" value="${data.electronicJournal}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>年份
                    </div>
                    <div class="col-md-9">
                        <select id="years" value="${data.year}"/>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'years','${data.year}');
        });
    });

    function save() {
        if ($("#totalNumberEdit").val() == "" || $("#totalNumberEdit").val() == undefined || $("#totalNumberEdit").val() == null) {
            swal({
                title: "请填写总册数！",
                type: "warning"
            });
            return;
        }
        if ($("#schoolYearAddEdit").val() == "" || $("#schoolYearAddEdit").val() == undefined || $("#schoolYearAddEdit").val() == null) {
            swal({
                title: "请填写本学年新增数！",
                type: "warning"
            });
            return;
        }
        if ($("#chinesePaperJournalEdit").val() == "" || $("#chinesePaperJournalEdit").val() == undefined || $("#chinesePaperJournalEdit").val() == null) {
            swal({
                title: "请填写中文纸质专业期刊！",
                type: "warning"
            });
            return;
        }
        if ($("#foreignPaperJournalsEdit").val() == "" || $("#foreignPaperJournalsEdit").val() == undefined || $("#foreignPaperJournalsEdit").val() == null) {
            swal({
                title: "请填写外文纸质专业期刊！",
                type: "warning"
            });
            return;
        }
        if ($("#electronicJournalEdit").val() == "" || $("#electronicJournalEdit").val() == undefined || $("#electronicJournalEdit").val() == null) {
            swal({
                title: "请填写电子专业期刊！",
                type: "warning"
            });
            return;
        }
        if ($("#years").val() == "" || $("#years").val() == undefined || $("#years").val() == null) {
            swal({
                title: "请选择年份！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/bookcollection/saveBookCollection", {
            id: "${data.id}",
            totalNumber: $("#totalNumberEdit").val(),
            schoolYearAdd: $("#schoolYearAddEdit").val(),
            chinesePaperJournal: $("#chinesePaperJournalEdit").val(),
            foreignPaperJournals: $("#foreignPaperJournalsEdit").val(),
            electronicJournal: $("#electronicJournalEdit").val(),
            year:$("#years").val(),
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



