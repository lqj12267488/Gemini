<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/12
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/14
  Time: 14:47
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
            <h4 class="modal-title">选择班级</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <ul id="scoreClassTree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">取消</button>
        </div>
    </div>
    <input id="subjectId" hidden value="${scoreClass.subjectId}">
    <input id="scoreExamId" hidden value="${scoreClass.scoreExamId}">
    <input id="planId" hidden value="${scoreClass.planId}">
</div>
<script>
    var scoreClassTree;
    var setting = {
        view: {
            dblClickExpand: dblClickExpand,
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
    function dblClickExpand(treeId, treeNode) {
        return treeNode.level > 0;
    }
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/scoreCourse/getClassTreeByScoreClass?subjectId=" + "${scoreClass.subjectId}"+"&courseType="+"${scoreClass.courseType}", function (data) {
            scoreClassTree = $.fn.zTree.init($("#scoreClassTree"), setting, data.tree);
            scoreClassTree.expandAll(false);
            var node = scoreClassTree.getNodeByParam();
            var major_node = scoreClassTree.getNodeByParam();
            var dept_node = scoreClassTree.getNodeByParam();
            scoreClassTree.expandNode(node, true, false, false);
            var selected = data.selected;
            for (var i = 0; i < selected.length; i++) {
                node = scoreClassTree.getNodeByParam("id", selected[i].classId);
                major_node = scoreClassTree.getNodeByParam("id", selected[i].majorCode);
                dept_node = scoreClassTree.getNodeByParam("id", selected[i].departmentsId);
                scoreClassTree.checkNode(node, true, false);
                scoreClassTree.checkNode(major_node, true, false);
                scoreClassTree.checkNode(dept_node, true, false);
            }
        })
    });
    function save() {
        var classIds = scoreClassTree.getCheckedNodes(true);
        var classes = "";
        for (var i = 0; i < classIds.length; i++) {
            classes += classIds[i].id + ",";
        }
        classes = classes.substring(0,classes.length-1);
        if(classes.length==0){
            swal({title: "请选择考试班级！",type: "info"});
            return;
        }
        swal({
            title: "保存后需重新设置录入教师，如无更改请点击取消?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "保存",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/scoreCourse/saveClass", {
                subjectId: $("#subjectId").val(),
                scoreExamId:$("#scoreExamId").val(),
                planId:$("#planId").val(),
                classes: classes
            }, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"});
                    $("#dialog").modal('hide');
                    $('#listGrid').DataTable().ajax.reload();
                }
            });
        })
    }
</script>
