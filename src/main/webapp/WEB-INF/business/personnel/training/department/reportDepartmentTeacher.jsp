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
            <h4 class="modal-title">
                <input id="id" name="id"  hidden value="${id}">
                <input id="deptId" name="deptId"  hidden value="${deptId}">
            </h4>
            <div style="text-align: center">
                <strong> <font size="2" color="white">剩余名额：</font></strong>
                <strong> <font size="2" color="red">${overplus}</font></strong>
            </div>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <ul id="emptree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>

<script>
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
        var id = $("#id").val();
        $.get("<%=request.getContextPath()%>/training/department/getEmpTreeForReport?deptId=${deptId}&id="+id, function (data) {
            emptree = $.fn.zTree.init($("#emptree"), setting, data.tree);
            emptree.expandAll(false);
            var node = emptree.getNodeByParam();


        })
    });


    function save() {
        var nodes = emptree.getCheckedNodes(true);
        var id = '';
        for (var i = 0; i < nodes.length; i++) {
            id+="'" + nodes[i].id +"',";
        }
        id = id.substring(0,id.length-1);
        if(id.length==0){
            swal({
                title: "请选择参培教师",
                type: "info"
            });
            //alert("请选择参培教师");
            return;
        }else{
            $.post("<%=request.getContextPath()%>/training/department/checkSaveReportTeacher", {
                ids: id,
                deptId: '${deptId}',
                id: '${id}'

            }, function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "error"
                    });
                    //alert(msg.msg);

                }else{
                    $.post("<%=request.getContextPath()%>/training/department/saveReportTeacher", {
                        ids: id,
                        deptId: '${deptId}',
                        id: '${id}'

                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            $("#dialog").modal('hide');
                            table.ajax.reload();
                        }
                    })
                }
            })




        }

    }
</script>
