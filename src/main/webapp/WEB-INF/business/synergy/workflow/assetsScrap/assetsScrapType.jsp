<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
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
                                校产类型：
                            </div>
                            <div class="col-md-2">
                                <input id="dicname" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchAssetsScrap()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="clearAssets()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addAssetsScrap()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="assetsScrapGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var officesuppliesTable;

    $(document).ready(function () {
        searchAssetsScrap();

        officesuppliesTable.on('click', 'tr a', function () {
            var data = officesuppliesTable.row($(this).parent()).data();
            var id = data.id;
            var dicname = data.dicname;
            var editUrl = "/business/synergy/workflow/assetsScrap/editAssetsType";
            if (this.id == "editAssetsType") {
                $("#dialog").load("<%=request.getContextPath()%>/userDic/editUserDic?id=" + id + "&editUrl=" + editUrl);
                $("#dialog").modal("show");
            }
            if (this.id == "delAssetsScrap") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "校产类型：" + dicname + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/userDic/deleteUserDicById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#assetsScrapGrid').DataTable().ajax.reload();

                        }
                    })

                });
                /*if (confirm("确定要删除" + data.dicname + "?")) {
                    $.get("/userDic/deleteUserDicById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#assetsScrapGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
        });
    })

    function addAssetsScrap() {
        var urlName = "/business/synergy/workflow/assetsScrap/editAssetsType";
        $("#dialog").load("<%=request.getContextPath()%>/userDic/addUserDicSupplies?urlName=" + urlName);
        $("#dialog").modal("show");
    }

    function clearAssets() {
        $("#dicname").val("");
        searchAssetsScrap();
    }

    function searchAssetsScrap() {
        var dicname = $("#dicname").val();
        if (dicname != "") {
            dicname = '%' + dicname + '%';
        }
        officesuppliesTable = $("#assetsScrapGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/userDic/searchUserDic',
                "data": {
                    dicname: dicname,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "50%", "data": "dicname", "title": "校产类型"},
                {"data": "dicorder", "visible": false},
                {
                    "width": "50%",
                    "title": "操作",
                    "render": function () {
                        return  "<a id='editAssetsType' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delAssetsScrap' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order': [3, 'desc'],
            "dom": 'rtlip',
            language: language
        });

    }
</script>
