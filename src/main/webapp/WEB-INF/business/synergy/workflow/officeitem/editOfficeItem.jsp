<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/6 0006
  Time: 下午 2:59
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
            <input id="officeItemId" hidden value="${officeItem.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        物品名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="itemNameShow" type="text" onclick="showMenu()"  placeholder="请点击选择"
                                   value="${officeItem.itemNameShow}"/>
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
                        <input id="itemNumber" type="" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               placeholder="请输入数字"
                               class="validate[required,maxSize[100],digits:true] form-control"
                               value="${officeItem.itemNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请部门
                    </div>
                    <div class="col-md-9">
                        <input id="requestdept" type="text" readonly
                               class="validate[required,maxSize[100]] form-control"
                               value="${deptName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请人
                    </div>
                    <div class="col-md-9">
                        <input id="personName" type="text" readonly
                               class="validate[required,maxSize[20]] form-control"
                               value="${personName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="o_requestDate" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${officeItem.requestDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${officeItem.remark}">${officeItem.remark}</textarea>
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
<%--<input id="roleCache" hidden value="${officeItem.roletype}">--%>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
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
        var reg = new RegExp("^[0-9]*$");
        var date = $("#o_requestDate").val();
        date = date.replace('T', '');
        if ($("#o_requestDate").val() == "") {
             swal({
                title: "请填写申请日期",
                type: "info"
            });
            return;
        }
        if ($("#itemName").val() == "" || $("#itemName").val() == "0" || $("#itemName").val() == undefined ) {
            swal({
                title: "请选择物品名称",
                type: "info"
            });
            return;
        }
        if ($("#itemNumber").val() == "") {
              swal({
                title: "请填写申请数量",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#itemNumber").val())){
           swal({
                title: "申请数量请填写整数",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/officeItem/saveOfficeItem", {
            id: $("#officeItemId").val(),
            remark: $("#remark").val(),
            itemNumber: $("#itemNumber").val(),
            requestDate:date,
            itemName: $("#itemName").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#officeItem').DataTable().ajax.reload();
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
