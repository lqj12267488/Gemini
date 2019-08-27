<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/21
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">选择班级<input id="signId" hidden value="${id}"></h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <ul id="signTree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var signTree;
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
        $.get("<%=request.getContextPath()%>/coursesign/getClassTreeBySign?id=${id}&planId=${planId}" , function (data) {
            signTree = $.fn.zTree.init($("#signTree"), setting, data.tree);
            signTree.expandAll(false
            );
            var node = signTree.getNodeByParam("id", id);
            signTree.expandNode(node, true, false, false);
            var selected = data.selected;
            for (var i = 0; i < selected.length; i++) {
                var node = signTree.getNodeByParam("id", selected[i].classId)
                if(node != null)
                signTree.checkNode(node, true, false);
            }

        })
    });
    var id = "";

    function save() {
        var nodes = signTree.getCheckedNodes(true);
        id = "";
        for (var i = 0; i < nodes.length; i++) {
            id += nodes[i].id + ",";
        }
        id = id.substring(0,id.length-1);
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/coursesign/saveClass", {
            signId: $("#signId").val(),
            ids: id
        }, function (msg) {
            if (msg.status == 1) {
                hideSaveLoading();
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#signClassList').DataTable().ajax.reload();
            }
        })
    }
</script>
