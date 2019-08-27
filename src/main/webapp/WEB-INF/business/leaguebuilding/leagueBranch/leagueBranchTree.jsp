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
    var deptTree;
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
            onClick: branchTreeOnClick
        }
    };

    function branchTreeOnClick(event, treeId, treeNode) {
        if(treeNode.id != 0 ){
            $("#addDept").show();
            $("#addDept").load("<%=request.getContextPath()%>/league/editLeagueBranch", {id: treeNode.id});
            return false;
        }else{
            swal({
                title: "根节点不能编辑！",
                type: "info"
            });
        }
    }

    function del(treeNode) {
        if (treeNode.id == 0) {
            swal({
                title: "根节点不能删除！",
                type: "info"
            });
            return false;
        } else if (treeNode != null && treeNode.children != null && treeNode.children.length != null && treeNode.children.length > 0) {
            swal({
                title: "当前节点存在子节点，不能删除！",
                type: "info"
            });
            return false;
        } else {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            zTree.selectNode(treeNode);
            $.post("<%=request.getContextPath()%>/league/checkLeagueBranchById", {
                id :treeNode.id
            },function (msg) {
                if (msg.status!=1){
                    swal({
                        title: "当前节点存在团员信息，不能删除！",
                        type: "info"
                    });
                    return false;
                }else{
                    swal({
                        title: "确定要删除" + treeNode.name + "?",
                        type: "warning",
                        showCancelButton: true,
                        cancelButtonText: "取消",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "删除",
                        closeOnConfirm: false
                    }, function () {
                        $.post("<%=request.getContextPath()%>/league/deleteLeagueBranchById", {
                            id: treeNode.id
                        }, function (msg) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            if(treeNode) {
                                zTree.removeNode(treeNode);
                            }
                            deptObjhide();
                        });
                    })
                }
            })

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
            if(treeNode.id.length<4){
                $("#addDept").show();
                $("#addDept").load("<%=request.getContextPath()%>/league/addLeagueBranch", {pId: treeNode.id, name: treeNode.name})
                return false;
            }else{
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
        $.get("<%=request.getContextPath()%>/league/getLeagueBranchTree", function (data) {
            deptTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            deptTree.expandAll(true);
        });
    });

    function deptObjhide(){
        $("#addDept").hide();
    }

    function refreDeptTree() {
        $.get("<%=request.getContextPath()%>/league/getLeagueBranchTree", function (data) {
            deptTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            deptTree.expandAll(true);
        })
        deptObjhide();
    }

</script>