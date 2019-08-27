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
            <h4 class="modal-title">选择人员</h4>
        </div>
        <div class="modal-body clearfix">
            <input id="id" hidden value="${id}">
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <ul id="tree" class="ztree"></ul>
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
    var tree;
    var setting = {
        view: {
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
                enable: true,
                idKey: "id",
                pIdKey: "pId",
                rootPId: 0
            }
        }
    };

    function dblClickExpand(treeId, treeNode) {
        return treeNode.level > 0;
    }

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/exam/getEmpsTree?id=" + "${id}", function (data) {
            tree = $.fn.zTree.init($("#tree"), setting, data);
        })
    });
    var id = "";

    function save() {
        var nodes = tree.getCheckedNodes(true);
        id = "";
        for (var i = 0; i < nodes.length; i++) {
            if (!nodes[i].isParent) {
                id += nodes[i].id + "," + nodes[i].name + ";";
            }
        }
        id = id.substring(0, id.length - 1);
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/exam/saveEmps", {
            id: '${id}',
            ids: id,
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
            }
        })
    }
</script>
