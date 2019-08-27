<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/13
  Time: 16:55
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
<input type="hidden" id="publicityDeliveryId" value="${publicityDelivery.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        标题
    </div>
    <div class="col-md-9">
        <input id="caption" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="12" placeholder="最多输入12个字"
               class="validate[required,maxSize[100]] form-control"
               value="${publicityDelivery.caption}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        发布渠道
    </div>
    <div class="col-md-9">
        <div>
            <input id="publicityDeliveryShow" type="text" placeholder="请点击选择"
                   onclick="showMenu()"  value="${publicityDelivery.distributionChannelsShow}"/>
        </div>
        <div id="menuContent" class="menuContent">
            <ul id="publicityDeliveryTree" class="ztree"></ul>
        </div>
        <input id="publicityDelivery" type="hidden" value="${publicityDelivery.distributionChannels}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-local"
               value="${publicityDelivery.requestDate}"
               class="validate[required,maxSize[100]] form-control" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${publicityDelivery.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        撰稿人
    </div>
    <div class="col-md-9">
        <input id="requester" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${publicityDelivery.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="remark" maxlength="330" placeholder="最多输入330个字"
                  class="validate[required,maxSize[100]] form-control"
                  value="${publicityDelivery.remark}"
        >${publicityDelivery.remark}</textarea>
    </div>
</div>
<input id="workflowCode" hidden value="T_BG_PUBLICITYDELIVERY_WF01">

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=FBQD", function (data) {
            var publicityDeliveryTree = $.fn.zTree.init($("#publicityDeliveryTree"), setting, data);
            var node;
            var lis = $("#publicityDelivery").val().split(",");
            //设置选择节点
            for(var i = 0;i< lis.length;i++){
                node = publicityDeliveryTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                publicityDeliveryTree.checkNode(node, true, false, callbackFlag);
            }
        });
    })
    function save() {
        if ($("#caption").val() == "" || $("#caption").val() == "0" || $("#caption").val() == undefined) {
            swal({
                title: "请填写标题",
                type: "info"
            });
            //alert("请填写标题");
            return;
        }
        if ($("#publicityDelivery").val() == "" || $("#publicityDelivery").val() == "0" || $("#publicityDelivery").val() == undefined) {
            swal({
                title: "请选择发布渠道",
                type: "info"
            });
            //alert("请选择发布渠道");
            return;
        }
        var requestDate = $("#requestDate").val().replace('T', '');
        $.post("<%=request.getContextPath()%>/publicityDelivery/savePublicityDelivery", {
            id: $("#publicityDeliveryId").val(),
//            requestDept: $("#requestDept").val(),
            caption: $("#caption").val(),
            distributionChannels: $("#publicityDelivery").val(),

//            requester: $("#requester").val(),
            requestDate: requestDate,
            remark: $("#remark").val()
        }, function (msg) {
            if (msg.status == 1) {
                $('#publicityDeliveryGrid').DataTable().ajax.reload(function () {
                    $('#publicityDeliveryGrid tr a').qtip()
                });
               /* swal({
                    title: "修改成功",
                    type: "success"
                });*/
                //alert("修改成功!");
            }
        })
        return true;
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
    var zTree = $.fn.zTree.getZTreeObj("publicityDeliveryTree");
    zTree.checkNode(treeNode, !treeNode.checked, null, true);
    return false;
}

function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("publicityDeliveryTree"),
        nodes = zTree.getCheckedNodes(true),
        v = "";
    for (var i=0, l=nodes.length; i<l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0 ) v = v.substring(0, v.length-1);
    var deptId = $("#publicityDelivery");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#publicityDelivery");
    var cityOffset = $("#publicityDelivery").offset();
    $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
    $("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "publicityDeliveryShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("publicityDeliveryTree"),
            nodes = zTree.getCheckedNodes(true);
        $("#publicityDelivery").val(getChildNodes(nodes));//获取子节点
        $("#publicityDeliveryShow").val(getChildNodesSel(nodes));//获取子节点
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










