<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:19
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
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
            <span style="font-size: 14px">${head}</span>
            <input id="receptionid" name="receptionid" type="hidden" value="${reception.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDept" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${reception.requestDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="f_requester" type="text" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${reception.requester}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDate" value="${reception.requestDate}" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        接待时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_receptionTime" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${reception.receptionTime}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        接待事由
                    </div>
                    <div class="col-md-9">
                        <input id="f_receptionReason" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${reception.receptionReason}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        联系电话
                    </div>
                    <div class="col-md-9">
                        <input id="f_tel" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${reception.tel}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        来访主要领导及职务
                    </div>
                    <div class="col-md-9">
                        <input id="f_visitLeader" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${reception.visitLeader}"/>
                    </div>
                </div>


                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        来访人数
                    </div>
                    <div class="col-md-9">
                        <input id="f_visitNumber" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${reception.visitNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        接待地点
                    </div>
                    <div class="col-md-9">
                        <input id="f_receptionPlace" type="text" class="validate[required,maxSize[100]] form-control"
                               value="${reception.receptionPlace}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        拟陪同人员
                    </div>
                    <div class="col-md-9">
                        <div style="white-space:nowrap;">
                                <textarea id="empSel" type="text" style="height: 12%;"
                                          onclick="empType()">${reception.entourageShow}</textarea>
                        </div>
                        <div id="empContent" class="empContent" style="width: 95%">
                            <ul id="empTree" class="ztree"></ul>
                        </div>
                        <input id="textbookUser" type="hidden" placeholder="最多发送80人"
                               value="${reception.entourage}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        是否需要用车
                    </div>
                    <div class="col-md-9">
                        <select id="f_isNeedVehicle"></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveReception()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'f_isNeedVehicle', '${reception.isNeedVehicle}');
        });
    })

    function empType() {
        //人员多选树，初始化
        $.get("<%=request.getContextPath()%>/message/getEmpTree", function (data) {
            var empTree = $.fn.zTree.init($("#empTree"), settingEmp, data);
            var node;
            var lis = $("#textbookUser").val().split(",");
            //设置选择节点
            if (lis != "")
                for (var i = 0; i < lis.length; i++) {
                    node = empTree.getNodeByParam("id", lis[i], null);
                    var callbackFlag = $("#" + lis[i]).attr("checked");
                    empTree.checkNode(node, true, false, callbackFlag);
                }
        });
        showMenuEmp();
    }

    function saveReception() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        var borrowTime = $("#f_receptionTime").val();
        borrowTime = borrowTime.replace('T', '');
        if ($("#f_receptionTime").val() == "" || $("#f_receptionTime").val() == "0") {
            swal({
                title: "请填写接待时间!",
                type: "info"
            });
            return;
        }
        if ($("#f_receptionReason").val() == "" || $("#f_receptionReason").val() == undefined) {
            swal({
                title: "请填写接待事由!",
                type: "info"
            });
            return;
        }
        if ($("#f_tel").val() == "" || $("#f_tel").val() == undefined) {
            swal({
                title: "请填写联系电话!",
                type: "info"
            });
            return;
        }
        if ($("#f_visitLeader").val() == "" || $("#f_visitLeader").val() == undefined) {
            swal({
                title: "请填写来访主要领导及职务!",
                type: "info"
            });
            return;
        }
        if ($("#f_visitNumber").val() == "" || $("#f_visitNumber").val() == "0" || $("#f_visitNumber").val() == undefined) {
            swal({
                title: "请填写来访人数!",
                type: "info"
            });
            return;
        }
        if ($("#f_receptionPlace").val() == "" || $("#f_receptionPlace").val() == undefined) {
            swal({
                title: "请填写接待地点!",
                type: "info"
            });
            return;
        }
        var makeEmp = $("#textbookUser").val();
        var name1 = $("#textbookUser").val();
        if (name1 == null || name1 == undefined || name1 == '') {
            swal({
                title: "请选择拟陪同人员！",
                type: "error"
            });
            return;
        }
        if (makeEmp.length > 3000) {
            swal({title: "拟陪同人员数量，最多只能选择80人以下", type: "info"});
            return;
        }
        if ($("#f_isNeedVehicle").val() == "" || $("#f_isNeedVehicle").val() == undefined) {
            swal({
                title: "请选择是否需要用车!",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/reception/saveReception", {
            id: $("#receptionid").val(),
            requestDate: date,
            receptionTime: borrowTime,
            receptionReason: $("#f_receptionReason").val(),
            tel: $("#f_tel").val(),
            visitLeader: $("#f_visitLeader").val(),
            visitNumber: $("#f_visitNumber").val(),
            receptionPlace: $("#f_receptionPlace").val(),
            entourage: name1,
            isNeedVehicle: $("#f_isNeedVehicle").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#receptionGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>
<style type="text/css">
    textarea {
        resize: none;
    }

    #edui_fixedlayer {
        z-index: 1060 !important;
    }

    modal-dialog {
        width: 1000px !important;
    }

    .edui-default {
        color: black;
    }

    #empContent {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }

    #menuContentMake {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<script type="text/javascript">
    //多选树z-tree.js数据格式 end
    var settingEmp = {
        check: {
            enable: true,
            chkboxType: {"Y": "s", "Y": "ps"}
        },
        view: {
            dblClickExpand: false,
            showIcon: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClickEmp,
            onCheck: onCheckEmp
        }
    };

    function getChildNodesSelEmp(treeNode) {
        var nodes = new Array();
        for (i = 0; i < treeNode.length; i++) {
            if (treeNode[i].id.length == 36) {
                nodes[i] = treeNode[i].name;
            } else {
                nodes[i] = "";
            }
        }
        if (nodes.length == 0) {
            swal({
                title: "请选择人员！",
                type: "info"
            });
            return;
        } else {
            return nodes.join(",").substring(3, nodes.join(",").length);//回显教师姓名，把系部部门去掉
        }

    }

    function getChildNodesEmp(treeNode) {
        var nodes = new Array();
        for (i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");

    }

    function beforeClickEmp(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("empTree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheckEmp(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("empTree");
        nodes = zTree.getCheckedNodes(true);
        v = "";
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
        var textbookUser = $("#textbookUser");
        textbookUser.attr("value", v);
    }

    function showMenuEmp() {
        var cityObj = $("#textbookUser");
        var cityOffset = $("#textbookUser").offset();
        $("#empContent").css({
            left: cityOffset.left + "px",
            top: cityOffset.top + cityObj.outerHeight() + "px"
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDownEmp);
    }

    function hideMenuEmp() {
        $("#empContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDownEmp);
    }

    function onBodyDownEmp(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "empSel" || event.target.id == "empContent" || $(event.target).parents("#empContent").length > 0)) {
            hideMenuEmp();
            var zTree = $.fn.zTree.getZTreeObj("empTree"),
                nodes = zTree.getCheckedNodes(true);
            $("#textbookUser").val(getChildNodesEmp(nodes));//获取子节点
            $("#empSel").val(getChildNodesSelEmp(nodes));//获取子节点
        }
    }

</script>
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>

