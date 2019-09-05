<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2018/4/4
  Time: 9:52
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
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <input id="archivesId" hidden value="${archivesId}">
                <ul id="treeDemo" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-success btn-clean" id="saveBtn" onclick="saveRoleEmpDeptRelation()">保存</button>
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>
<input id="ids" hidden value="${ids}">
<input id="flag" hidden value="${flag}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var EmpDeptTree;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
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
                enable: true
            }
        }
    };

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/archives/getArchivesDeptAndPersonTree?id=" + $("#archivesId").val()+"&flag="+$("#flag").val(), function (data) {
            EmpDeptTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            EmpDeptTree.expandAll(true);
        });
    });

    function saveRoleEmpDeptRelation() {
        var archivesId = $("#archivesId").val();
        var nodes = EmpDeptTree.getCheckedNodes(true);
        var checkList = "";
        for (var i = 0; i < nodes.length; i++) {
            if (isNaN(nodes[i].id)) {
                checkList += nodes[i].pId + "@" + nodes[i].id + "@@@";
            }
        }
        if (checkList.length > 0)
            checkList = checkList.substring(0, checkList.length - 3);
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/archives/savePerRelation", {
            ids:$("#ids").val(),
            archivesId: archivesId,
            checkList: checkList
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#listGrid').DataTable().ajax.reload();
            }
        })
    }
</script>
<style>
    #style-4::-webkit-scrollbar-track {
        -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
        background-color: #474D52;
    }

    #style-4::-webkit-scrollbar {
        width: 5px;
        background-color: #474D52;
    }

    #style-4::-webkit-scrollbar-thumb {
        background-color: #ffffff;
        border: 1px solid #474D52;
    }
</style>