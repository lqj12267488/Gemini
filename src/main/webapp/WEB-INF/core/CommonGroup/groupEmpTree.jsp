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
<input id="groupId" hidden value="${groupId}">
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">选择人员</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <ul id="groupEmpTree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.excheck.js"></script>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
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
                enable: true,
                idKey: "id",
                pIdKey: "pId",
                rootPId: "0"
            }
        }
    };
    var groupEmpTree;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/commonGroup/getEmpTree?groupId=" + "${groupId}", function (data) {
            groupEmpTree = $.fn.zTree.init($("#groupEmpTree"), setting, data);
            groupEmpTree.expandAll(true);
        })
    });
    var id = "";

    function save() {
        var groupId = $("#groupId").val();
        var nodes=groupEmpTree.getCheckedNodes(true);
        //var checkList =new Array;
        var checkList="";
        for(var i=0;i<nodes.length;i++){
            if(isNaN(nodes[i].id)){
                checkList += nodes[i].id + "," + nodes[i].pId + "," + nodes[i].name + ";";
            }
        }
        if(checkList.length>0)
            checkList = checkList.substring(0,checkList.length-1);
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/commonGroup/saveCommomGroupMember", {
            groupId:groupId,
            checkList:checkList
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1 ) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
            }
        })

    }
</script>
