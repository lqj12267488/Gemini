<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<input id="taskId" hidden value="${id}">
<input id="startFlag" hidden value="${startFlag}">
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title" id="titleValue">选择人员</h4>
        </div>
        <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
        <div class="modal-body clearfix">
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <ul id="empTree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-success btn-clean" id="saveBtn" onclick="save()">保存</button>
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">关闭</button>
        </div>
    </div>
    <input id="eType" value="${evaluationType}" hidden>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var empTree;
    var setting = {
        view: {
            dblClickExpand: dblClickExpand,
            fontCss: {color: "white"},
            showLine: false
        },
        check: {
            enable: true,
            chkStyle: "checkbox",
            chkboxType: {"Y": "s", "N": "ps"}
        },
        data: {
            simpleData: {
                enable: true
            }
        }
    };

    function dblClickExpand(treeId, treeNode) {
        return treeNode.level > 0;
    }

    $(document).ready(function () {
        var startFlag = $("#startFlag").val();
        startFlag = 1 ;
        if(startFlag == 1 ){
            $("#saveBtn").hide();
            $("#titleValue").html('查看被评人');
            getEmpsCheck();
        }else{
            $("#saveBtn").show();
            getTree();
        }
    });

    function getEmpsCheck() {
        $.get("<%=request.getContextPath()%>/evaluation/getEmpsCheckByTask?id=" + "${id}"+"&evaluationType="+$("#eType").val(), function (data) {
            empTree = $.fn.zTree.init($("#empTree"), setting, data.tree);
            var node = empTree.getNodeByParam("id", "001");
            empTree.expandNode(node, true, false, false);
        })
    }

    function getTree() {
        $.get("<%=request.getContextPath()%>/evaluation/getEmpsByTask?id=" + "${id}", function (data) {
            empTree = $.fn.zTree.init($("#empTree"), setting, data.tree);
            empTree.expandAll(true);
            var node = empTree.getNodeByParam("id", "001");
            empTree.expandNode(node, true, false, false);
            var selected = data.selected;
            for (var i = 0; i < selected.length; i++) {
                var node = empTree.getNodeByParam("id", selected[i].personId +','+ selected[i].deptId);
                empTree.checkNode(node, true, false);
            }
        })
    }

    var id = "";
    function save() {
        var nodes = empTree.getCheckedNodes(true);
        id = "";
        for (var i = 0; i < nodes.length; i++) {
            id += nodes[i].id + "," + nodes[i].name + ";";
        }
        id = id.substring(0, id.length - 1);
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/evaluation/saveEmps", {
            taskId: $("#taskId").val(),
            ids: id
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                taskTable.ajax.reload();
            }
        })
    }
</script>
