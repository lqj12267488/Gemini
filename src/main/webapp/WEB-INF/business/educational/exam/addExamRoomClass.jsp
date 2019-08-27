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
            <h4 class="modal-title">选择考试班级
                <input id="examCourseId" name="examCourseId" hidden value="${examCourseId}">
                <input id="examId" name="examId" hidden value="${examId}">
                <input id="courseType" name="courseType" hidden value="${courseType}">
                <input id="departmentsId" name="departmentsId" hidden value="${departmentsId}">
                <input id="courseId" name="courseId" hidden value="${courseId}">
                <input id="examType" name="examType" hidden value="${examType}">
            </h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <ul id="classtree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-success btn-clean" id="saveBtn"	 onclick="save()">保存</button>
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var classtree;
    var setting = {
        view: {
            dblClickExpand: dblClickExpand,
            fontCss: {color: "white"},
            showLine: false
        },
        check: {
            enable: true,
            chkStyle: "checkbox",
            chkboxType: {"Y": "s", "Y": "ps"}
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
        $.get("<%=request.getContextPath()%>/exam/class/getRoomClassTreeForExam?examId=${examId}&examRoomId=${examRoomId}&roomId=${roomId}", function (data) {
            classtree = $.fn.zTree.init($("#classtree"), setting, data.tree);
            classtree.expandAll(false);
            var node = classtree.getNodeByParam();
            var major_node = classtree.getNodeByParam();
            var dept_node = classtree.getNodeByParam();
            classtree.expandNode(node, true, false, false);
            var selected = data.selected;
            for (var i = 0; i < selected.length; i++) {
                node = classtree.getNodeByParam("id", selected[i].classId);
                major_node = classtree.getNodeByParam("id", selected[i].majorCode);
                dept_node = classtree.getNodeByParam("id", selected[i].departmentsId);
                classtree.checkNode(node, true, false);
                classtree.checkNode(major_node, true, false);
                classtree.checkNode(dept_node, true, false);
            }

        })
    });


    function save() {
        var nodes = classtree.getCheckedNodes(true);
        var id = '';
        for (var i = 0; i < nodes.length; i++) {
            id+="'" + nodes[i].id +"',";
        }
        id = id.substring(0,id.length-1);
        if(id.length==0){
            swal({
                title: "请选择考试的班级！",
                type: "info"
            });
            return;
        }else{
            showSaveLoading();
            $.post("<%=request.getContextPath()%>/exam/class/saveExamRoomClass", {
                ids: id,
                examRoomId: '${examRoomId}',
                examId: '${examId}',
                roomId: '${roomId}',
            }, function (msg) {
                hideSaveLoading();
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"});
                    $("#dialog").modal('hide');
                    groupTable.ajax.reload();
                }else{
                    swal({title: msg.msg, type: "error"});
                    $("#dialog").modal('hide');
                    groupTable.ajax.reload();
                }
            })
        }

    }
</script>
