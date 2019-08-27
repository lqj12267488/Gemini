<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/libs/css/stylesheets.css" rel="stylesheet" type="text/css">
<div class="modal-dialog" id="modaldialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">新增</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            考评子项名称
                        </div>
                        <div class="col-md-9">
                            <input id="taskShowName" type="text"
                                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="15" placeholder="最多输入15个字"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            权重
                        </div>
                        <div class="col-md-9">
                            <input id="weights" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="10" placeholder="最多输入10位数字"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            添加考评任务
                        </div>
                        <div class="col-md-9">
                            <div>
                                <input id="itemTaskShow" type="text" onclick="showTree()" />
                            </div>
                            <div id="menuContent" class="menuContent">
                                <ul id="itemTaskTree" class="ztree"></ul>
                            </div>
                            <input id="itemTask" type="hidden" />
                        </div>
                    </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()" id="saveBtn">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
    <input type="hidden" id="complexTaskId" value="${complexTaskId}">
    <input type="hidden" id="term" value="${term}">
    <input type="hidden" id="evaluationType" value="${evaluationType}"/>
</div>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.excheck.js"></script>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var zTree ;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableToTree",{
                id: " task_id",
                text: " task_name ",
                tableName: "T_KH_EVALUATION_TASK ",
                where: " WHERE  ( START_FLAG = 2 or  END_TIME  <  sysdate )  and term = '"+$("#term").val()+"'" +
                                " and EVALUATION_TYPE = '"+$("#evaluationType").val()+"'"// END_TIME >sysdate and
            },
            function (data) {
                zTree = $.fn.zTree.init($("#itemTaskTree"), setting, data);
                var node;
//                var lis = $("#itemName").val().split(",");
//                //设置选择节点
//                for(var i = 0;i< lis.length;i++){
//                    node = itemTaskTree.getNodeByParam("id", lis[i], null);
//                    var callbackFlag = $("#"+lis[i]).attr("checked");
//                    itemTaskTree.checkNode(node, true, false, callbackFlag);
//                }
            });
    });

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
        zTree = $.fn.zTree.getZTreeObj("itemTaskTree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        zTree = $.fn.zTree.getZTreeObj("itemTaskTree"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var deptId = $("#itemTask");
        deptId.attr("value", v);
    }

    function showTree() {
        var cityObj = $("#itemTask");
        var cityOffset = $("#itemTask").offset();
        $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "itemTaskShow" || $(event.target).parents("#menuContent").length>0)) {
            hideTree();
            zTree = $.fn.zTree.getZTreeObj("itemTaskTree"),
                nodes = zTree.getCheckedNodes(true);
            $("#itemTask").val(getChildNodes(nodes));//获取子节点
            $("#itemTaskShow").val(getChildNodesSel(nodes));//获取子节点
        }
    }

    function getChildNodesSel(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }

    function hideTree() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    function getChildNodes(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }
    function save() {
        if ($("#taskShowName").val() == "" || $("#taskShowName").val() == null) {
            swal({
                title: "请填写综合评教任务名称！",
                type: "info"
            });
            return;
        }
        if ($("#weights").val() == "" || $("#weights").val() == null) {
            swal({
                title: "请填写权重！",
                type: "info"
            });
            return;
        }
        if ($("#itemTaskShow").val() == "" || $("#itemTaskShow").val() == null) {
            swal({
                title: "请选择考评子任务！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/xgEvaluation/complex/saveDetail", {
            complexTaskId: $("#complexTaskId").val(),
            taskShowName: $("#taskShowName").val(),
            score: $("#score").val(),
            weights: Number($("#weights").val()),
            taskId : $("#itemTask").val(),
            taskName : $("#itemTaskShow").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal("hide");
                $('#ComplexDetailTable').DataTable().ajax.reload();
            }else if (msg.status == 0) {
                swal({title: msg.msg, type: "error"});
            }
            hideSaveLoading();
        })
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
