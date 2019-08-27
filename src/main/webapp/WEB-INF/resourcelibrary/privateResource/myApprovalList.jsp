<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="block block-drop-shadow content">
	<div class="form-row1 tk1" style="padding:0">
		<div style="overflow:hidden; display:block; float:left">
			<div style="overflow:hidden; display:block; width:280px; height:44px; padding:7px 10px; float:left">
				<div style="width: 100px; padding:0px 10px; display:block; float:left">资源名称：</div>
				<input id="resourceNameSel"  style="width: 160px;" type="text"/>
			</div>
			<div style="overflow:hidden; display:block; width:280px; padding:7px 10px; float:left">
				<div style="width: 100px; padding:0px 10px;  display:block; float:left">申请类型：</div>
				<select id="requestTypeSel" style="width: 160px;"/>
			</div>
			<div style="overflow:hidden; display:block; width:280px; padding:7px 10px; float:left">
				<div style="width: 100px; padding:0px 10px;  display:block; float:left">状态：</div>
				<select id="requestFlagSel" style="width: 120px"/>
			</div>
		</div>
		<div style="overflow:hidden; width:140px; display:block;  padding:7px 10px; float:left">
			<button  type="button" class="btn btn-success" onclick="search()">查询</button>
			<button  type="button" class="btn btn-success" onclick="searchclear()">清空</button>
		</div>
	</div>
	<div class="form-row block" style="overflow-y:auto;">
		<table id="tableApproval" cellpadding="0" cellspacing="0"
			   width="100%" style="max-height: 50%;min-height: 10%; margin:0px auto; margin-bottom:20px"
			   class="table table-bordered table-striped sortable_default">
		</table>
	</div>
	<input hidden id="personId" value="${personId}">
</div>
<script>
    var tableApproval;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYSQLX", function (data) {
            addOption(data, 'requestTypeSel' );
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYSQZT", function (data) {
            addOption(data, 'requestFlagSel' );
        });

        tableApproval = $("#tableApproval").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourceLibrary/approval/getResourceApprovalList?creator='+$("#personId").val(),
            },
            "destroy": true,
            "columns": [
                {"data":"requestDate","visible":false},
                {"data":"approvalId","visible":false},
                {"data":"resourceId","visible":false},
                {"data":"requestDept","visible":false},
                {"data":"requestFlag","visible":false},
                {"data":"approvalDept","visible":false},
                {"data":"approvalTime","visible":false},
                {"data":"requester","visible":false},
                {"data":"approver","visible":false},
                {"data":"requestType","visible":false},
                {"width": "15%","data":"resourceName","title":"资源名称"},
                {
                    "width": "10%",
                    "title": "申请时间",
                    "render": function (data, type, row) {
                        if(null == row.requestDate){
                            return "";
                        }else{
                            var a = new Date(row.requestDate);
                            var r = a.getFullYear() +"-"+(a.getMonth()+1)+"-"+(a.getDate()+1);
                            return r;
                        }
                    }
                },
                {"width": "10%","data":"requestReason","title":"申请原因"},
                {"width": "10%","data":"requestTypeShow","title":"申请类型"},
                {"width": "10%","data":"requestFlagShow","title":"状态"},
                {"width": "10%","data":"approverShow","title":"审核人"},
                {"width": "10%","data":"requestFlagShow","title":"审核结果"},
                {"width": "15%","data":"approvalOpinion","title":"审核意见"},
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        var r = '<span class="icon-eye-open" title="查看" onclick=view("' + row.resourceId + '")></span>&ensp;&ensp;';
/*
                        if(row.requestFlag=='1'){
                            r = r+ '<span class="icon-signin" title="审核" onclick=approval("' + row.approvalId + '")></span>&ensp;&ensp;';
                        }
*/
                        if(row.requestFlag=='1'){
                            r = r+ '<span class="icon-trash" title="取消共享申请" onclick=del("' + row.approvalId + '","'+row.resourceId+'")></span>&ensp;&ensp;';
                        }
                        return r;
                    }
                }
            ],
            'order' : [0,'desc'],
            "dom": 'rtlip',
            language: language
        });
    })

    function view(resourceId) {
        window.open("<%=request.getContextPath()%>/resourcePrivate/getPrivateResourceViewMain?resourceId="+resourceId);
    }

    function approval(approvalId) {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/approval/approvalResource?approvalId="+approvalId);
        $("#dialog").css('display','block');
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/approval/toResourceApprovalAdd")
        $("#dialog").css('display','block');
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/approval/toResourceApprovalEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function del(approvalId,resourceId) {
        swal({
            title: "确定要删除此资源共享申请?",
            text: "",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/resourceLibrary/approval/delResourceApproval", {
                approvalId: approvalId,
                resourceId: resourceId
            }, function (msg) {
                swal({title: msg.msg,type: msg.result});
                $('#tableApproval').DataTable().ajax.reload();
            });
        })
    }

    function search() {
        var resourceName = $("#resourceNameSel").val();
        var requestType = $("#requestTypeSel").val();
        var requestFlag = $("#requestFlagSel").val();
        tableApproval.ajax.url("<%=request.getContextPath()%>/resourceLibrary/approval/getResourceApprovalList" +
            "?resourceName="+resourceName+"&requestType="+requestType
            +"&requestFlag="+requestFlag+"&creator="+$("#personId").val()).load();
    }

    function searchclear() {
        $("#resourceNameSel").val("");
        $("#requestTypeSel").val("");
        $("#requestFlagSel").val("");
        search();
    }


</script>