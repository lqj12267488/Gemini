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
<div class="content">
    <div class="col-md-12">
        <div class="block">
            <div class="content">
                <button type="button" class="btn btn-default btn-clean"
                        onclick="back()">返回
                </button>
            </div>
        </div>
    </div>
    <div class="col-md-5">
        <div class="block">
            <div class="content">
                <div class="controls" id="style-4" style="overflow-y:auto;height:74% ">
                    <ul id="indexTree" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-7">
        <div class="block">
            <div class="content">
                <div class="controls" id="addIndex" style="overflow-y:auto;height:74% ">
                </div>
            </div>
        </div>
    </div>
    <input id="planId" hidden value="${id}">
</div>
<script>
    var level;
    var indexTree;
    var setting = {
        view: {
            addHoverDom: addHoverDom,
            removeHoverDom: removeHoverDom,
            fontCss: {color: "white"},
            showLine: false
        },
        data: {
            simpleData: {
                enable: true,
            }
        },
        callback: {
            onClick: onClick
        }
    };


    $(document).ready(function () {
        indexTree = $.fn.zTree.init($("#indexTree"), setting, ${data});
        indexTree.expandAll(true);
    });

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
            if (treeNode.level == 3) {
                swal({title: "指标不能超过三级！"});
            } else {
                level = treeNode.level;
                $("#addIndex").show();
                $("#addIndex").load("<%=request.getContextPath()%>/evaluation/toAddIndex", {planId: '${id}', pId: treeNode.id})
            }
            return false;
        });
    };

    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_" + treeNode.tId).unbind().remove();
//        $("#editBtn_" + treeNode.tId).unbind().remove();
        $("#delBtn_" + treeNode.tId).unbind().remove();
    };

    function del(treeNode) {
        if (treeNode.id == 0 || treeNode.id == $("#planId").val() ) {
            swal({
                title: "根节点不能删除！",
                type: "error"
            });
            return false;
        } else if (treeNode != null && treeNode.children != null && treeNode.children.length != null && treeNode.children.length > 0) {
            swal({title: "当前指标下有子指标，不能删除！", type: "error"});
            return false;
        } else {
            var zTree = $.fn.zTree.getZTreeObj("indexTree");
            zTree.selectNode(treeNode);
            swal({
                title: "您确定要删除本条信息? ",
                text: "指标名称："+treeNode.name+"\n\n删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                closeOnConfirm: false
            }, function () {
                $.get("<%=request.getContextPath()%>/evaluation/deleteIndex?id=" + treeNode.id, function (msg) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    if (treeNode) {
                        zTree.removeNode(treeNode);
                    }
                })

            });
        }

    }

    function onClick(event, treeId, treeNode) {
        if (treeNode.level != 0) {
            $("#index").show();
            $("#addIndex").load("<%=request.getContextPath()%>/evaluation/toEditIndex", {id: treeNode.id});
        } else {
            $("#index").hide();
        }
        return false;
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/evaluation/interviewersPlan");
    }
</script>
