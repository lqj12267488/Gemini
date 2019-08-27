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
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="block block-drop-shadow">
                <div class="content controls" id="style-4" style="overflow-y:auto;height: 85%">
                    <ul id="majorClassTree" class="ztree"></ul>
                </div>
            </div>
        </div>
        <div id="studentList" class="col-md-9"></div>
    </div>
    <div class="modal" id="alert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <%--<div class="modal-content">
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
            </div>--%>
        </div>
    </div>
</div>

<script>
    var majorClassTree;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        view: {
            fontCss: {color: "white"},
            showLine: false
        },
        data: {
            simpleData: {
                enable: true,
                rootPId:'0'
            }
        },
        callback: {
            onClick: zTreeOnClick
        }
    };

    function zTreeOnClick(event, treeId, treeNode) {
        $.post("<%=request.getContextPath()%>/classManagement/checkClassById?id="+treeNode.id, {
        },function (msg) {
            if(msg.status==1){
                $("#studentList").show();
                $("#studentList").load("<%=request.getContextPath()%>/scoreClass/studentGrid", {id: treeNode.id})
            }
        })
    }

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/scoreClass/getMajorClassTree?level=", function (data) {
            majorClassTree = $.fn.zTree.init($("#majorClassTree"), setting, data);
            majorClassTree.expandAll(true);
        })
    });

    function refreTree() {
        $.get("<%=request.getContextPath()%>/getMenuTree", function (data) {
            majorClassTree = $.fn.zTree.init($("#majorClassTree"), setting, data);
            majorClassTree.expandAll(true);
        });

    }

    function studentObjhide(){
        $("#studentList").hide();
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