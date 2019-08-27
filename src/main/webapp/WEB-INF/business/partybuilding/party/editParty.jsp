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
            <input id="person" hidden value="${party.personId}">
            <input id="dept" hidden value="${party.deptId}">
            <input id="firstcultivatePeople" hidden value="${party.firstCultivatePeopleId}">
            <input id="firstcultivatePeopleDept" hidden value="${party.firstCultivatePeopleDeptId}">
            <input id="secondcultivatePeople" hidden value="${party.secondCultivatePeopleId}">
            <input id="secondcultivatePeopleDept" hidden value="${party.secondCultivatePeopleDeptId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 成员类型：
                    </div>
                    <div class="col-md-9">
                        <select id="peopleType" class="js-example-basic-single" onchange="autoComplete()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 姓名：
                    </div>
                    <div class="col-md-9">
                        <input id="partyMembersId" placeholder="请选择人员姓名" type="text" value="${party.personIdDept}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 成员来源：
                    </div>
                    <div class="col-md-9">
                        <select id="personSource"
                                class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  所属党支部：
                    </div>
                    <div class="col-md-9">
                        <select id="branchName"
                                class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 成员角色：
                    </div>
                    <div class="col-md-9">
                        <select id="partyRoles" class="js-example-basic-single" onchange="changePartyRoles()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>第一培养人：
                    </div>
                    <div class="col-md-9">
                        <input id="cultivatePeopleId1" type="text" placeholder="请选择人员姓名"
                               value="${party.firstCultivatePeopleIdDept}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        第二培养人：
                    </div>
                    <div class="col-md-9">
                        <input id="cultivatePeopleId2" type="text" placeholder="请选择人员姓名"
                               value="${party.secondCultivatePeopleIdDept}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 申请入党时间：
                    </div>
                    <div class="col-md-9">
                        <input id="applyTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.applyTime}"/>
                    </div>
                </div>
                <div class="form-row" id="activeMolecular">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 转为积极分子时间：
                    </div>
                    <div class="col-md-9">
                        <input id="activeMolecularTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.activeMolecularTime}"/>
                    </div>
                </div>

                <div class="form-row" id="development">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 转为发展对象时间：
                    </div>
                    <div class="col-md-9">
                        <input id="developmentTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.developmentTime}"/>
                    </div>
                </div>
                <div class="form-row" id="prepare">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 转为预备党员时间：
                    </div>
                    <div class="col-md-9">
                        <input id="prepareTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${party.prepareTime}"/>
                    </div>
                </div>
                <div class="form-row" id="joinParty">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 转为正式党员时间：
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
                                  >${party.remark}</textarea>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn"	class="btn btn-success btn-clean" onclick="saveParty()">保存</button>
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
        var id = $("#id").val();
        if (id != '') {
            $("#partyMembersId").attr("disabled", "disabled");
            $("#peopleType").attr("disabled", "disabled");
            $("#branchName").attr("disabled", "disabled");
            $("#partyRoles").attr("disabled", "disabled");
        }
        var partyRoles = '${party.memberRoles}';
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
        var personType = '${party.personType}';
        if (personType == '0') {
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
        } else if (personType == '1') {
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
    })

    $("#cultivatePeopleId2").change(function(){
        if($("#cultivatePeopleId2").val() ==""){
            $("#cultivatePeopleId2").attr("keycode",",");
        }
    });

    function autoComplete() {
        $("#partyMembersId").val("");
        var personType = $("#peopleType option:selected").val();
        if (personType == '0') {
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
        } else if (personType == '1') {
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
        var personType = $("#peopleType option:selected").val();
        var personSource = $("#personSource option:selected").val();
        var personId = $("#partyMembersId").val();
        var partyRoles = $("#partyRoles option:selected").val();
        var apply = $("#applyTime").val();
        var applyTime = new Date($("#applyTime").val().replace('T', ' ')).getTime();
        var activeMolecular = $("#activeMolecularTime").val();
        var activeMolecularTime = new Date($("#activeMolecularTime").val().replace('T', ' ')).getTime();
        var development = $("#developmentTime").val();
        var developmentTime = new Date($("#developmentTime").val().replace('T', ' ')).getTime();
        var prepare = $("#prepareTime").val();
        var prepareTime = new Date($("#prepareTime").val().replace('T', ' ')).getTime();
        var joinParty = $("#joinPartyTime").val();
        var joinPartyTime = new Date($("#joinPartyTime").val().replace('T', ' ')).getTime();
        var partyMembersId = $("#partyMembersId").attr("keycode");
        var person;
        var dept;
        if (personType == "" || personType == null || personType == undefined) {
            swal({
                title: "请先选择成员类型!",
                type: "info"
            });
            return;
        }
        if (personId == "" || personId == null || personId == undefined) {
            swal({
                title: "请填写姓名！",
                type: "info"
            });
            return;
        } else {
            if (partyMembersId == "" || partyMembersId == null || partyMembersId == undefined) {
                person = $("#person").val();
                dept = $("#dept").val();
            } else {
                var headT = $("#partyMembersId").attr("keycode");
                var personList = headT.split(",");
                person = personList[1];
                dept = personList[0];
            }
        }
        if (personSource == "" || personSource == null || personSource == undefined) {
            swal({
                title: "请选择成员来源！",
                type: "info"
            });
            return;
        }
        if ($("#branchName option:selected").val() == "" || $("#branchName option:selected").val() == null || $("#branchName option:selected").val() == undefined) {
            swal({
                title: "请选择党支部！",
                type: "info"
            });
            return;
        }
        if (partyRoles == "" || partyRoles == null || partyRoles == undefined) {
            swal({
                title: "请选择成员角色！",
                type: "info"
            });
            return;
        } else {
            if (partyRoles == 0) {
                if (apply == "" || apply == null || apply == undefined) {
                    swal({
                        title: "请填写申请入党时间!",
                        type: "info"
                    });
                    return;
                }
            } else if (partyRoles == 1) {
                if (apply == "" || apply == null || apply == undefined) {
                    swal({
                        title: "请填写申请入党时间!",
                        type: "info"
                    });
                    return;
                }else{
                    if(applyTime>activeMolecularTime||applyTime==activeMolecularTime){
                        swal({
                            title: "申请入党时间只能小于转为积极分子时间!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (activeMolecular == "" || activeMolecular == null || activeMolecular == undefined) {
                    swal({
                        title: "请填写转为积极分子时间!",
                        type: "info"
                    });
                    return;
                }
            } else if (partyRoles == 2) {
                if (apply == "" || apply == null || apply == undefined) {
                    alert("请填写申请入党时间！");
                    swal({
                        title: "请先选择成员类型!",
                        type: "info"
                    });
                    return;
                }else{
                    if(applyTime>activeMolecularTime||applyTime==activeMolecularTime){
                        swal({
                            title: "申请入党时间只能小于转为积极分子时间!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (activeMolecular == "" || activeMolecular == null || activeMolecular == undefined) {
                    swal({
                        title: "请填写转为积极分子时间!",
                        type: "info"
                    });
                    return;
                }else {
                    if(activeMolecularTime>developmentTime||activeMolecularTime==developmentTime){
                        swal({
                            title: "转为积极分子时间只能小于转为发展对象时间!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (development == "" || development == null || development == undefined) {
                    swal({
                        title: "请填写转为发展对象时间!",
                        type: "info"
                    });
                    return;
                }
            } else if (partyRoles == 3) {
                if (apply == "" || apply == null || apply == undefined) {
                    swal({
                        title: "请填写申请入党时间!",
                        type: "info"
                    });
                    return;
                }else{
                    if(applyTime>activeMolecularTime||applyTime==activeMolecularTime){
                        swal({
                            title: "申请入党时间只能小于转为积极分子时间!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (activeMolecular == "" || activeMolecular == null || activeMolecular == undefined) {
                    swal({
                        title: "请填写转为积极分子时间!",
                        type: "info"
                    });
                    return;
                }else {
                    if(activeMolecularTime>developmentTime||activeMolecularTime==developmentTime){
                        swal({
                            title: "转为积极分子时间只能小于转为发展对象时间!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (development == "" || development == null || development == undefined) {
                    swal({
                        title: "请填写转为发展对象时间!",
                        type: "info"
                    });
                    return;
                }else{
                    if(developmentTime>prepareTime|developmentTime==prepareTime){
                        swal({
                            title: "转为发展对象时间只能小于转为预备党员时间!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (prepare == "" || prepare == null || prepare == undefined) {
                    swal({
                        title: "请填写转为预备党员时间!",
                        type: "info"
                    });
                    return;
                }
            } else if (partyRoles == 4) {
                if (apply == "" || apply == null || apply == undefined) {
                    swal({
                        title: "请填写申请入党时间!",
                        type: "info"
                    });
                    return;
                }else{
                    if(applyTime>activeMolecularTime||applyTime==activeMolecularTime){
                        swal({
                            title: "申请入党时间只能小于转为积极分子时间!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (activeMolecular == "" || activeMolecular == null || activeMolecular == undefined) {
                    swal({
                        title: "请填写转为积极分子时间!",
                        type: "info"
                    });
                    return;
                }else {
                    if(activeMolecularTime>developmentTime||activeMolecularTime==developmentTime){
                        swal({
                            title: "转为积极分子时间只能小于转为发展对象时间!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (development == "" || development == null || development == undefined) {
                    swal({
                        title: "请填写转为发展对象时间!",
                        type: "info"
                    });
                    return;
                }else{
                    if(developmentTime>prepareTime|developmentTime==prepareTime){
                        swal({
                            title: "转为发展对象时间只能小于转为预备党员时间!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (prepare == "" || prepare == null || prepare == undefined) {
                    swal({
                        title: "请填写转为预备党员时间!",
                        type: "info"
                    });
                    return;
                }else{
                    if(prepareTime>joinPartyTime||prepareTime==joinPartyTime){
                        swal({
                            title: "转为预备党员时间只能小于转为正式党员时间!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (joinParty == "" || joinParty == null || joinParty == undefined) {
                    swal({
                        title: "请填写转为正式党员时间!",
                        type: "info"
                    });
                    return;
                }else{
                    if(joinPartyTime<prepareTime+31536000000){
                        swal({
                            title: "转为正式党员时间必须在转为预备党员一年或者一年之后!",
                            type: "info"
                        });
                        return;
                    }
                }
            }

        }
        var firstcultivatePeople;
        var firstcultivatePeopleDept;
        var secondcultivatePeople;
        var secondcultivatePeopleDept;
        var firstCultivate = $("#cultivatePeopleId1").attr("keycode");
        if($("#cultivatePeopleId1").val() ==''){
            swal({
                title: "请填写第一培养人!",
                type: "info"
            });
            return;
        }
        var secondCultivate = $("#cultivatePeopleId2").attr("keycode");
        if (firstCultivate == "" || firstCultivate == null || firstCultivate == undefined) {
            firstcultivatePeople = $("#firstcultivatePeople").val();
            firstcultivatePeopleDept = $("#firstcultivatePeopleDept").val();
        } else {
            firstCultivate = $("#cultivatePeopleId1").attr("keycode");
            var firstCultivateList = firstCultivate.split(",");
            firstcultivatePeople = firstCultivateList[1];
            firstcultivatePeopleDept = firstCultivateList[0];
        }
        if (secondCultivate == "" || secondCultivate == null || secondCultivate == undefined) {
            secondcultivatePeople = $("#secondcultivatePeople").val();
            secondcultivatePeopleDept = $("#secondcultivatePeopleDept").val();
        } else {
            secondCultivate = $("#cultivatePeopleId2").attr("keycode");
            var secondCultivateList = secondCultivate.split(",");
            secondcultivatePeople = secondCultivateList[1];
            secondcultivatePeopleDept = secondCultivateList[0];
        }
        if(person=="" || person==null){
            swal({
                title: "请填写正确的人员姓名!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/party/checkName", {
            personId: person,
            id: $("#id").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "error"});
            } else {
                showSaveLoading();
                $.post("<%=request.getContextPath()%>/saveParty", {
                    id: $("#id").val(),
                    personType: personType,
                    personSource: $("#personSource option:selected").val(),
                    personId: person,
                    deptId: dept,
                    branchId: $("#branchName option:selected").val(),
                    memberRoles: $("#partyRoles option:selected").val(),
                    firstCultivatePeopleId: firstcultivatePeople,
                    firstCultivatePeopleDeptId: firstcultivatePeopleDept,
                    secondCultivatePeopleId: secondcultivatePeople,
                    secondCultivatePeopleDeptId: secondcultivatePeopleDept,
                    applyTime: $("#applyTime").val(),
                    activeMolecularTime: $("#activeMolecularTime").val(),
                    developmentTime: $("#developmentTime").val(),
                    prepareTime: $("#prepareTime").val(),
                    joinPartyTime: $("#joinPartyTime").val(),
                    remark: $("#remark").val()
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        $("#dialog").modal('hide');
                        $('#partyGrid').DataTable().ajax.reload();
                    }
                })
            }
        });

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


