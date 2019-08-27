<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">
    .ztree li span.button.switch.level0 {
        visibility: hidden;
        width: 1px;
    }

    .ztree li ul.level0 {
        padding: 0;
        background: none;
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="block block-drop-shadow">
                <div class="content controls" id="style-4" style="overflow-y:auto;height: 85%">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
        <div id="addMenu" class="col-md-9"></div>
    </div>
    <div class="modal" id="alert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">确定删除?</h4>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success btn-clean" data-dismiss="modal">是
                    </button>
                    <button type="button" class="btn btn-danger btn-clean" data-dismiss="modal">否
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var deptTree;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        view: {
            fontCss: {color: "white"},
            addHoverDom: addHoverDom,
            removeHoverDom: removeHoverDom,
            dblClickExpand: dblClickExpand,
            showLine: false
        },
        data: {
            simpleData: {
                enable: true,
                rootPId: 'MenuRootNode'
            }
        },
        callback: {
            onClick: zTreeOnClick
        }
    };

    function dblClickExpand(treeId, treeNode) {
        return treeNode.level > 0;
    }

    function zTreeOnClick(event, treeId, treeNode) {
        $("#addMenu").show();
        $("#addMenu").load("<%=request.getContextPath()%>/getMenuById", {id: treeNode.id})
        return false;
    }

    function del(treeNode) {
        if (treeNode != null && treeNode.children != null && treeNode.children.length != null && treeNode.children.length > 0) {
            swal({title: "当前菜单下有子菜单，不能删除！", type: "error"});
            //alert("当前菜单下有子菜单，不能删除！")
            return false;
        } else {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            zTree.selectNode(treeNode);
            //var r = confirm("确定要删除" + treeNode.name + "?");

            swal({
                title: "您确定要删除本条信息?",
                text: "菜单名称：" + treeNode.name + "\n\n删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                closeOnConfirm: false
            }, function () {
                /*if(r==true){*/
                $.get("<%=request.getContextPath()%>/deleteMenuById?id=" + treeNode.id,
                    function (msg) {
                        swal({
                            title: msg.msg,
                            type: msg.result
                        });
                    });
                //alert(msg.msg);
                if (treeNode) {
                    zTree.removeNode(treeNode);
                }
                menuObjhide();
            })
            /* }*/
        }
    }

    function insert(treeNode) {
        if (treeNode.id.length == 15) {
            swal({title: "第四层菜单不允许创建子菜单", type: "error"});
            //alert("第三层菜单不允许创建子菜单");
        }
        else {
            $("#addMenu").show();
            $("#addMenu").load("<%=request.getContextPath()%>/addMenu", {pId: treeNode.id, name: treeNode.name});
        }
    }

    function addHoverDom(treeId, treeNode) {
        if (treeNode.level > 0) {
            var delObj = $("#" + treeNode.tId + "_span");
            if (treeNode.editNameFlag || $("#delBtn_" + treeNode.tId).length > 0) return;
            var delStr = "<span class='button remove' id='delBtn_" + treeNode.tId
                + "' title='删除' onfocus='this.blur();'></span>";
            delObj.after(delStr);
            var delBtu = $("#delBtn_" + treeNode.tId);
            if (delBtu) delBtu.bind("click", function () {
                del(treeNode);
                return false;
            });
        }
        /*var editObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#editBtn_" + treeNode.tId).length > 0) return;
        var editStr = "<span class='button edit' id='editBtn_" + treeNode.tId
            + "' title='修改' onfocus='this.blur();'></span>";
        editObj.after(editStr);
        var enitBtu = $("#editBtn_" + treeNode.tId);
        if (enitBtu) enitBtu.bind("click", function () {
            $("#addMenu").load("/getMenuById", {id: treeNode.id})
            return false;
        });*/
        var addObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
            + "' title='添加' onfocus='this.blur();'></span>";
        addObj.after(addStr);
        var addBtu = $("#addBtn_" + treeNode.tId);
        if (addBtu) addBtu.bind("click", function () {
            insert(treeNode);
            return false;
        });
    };

    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_" + treeNode.tId).unbind().remove();
        //$("#editBtn_" + treeNode.tId).unbind().remove();
        $("#delBtn_" + treeNode.tId).unbind().remove();
    };
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/getSystemMenuTree", function (data) {
            deptTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            var nodes = deptTree.getNodes()[0].children;
            for (var i = 0; i < nodes.length; i++) { //设置节点展开
                deptTree.expandNode(nodes[i], true, false, true);
            }
        })
    });

    function refreMenuTree() {
        $.get("<%=request.getContextPath()%>/getSystemMenuTree", function (data) {
            deptTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            deptTree.expandAll(true);
        });
        menuObjhide();
    }

    function menuObjhide() {
        $("#addMenu").hide();
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