
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
            <h4 class="modal-title" id="titleValue">查看评委组</h4>
        </div>
        <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
        <div class="modal-body clearfix">
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <h4 class="modal-title">教师评委</h4>
                <ul id="empTree" class="ztree"></ul>
                <h4 class="modal-title">学生评委</h4>
                <ul id="stuTree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">关闭</button>
        </div>
    </div>
    <input id="eType" value="${evaluationType}" hidden>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
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

        $.get("<%=request.getContextPath()%>/xgEvaluation/getMembersByTask?id=" + "${id}"+"&evaluationType="+$("#eType").val(), function (data) {
            var empTree = $.fn.zTree.init($("#empTree"), setting, data.tea);
            var node = empTree.getNodeByParam("id", "001");
            empTree.expandNode(node, true, false, false);

            var stuTree = $.fn.zTree.init($("#stuTree"), setting, data.stu);
            var node = stuTree.getNodeByParam("id", "001");
            stuTree.expandNode(node, true, false, false);
        })

    });
</script>
