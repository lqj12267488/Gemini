<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/6 0006
  Time: 下午 2:59
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
            <input id="reId" hidden value="${reportManagement.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row" id="deptSel">
                    <div class="col-md-3 tar">
                        部门
                    </div>
                    <div class="col-md-9">
                        <input id="reDept" type="text" readonly value="${reportManagement.requestDept}"
                               class="validate[required,maxSize[100]] form-control"
                        />
                    </div>
                </div>
                <div class="form-row" id="classSel" hidden>
                    <div class="col-md-3 tar">
                        班级
                    </div>
                    <div class="col-md-9">
                        <input id="reClass" type="text" readonly value="${reportManagement.requestDept}"
                               class="validate[required,maxSize[100]] form-control"
                        />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="reManager" type="text" readonly value="${reportManagement.manager}"
                               class="validate[required,maxSize[100]] form-control"
                        />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="reDate" type="datetime-local" readonly
                               class="validate[required,maxSize[100]] form-control" value="${reportManagement.requestDate}"
                        />
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>申诉内容
                    </div>
                    <div class="col-md-9">
                        <input id="rcProjectName" type="text" value="${reportManagement.reportContent}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 申诉类型
                    </div>
                    <div class="col-md-9">
                        <select id="l_request"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="requestTypeShowSel" type="hidden" value="${reportManagement.reportType}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        if ('${reportManagement.studentTeacherType}' == '0') {
            $("#classSel").show();
            $("#deptSel").hide();
        }else{
            $("#deptSel").show();
            $("#classSel").hide();
        }


        $(".form_datetime").datetimepicker({
            format: "dd MM yyyy - hh:ii"
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SSLX", function (data) {
            addOption(data, 'l_request', $("#requestTypeShowSel").val());
        });

       /* if ($("#requestTypeShowSel").val() == "1") {
            $("#nameSel").show();
            $("#nameSel1").hide();
        } else if ($("#requestTypeShowSel").val() == "2" || $("#requestTypeShowSel").val() == null || $("#requestTypeShowSel").val() == "undefined") {
            $("#nameSel").hide();
            $("#nameSel1").show();

        }*/
    })


    function save() {

        if ($("#rcProjectName").val() == "" || $("#rcProjectName").val() == null) {
            swal({
                title: "请填写申诉内容",
                type: "info"
            });
            return;
        }
        if ($("#l_request").val() == "" || $("#l_request").val() == null) {
            swal({
                title: "请选择申诉类型",
                type: "info"
            });
            return;
        }
        var reDate = $("#reDate").val().replace("T", " ");

        $.post("<%=request.getContextPath()%>/reportManagement/saveReportManagement", {
            id: $("#reId").val(),
            requestDate: reDate,
            reportType: $("#l_request").val(),
            reportContent: $("#rcProjectName").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#crTable').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>
