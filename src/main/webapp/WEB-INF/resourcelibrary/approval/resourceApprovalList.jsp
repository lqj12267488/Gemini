<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <div class="col-md-1 tar" >
                            资源名称：
                        </div>
                        <div class="col-md-3 " >
                            <input id="resourceNameSel" type="text" />
                        </div>
                        <div class="col-md-1 tar" >
                            申请类型：
                        </div>
                        <div class="col-md-3 " >
                            <select id="requestTypeSel" />
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-1 tar" >
                            申请人：
                        </div>
                        <div class="col-md-3 " >
                            <input id="requesterSel" />
                        </div>
                        <div class="col-md-1 tar" >
                            状态：
                        </div>
                        <div class="col-md-3 " >
                            <select id="requestFlagSel" />
                        </div>
                        <div class="col-md-2 tar">
                            <button  type="button" class="btn btn-default btn-clean"
                                     onclick="search()">查询</button>
                            <button  type="button" class="btn btn-default btn-clean"
                                     onclick="searchclear()">清空</button>
                        </div>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="approvalTable" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var approvalTable;
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYSQLX", function (data) {
            addOption(data, 'requestTypeSel' );
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYSQZT", function (data) {
            addOption(data, 'requestFlagSel' );
        });

        autoComplateOption("requesterSel", '<%=request.getContextPath()%>/common/getPersonDeptByPname');

        approvalTable = $("#approvalTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourceLibrary/approval/getResourceApprovalList',
            },
            "destroy": true,
            "columns": [
                {"data":"approvalId","visible":false},
                {"data":"resourceId","visible":false},
                {"data":"requestDept","visible":false},
                {"data":"requestFlag","visible":false},
                {"data":"approvalDept","visible":false},
                {"data":"approvalTime","visible":false},
                {"width": "25%","data":"resourceName","title":"资源名称"},
                {"width": "15%","data":"requesterShow","title":"申请人"},
                {"width": "10%","data":"requestDate","title":"申请时间"},
/*
                {"width": "10%","data":"requestReason","title":"申请原因"},
*/
                {"width": "10%","data":"requestTypeShow","title":"申请类型"},
                {"width": "15%","data":"approverShow","title":"审核人"},
                {"width": "10%","data":"requestFlagShow","title":"审核结果"},
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        var r = '<span class="icon-search" title="查看" onclick=edit("' + row.resourceId + '")></span>&ensp;&ensp;';
                        if(row.requestFlag=='1'){
                            r +=  '<span class="icon-edit" title="审核" onclick=approval("' + row.approvalId + '")></span>&ensp;&ensp;';
                        }
                        return r;
                    }
                }
            ],
            'order' : [[8,'desc'],[5,'desc']],
            "dom": 'rtlip',
            language: language
        });
    })

    function approval(approvalId) {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/approval/approvalPublic?approvalId="+approvalId);
        $("#dialog").modal("show")
    }

    function edit(id) {
        window.open("<%=request.getContextPath()%>/resourcePrivate/getPrivateResourceViewMain?resourceId="+id);
    }

    function del(id) {
        swal({
            title: "确定要删除这条记录？",
            text: "",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/resourceLibrary/approval/delResourceApproval", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#approvalTable').DataTable().ajax.reload();
            });
        })
    }

    function search() {
        var resourceName = $("#resourceNameSel").val();
        var requestType = $("#requestTypeSel").val();
        var requestFlag = $("#requestFlagSel").val();
        var requester = $("#requesterSel").attr("keycode");
        if(requester!=undefined &&requester!="" && requester!="undefined"){
            requester = requester.split(",")[1];
        }else{
            $("#requesterSel").val('');
            requester = "";
        }

        approvalTable.ajax.url("<%=request.getContextPath()%>/resourceLibrary/approval/getResourceApprovalList" +
            "?resourceName="+resourceName+"&requestType="+requestType+
            "&requestFlag="+requestFlag+"&requester="+requester).load();
    }

    function searchclear() {
        $("#resourceNameSel").val("");

        $("#requestTypeSel").val("");
        $("#requestTypeSel option:selected").val("");

        $("#requestFlagSel").val("");
        $("#requestFlagSel option:selected").val("");

        $("#requesterSel").val("");
        $("#requesterSel").attr("keycode","");
        search();
    }

</script>