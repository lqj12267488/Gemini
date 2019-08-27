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
<style>
    @media screen and (max-width: 1050px) {
        .tar {
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
                                <input id="e_requestDate" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addFunds()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="funds1" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_FUNDS1_WF">
<input id="workflowCode" hidden value="T_BG_FUNDS1_WF01">
<input id="businessId" hidden>
<script>
    var roleTable;

    $(document).ready(function () {
        search();

        /*$("div.toolbar").html('<button  type="button" class="btn btn-info btn-clean" onclick="addEmp()">新增</button>');*/
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "uFunds") {
                $("#dialog").load("<%=request.getContextPath()%>/funds1/getFundsById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "relationFunds") {
                $("#right").load("<%=request.getContextPath()%>/funds1/relationRequest?id=" + id+"&type=0");
            }
            if (this.id == "delFunds") {
                //if (confirm("请确认是否要删除本条申请?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "申请原因："+data.reason+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/funds1/deleteFundsById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            $('#funds1').DataTable().ajax.reload();
                        }
                    })
                })
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();
            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_FUNDS_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function addFunds() {
        $("#dialog").load("<%=request.getContextPath()%>/funds1/addFunds");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#e_requestDate").val("");
        search()
    }

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
                tableName: "T_BG_FUNDS1_WF",
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
                    //alert(msg.msg);
                    $("#dialog").modal("hide");
                    $('#funds1').DataTable().ajax.reload();
                }
            })
    }

    function search() {
        var requestDate = $("#e_requestDate").val();
        if (requestDate != "")
            requestDate = '%' + requestDate + '%';

        roleTable = $('#funds1').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/funds1/search',
                "data": {
                    requestDate: requestDate,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "13%", "data": "reason", "title": "申请原因"},
                {"width": "13%", "data": "amount", "title": "小写金额"},
                {"width": "13%", "data": "amountUpper", "title": "大写金额"},
                {"width": "12%", "data": "requestDept", "title": "申请部门"},
                {"width": "12%", "data": "manager", "title": "申请人"},
                {"width": "13%", "data": "requestDate", "title": "申请日期"},
                {"width": "12%", "data": "remark", "title": "备注"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uFunds' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delFunds' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='relationFunds' class='icon-exchange' title='关联事物'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='submit' class='icon-upload-alt' title='提交'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

    }
</script>

