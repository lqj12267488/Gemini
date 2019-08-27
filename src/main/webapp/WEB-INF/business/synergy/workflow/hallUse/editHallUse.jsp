<%--q申请新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/18
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
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
            <span style="font-size: 14px">${head}</span>
            <input id="h_Id" name="h_Id" type="hidden" value="${hallUse.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="h_requestDept" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${hallUse.requestDept}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="h_requester" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${hallUse.requester}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请时间
                    </div>
                    <div class="col-md-9">
                        <input id="h_requestDate" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${hallUse.requestDate}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="h_startTime" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${hallUse.startTime}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="h_endTime" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${hallUse.endTime}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        使用设备
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="usedeviceShow" type="text" onclick="showMenu()" value="${hallUse.usedeviceShow}"/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="deviceNameTree" class="ztree"></ul>
                        </div>
                        <input id="usedevice" type="hidden" value="${hallUse.usedevice}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        活动内容
                    </div>
                    <div class="col-md-9">
                        <textarea id="h_content" class="validate[required,maxSize[100]] form-control"
                                  maxlength="165" placeholder="最多输入165个字">${hallUse.content}</textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        参与人数
                    </div>
                    <div class="col-md-9">
                        <input id="h_peopleNumber" type="text"
                               class="validate[required,maxSize[10]] form-control"
                               value="${hallUse.peopleNumber}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="h_remark"
                                  class="validate[required,maxSize[100]] form-control"
                                  maxlength="165" placeholder="最多输入165个字">${hallUse.remark}</textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        使用规范
                    </div>
                    <div class="col-md-9">
                        <textarea id="h_standard" style="height: 200px"
                                  class="validate[required,maxSize[100]] form-control"
                                  readonly="readonly">${standard.standardContent}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">
                保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">
                关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=ITSB", function (data) {
            var deviceNameTree = $.fn.zTree.init($("#deviceNameTree"), setting, data);
            var node;
            var lis = $("#usedevice").val().split(",");
            //设置选择节点
            for (var i = 0; i < lis.length; i++) {
                node = deviceNameTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#" + lis[i]).attr("checked");
                deviceNameTree.checkNode(node, true, false, callbackFlag);
            }
        });
    });

    /**功能：修改的申请信息保存
     * create by wq
     * @return mv界面
     */
    function save() {
        var date = $("#h_requestDate").val();
        date = date.replace('T', '');
        var reg = new RegExp("^[0-9]*$");
        if ($("#h_startTime").val() == "" || $("#h_startTime").val() == "0" || $("#h_startTime").val() == undefined) {
            swal({
                title: "请填写精确的开始时间",
                type: "info"
            });
            //alert("请填写精确的开始时间");
            return;
        }
        if ($("#h_endTime").val() == "" || $("#h_endTime").val() == "0" || $("#h_endTime").val() == undefined) {
            swal({
                title: "请填写精确的结束时间",
                type: "info"
            });
            //alert("请填写精确的结束时间");
            return;
        }
        if ($("#usedevice").val() == "" || $("#usedevice").val() == "0" || $("#usedevice").val() == undefined) {
            swal({
                title: "请选择使用设备",
                type: "info"
            });
            //alert("请选择使用设备");
            return;
        }
        if ($("#h_content").val() == "" || $("#h_content").val() == "0" || $("#h_content").val() == undefined) {
            swal({
                title: "请填写活动内容",
                type: "info"
            });
            //alert("请填写活动内容");
            return;
        }
        if ($("#h_peopleNumber").val() == "" || $("#h_peopleNumber").val() == "0" || $("#h_peopleNumber").val() == undefined) {
            swal({
                title: "请填写参与人数",
                type: "info"
            });
            //alert("请填写参与人数");
            return;
        }
        if ($("#h_peopleNumber").val() > 1000) {
            swal({
                title: "参与人数不能超过1000",
                type: "info"
            });
            //alert("请填写参与人数");
            return;
        }
        if (!reg.test($("#h_peopleNumber").val())) {
            swal({
                title: "参与人数请填写整数",
                type: "info"
            });
            //alert("参与人数请填写整数");
            return;
        }
        var startTime = $("#h_startTime").val();
        var endTime = $("#h_endTime").val();
        if (startTime >= endTime) {
            swal({
                title: "开始时间必须早于结束时间",
                type: "info"
            });
            //alert("开始时间必须早于结束时间");
            return;
        }
        startTime = startTime.replace('T', '');
        endTime = endTime.replace('T', '');
        $.post("<%=request.getContextPath()%>/hallUse/saveHallUse", {
            id: $("#h_Id").val(),
            requestDept: $("#h_requestDept").val(),
            requester: $("#h_requester").val(),
            requestDate: date,
            startTime: startTime,
            endTime: endTime,
            usedevice: $("#usedevice").val(),
            content: $("#h_content").val(),
            peopleNumber: $("#h_peopleNumber").val(),
            remark: $("#h_remark").val()
        }, function (msg) {
            hideSaveLoading();
//          保存后刷新页面数据表
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#hallUseGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }
</script>

<script type="text/javascript">//多选树z-tree.js数据格式 end
var setting = {
    check: {
        enable: true,
        chkboxType: {"Y": "", "N": ""}
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
        beforeClick: beforeClick,
        onCheck: onCheck
    }
};

function beforeClick(treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("deviceNameTree");
    zTree.checkNode(treeNode, !treeNode.checked, null, true);
    return false;
}

function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("deviceNameTree"),
        nodes = zTree.getCheckedNodes(true),
        v = "";
    for (var i = 0, l = nodes.length; i < l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0) v = v.substring(0, v.length - 1);
    var deptId = $("#usedevice");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#usedevice");
    var cityOffset = $("#usedevice").offset();
    $("#menuContent").css({left: cityOffset.left + "px", top: cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
    $("body").bind("mousedown", onBodyDown);
}

function hideMenu() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}

function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "usedeviceShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("deviceNameTree"),
            nodes = zTree.getCheckedNodes(true);
        $("#usedevice").val(getChildNodes(nodes));//获取子节点
        $("#usedeviceShow").val(getChildNodesSel(nodes));//获取子节点
    }
}

function getChildNodesSel(treeNode) {
    var nodes = new Array();
    for (i = 0; i < treeNode.length; i++) {
        nodes[i] = treeNode[i].name;
    }
    return nodes.join(",");
}

function getChildNodes(treeNode) {
    var nodes = new Array();
    for (i = 0; i < treeNode.length; i++) {
        nodes[i] = treeNode[i].id;
    }
    return nodes.join(",");
}
</script>
<style>
    #menuContent {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
