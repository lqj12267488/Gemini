<%--
  Created by IntelliJ IDEA.
  User: znw
  Date: 2017/4/14
  Time: 15:39
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
            <input id="empRangeid" hidden value="${empRange.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 人员姓名
                    </div>
                    <div class="col-md-9">
                        <input id="personId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[100]] form-control" value="${empRange.personIdShow}"/>
                        <input id="perId" type="hidden" value="${empRange.personId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  所属部门
                    </div>
                    <div class="col-md-9">
                        <div style="white-space:nowrap;">
                            <input id="deptSel" type="text" onclick="showMenu()" value="${empRange.deptIdShow}"
                                   readonly/>
                        </div>
                        <div id="menuContent1" class="menuContent1">
                            <ul id="treeDemo" class="ztree"></ul>
                        </div>
                        <input id="deptId" type="hidden" value="${empRange.deptId}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" id="saveBtn" onclick="saveRange()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        //部门多选树，初始化
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            var editRangezTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            var node;
            var lis = $("#deptId").val().split(",");
            //设置选择节点
            for (var i = 0; i < lis.length; i++) {
                node = editRangezTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#" + lis[i]).attr("checked");
                editRangezTree.checkNode(node, true, false, callbackFlag);
            }
        });

        //经办人自动提示框
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#personId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#personId").val(ui.item.label.split("  ----  ")[0]);
                    $("#personId").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    })

    function saveRange() {

        if ($("#perId").val() == "" || $("#perId").val() == undefined || $("#perId").val() == null || $("#personId").attr("keycode") == "") {
            swal({
                title: "请选择人员",
                type: "info"
            });
            //alert("请选择人员");
            return;
        }

        if ($("#deptId").val() == "" || $("#deptId").val() == undefined) {
            swal({
                title: "请填写部门",
                type: "info"
            });
            //alert("请填写部门");
            return;
        }
        var a = $("#perId").val().split(",");
        //alert(a[1]);
        showSaveLoading()
        $.post("<%=request.getContextPath()%>/emp/range/saveEmpRange", {
            id: $("#empRangeid").val(),
            personId:$("#perId").val(),
            deptId: $("#deptId").val(),

        }, function (msg) {

            if (msg.status == 1) {
                hideSaveLoading()
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#rangeDataId').DataTable().ajax.reload();
            }
        })
    }
</script>
<script type="text/javascript">//多选树z-tree.js数据格式 end
var setting = {
    check: {
        enable: true,
        chkboxType: { "Y": "s", "N": "ps" }
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
    var zTree = $.fn.zTree.getZTreeObj("treeDemo");
    zTree.checkNode(treeNode, !treeNode.checked, null, true);
    return false;
}

function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
        nodes = zTree.getCheckedNodes(true),
        v = "";
    for (var i = 0, l = nodes.length; i < l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0) v = v.substring(0, v.length - 1);
    var deptId = $("#deptId");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#deptId");
    var cityOffset = $("#deptId").offset();
    $("#menuContent1").css({
        left: cityOffset.left + "px",
        top: cityOffset.top + cityObj.outerHeight() + "px"
    }).slideDown("fast");

    $("body").bind("mousedown", onBodyDown);
}

function hideMenu() {
    $("#menuContent1").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}

function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "deptSel" || event.target.id == "menuContent1" || $(event.target).parents("#menuContent1").length > 0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
            nodes = zTree.getCheckedNodes(true);
        $("#deptId").val(getChildNodes(nodes));//获取子节点
        $("#deptSel").val(getChildNodesSel(nodes));//获取子节点
    }
}

function getChildNodesSel(treeNode) {
    var nodes = "";
    for (i = 0; i < treeNode.length; i++) {
        if (!treeNode[i].isParent)
            nodes += treeNode[i].name + ",";
    }
    return nodes.substring(0, nodes.length - 1);
}

function getChildNodes(treeNode) {
    var nodes = "";
    for (i = 0; i < treeNode.length; i++) {
        if (!treeNode[i].isParent) {
            nodes += treeNode[i].id + ",";
        }

    }
    return nodes.substring(0, nodes.length - 1);
}
</script>
<style>
    #menuContent1 {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>


