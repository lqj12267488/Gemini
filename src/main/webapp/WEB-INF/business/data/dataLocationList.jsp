<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="row">
    <div class="col-md-3">
        <div class="block block-drop-shadow">
            <div class="content controls" style="height: 85%">
                <ul id="treeDemo" class="ztree"></ul>
            </div>
        </div>
    </div>
    <div id="addDept" class="col-md-9"></div>
</div>
<script>
    var dataTree;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        view: {
            fontCss: {color: "white"},
            addHoverDom: addHoverDom,
            removeHoverDom: removeHoverDom,
            showLine: false
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "pId",
                rootPId: "root"
            }
        },
        callback: {
            onClick: dataTreeOnClick
        }
    };

    function dataTreeOnClick(event, treeId, treeNode) {
        if (treeNode.id != 0) {
            $("#addDept").show();
            $("#addDept").load("<%=request.getContextPath()%>/dataLocation/editDataLocation", {
                id: treeNode.id,
                name:treeNode.name
            });
            return false;
        } else {
            swal({
                title: "根节点不能编辑！",
                type: "info"
            });
        }
    }

    function del(treeNode) {
        if (treeNode.id == 0) {
            swal({title: "根节点不能删除", type: "error"});
            return false;
        } else if (treeNode != null && treeNode.children != null && treeNode.children.length != null && treeNode.children.length > 0) {
            swal({title: "当前节点下存在数据，不能删除！", type: "error"});
            return false;
        } else {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            zTree.selectNode(treeNode);
            swal({
                title: "您确定要删除本条信息?",
                text: "存放位置名称：" + treeNode.name + "\n\n删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                closeOnConfirm: false
            }, function () {
                $.get("<%=request.getContextPath()%>/data/deleteDataById?dataId=" + treeNode.id, function (msg) {
                    swal({
                        title: msg.msg,
                        type: msg.result
                    });
                    if (msg.status != 0) {
                        if (treeNode) {
                            zTree.removeNode(treeNode);
                        }
                        deptObjhide();
                    }
                });
            });
        }

    }

    function addHoverDom(treeId, treeNode) {
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
        var addObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
            + "' title='添加' onfocus='this.blur();'></span>";
        addObj.after(addStr);
        var addBtu = $("#addBtn_" + treeNode.tId);
        if (addBtu) addBtu.bind("click", function () {
            //只能建立三级树节点
            if(treeNode.id.length<7) {
                $("#addDept").show();
                $("#addDept").load("<%=request.getContextPath()%>/dataLocation/addDataLocation", {
                    pId: treeNode.id,
                    typeName: treeNode.name
                })
                return false;
            }
            else{
                swal({
                    title: "当前节点下不能继续新增！",
                    type: "info"
                });
                return false;
            }
        });
    };

    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_" + treeNode.tId).unbind().remove();
        $("#delBtn_" + treeNode.tId).unbind().remove();
    };
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/dataLocation/getDataLocationTree", function (data) {
            dataTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            dataTree.expandAll(true);
        });
    });

    function deptObjhide() {
        $("#addDept").hide();
    }

    function refreDataTree() {
        $.get("<%=request.getContextPath()%>/dataLocation/getDataLocationTree", function (data) {
            dataTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            dataTree.expandAll(true);
        })
        deptObjhide();
    }

</script>