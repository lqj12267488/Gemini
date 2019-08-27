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
            <input id="id" hidden value="${party.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        当前成员角色：
                    </div>
                    <div class="col-md-9">
                        <select id="peopleRoles" class="js-example-basic-single" disabled
                        ></select>
                    </div>
                </div>
                <div class="form-row" id="activeMolecular">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 转为积极分子时间：
                    </div>
                    <div class="col-md-9">
                        <input id="p_activeMolecularTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.activeMolecularTime}"/>
                    </div>
                </div>

                <div class="form-row" id="development">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  转为发展对象时间：
                    </div>
                    <div class="col-md-9">
                        <input id="p_developmentTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.developmentTime}"/>
                    </div>
                </div>
                <div class="form-row" id="prepare">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 转为预备党员时间：
                    </div>
                    <div class="col-md-9">
                        <input id="p_prepareTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.prepareTime}"/>
                    </div>
                </div>
                <div class="form-row" id="joinParty">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 转为正式党员时间：
                    </div>
                    <div class="col-md-9">
                        <input id="p_joinPartyTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.joinPartyTime}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="savePartyRoles()">
                发展为${party.peopleRoles}</button>
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
        var partyRoles = '${party.memberRoles}';
        if (partyRoles == 0) {
            $("#activeMolecular").show();
            $("#development").hide();
            $("#prepare").hide();
            $("#joinParty").hide();
        } else if (partyRoles == 1) {
            $("#activeMolecular").hide();
            $("#development").show();
            $("#prepare").hide();
            $("#joinParty").hide();
        } else if (partyRoles == 2) {
            $("#activeMolecular").hide();
            $("#development").hide();
            $("#prepare").show();
            $("#joinParty").hide();
        } else if (partyRoles == 3) {
            $("#activeMolecular").hide();
            $("#development").hide();
            $("#prepare").hide();
            $("#joinParty").show();
        } else {
            $("#activeMolecular").hide();
            $("#development").hide();
            $("#prepare").hide();
            $("#joinParty").hide();
        }
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DYJS", function (data) {
            addOption(data, 'peopleRoles', '${party.memberRoles}');
        });
    })
    function savePartyRoles() {
        var activeMolecular = $("#p_activeMolecularTime").val();
        var activeMolecularTime = new Date($("#p_activeMolecularTime").val().replace('T', ' ')).getTime();
        var development = $("#p_developmentTime").val();
        var developmentTime = new Date($("#p_developmentTime").val().replace('T', ' ')).getTime();
        var prepare = $("#p_prepareTime").val();
        var prepareTime = new Date($("#p_prepareTime").val().replace('T', ' ')).getTime();
        var joinParty = $("#p_joinPartyTime").val();
        var joinPartyTime = new Date($("#p_joinPartyTime").val().replace('T', ' ')).getTime();
        var peopleRoles = $("#peopleRoles").val()
        if (peopleRoles == 0) {
            if (activeMolecular == "" || activeMolecular == null || activeMolecular == undefined) {
                swal({
                    title: "请填写转为积极分子时间！",
                    type: "info"
                });
                return;
            }
        } else if (peopleRoles == 1) {
            if (development == "" || development == null || development == undefined) {
                swal({
                    title: "请填写转为发展对象时间！",
                    type: "info"
                });
                return;
            }
        } else if (peopleRoles == 2) {
            if (prepare == "" || prepare == null || prepare == undefined) {
                swal({
                    title: "请填写转为预备党员时间！",
                    type: "info"
                });
                return;
            }
        } else if (peopleRoles == 3) {
            if (joinParty == "" || joinParty == null || joinParty == undefined) {
                swal({
                    title: "请填写转为正式党员时间！",
                    type: "info"
                });
                return;
            }
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/updatePartyRolesById", {
            id: $("#id").val(),
            activeMolecularTime: $("#p_activeMolecularTime").val(),
            developmentTime: $("#p_developmentTime").val(),
            prepareTime: $("#p_prepareTime").val(),
            joinPartyTime: $("#p_joinPartyTime").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#partyGrid').DataTable().ajax.reload();
            }
        })
    }

</script>


