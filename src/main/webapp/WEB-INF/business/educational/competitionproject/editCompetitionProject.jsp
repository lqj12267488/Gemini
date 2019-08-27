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
            <input id="competitionProjectid" hidden value="${competitionProject.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        竞赛项目
                    </div>
                    <div class="col-md-9">
                        <input id="f_competitionProject" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${competitionProject.competitionProject}" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        竞赛级别
                    </div>
                    <div class="col-md-9">
                       <select id="f_competitionLevel"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        主办单位
                    </div>
                    <div class="col-md-9">
                        <input id="f_competitionCompany"  type="text"  onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="60" placeholder="最多输入60个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${competitionProject.competitionCompany}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        年份
                    </div>
                    <div class="col-md-9">
                        <input id="f_year" type="number" min="2000" max="3000"
                               class="validate[required,maxSize[20]] form-control"
                               value="${competitionProject.year}"/>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSJB", function (data) {
            addOption(data, 'f_competitionLevel','${competitionProject.competitionLevel}');
        });
    });

    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_competitionProject").val() == "" || $("#f_competitionProject").val() == "0" || $("#f_competitionProject").val() == undefined) {
            swal({
                title: "请填写竞赛项目！",
                type: "info"
            });
            return;
        }
        if ($("#f_competitionLevel").val() == "" || $("#f_competitionLevel").val() == "0") {
            swal({
                title: "请选择级别！",
                type: "info"
            });
            return;
        }
        if ($("#f_competitionCompany").val() == "" || $("#f_competitionCompany").val() == "0" || $("#f_competitionCompany").val() == undefined) {
            swal({
                title: "请填写主办单位！",
                type: "info"
            });
            return;
        }
        if( $("#f_year").val() == "" || $("#f_year").val() == "0" || $("#f_year").val() == undefined){
            swal({
                title: "请填写年份！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/competitionProject/saveCompetitionProject", {
            id: $("#competitionProjectid").val(),
            competitionProject: $("#f_competitionProject").val(),
            competitionLevel: $("#f_competitionLevel").val(),
            competitionCompany: $("#f_competitionCompany").val(),
            year: $("#f_year").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#competitionProject').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>

