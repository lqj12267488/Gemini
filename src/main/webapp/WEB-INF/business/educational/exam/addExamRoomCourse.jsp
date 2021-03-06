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
            <h4 class="modal-title">选择考试课程
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
                <ul id="coursetree" class="ztree"></ul>
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
    var coursetree;
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
        $.get("<%=request.getContextPath()%>/exam/course/getExamCourseClassTree?examId=${examId}&examRoomId=${examRoomId}&roomId=${roomId}", function (data) {
            coursetree = $.fn.zTree.init($("#coursetree"), setting, data.tree);
            coursetree.expandAll(true);
            var node = coursetree.getNodeByParam();
            var dept_node = coursetree.getNodeByParam();
            var major_node =coursetree.getNodeByParam();
            coursetree.expandNode(node, true, false, false);
            var selected = data.selected;
            for (var i = 0; i < selected.length; i++) {
                node = coursetree.getNodeByParam("id", selected[i].courseId);
                major_node = coursetree.getNodeByParam("id", selected[i].majorCode);
                dept_node = coursetree.getNodeByParam("id", selected[i].departmentsId);
                coursetree.checkNode(node, true, false);
                coursetree.checkNode(major_node, true, false);
                coursetree.checkNode(dept_node, true, false);
            }

        })
    });


    function save() {
        var nodes = coursetree.getCheckedNodes(true);
        var id = '';
        for (var i = 0; i < nodes.length; i++) {
            id+="'" + nodes[i].id +"',";
        }
        id = id.substring(0,id.length-1);
        if(id.length==0){
            swal({
                title: "请选择考试的科目！",
                type: "info"
            });
            return;
        }else{
            showSaveLoading();
            $.post("<%=request.getContextPath()%>/exam/course/saveExamRoomCourse", {
                ids: id,
                examRoomId: '${examRoomId}',
                roomId:'${roomId}',
                examId: '${examId}',
                courseId: '${courseId}'
            }, function (msg) {
                hideSaveLoading();
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"});
                    $("#dialog").modal('hide');
                    $('#courseTableGrid').DataTable().ajax.reload();
                }else{
                    swal({title: msg.msg, type: "error"});
                    $("#dialog").modal('hide');
                    $('#courseTableGrid').DataTable().ajax.reload();

                }
            })
        }

    }
</script>
