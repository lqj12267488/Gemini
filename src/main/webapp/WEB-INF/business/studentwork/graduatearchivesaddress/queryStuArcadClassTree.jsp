<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
</div>
<input hidden id="classIdHid">
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
                rootPId: '0'
            }
        },
        callback: {
            onClick: zTreeOnClick
        }
    };

    function zTreeOnClick(event, treeId, treeNode) {
        $("#classIdHid").val(treeNode.id);
        $("#studentList").show();
        if (treeNode.type == '1')
        {
            $("#studentList").load("<%=request.getContextPath()%>/stuArcad/queryStuArcadList", {deptId:treeNode.id})
        }
        if (treeNode.type == '2') {
            $("#studentList").load("<%=request.getContextPath()%>/stuArcad/queryStuArcadList", {majorCode:treeNode.id})
        }
        if (treeNode.type == '3') {
            $("#studentList").load("<%=request.getContextPath()%>/stuArcad/queryStuArcadList", {classId:treeNode.id})
        }
    }

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/student/getMajorClassTreeByLevel?level=1,2,3", function (data) {
            majorClassTree = $.fn.zTree.init($("#majorClassTree"), setting, data);
            majorClassTree.expandAll(true);
        })
    });

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