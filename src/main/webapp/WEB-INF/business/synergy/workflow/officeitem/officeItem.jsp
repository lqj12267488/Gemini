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
                                onclick="addOfficeItem()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="officeItem" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_OFFICEITEM_WF">
<input id="workflowCode" hidden value="T_BG_OFFICEITEM_WF01">
<input id="businessId" hidden>
<script>
    var roleTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TYJB", function (data) {
            addOption(data, "searchreroletype")
        })

        search();
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var itemNameShow = data.itemNameShow;
            if (this.id == "uOfficeItem") {
                $("#dialog").load("<%=request.getContextPath()%>/officeItem/getOfficeItemById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delOfficeItem") {
                    swal({
                        title: "您确定要删除本条信息?",
                        text: "物品名称："+itemNameShow+"\n\n删除后将无法恢复，请谨慎操作！",
                        type: "warning",
                        showCancelButton: true,
                        cancelButtonText: "取消",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "删除",
                        closeOnConfirm: false
                    }, function () {
                        $.get("<%=request.getContextPath()%>/officeItem/deleteOfficeItemById?id=" + id, function (msg) {
                            if (msg.status == 1) {
                                swal({
                                    title: msg.msg,
                                    type: "success"
                                });
                                $('#officeItem').DataTable().ajax.reload();
                            }
                        })
                    });


            }
            if (this.id == "submit") {
                $("#businessId").val(id)
                getAuditer()
            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_OFFICEITEM_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function addOfficeItem() {
        $("#dialog").load("<%=request.getContextPath()%>/officeItem/addOfficeItem");
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
                tableName: "T_BG_OFFICEITEM_WF",
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
                    $('#officeItem').DataTable().ajax.reload();
                }
            })
    }

    function search() {
        var e_requestDate = $("#e_requestDate").val();
        if (e_requestDate != "")
            e_requestDate = '%' + e_requestDate + '%';
        var e_requestDept=$("#e_requestDept").val();
        if(e_requestDept !="")
            e_requestDept =  e_requestDept ;
        var e_requester = $("#e_requester").val();
        if (e_requester != "")
            e_requester =  e_requester ;
        roleTable = $("#officeItem").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/officeItem/search',
                "data": {
                    requestDate: e_requestDate,
                    requestDept:e_requestDept,
                    requester:e_requester,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "15%", "data": "itemNameShow", "title": "物品名称"},
                {"width": "15%", "data": "itemNumber", "title": "数量"},
                {"width": "15%", "data": "requestDept", "title": "申请部门"},
                {"width": "15%", "data": "requester", "title": "申请人"},
                {"width": "15%", "data": "requestDate", "title": "申请日期"},
                {"width": "15%", "data": "remark", "title": "备注"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uOfficeItem' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delOfficeItem' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='submit' class='icon-upload-alt' title='提交'></a>";
                    }
                }
            ],

            "dom": 'rtlip',
            language: language
        });

    }
</script>

