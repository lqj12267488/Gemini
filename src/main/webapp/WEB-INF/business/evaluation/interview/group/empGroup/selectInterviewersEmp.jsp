<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2017/4/28
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">选择人员<input id="groupId" hidden value="${id}"></h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <ul id="groupTree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-success btn-clean" onclick="save()" id="saveBtn">保存</button>
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var groupTree;
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
        $.get("<%=request.getContextPath()%>/evaluation/getEmpsInterviewersTree?groupId=" + "${id}" + "&evaluationType=" + '${evaluationType}', function (data) {
            groupTree = $.fn.zTree.init($("#groupTree"), setting, data.tree);
            groupTree.expandAll(false);
            var node = groupTree.getNodeByParam("id", "0");
            groupTree.expandNode(node, true, false, false);
            var selected = data.selected;
            for (var i = 0; i < selected.length; i++) {
                var node = groupTree.getNodeByParam("id", selected[i].personId +","+ selected[i].deptId ) ;
                groupTree.checkNode(node, true, false);
            }

        })
    });
    var id = "";

    function save() {
        var nodes = groupTree.getCheckedNodes(true);
        id = "";
        for (var i = 0; i < nodes.length; i++) {
            id += nodes[i].id + "," + nodes[i].name + ";";
        }
        id = id.substring(0, id.length - 1);
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/evaluation/saveGroupInterviewersEmps", {
            groupId: $("#groupId").val(),
            ids: id,
            evaluationType: '${evaluationType}'
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                groupTable.ajax.reload();
            }
        })
    }
</script>
