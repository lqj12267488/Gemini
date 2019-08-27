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
                <input id="rel_roleid" hidden value="${roleid}">
                <ul id="parentStudentTree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" class="btn btn-success btn-clean" onclick="saveRelation()">保存</button>
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var parentStudentTree;
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
        $.get("<%=request.getContextPath()%>/core/parent/getParentTree?roleId="+$("#rel_roleid").val(), function (data) {
            parentStudentTree = $.fn.zTree.init($("#parentStudentTree"), setting, data);
            parentStudentTree.expandAll(true);
        });
    });

    function saveRelation(){
        var roleid = $("#rel_roleid").val();
        var nodes=parentStudentTree.getCheckedNodes(true);
        //var checkList =new Array;
        var checkList="";
        for(var i=0;i<nodes.length;i++){
            var leafId =  nodes[i].id ;
            if(leafId.indexOf(",") > 0 ){
                checkList += nodes[i].id+"@";
            }
        }
        if(checkList.length>0)
            checkList = checkList.substring(0,checkList.length-1);
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/role/savePerStuRelation", {
            roleid:roleid,
            checkList:checkList
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1 ) {
                swal({title: msg.msg, type: "success"});
                //alert(msg.msg);
                $("#dialog").modal('hide');
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