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
<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                申请日期：
                            </div>
                            <div class="col-md-2">
                                <input id="rdate" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addReimbur()">新增
                        </button>
                        <br>
                    </div>
                    <table id="reimbursementGrid" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_REIMBURSEMENT_WF">
<input id="workflowCode" hidden value="T_BG_REIMBURSEMENT_WF01">
<input id="businessId" hidden>
<script>
    var reimbursementGrid;
    //主页面显示的条件
    $(document).ready(function () {
        reimbursementGrid = $("#reimbursementGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/reimbursement/info',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                { "width": "15%", "data":"rcause", "title": "报销事由"},
                { "width":"15%", "data": "content", "title": "报销内容"},
                { "width":"14%", "data": "money", "title": "报销金额"},
                { "width":"14%", "data": "requestDept", "title": "申请部门"},
                { "width": "14%", "data":"requester", "title": "申请人"},
                { "width": "14%", "data":"requestDate", "title": "申请日期"},
                {"width": "14","title": "操作", "render": function () {return "<a id='editReimbur' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='deleteReimbur' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='relationFunds' class='icon-exchange' title='关联事物'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='submitReimbur' class='icon-upload-alt' title='提交'></a>";}}
            ],
            'order' : [1,'desc'],
            paging: true,
            "dom": 'rtlip',
            "language": language
        });
        reimbursementGrid.on('click', 'tr a', function () {
            var data = reimbursementGrid.row($(this).parent()).data();
            var id = data.id;
            //修改
            if (this.id == "editReimbur") {
                $("#dialog").load("<%=request.getContextPath()%>/reimbursement/editReimbur?id=" + id);
                $("#dialog").modal("show");
            }
            //删除
            if (this.id == "deleteReimbur") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/reimbursement/deleteReimbursement?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#reimbursementGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
            //提交
            if (this.id == "submitReimbur") {
                $("#businessId").val(id);
                getAuditer();
            }
            /*关联业务*/
            if (this.id == "relationFunds") {
                $("#right").load("<%=request.getContextPath()%>/association/associtionList?id=" + id+"&type=0" +"&tableName="+$("#tableName").val()
                +"&workflowCode="+$("#workflowCode").val()+"&backUrl="+"/reimbursement/request");
            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_REIMBURSEMENT_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function addReimbur() {
        $("#dialog").load("<%=request.getContextPath()%>/reimbursement/addReimbur");
        $("#dialog").modal("show");
    }

        function searchclear() {
        $("#rdate").val("");
        search();
    }

    function search() {
       var requestDate = $("#rdate").val();
        reimbursementGrid.ajax.url("<%=request.getContextPath()%>/reimbursement/info?requestDate="+requestDate).load();
    }
    /*动态弹窗选择审批人*/
    function getAuditer() {
        $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer")
    }
    function audit() {
        var personId;
        var handleName;
        var select = $("#personId").html();
        if (select != undefined) {
            if (handleName == undefined) {
                handleName = $("#personId option:selected").text();
            }
            if (personId == undefined) {
                personId = $("#personId option:selected").val();
            }
        } else {
            if (handleName == undefined) {
                handleName = $("#name").val();
            }
            if (personId == undefined) {
                personId = $("#personIds").val();
            }
        }
        if (personId == '') {
            swal({title: '请选择人员！',type: "warning"});
            return;
        }
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_BG_REIMBURSEMENT_WF",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName,
            },
            function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    $("#dialog").modal("hide");
                    $('#reimbursementGrid').DataTable().ajax.reload();
                }
            }
        )
    }
</script>

