<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <span style="font-size: 14px;">${head}</span>
            <input id="rewardId" hidden value="${rewardAndPunishment.rewardId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <select id="rewardName" />
                            <%--<input id="rewardName" type="text" placeholder="请填写名称"--%>
                                   <%--value="${rewardAndPunishment.rewardName}"/>--%>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>级别
                    </div>
                    <div class="col-md-9">
                        <select id="rewardLevel" type="text"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>认定单位
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="cognizanceUnit" type="text" value="${rewardAndPunishment.cognizanceUnit}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 认定过程
                    </div>
                    <div class="col-md-9">
                        <input id="cognizanceProcess" type="text" value="${rewardAndPunishment.cognizanceProcess}" placeholder="请写明何种原因奖励或处罚"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>认定结论
                    </div>
                    <div class="col-md-9">
                        <input type="text" id="cognizanceConclusion"
                               value="${rewardAndPunishment.cognizanceConclusion}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>认定时间
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="cognizanceDate" value="${rewardAndPunishment.cognizanceDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>有效期
                    </div>
                    <div class="col-md-9">
                        <input type="text" id="termValidity" value="${rewardAndPunishment.termValidity}" placeholder="年月日起至年月日止。或无"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSJB", function (data) {
            addOption(data, 'rewardLevel', '${rewardAndPunishment.rewardLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JLCF", function (data) {
            addOption(data, 'rewardName','${rewardAndPunishment.rewardName}');
        });
    });

    function save() {
        var rewardId = $("#rewardId").val();
        var rewardName = $("#rewardName option:selected").val();
        var rewardLevel = $("#rewardLevel").val();
        var cognizanceUnit = $("#cognizanceUnit").val();
        var cognizanceProcess = $("#cognizanceProcess").val();
        var cognizanceConclusion = $("#cognizanceConclusion").val();
        var cognizanceDate = $("#cognizanceDate").val();
        var termValidity = $("#termValidity").val();
        if (rewardName == "" || rewardName == undefined || rewardName == null) {
            swal({
                title: "请填写名称！",
                type: "info"
            });
            return;
        }
        if (rewardLevel == "" || rewardLevel == undefined || rewardLevel == null) {
            swal({
                title: "请选择级别！",
                type: "info"
            });
            return;
        }
        if (cognizanceUnit == "" || cognizanceUnit == undefined || cognizanceUnit == null) {
            swal({
                title: "请填写认定单位！",
                type: "info"
            });
            return;
        }
        if (cognizanceProcess == "" || cognizanceProcess == undefined || cognizanceProcess == null) {
            swal({
                title: "请填写认定过程！",
                type: "info"
            });
            return;
        }
        if (cognizanceConclusion == "" || cognizanceConclusion == undefined || cognizanceConclusion == null) {
            swal({
                title: "请填写认定结论 ！",
                type: "info"
            });
            return;
        }
        if (cognizanceDate == "" || cognizanceDate == undefined || cognizanceDate == null) {
            swal({
                title: "请填写认定时间！",
                type: "info"
            });
            return;
        }
        if (termValidity == "" || termValidity == undefined || termValidity == null) {
            swal({
                title: "请填写有效期！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/teacher/rewardSave", {
            rewardId: rewardId,
            rewardName: rewardName,
            rewardLevel: rewardLevel,
            cognizanceUnit: cognizanceUnit,
            cognizanceProcess: cognizanceProcess,
            cognizanceConclusion: cognizanceConclusion,
            cognizanceDate: cognizanceDate,
            termValidity: termValidity
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            });
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })


    }
</script>




