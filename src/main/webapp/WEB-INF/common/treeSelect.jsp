<style type="text/css">
    textarea {
        resize: none;
    }

    #menuContent {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<script>
    var selectTreeSetting = {
        check: {
            enable: true,
            chkboxType: {"Y": "s", "N": "s"}
        },
        view: {
            dblClickExpand: false,
            showIcon: false,
            showLine: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClick,
            onCheck: onCheck,
        }
    };

    var selectTreeId;
    var hiddenInput;
    var nameShow;

    function initSelectTreeByData(data, zTreeId, nameShowId, hiddenInputId, setting) {
        if (setting != undefined) {
            selectTreeSetting = setting;
        }
        $("#" + nameShowId).attr("onclick", "showMenu()");
        selectTreeId = zTreeId;
        nameShow = nameShowId;
        hiddenInput = hiddenInputId;
        $.fn.zTree.init($("#" + selectTreeId), selectTreeSetting, data);
    }

    function initSelectTree(url, zTreeId, nameShowId, hiddenInputId, setting) {
        if (setting != undefined) {
            selectTreeSetting = setting;
        }
        $("#" + nameShowId).attr("onclick", "showMenu()");
        selectTreeId = zTreeId;
        nameShow = nameShowId;
        hiddenInput = hiddenInputId;
        $.get(url, function (data) {
            $.fn.zTree.init($("#" + selectTreeId), selectTreeSetting, data);
        });
    }

    function beforeClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj(treeId);
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        var v = "";
        for (var i = 0, l = treeNode.length; i < l; i++) {
            v += treeNode[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
        $("#" + nameShow).attr("value", v);
    }

    function showMenu() {
        var Obj = $("#" + nameShow);
        var Offset = $("#" + nameShow).offset();
        $("#menuContent").css({
            left: Offset.left + "px",
            top: Offset.top + Obj.outerHeight() + "px",
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

    function hideMenu() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == hiddenInput || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
            hideMenu();
            var nodes = $.fn.zTree.getZTreeObj(selectTreeId).getCheckedNodes(true);
            $("#" + hiddenInput).val(getChildNodes(nodes));//获取子节点
            $("#" + nameShow).val(getChildNodesSel(nodes));//获取子节点
        }
    }

    function getChildNodesSel(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (treeNode[i].id != "9999") {
                nodes += treeNode[i].name + ",";
            }
        }
        return nodes.substring(0, nodes.length - 1);
    }

    function getChildNodes(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (treeNode[i].id != "9999") {
                nodes += treeNode[i].id + ",";
            }
        }
        return nodes.substring(0, nodes.length - 1);
    }
</script>