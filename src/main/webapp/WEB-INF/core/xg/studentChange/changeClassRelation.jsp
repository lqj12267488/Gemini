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
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <input id="studentId" hidden value="${studentId}">
                <input id="relation" hidden value="${relation}">
                <ul id="relationTree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
                <button class="btn btn-success btn-clean" id="saveBtn" onclick="saveRelation()">保存</button>
                <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var relation = $("#relation").val();
    var lis = relation.split(",");

    var relTree;
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
        <%--$.get("<%=request.getContextPath()%>/student/getMajorClassTree", function (data) {--%>
        $.get("<%=request.getContextPath()%>/student/getMajorClassTreeByLevel?level=1,2,3", function (data) {
            relTree = $.fn.zTree.init($("#relationTree"), setting, data);
            relTree.expandAll(true);
            var node;
            for(var i = 0;i< lis.length;i++){
                node = relTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#"+lis[i]).attr("checked");
                relTree.checkNode(node, true, false, callbackFlag);
            }
        })
    });

    function saveRelation(){
        var nodes=relTree.getCheckedNodes(true);
        var id="";
        for(var i=0;i<nodes.length;i++){
            id +=nodes[i].id+",";
        }
        if(id ==''){
            swal({
                title: "请选择班级!",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/studentChangeLog/saveClassRelation", {
            studentId: $("#studentId").val(),
            relationids:id
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1 ) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#studentChangeGrid').DataTable().ajax.reload();
            }
        })
    }
</script>
<style>
    #style-4::-webkit-scrollbar-track
    {
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
        background-color: #474D52;
    }
    #style-4::-webkit-scrollbar
    {
        width: 5px;
        background-color: #474D52;
    }
    #style-4::-webkit-scrollbar-thumb
    {
        background-color: #ffffff;
        border: 1px solid #474D52;
    }
</style>