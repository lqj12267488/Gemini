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
            <h4 class="modal-title">修改监考教师
                <input id="examId" name="examId" hidden value="${examId}">
                <input id="roomId" name="roomId" hidden value="${roomId}">
            </h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <ul id="emptree" class="ztree"></ul>
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
    var emptree;
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
        $.get("<%=request.getContextPath()%>/exam/room/getEmpTreeForHandWork?examId=${examId}&roomId=${roomId}", function (data) {
            emptree = $.fn.zTree.init($("#emptree"), setting, data.tree);
            emptree.expandAll(false);
            var node = emptree.getNodeByParam();
            var major_node = classtree.getNodeByParam();
            var dept_node = classtree.getNodeByParam();
            emptree.expandNode(node, true, false, false);
            var selected = data.selected;
            for (var i = 0; i < selected.length; i++) {
                var node = emptree.getNodeByParam("id", selected[i].id);
                var  major_node = classtree.getNodeByParam("id", selected[i].majorCode);
                var  dept_node = classtree.getNodeByParam("id", selected[i].departmentsId);
                emptree.checkNode(node, true, false);
                classtree.checkNode(major_node, true, false);
                classtree.checkNode(dept_node, true, false);
            }

        })
    });


    function save() {
        var nodes = emptree.getCheckedNodes(true);
        var id = '';
        for (var i = 0; i < nodes.length; i++) {
            id+="'" + nodes[i].id +"',";
        }
        id = id.substring(0,id.length-1);
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/exam/room/saveExamRoomTeacherForHandWork", {
            ids: id,
            examId: '${examId}',
            roomId: '${roomId}'

        }, function (data) {
            hideSaveLoading();
            if(data.status==1){
                swal({title: data.msg, type: "error"});
            }else{
                swal({title: data.msg, type: "success"});
                $("#dialog").modal('hide');
                roomTable.ajax.reload();
            }
      })
    }
</script>
