<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/17
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="form-row">
    <div class="col-md-3 tar">
        设备名称
    </div>
    <div class="col-md-9">
        <div>
            <input id="deviceUseNameShow" type="text" onclick="showMenu()"  value="${deviceUse.deviceUseNameShow}"/>
        </div>
        <div id="menuContent" class="menuContent">
            <ul id="deviceNameTree" class="zTree"></ul>
        </div>
        <input id="deviceName" type="hidden" value="${deviceUse.deviceName}"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请事由
    </div>
    <div class="col-md-9">
        <input id="reason" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${deviceUse.reason}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${deviceUse.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        经办人
    </div>
    <div class="col-md-9">
        <input id="manager" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${deviceUse.manager}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${deviceUse.requestDate}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <input id="remark" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${deviceUse.remark}" />
    </div>
</div>
<input id="workflowCode" hidden value="T_BG_DEVICEUSE_WF01">
<input id="id" hidden value="${deviceUse.id}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=ITSB", function (data) {
            //addOption(data, 'deviceName','$ {deviceUse.deviceName}');
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
    })
    function save() {
        if($("#deviceName").val()=="" ||  $("#deviceName").val() =="0" || $("#deviceName").val() == undefined){
             swal({
                title: "请填写设备名称!",
                type: "info"
            });
            return;
        }
        if($("#reason").val()=="" ||  $("#reason").val() =="0" || $("#reason").val() == undefined){
             swal({
                title: "请填写申请事由!",
                type: "info"
            });
            return;
        }
        if( $("#requestDept").val() =="" ||  $("#requestDept").val() =="0" || $("#requestDept").val() == undefined){
             swal({
                title: "请填写申请部门!",
                type: "info"
            });
            return;
        }
        if($("#manager").val()=="" ||  $("#manager").val() =="0" || $("#manager").val() == undefined){
             swal({
                title: "请填写经办人!",
                type: "info"
            });
            return;
        }
        if($("#requestDate").val()=="" ||  $("#requestDate").val() =="0" || $("#requestDate").val() == undefined){
             swal({
                title: "请填写申请日期!",
                type: "info"
            });
            return;
        }
        var v_requestDate = $("#requestDate").val().replace('T',' ');
        $.post("<%=request.getContextPath()%>/deviceUse/saveDeviceUse", {
            id: $("#id").val(),
            requestDept: $("#requestDept").val(),
            reason: $("#reason").val(),
            deviceName: $("#deviceName").val(),
            manager: $("#manager").val(),
            requestDate:v_requestDate,
            remark: $("#remark").val(),
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#deviceUseGrid').DataTable().ajax.reload();

            }
        })
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
    if (!(event.target.id == "menuBtn" || event.target.id == "deviceUseNameShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("deviceNameTree"),
            nodes = zTree.getCheckedNodes(true);
        $("#deviceName").val(getChildNodes(nodes));//获取子节点
        $("#deviceUseNameShow").val(getChildNodesSel(nodes));//获取子节点
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
