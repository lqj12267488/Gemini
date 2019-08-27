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
            <h4 class="modal-title">选择班级</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <ul id="classtree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>

<script>
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
        $.get("<%=request.getContextPath()%>/arrayClassCourse/getClassTree?id=${id}&departmentsId=${departmentsId}&courseType=${courseType}&courseID=${courseID}", function (data) {
            classtree = $.fn.zTree.init($("#classtree"), setting, data.tree);
            classtree.expandAll(false);
            var node = classtree.getNodeByParam("id", "001");
            classtree.expandNode(node, true, false, false);
            var selected = data.selected;
            for (var i = 0; i < selected.length; i++) {
                var node = classtree.getNodeByParam("id", selected[i].classId)
                classtree.checkNode(node, true, false);
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
        $.post("<%=request.getContextPath()%>/arrayClassCourse/saveClass", {
            id: id,
            courseID: '${courseID}',
            arrayClassId: '${arrayClassId}',
            courseType: '${courseType}',
            departmentsId: '${departmentsId}',
            majorCode: '${majorCode}',
            classId: '${classId}',
            trainingLevel: '${trainingLevel}',
            arrayClassCourseId: '${arrayClassCourseId}'

        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                groupTable.ajax.reload();
            }
        })
    }
</script>