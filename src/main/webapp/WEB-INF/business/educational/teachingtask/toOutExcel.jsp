<%--
  Created by IntelliJ IDEA.
  User: ZhangHao
  Date: 2018/3/15
  Time: 09:06
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
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">

            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学年/学期
                    </div>
                    <div class="col-md-9">
                        <select id="toExcel_semester" class="form-control">
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 系部
                    </div>
                    <div class="col-md-9">
                        <div style="white-space:nowrap;">
                            <input id="deptSel" type="text" onclick="showMenu()" value="${toEdit.departmentName}"
                                   readonly/>
                        </div>
                        <div id="menuContent1" class="menuContent1">
                            <ul id="treeDemo" class="ztree"></ul>
                        </div>
                        <input id="deptId" type="hidden" value="${toEdit.department}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>填表人
                    </div>
                    <div class="col-md-9">
                        <input id="toExcel_pBy" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${toEdit.preparedByName}"/>
                        <input id="toExcel_preparedBy" type="hidden" value="${toEdit.preparedBy}">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="outExcelTemplate()">下载模板
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    function outExcelTemplate() {
        var semester = $("#toExcel_semester").val();
        var department = $("#deptId").val();
        var teacherId = $("#toExcel_preparedBy").val();
        if (semester == "" || semester == null) {
            swal({
                title: "请选择学年",
                type: "info"
            });
            return;
        }
        if (department == "" || department == null) {
            swal({
                title: "请选择系部",
                type: "info"
            });
            return;
        }
        if (teacherId == "" || teacherId == null) {
            swal({
                title: "请输入教师名称",
                type: "info"
            });
            return;
        }
        window.location.href = "<%=request.getContextPath()%>/teachingTask/outTemplate?deptId=" + department + "&userId=" + teacherId + "&semester=" + semester;
    }

    $(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'toExcel_semester', '${toEdit.semester}');
        });

        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#toExcel_pBy").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#toExcel_pBy").val(ui.item.label.split("  ----  ")[0]);
                    $("#toExcel_pBy").attr("keycode", ui.item.value);
                    $("#toExcel_preparedBy").val(ui.item.value.split(",")[1]);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            var editRangezTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            var node;
            var lis = $("#deptId").val().split(",");
            //设置选择节点
            for (var i = 0; i < lis.length; i++) {
                node = editRangezTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#" + lis[i]).attr("checked");
                editRangezTree.checkNode(node, true, false, callbackFlag);
            }
        });
    });

    var setting = {
        check: {
            enable: true,
            chkStyle: "radio",
            chkboxType: {"Y": "s", "N": "ps"}
        },
        view: {
            dblClickExpand: false,
            showIcon: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClick,
            onCheck: onCheck
        }
    };

    function beforeClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
        var deptId = $("#deptId");
        deptId.attr("value", v);
    }

    function showMenu() {
        var cityObj = $("#deptId");
        var cityOffset = $("#deptId").offset();
        $("#menuContent1").css({
            left: cityOffset.left + "px",
            top: cityOffset.top + cityObj.outerHeight() + "px"
        }).slideDown("fast");

        $("body").bind("mousedown", onBodyDown);
    }

    function hideMenu() {
        $("#menuContent1").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "deptSel" || event.target.id == "menuContent1" || $(event.target).parents("#menuContent1").length > 0)) {
            hideMenu();
            var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
                nodes = zTree.getCheckedNodes(true);
            $("#deptId").val(getChildNodes(nodes));//获取子节点
            $("#deptSel").val(getChildNodesSel(nodes));//获取子节点
        }
    }

    function getChildNodesSel(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (!treeNode[i].isParent)
                nodes += treeNode[i].name + ",";
        }
        return nodes.substring(0, nodes.length - 1);
    }

    function getChildNodes(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (!treeNode[i].isParent) {
                nodes += treeNode[i].id + ",";
            }

        }
        return nodes.substring(0, nodes.length - 1);
    }
</script>
<style>
    #menuContent1 {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>


