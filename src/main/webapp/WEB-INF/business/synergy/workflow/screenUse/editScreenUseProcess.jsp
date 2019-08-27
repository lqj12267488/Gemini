<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/6/28
  Time: 15:34
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
<input type="hidden" id="screenUseId" value="${screenUse.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请内容
    </div>
    <div class="col-md-9">
        <input id="content" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="165" placeholder="最多输入165个字"
               class="validate[required,maxSize[100]] form-control"
               value="${screenUse.content}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        大屏幕
    </div>
    <div class="col-md-9">
        <div>
            <input id="screenShow" type="text" placeholder="请点击选择" onclick="showMenu()"  value="${screenUse.screenShow}"/>
        </div>
        <div id="menuContent" class="menuContent">
            <ul id="screenUseTree" class="ztree"></ul>
        </div>
        <input id="screen" type="hidden" value="${screenUse.screen}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-local"
               value="${screenUse.requestDate}"
               class="validate[required,maxSize[100]] form-control" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        使用日期
    </div>
    <div class="col-md-9">
        <input id="usingTime" type="datetime-local"
               value="${screenUse.usingTime}"
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
               value="${screenUse.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        经办人
    </div>
    <div class="col-md-9">
        <input id="requester" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${screenUse.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="remark" maxlength="330" placeholder="最多输入330个字"
                  class="validate[required,maxSize[100]] form-control"
                  value="${screenUse.remark}"
        >${screenUse.remark}</textarea>
    </div>
</div>
<input id="workflowCode" hidden value="T_BG_SCREENUSE_WF01">

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=DPM", function (data) {
            var screenUseTree = $.fn.zTree.init($("#screenUseTree"), setting, data);
            var node;
            var lis = $("#screen").val().split(",");
            //设置选择节点
            for(var i = 0;i< lis.length;i++){
                node = screenUseTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                screenUseTree.checkNode(node, true, false, callbackFlag);
            }
        });
    })
    function save() {
        if ($("#content").val() == "" || $("#content").val() == "0" || $("#content").val() == undefined) {
              swal({
                title: "请填写申请内容",
                type: "info"
            });
            return;
        }
        if ($("#screen").val() == "" || $("#screen").val() == "0" || $("#screen").val() == undefined) {
             swal({
                title: "请选择大屏幕",
                type: "info"
            });
            return;
        }
        var requestDate = $("#requestDate").val().replace('T', '');
        var usingTime = $("#usingTime").val().replace('T', '');
        $.post("<%=request.getContextPath()%>/screenUse/saveScreenUse", {
            id: $("#screenUseId").val(),
//            requestDept: $("#requestDept").val(),
            content: $("#content").val(),
            screen: $("#screen").val(),
//            requester: $("#requester").val(),
            requestDate: requestDate,
            usingTime: usingTime,
            remark: $("#remark").val()
        }, function (msg) {
            if (msg.status == 1) {
                $('#screenUseGrid').DataTable().ajax.reload(function () {
                    $('#screenUseGrid tr a').qtip()
                });
                /*swal({
                    title: "修改成功!",
                    type: "success"
                });*/
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
    var zTree = $.fn.zTree.getZTreeObj("screenUseTree");
    zTree.checkNode(treeNode, !treeNode.checked, null, true);
    return false;
}

function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("screenUseTree"),
        nodes = zTree.getCheckedNodes(true),
        v = "";
    for (var i=0, l=nodes.length; i<l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0 ) v = v.substring(0, v.length-1);
    var deptId = $("#screen");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#screen");
    var cityOffset = $("#screen").offset();
    $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
    $("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "screenUseShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("screenUseTree"),
            nodes = zTree.getCheckedNodes(true);
        $("#screen").val(getChildNodes(nodes));//获取子节点
        $("#screenShow").val(getChildNodesSel(nodes));//获取子节点
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









