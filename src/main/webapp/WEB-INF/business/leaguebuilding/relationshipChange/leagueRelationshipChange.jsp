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
        <div class="modal-header" style="height: 50px">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="ids" hidden value="${ids}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 变更类型：
                    </div>
                    <div class="col-md-9">
                        <select id="relationshipChangeType" class="js-example-basic-single" onchange="changeType()"
                        ></select>
                    </div>
                </div>
                <div class="form-row" id="branch">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 转至团组织：
                    </div>
                    <div class="col-md-9">
                        <select id="branchName" class="js-example-basic-single"
                        ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="relationshipRemark" type="text"
                                  class="validate[required,maxSize[20]] form-control"
                        ></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveRelationship()">
                保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $("#branch").hide();
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " branch_name ",
                tableName: "T_DT_LEAGUEBRANCH",
                where: " WHERE length(nvl(ID,''))>3",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "branchName", '${league.branchId}');
            });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TYBGLX", function (data) {
            addOption(data, 'relationshipChangeType', '${league.relationshipChangeType}');
        });
    })
    function saveRelationship() {
        var relationshipChangeType = $("#relationshipChangeType option:selected").val();
        var branchName = $("#branchName option:selected").val();
        if (relationshipChangeType == '' || relationshipChangeType == null || relationshipChangeType == undefined) {
            swal({
                title: "请选择团组织关系变更类型！",
                type: "info"
            });
            return;
        }if(relationshipChangeType!='2'){
            if (branchName == '' || branchName == null || branchName == undefined) {
                swal({
                    title: "请选择要转入的团组织！",
                    type: "info"
                });
                return;
            }
        }
        if (relationshipChangeType == 1 || relationshipChangeType == 3) {
            var branchName = $("#branchName option:selected").val();
            if (branchName == '' || branchName == null || branchName == undefined) {
                swal({
                    title: "请选择团组织",
                    type: "info"
                });
                return;
            }
        }
        var ids = $("#ids").val();
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/league/updateRelationshipByIds", {
            ids: ids,
            relationshipChangeType: relationshipChangeType,
            branchId: $("#branchName option:selected").val(),
            relationshipRemark: $("#relationshipRemark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#leagueGrid').DataTable().ajax.reload();
            }
        })
    }
    //跟据党组织关系变更类型判断是否需要变更党支部信息
    function changeType() {
        var relationshipChangeType = $("#relationshipChangeType option:selected").val();
        if (relationshipChangeType == 1 || relationshipChangeType == 3) {
            $("#branch").show();
        } else {
            $("#branch").hide();
        }
    }
</script>


