<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2017/4/28
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
            <h4 class="modal-title">分配角色</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <input id="deptId" hidden value="${deptId}">
                <input id="personId" hidden value="${personId}">
                <ul id="roleTree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-success btn-clean"id="saveBtn" onclick="save()">保存</button>
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var data = ${data};
    var roleTree;
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
        roleTree = $.fn.zTree.init($("#roleTree"), setting, data);
    });
    var id = "";
    function save() {
        var nodes = roleTree.getCheckedNodes(true);
        id = "";
        for (var i = 0; i < nodes.length; i++) {
            id += nodes[i].id + ",";
        }
        id = id.substring(0, id.length - 1)
        showSaveLoading();
        if ('${flag}'!='1') {
            swal({
                title: "批量授权后原有授权将进行更改，是否继续授权？",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "green",
                confirmButtonText: "确定",
                closeOnConfirm: false
            }, function () {
                $.post("<%=request.getContextPath()%>/changeEmpRole", {
                    deptId: $("#deptId").val(),
                    personId: $("#personId").val(),
                    ids: id
                }, function (msg) {
                    if (msg.status == 1) {
                        hideSaveLoading()
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        //alert(msg.msg);
                        $("#dialog").modal('hide');
                    }
                    $("#empGrid").DataTable().ajax.reload();
                })
            })
        }else {
            swal({
                title: "请确认更改授权！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "green",
                confirmButtonText: "确定",
                closeOnConfirm: false
            }, function () {
                $.post("<%=request.getContextPath()%>/changeEmpRole", {
                    deptId: $("#deptId").val(),
                    personId: $("#personId").val(),
                    ids: id
                }, function (msg) {
                    if (msg.status == 1) {
                        hideSaveLoading()
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        //alert(msg.msg);
                        $("#dialog").modal('hide');
                    }
                    $("#empGrid").DataTable().ajax.reload();
                })
            })
        }
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