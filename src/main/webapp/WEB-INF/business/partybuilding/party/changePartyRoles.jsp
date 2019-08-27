<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">成员角色变更</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        当前成员角色：
                    </div>
                    <div class="col-md-9">
                        <select id="peopleRoles" value="${memberRoles}" class="js-example-basic-single" disabled
                        ></select>
                    </div>
                </div>
                <div class="form-row" id="activeMolecular">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>转为积极分子时间：
                    </div>
                    <div class="col-md-9">
                        <input id="p_activeMolecularTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                        />
                    </div>
                </div>

                <div class="form-row" id="development">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>转为发展对象时间：
                    </div>
                    <div class="col-md-9">
                        <input id="p_developmentTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                        />
                    </div>
                </div>
                <div class="form-row" id="prepare">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 转为预备党员时间：
                    </div>
                    <div class="col-md-9">
                        <input id="p_prepareTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                        />
                    </div>
                </div>
                <div class="form-row" id="joinParty">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>转为正式党员时间：
                    </div>
                    <div class="col-md-9">
                        <input id="p_joinPartyTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                        />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button"  class="btn btn-success btn-clean" id="turnRoles" onclick="save()">转为${peopleRoles}
            </button>
            <button type="button" class="btn btn-success btn-clean" id="rolesBack" onclick="rolesBack()">回调至${personRoles}
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
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
    $(document).ready(function () {
        var partyRoles = '${memberRoles}';
        if (partyRoles == 0) {
            $("#activeMolecular").show();
            $("#development").hide();
            $("#prepare").hide();
            $("#joinParty").hide();
            $("#rolesBack").hide();
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
            $("#turnRoles").hide();
        }
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DYJS", function (data) {
            addOption(data, 'peopleRoles', '${memberRoles}');
        });
    });

    function save() {
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
                    title: "请填写转为积极分子时间!",
                    type: "info"
                });
                return;
            }
        } else if (peopleRoles == 1) {
            if (development == "" || development == null || development == undefined) {
                swal({
                    title: "请填写转为发展对象时间!",
                    type: "info"
                });
                return;
            }
        } else if (peopleRoles == 2) {
            if (prepare == "" || prepare == null || prepare == undefined) {
                swal({
                    title: "请填写转为预备党员时间!",
                    type: "info"
                });
                return;
            }
        } else if (peopleRoles == 3) {
            if (joinParty == "" || joinParty == null || joinParty == undefined) {
                swal({
                    title: "请填写转为正式党员时间!",
                    type: "info"
                });
                return;
            }
        }
        var ids = '${ids}';
        $.post("<%=request.getContextPath()%>/changePartyRoles", {
            ids: ids,
            activeMolecularTime: $("#p_activeMolecularTime").val(),
            developmentTime: $("#p_developmentTime").val(),
            prepareTime: $("#p_prepareTime").val(),
            joinPartyTime: $("#p_joinPartyTime").val()
        }, function (msg) {
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $("#partyGrid").DataTable().ajax.reload();
        })
    }
    function rolesBack() {
        var ids = '${ids}';
        var memberRoles = '${memberRoles}';
        var peopleRoles;
        if (memberRoles == '1') {
            peopleRoles = 'activemolecular_time';
        } else if (memberRoles == '2') {
            peopleRoles = 'development_time';
        } else if (memberRoles == '3') {
            peopleRoles = 'prepare_time';
        } else if (memberRoles == '4') {
            peopleRoles = 'joinparty_time';
        }
        swal({
            title: "该功能仅限错误操作之后使用，确定要将该人员回调?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "回调",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/backPartyRoles", {
                ids: ids,
                memberRoles: memberRoles,
                peopleRoles: peopleRoles
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#partyGrid").DataTable().ajax.reload();
                $("#dialog").modal('hide');
            });
        })
    }
</script>



