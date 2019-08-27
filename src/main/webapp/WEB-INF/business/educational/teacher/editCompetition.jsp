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
            <input id="competitionId" hidden value="${competition.competitionId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>竞赛项目
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="competitionProject" type="text" placeholder="请填写名称" value="${competition.competitionProject}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>竞赛组别
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="competitionGroup" type="text" value="${competition.competitionGroup}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>竞赛级别
                    </div>
                    <div class="col-md-9">
                        <select id="competitionLevel" type="text"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 主办单位
                    </div>
                    <div class="col-md-9">
                        <input id="hostUnit" type="text" value="${competition.hostUnit}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>获奖情况
                    </div>
                    <div class="col-md-9">
                        <input type="text" id="score" value="${competition.score}"/>
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
            addOption(data, 'competitionLevel', '${competition.competitionLevel}');
        });
    });

    function save() {
        var competitionId = $("#competitionId").val();
        var competitionProject = $("#competitionProject").val();
        var competitionGroup = $("#competitionGroup").val();
        var competitionLevel = $("#competitionLevel").val();
        var hostUnit = $("#hostUnit").val();
        var score = $("#score").val();
        console.log(competitionProject);
        if (competitionProject == "" || competitionProject == undefined || competitionProject == null) {
            swal({
                title: "请填写竞赛项目！",
                type: "info"
            });
            return;
        }
        if (competitionGroup == "" || competitionGroup == undefined || competitionGroup == null) {
            swal({
                title: "请填写竞赛组别！",
                type: "info"
            });
            return;
        }
        if (competitionLevel == "" || competitionLevel == undefined || competitionLevel == null) {
            swal({
                title: "请选择竞赛级别！",
                type: "info"
            });
            return;
        }
        if (hostUnit == "" || hostUnit == undefined || hostUnit == null) {
            swal({
                title: "请填写主办单位！",
                type: "info"
            });
            return;
        }
        if (score == "" || score == undefined || score == null) {
            swal({
                title: "请填写获奖情况！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/teacher/competitionSave", {
            competitionId: competitionId,
            competitionProject: competitionProject,
            competitionGroup: competitionGroup,
            competitionLevel: competitionLevel,
            hostUnit: hostUnit,
            score: score
        }, function (msg) {
            // hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })


    }
</script>




