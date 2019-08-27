<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/13
  Time: 16:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>


<head>
    <style type="text/css">
        textarea{
            resize:none;
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
            <input id="publicityDeliveryId" hidden value="${publicityDelivery.id}">
            <%--<input id="publicityDeliveryTemp" hidden value="${publicityDelivery.temp}">--%>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
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
                <%--
                <div class="form-row">
                    <div class="col-md-3 tar">
                        文件上传&lt;%&ndash;这里就是modal里面的${head}值&ndash;%&gt;
                    </div>
                    <div class="col-md-9">
                        <div ms-controller="btnClick">
                            <button id="picture" type="button" title="文件上传"
                                   class="validate[required,maxSize[100]] form-control btn btn-default btn-clean"
                                    onclick="upload_pic()">{{@name}}</button>
                        </div>
                    </div>
                </div>
                --%>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        发布渠道
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="distributionChannelsShow" type="text" placeholder="请点击选择"
                                   onclick="showMenu()"  value="${publicityDelivery.distributionChannelsShow}"/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="publicityDeliveryTree" class="ztree"></ul>
                        </div>
                        <input id="distributionChannels" type="hidden" value="${publicityDelivery.distributionChannels}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="requestDate" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"
                               value="${publicityDelivery.requestDate}"/>
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
                        >${publicityDelivery.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDictToTree?name=FBQD", function (data) {
            addOption(data, 'distributionChannels', '${publicityDelivery.distributionChannels}');
            var publicityDeliveryTree = $.fn.zTree.init($("#publicityDeliveryTree"), setting, data);
            var node;
            var lis = $("#distributionChannels").val().split(",");
            //设置选择节点
            for(var i = 0;i< lis.length;i++){
                node = publicityDeliveryTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                publicityDeliveryTree.checkNode(node, true, false, callbackFlag);
            }
        });
    });
    function saveDept() {
        if ($("#caption").val() == "" || $("#caption").val() == "0" || $("#caption").val() == undefined) {
            swal({
                title: "请填写标题",
                type: "info"
            });
            //alert("请填写标题");
            return;
        }
        if ($("#distributionChannels").val() == "" || $("#distributionChannels").val() == "0" || $("#distributionChannels").val() == undefined) {
            swal({
                title: "请选择发布渠道",
                type: "info"
            });
            //alert("请选择发布渠道");
            return;
        }
        if ($("#requestDate").val() == "" || $("#requestDate").val() == "0" || $("#requestDate").val() == undefined) {
            swal({
                title: "请填写申请时间",
                type: "info"
            });
            //alert("请填写申请时间");
            return;
        }
        if ($("#requestDept").val() == "" || $("#requestDept").val() == "0" || $("#requestDept").val() == undefined) {
            swal({
                title: "请选择申请部门",
                type: "info"
            });
            //alert("请选择申请部门");
            return;
        }
        if ($("#requester").val() == "" || $("#requester").val() == "0" || $("#requester").val() == undefined) {
            swal({
                title: "请选择撰稿人",
                type: "info"
            });
            //alert("请选择撰稿人");
            return;
        }
        var requestDate = $("#requestDate").val().replace('T', '');
        $.post("<%=request.getContextPath()%>/publicityDelivery/savePublicityDelivery", {
            id: $("#publicityDeliveryId").val(),
//            requestDept: $("#requestDept").val(),
            caption: $("#caption").val(),
            temp:$("#publicityDeliveryTemp").val(),
            distributionChannels: $("#distributionChannels").val(),
//            requester: $("#requester").val(),
            requestDate: requestDate,
            remark: $("#remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                /*uploadImg();*/
                deliveryId = (String)(msg.result);
                $(".uploadBtn").click();
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $(".modal-backdrop").remove();//删除class值为modal-backdrop的标签，可去除阴影
                $('#publicityDeliveryGrid').DataTable().ajax.reload(function () {
                    $('#publicityDeliveryGrid tr a').qtip()
                });
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
    var deptId = $("#distributionChannels");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#distributionChannels");
    var cityOffset = $("#distributionChannels").offset();
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
        $("#distributionChannels").val(getChildNodes(nodes));//获取子节点
        $("#distributionChannelsShow").val(getChildNodesSel(nodes));//获取子节点
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

