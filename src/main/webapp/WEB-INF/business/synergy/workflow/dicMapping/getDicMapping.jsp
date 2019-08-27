<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="content">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${userDic.dicname} > 字典详情</span>
                </div>
                <div class="content">
                    <table id="userDicTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="userDicType" hidden value="${userDic.dictype}">
<input id="userName" hidden value="${userDic.dicname}">
<script>
    var userDicTable;
    $(document).ready(function () {
        userDicTable = $("#userDicTable").DataTable({
            "ajax": {
                "url": "<%=request.getContextPath()%>/dicMapping/infoDicMapping?dictype=" + $("#userDicType").val(),
            },
            "destroy": true,
            "columns": [
                {"data": "id","visible": false},
                {"data": "name","visible":false},
                {"data": "dictype", "visible": false},
                {"data": "dicname", "title": "字典名称"},
                {
                    "title": "操作",
                    "render": function () {
                        return "<span id='editNode' title='修改' class='icon-edit'></span>&ensp;" +
                            "<span id='deleteNode' title='删除' class='icon-trash'></span>&ensp;";
                    }
                }
            ],

            "dom": '<"toolbar">rtlip',
            "language": language
        });
        $("div.toolbar").html('<button class="btn btn-info btn-clean" onclick="returnDicmapping()">返回</button>' +
            '<button class="btn btn-info btn-clean" onclick="addUserDic()">新增</button>');
        userDicTable.on('click', 'tr span', function () {
            var data = userDicTable.row($(this).parent()).data();
            var nodeId = data.id;
            if (this.id == "editNode") {
                $("#dialog").load("<%=request.getContextPath()%>/dicMapping/editDic?id=" + nodeId);
                $("#dialog").modal("show");
            }
            if (this.id == "deleteNode") {
                //if (confirm("确定要删除" + data.dicname + "?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "类型名称："+data.dicname+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/userDic/deleteUserDicById", {
                        id: nodeId,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            userDicTable.ajax.reload();
                        }
                    })
                })
            }
          /*  if (this.id == "definition") {
                $("#right").load("/definition", {
                    nodeId: nodeId,
                    workflowId: $("#nodeWorkflowId").val()
                });
                $("#dialog").modal("show");
            }*/
        });
    })
    function addUserDic() {
        $("#dialog").load("<%=request.getContextPath()%>/userDic/addUserDic?dictype=" + $("#userDicType").val() +"&name=" + $("#userName").val());
        $("#dialog").modal("show");
    }
    function returnDicmapping() {
        $("#right").load("<%=request.getContextPath()%>/userDic/dicMapping");
    }
</script>