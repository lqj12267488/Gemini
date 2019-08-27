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
            <input id="dept" type="hidden" value="${teachingResult.resultPersonDeptId}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        成员类型：
                    </div>
                    <div class="col-md-9">
                        <select id="peopleType" class="js-example-basic-single" onchange="autoComplete()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        姓名：
                    </div>
                    <div class="col-md-9">
                        <input id="partyMembersId" type="text" value="${party.personId}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        成员来源：
                    </div>
                    <div class="col-md-9">
                        <select id="personSource"
                                class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        所属党支部：
                    </div>
                    <div class="col-md-9">
                        <select id="branchName"
                                class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        成员角色：
                    </div>
                    <div class="col-md-9">
                        <select id="partyRoles" class="js-example-basic-single" onchange="changePartyRoles()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        第一培养人：
                    </div>
                    <div class="col-md-9">
                        <input id="cultivatePeopleId1" type="text" value="${party.firstCultivatePeopleId}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        第二培养人：
                    </div>
                    <div class="col-md-9">
                        <input id="cultivatePeopleId2" type="text" value="${party.secondCultivatePeopleId}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请入党时间：
                    </div>
                    <div class="col-md-9">
                        <input id="applyTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.applyTime}"/>
                    </div>
                </div>
                <div class="form-row" id="activeMolecular">
                    <div class="col-md-3 tar">
                        转为积极分子时间：
                    </div>
                    <div class="col-md-9">
                        <input id="activeMolecularTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.activeMolecularTime}"/>
                    </div>
                </div>

                <div class="form-row" id="development">
                    <div class="col-md-3 tar">
                        转为发展对象时间：
                    </div>
                    <div class="col-md-9">
                        <input id="developmentTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.developmentTime}"/>
                    </div>
                </div>
                <div class="form-row" id="prepare">
                    <div class="col-md-3 tar">
                        转为预备党员时间：
                    </div>
                    <div class="col-md-9">
                        <input id="prepareTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.prepareTime}"/>
                    </div>
                </div>
                <div class="form-row" id="joinParty">
                    <div class="col-md-3 tar">
                        转为正式党员时间：
                    </div>
                    <div class="col-md-9">
                        <input id="joinPartyTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.joinPartyTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark" type="text"
                                  class="validate[required,maxSize[20]] form-control"
                                  value="${party.remark}"></textarea>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveParty()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " branch_name ",
                tableName: "T_DT_PARTYBRANCH",
                where: " WHERE 1 = 1",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "branchName", '${party.branchId}');
            });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TYDXLX", function (data) {
            addOption(data, 'peopleType', '${party.personType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DYLY", function (data) {
            addOption(data, 'personSource', '${party.personSource}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DYJS", function (data) {
            addOption(data, 'partyRoles', '${party.memberRoles}');
        });
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#cultivatePeopleId1").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#cultivatePeopleId1").val(ui.item.label);
                    $("#cultivatePeopleId1").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#cultivatePeopleId2").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#cultivatePeopleId2").val(ui.item.label);
                    $("#cultivatePeopleId2").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    })

    function autoComplete() {
        if ($("#peopleType option:selected").val() == '0') {
            $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
                $("#partyMembersId").autocomplete({
                    source: data,
                    select: function (event, ui) {
                        $("#partyMembersId").val(ui.item.label);
                        $("#partyMembersId").attr("keycode", ui.item.value);
                        return false;
                    }
                }).data("ui-autocomplete")._renderItem = function (ul, item) {
                    return $("<li>")
                        .append("<a>" + item.label + "</a>")
                        .appendTo(ul);
                };
            })
        } else {
            $.get("<%=request.getContextPath()%>/common/getStudentClass", function (data) {
                $("#partyMembersId").autocomplete({
                    source: data,
                    select: function (event, ui) {
                        $("#partyMembersId").val(ui.item.label);
                        $("#partyMembersId").attr("keycode", ui.item.value);
                        return false;
                    }
                }).data("ui-autocomplete")._renderItem = function (ul, item) {
                    return $("<li>")
                        .append("<a>" + item.label + "</a>")
                        .appendTo(ul);
                };
            })
        }
    }

    function saveParty() {
        var peopleType = $("#peopleType option:selected").val();
        var personSource = $("#personSource option:selected").val();
        var personId = $("#partyMembersId").val();
        var partyRoles = $("#partyRoles option:selected").val();
        var applyTime =  new Date($("#applyTime").val().replace('T',' ')).getTime();
        var activeMolecularTime = new Date($("#activeMolecularTime").val().replace('T',' ')).getTime();
        var developmentTime = new Date($("#developmentTime").val().replace('T',' ')).getTime();
        var prepareTime = new Date($("#prepareTime").val().replace('T',' ')).getTime();
        var joinPartyTime = new Date($("#joinPartyTime").val().replace('T',' ')).getTime();
        if (peopleType == "" || peopleType == null || peopleType == undefined) {
            alert("请先选择成员类型!");
            return;
        }
        if (personId == "" || personId == null || personId == undefined) {
            alert("请填写姓名！");
            return;
        }
        if (personSource == "" || personSource == null || personSource == undefined) {
            alert("请选择成员来源！");
            return;
        }
        if ($("#branchName option:selected").val() == "" || $("#branchName option:selected").val() == null || $("#branchName option:selected").val() == undefined) {
            alert("请选择党支部！");
            return;
        }
        if (partyRoles == "" || partyRoles == null || partyRoles == undefined) {
            alert("请选择成员角色！");
            return;
        } else {
            if (partyRoles == 0) {
                if (applyTime == "" || applyTime == null || applyTime == undefined) {
                    alert("请填写申请入党时间！");
                    return;
                }
            } else if (partyRoles == 1) {
                if (applyTime == "" || applyTime == null || applyTime == undefined) {
                    alert("请填写申请入党时间！");
                    return;
                }
                if (activeMolecularTime == "" || activeMolecularTime == null || activeMolecularTime == undefined) {
                    alert("请填写转为积极分子时间！");
                    return;
                }
            } else if (partyRoles == 2) {
                if (applyTime == "" || applyTime == null || applyTime == undefined) {
                    alert("请填写申请入党时间！");
                    return;
                }
                if (activeMolecularTime == "" || activeMolecularTime == null || activeMolecularTime == undefined) {
                    alert("请填写转为积极分子时间！");
                    return;
                }
                if (developmentTime == "" || developmentTime == null || developmentTime == undefined) {
                    alert("请填写转为发展对象时间！");
                    return;
                }
            } else if (partyRoles == 3) {
                if (applyTime == "" || applyTime == null || applyTime == undefined) {
                    alert("请填写申请入党时间！");
                    return;
                }
                if (activeMolecularTime == "" || activeMolecularTime == null || activeMolecularTime == undefined) {
                    alert("请填写转为积极分子时间！");
                    return;
                }
                if (developmentTime == "" || developmentTime == null || developmentTime == undefined) {
                    alert("请填写转为发展对象时间！");
                    return;
                }
                if (prepareTime == "" || prepareTime == null || prepareTime == undefined) {
                    alert("请填写转为预备党员时间！");
                    return;
                }
            } else if (partyRoles == 4) {
                if (applyTime == "" || applyTime == null || applyTime == undefined) {
                    alert("请填写申请入党时间！");
                    return;
                }
                if (activeMolecularTime == "" || activeMolecularTime == null || activeMolecularTime == undefined) {
                    alert("请填写转为积极分子时间！");
                    return;
                }
                if (developmentTime == "" || developmentTime == null || developmentTime == undefined) {
                    alert("请填写转为发展对象时间！");
                    return;
                }
                if (prepareTime == "" || prepareTime == null || prepareTime == undefined) {
                    alert("请填写转为预备党员时间！");
                    return;
                }
                if (joinPartyTime == "" || joinPartyTime == null || joinPartyTime == undefined) {
                    alert("请填写转为正式党员时间！");
                    return;
                }
            }

        }
        var headT = $("#partyMembersId").attr("keycode");
        var headTList = headT.split(",");
        var firstCultivate = $("#cultivatePeopleId1").attr("keycode");
        var firstCultivateList = firstCultivate.split(",");
        var secondCultivate = $("#cultivatePeopleId2").attr("keycode");
        var secondCultivateList = secondCultivate.split(",");
        $.post("<%=request.getContextPath()%>/saveParty", {
            id: $("#id").val(),
            personType: peopleType,
            personSource: $("#personSource option:selected").val(),
            personId: headTList[1],
            deptId: headTList[0],
            branchId: $("#branchName option:selected").val(),
            memberRoles: $("#partyRoles option:selected").val(),
            firstCultivatePeopleId: firstCultivateList[1],
            firstCultivatePeopleDeptId: firstCultivateList[0],
            secondCultivatePeopleId: secondCultivateList[1],
            secondCultivatePeopleDeptId: secondCultivateList[0],
            applyTime: applyTime,
            activeMolecularTime: activeMolecularTime,
            developmentTime: developmentTime,
            prepareTime: prepareTime,
            joinPartyTime: joinPartyTime,
            remark: $("#remark").val()
        }, function (msg) {
            if (msg.status == 1) {
                alert(msg.msg);
                $("#dialog").modal('hide');
                $('#partyGrid').DataTable().ajax.reload();
            }
        })
    }
    function changePartyRoles() {
        var partyRoles = $("#partyRoles option:selected").val();
        if (partyRoles == 0) {
            $("#activeMolecular").hide();
            $("#development").hide();
            $("#prepare").hide();
            $("#joinParty").hide();
        } else if (partyRoles == 1) {
            $("#activeMolecular").show();
            $("#development").hide();
            $("#prepare").hide();
            $("#joinParty").hide();
        } else if (partyRoles == 2) {
            $("#activeMolecular").show();
            $("#development").show();
            $("#prepare").hide();
            $("#joinParty").hide();
        } else if (partyRoles == 3) {
            $("#activeMolecular").show();
            $("#development").show();
            $("#prepare").show();
            $("#joinParty").hide();
        } else {
            $("#activeMolecular").show();
            $("#development").show();
            $("#prepare").show();
            $("#joinParty").show();
        }

    }
</script>


