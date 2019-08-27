<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/15
  Time: 17:11
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
<input type="hidden" id="deviceUseId" value="${deviceUse.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        设备名称
    </div>
    <div class="col-md-9">
        <div>
            <input id="deviceUseNameShow" type="text" onclick="showMenu()"  value="${deviceUse.deviceUseNameShow}"/>
        </div>
        <div id="menuContent" class="menuContent">
            <ul id="deviceNameTree" class="ztree"></ul>
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
               class="validate[required,maxSize[100]] form-control"
               value="${deviceUse.reason}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${deviceUse.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        经办人
    </div>
    <div class="col-md-9">
        <input id="manager" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${deviceUse.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="datetime-local"
               value="${deviceUse.requestDate}"
               class="validate[required,maxSize[100]] form-control" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="remark"
                  class="validate[required,maxSize[100]] form-control"
                  value="${deviceUse.remark}"
        >${deviceUse.remark}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/deviceUse/printDeviceUse?id=${deviceUse.id}">

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDictToTree?name=ITSB", function (data) {
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

    /*$.get("/deviceUse/getDept", function (data) {
        $("#requestDept").autocomplete({
            source: data,
            select: function (event, ui) {
                $("#requestDept").val(ui.item.label);
                $("#requestDept").attr("keycode", ui.item.value);
                return false;
            }
        }).data("ui-autocomplete")._renderItem = function (ul, item) {
            return $("<li>")
                .append("<a>" + item.label + "</a>")
                .appendTo(ul);
        }
    })

    $.get("/deviceUse/getPerson", function (data) {
        $("#manager").autocomplete({
            source: data,
            select: function (event, ui) {
                $("#manager").val(ui.item.label);
                $("#manager").attr("keycode", ui.item.value);
                return false;
            }
        }).data("ui-autocomplete")._renderItem = function (ul, item) {
            return $("<li>")
                .append("<a>" + item.label + "</a>")
                .appendTo(ul);
        };
    })*/

    function save() {
        if ($("#deviceName").val() == "" || $("#deviceName").val() == "0" || $("#deviceName").val() == undefined) {
             swal({
                title: "请填写设备名称!",
                type: "info"
            });
            return;
        }
        if ($("#reason").val() == "" || $("#reason").val() == "0" || $("#reason").val() == undefined) {
             swal({
                title: "请填写申请事由!",
                type: "info"
            });
            return;
        }
        var requestDate = $("#requestDate").val().replace('T', '');
        $.post("<%=request.getContextPath()%>/deviceUse/saveDeviceUse", {
            id: $("#deviceUseId").val(),
//            requestDept: $("#requestDept").val(),
            reason: $("#reason").val(),
            deviceName: $("#deviceName").val(),
//            manager: $("#manager").val(),
            requestDate: requestDate,
            remark: $("#remark").val()
        }, function (msg) {
            if (msg.status == 1) {
               /* swal({
                    title: "修改成功!",
                    type: "success"
                });*/
                $('#deviceUseGrid').DataTable().ajax.reload();
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

