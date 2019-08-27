<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">查看权限</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <ul id="treeDemo" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="groupId" hidden value="${groupId}">

<script>
    var menuTree;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        view: {
            fontCss: {color: "white"},
            showLine: false
        },
        check: {
            enable: true,
            chkStyle: "checkbox",
            chkboxType: { "Y": "s", "N": "ps" }
        },
        data: {
            simpleData: {
                enable: true
            }
        }
    };

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/getSystemMenuTree", function (data) {
            menuTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            menuTree.expandAll(true);
            var node;
            var menuList =${menuList};
            $.each(menuList, function (index, content) {
                node = menuTree.getNodeByParam("id", content.id, null);
                var callbackFlag = $("#"+content.id).attr("checked");
                menuTree.checkNode(node, true, false, callbackFlag);
            })
        })
    });

</script>