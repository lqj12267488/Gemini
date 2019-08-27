<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%--新增页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="awardWinningid" hidden value="${awardWinning.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        姓名
                    </div>
                    <div class="col-md-9">
                        <input id="f_projectName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${awardWinning.name}" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        竞赛名
                    </div>
                    <div class="col-md-9">
                        <select id="f_reason"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        获奖时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_appraisalTime" type="month"
                               class="validate[required,maxSize[20]] form-control"
                               value="${awardWinning.awardTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        奖项
                    </div>
                    <div class="col-md-9">
                        <input id="f_peopleNum"  type="text"  onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="60" placeholder="最多输入60个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${awardWinning.prize}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id:"id",
                text:"competition_project",
                tableName:"T_JW_COMPETITION_PROJECT",
                where:"WHERE valid_flag ='1'",
                orderBy:""}
            , function (data) {
                addOption(data, 'f_reason','${awardWinning.competitionName}');
            });
    })

    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_projectName").val() == "" || $("#f_projectName").val() == "0" || $("#f_projectName").val() == undefined) {
            swal({
                title: "请填写项目名称！",
                type: "info"
            });
            return;
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0") {
            swal({
                title: "请选择竞赛名！",
                type: "info"
            });
            return;
        }
        if ($("#f_appraisalTime").val() == "" || $("#f_appraisalTime").val() == "0" || $("#f_appraisalTime").val() == undefined) {
            swal({
                title: "请填写获奖时间！",
                type: "info"
            });
            return;
        }
        if( $("#f_peopleNum").val() == "" || $("#f_peopleNum").val() == "0" || $("#f_peopleNum").val() == undefined){
            swal({
                title: "请填写奖项！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/awardWinning/saveAwardWinning", {
            id: $("#awardWinningid").val(),
            name: $("#f_projectName").val(),
            awardTime: $("#f_appraisalTime").val(),
            competitionName: $("#f_reason").val(),
            prize: $("#f_peopleNum").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#awardWinning').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>

