<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/6 0006
  Time: 上午 10:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean" id="add"
                                onclick="addAssociation()">新增关联
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="relationFundsGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="workflowCode" hidden value=${workflowCode}>
<script>
    var roleTable;
    $(document).ready(function () {
        roleTable = $("#relationFundsGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/association/associationInfo?id=${id}'+'&workflowCode=${workflowCode}',
            },
            "destroy": true,
            "columns": [
                {"data": "businessId", "visible": false},
                {"data": "url", "visible": false},
                {"data": "tableName", "visible": false},
                {"width": "60%", "data": "text", "title": "已关联的已办结业务"},
                {"width": "30%", "data": "createTime", "title": "申请日期"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-eye-open" title="查看详情" onclick=seeValues("' + row.businessId + '","' + row.url + '","' + row.tableName + '")></span>&nbsp;&nbsp;&nbsp;&nbsp;'
                          +  '<span class="icon-trash"  id="delete" title="删除" onclick=del("' + row.businessId + '")></span>';
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    })

    function addAssociation() {
        $("#dialog").load("<%=request.getContextPath()%>/association/addAssociation?id=${id}"+"&workflowCode="+$("#workflowCode").val());
        $("#dialog").modal("show");
    }

    function del(businessId,text) {
        //if (confirm("请确认是否要删除本条业务关联?")) {
        var data = roleTable.row($(this).parent()).data();
        swal({
            title: "您确定要删除本条信息?",
            //text: "业务名称："+text+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/funds/deleteRelationFundsById?id=${id}&businessId=" + businessId, function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    //alert(msg.msg);
                    $('#relationFundsGrid').DataTable().ajax.reload();
                }
            })
        })
    }

    function seeValues(businessId, url, tableName) {
        $("#dialogFile").load("<%=request.getContextPath()%>/association/getWotkflowLog?businessId=" + businessId + "&url=" + url + "&tableName=" + tableName+"&type=0");
        $("#dialogFile").modal("show");
    }

    function back() {
            $("#right").load("<%=request.getContextPath()%>${backUrl}");
    }
</script>

