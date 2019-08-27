<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<%--<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>--%>
<input type="hidden" id="officeItemid" value="${officeItem.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        物品名称
    </div>
    <div class="col-md-9">
        <div>
            <input id="itemNameShow" type="text" placeholder="请点击选择"
                   onclick="showMenu()"  value="${officeItem.itemNameShow}"/>
        </div>
        <div id="menuContent" class="menuContent">
            <ul id="itemNameTree" class="ztree"></ul>
        </div>
        <input id="itemName" type="hidden" value="${officeItem.itemName}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请数量
    </div>
    <div class="col-md-9">
        <input id="itemNumber" type="text" placeholder="请输入数量"
               class="validate[required,maxSize[20]] form-control"
               value="${officeItem.itemNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${officeItem.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="requester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${officeItem.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" value="${officeItem.requestDate}" type="datetime-local"
               class="validate[required,maxSize[100]] form-control" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="remark" maxlength="330" placeholder="最多输入330个字"
                  class="validate[required,maxSize[100]] form-control">${officeItem.remark}</textarea>
    </div>
</div>
<input id="workflowCode" hidden value="T_BG_OFFICEITEM_WF01">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/officeItem/printOfficeItem?id=${officeItem.id}">

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=BGHC", function (data) {
            var itemNameTree = $.fn.zTree.init($("#itemNameTree"), setting, data);
            var node;
            var lis = $("#itemName").val().split(",");
            //设置选择节点
            for(var i = 0;i< lis.length;i++){
                node = itemNameTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                itemNameTree.checkNode(node, true, false, callbackFlag);
            }

        });
    })
    function save() {
        var date = $("#requestDate").val();
        date = date.replace('T', '');
        if ($("#itemName").val() == "" || $("#itemName").val() == "0" || $("#itemName").val() == undefined ) {
            swal({
                title: "请填写物品名称",
                type: "info"
            });
            return;
        }
        else if ($("#itemNumber").val() == "" || $("#itemNumber").val() == "0" || $("#itemNumber").val() == undefined) {
            swal({
                title: "请填申请数量",
                type: "info"
            });
            return;
         }
        $.post("<%=request.getContextPath()%>/officeItem/saveOfficeItem", {
            id: $("#officeItemid").val(),
            itemName: $("#itemName").val(),
            itemNumber: $("#itemNumber").val(),
            remark: $("#remark").val(),
            requestDate: date
        }, function (msg) {
            if (msg.status == 1) {
                $('#officeItemGrid').DataTable().ajax.reload();
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
    var zTree = $.fn.zTree.getZTreeObj("itemNameTree");
    zTree.checkNode(treeNode, !treeNode.checked, null, true);
    return false;
}

function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("itemNameTree"),
        nodes = zTree.getCheckedNodes(true),
        v = "";
    for (var i=0, l=nodes.length; i<l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0 ) v = v.substring(0, v.length-1);
    var deptId = $("#itemName");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#itemName");
    var cityOffset = $("#itemName").offset();
    $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
    $("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "itemNameTreeShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("itemNameTree"),
            nodes = zTree.getCheckedNodes(true);
        $("#itemName").val(getChildNodes(nodes));//获取子节点
        $("#itemNameShow").val(getChildNodesSel(nodes));//获取子节点
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
