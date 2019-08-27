<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
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
            <input id="deviceid" hidden value="${ITSuppliesRepair.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        设备名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="deviceNameShow" type="text" onclick="showMenu()" placeholder="请点击选择"
                                   value="${ITSuppliesRepair.deviceNameShow}"/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="deviceNameTree" class="ztree"></ul>
                        </div>
                        <input id="deviceName" type="hidden" value="${ITSuppliesRepair.deviceName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请事由
                    </div>
                    <div class="col-md-9">
                        <textarea id="f_reason" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${ITSuppliesRepair.reason}">${ITSuppliesRepair.reason}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDept" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${ITSuppliesRepair.requestDept}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        经办人
                    </div>
                    <div class="col-md-9">
                        <input id="f_manager" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${ITSuppliesRepair.manager}" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDate" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${ITSuppliesRepair.requestDate}"/>
                    </div>

                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="f_remark" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${ITSuppliesRepair.remark}">${ITSuppliesRepair.remark}</textarea>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=YZCHC", function (data) {
            var deviceNameTree = $.fn.zTree.init($("#deviceNameTree"), setting, data);
            var node;
            var lis = $("#deviceName").val().split(",");
            //设置选择节点
            for(var i = 0;i< lis.length;i++){
                node = deviceNameTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                deviceNameTree.checkNode(node, true, false, callbackFlag);
            }
        });

    });

    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        if ($("#deviceName").val() == "" || $("#deviceName").val() == "0" || $("#deviceName").val() == undefined) {
            swal({
                title: "请填写设备名称",
                type: "info"
            });
            //alert("请填写设备名称");
            return;
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            swal({
                title: "请填写申请理由",
                type: "info"
            });
            //alert("请填写申请理由");
            return;
        }
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0") {
            swal({
                title: "请填写申请日期",
                type: "info"
            });
            //alert("请填写申请日期");
            return;
        }
        $.post("<%=request.getContextPath()%>/ITSuppliesRepair/updateITSuppliesRepairById", {
            id: $("#deviceid").val(),
            deviceName: $("#deviceName").val(),
            requestDate: date,
            reason: $("#f_reason").val(),
            remark: $("#f_remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#ITSuppliesRepairGrid').DataTable().ajax.reload();

            }
        })
        showSaveLoading();
    }
</script>
<script type="text/javascript">//多选树z-tree.js数据格式 end
var setting = {
    check: {
        enable: true,
        chkboxType: {"Y":"", "N":""}
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
    for (var i=0, l=nodes.length; i<l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0 ) v = v.substring(0, v.length-1);
    var deptId = $("#deviceName");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#deviceName");
    var cityOffset = $("#deviceName").offset();
    $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
    $("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "deviceNameShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("deviceNameTree"),
            nodes = zTree.getCheckedNodes(true);
        $("#deviceName").val(getChildNodes(nodes));//获取子节点
        $("#deviceNameShow").val(getChildNodesSel(nodes));//获取子节点
    }
}

function getChildNodesSel(treeNode) {
    var nodes = new Array();
    for(i = 0; i < treeNode.length; i++) {
        nodes[i] = treeNode[i].name;
    }
    return nodes.join(",");
}

function getChildNodes(treeNode) {
    var nodes = new Array();
    for(i = 0; i < treeNode.length; i++) {
        nodes[i] = treeNode[i].id;
    }
    return nodes.join(",");
}
</script>
<style>
    #menuContent{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
