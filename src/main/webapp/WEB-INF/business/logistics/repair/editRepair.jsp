<%--报修类型管理新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/5/26
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 800px">
    <div class="modal-content block-fill-white">
        <div class="modal-header" style="height: 50px">
            <span style="font-size: 14px">${head}</span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <input id="rID" hidden value="${repair.repairID}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        报修类型
                    </div>
                    <div class="col-md-9">
                        <select id="repairType" class="js-example-basic-single"></select>
                    </div>
                </div>
                <%--<div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        所在位置
                    </div>
                    <div class="col-md-9">
                        <input id="position" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="100" placeholder="最多输入100个字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${repair.position}"/>
                    </div>
                </div>--%>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        报修物品名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="itemNameShow" type="text" placeholder="请点击选择"
                                   onclick="itemType()" value="${repair.itemNameShow}"/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="itemNameTree" class="ztree"></ul>
                        </div>
                        <input id="itemName" type="hidden" value="${repair.itemName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        联系人电话
                    </div>
                    <div class="col-md-9">
                        <input id="contactNumber" type="text" placeholder="请输入有效联系电话"
                               class="validate[required,maxSize[100]] form-control"
                               value="${repair.contactNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        故障描述
                    </div>
                    <div class="col-md-9">
                        <input id="faultDescription" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="165" placeholder="最多输入165个字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${repair.faultDescription}"/>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        维修位置
                    </div>
                    <div class="col-md-9">
                        <input id="repairAddress" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="100" placeholder="最多输入100个字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${repair.repairAddress}"/>
                    </div>
                </div>
                <%--<div class="form-row">
                    <div class="col-md-2 tar">
                        资产编号
                    </div>
                    <div class="col-md-9">
                        <input id="assetsID" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="12" placeholder="最多输入12个字"
                               class="validate[required,maxSize[100]] form-control"
                               value="${repair.assetsID}"/>
                    </div>
                </div>--%>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "dic_code",
                text: "dic_name",
                tableName: "T_SYS_USERDIC",
                where: " WHERE 1 = 1 and dic_type='BXLXGL' and VALID_FLAG=1",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "repairType", '${repair.repairType}');
            });
    })

    /*物品名称多选树*/
    function itemType() {
        $.get("<%=request.getContextPath()%>/getRepairDicTree", function (data) {
            addOption(data, 'itemName', '${repair.itemName}');
            var itemNameTree = $.fn.zTree.init($("#itemNameTree"), setting, data);
            var node;
            var lis = $("#itemName").val().split(",");
            //设置选择节点
            for (var i = 0; i < lis.length; i++) {
                node = itemNameTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#" + lis[i]).attr("checked");
                itemNameTree.checkNode(node, true, false, callbackFlag);
            }
        });
        showMenu();
    }

    function save() {
        // var itemName = $("#itemName").val();
        // alert(itemName)
        var reg = /^[0-9]+.?[0-9]*$/;
        var regTel = /^1[0-9]{10}$/;
        if ($("#repairType").val() == "" || $("#repairType").val() == "0" || $("#repairType").val() == undefined) {
            swal({
                title: "请填写报修类型！",
                type: "info"
            });
            return;
        }
        /*if ($("#assetsID").val() != "" && !reg.test($("#assetsID").val())) {
            swal({
                title: "资产编号请填写数字！",
                type: "info"
            });
            return;
        }*/
        if ($("#itemName").val() == "" || $("#itemName").val() == "0" || $("#itemName").val() == undefined) {
            swal({
                title: "请填写报修物品名称！",
                type: "info"
            });
            return;
        }
        if ($("#contactNumber").val() == "" || $("#contactNumber").val() == "0" || $("#contactNumber").val() == undefined) {
            swal({
                title: "请填写联系方式！",
                type: "info"
            });
            return;
        }
        if (!reg.test($("#contactNumber").val())) {
            swal({
                title: "联系方式填写数字！",
                type: "info"
            });
            return;
        } else if (!regTel.test($("#contactNumber").val())) {
            swal({
                title: "联系方式请填写11位手机号！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/repair/saveRepair", {
            repairID: $("#rID").val(),
            repairType: $("#repairType").val(),
            assetsID: $("#assetsID").val(),
            position: $("#position").val(),
            dept: $("#dept").val(),
            itemName: $("#itemName").val(),
            repairAddress: $("#repairAddress").val(),
            faultDescription: $("#faultDescription").val(),
            contactNumber: $("#contactNumber").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#repairTable').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
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
<script type="text/javascript">//多选树z-tree.js数据格式 end
var setting = {
    check: {
        enable: true,
        chkboxType: {"Y": "s", "N": "ps"}
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
    var zTree = $.fn.zTree.getZTreeObj("itemNameTree");
    var nodes = zTree.getCheckedNodes(true);
    v = "";
    for (var i = 0, l = nodes.length; i < l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0) v = v.substring(0, v.length - 1);
    var deptId = $("#itemName");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#itemName");
    var cityOffset = $("#itemName").offset();
    $("#menuContent").css({
        left: cityOffset.left + "px",
        top: cityOffset.top + cityObj.outerHeight() + "px"
    }).slideDown("fast");
    $("body").bind("mousedown", onBodyDown);
}

function hideMenuDept() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}

function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "itemNameShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
        hideMenuDept();
        var zTree = $.fn.zTree.getZTreeObj("itemNameTree");
        var nodes = zTree.getCheckedNodes(true);
        $("#itemName").val(getChildNodes(nodes));//获取子节点
        $("#itemNameShow").val(getChildNodesSel(nodes));//获取子节点
    }
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
