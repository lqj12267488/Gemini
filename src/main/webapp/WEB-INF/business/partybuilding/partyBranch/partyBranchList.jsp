<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/26
  Time: 15:29
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
                                党支部名称：
                            </div>
                            <div class="col-md-2">
                                <input id="branchName" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="searchBranch()">
                                    查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addPartyBranch()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="partyBranchGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var branchTable;

    $(document).ready(function () {
        searchBranch();

        branchTable.on('click', 'tr a', function () {
            var data = branchTable.row($(this).parent()).data();
            var id = data.id;
            var branchName = data.branchName;
            if (this.id == "editPartyBranch") {
                $("#dialog").load("<%=request.getContextPath()%>/editPartyBranch?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delPartyBranch") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "党支部名称："+branchName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/deletePartyBranchById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: msg.result
                        });
                        branchTable.ajax.reload();

                    });
                })
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();
            }
        });
    });

    function addPartyBranch() {
        $("#dialog").load("<%=request.getContextPath()%>/addPartyBranch");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#branchName").val("");
        searchBranch();
    }
    function searchBranch() {
        var branchName = $("#branchName").val();
        if (branchName != "")
            branchName = '%'+branchName+'%';
        branchTable = $("#partyBranchGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/getPartyBranchList',
                "data": {
                    branchName: branchName
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "18%", "data": "branchName", "title": "党支部名称"},
                {"width": "20%", "data": "remark", "title": "备注"},
                {
                    "width": "10%", "title": "操作", "render": function () {
                    return "<a id='editPartyBranch' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='delPartyBranch' class='icon-trash' title='删除'></a>";
                }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });

    }
</script>
