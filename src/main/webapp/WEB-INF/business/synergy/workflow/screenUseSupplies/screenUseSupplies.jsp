<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/3
  Time: 14:13
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
                                大屏幕名称:
                            </div>
                            <div class="col-md-2">
                                <input id="dicname" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchScreenUseSupplies()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclearScreenUseSupplies()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addScreenUseSupplies()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="screenUseSuppliesGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var screenUseSuppliesTable;

    $(document).ready(function () {
        screenUseSuppliesTable = $("#screenUseSuppliesGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/userDic/getUserDicList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"50%","data": "dicname", "title": "大屏幕名称"},
                {
                    "width":"50%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uScreenUseSupplies' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delScreenUseSupplies' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [0,'desc'],
            "dom": 'rtlip',
            language: language
        });
        screenUseSuppliesTable.on('click', 'tr a', function () {
            var data = screenUseSuppliesTable.row($(this).parent()).data();
            var id = data.id;
            var dicname = data.dicname;
            var editUrl="/business/synergy/workflow/screenUseSupplies/editScreenUseSupplies";
            if (this.id == "uScreenUseSupplies") {
                $("#dialog").load("<%=request.getContextPath()%>/userDic/editUserDic?id=" + id +"&editUrl=" +editUrl);
                $("#dialog").modal("show");
            }
            if (this.id == "delScreenUseSupplies") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "大屏幕名称："+dicname+"\n\n删除后将无法恢复，请谨慎操作！",
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
                            $('#screenUseSuppliesGrid').DataTable().ajax.reload();
                        }
                    })

                });
            }
        });
    })

    function addScreenUseSupplies() {
        var urlName="/business/synergy/workflow/screenUseSupplies/addScreenUseSupplies";
        $("#dialog").load("<%=request.getContextPath()%>/userDic/addUserDicSupplies?urlName=" + urlName);
        $("#dialog").modal("show");
    }

    function searchclearScreenUseSupplies() {
        $("#dicname").val("");
        searchScreenUseSupplies();
    }

    function searchScreenUseSupplies() {
        var dicname = $("#dicname").val();
        if (dicname != "") {
            dicname = '%' + dicname + '%';
        }
        screenUseSuppliesTable = $("#screenUseSuppliesGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/userDic/searchUserDic',
                "data":{
                    dicname:dicname,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"50%","data": "dicname", "title": "大屏幕名称"},
                {
                    "width":"50%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uScreenUseSupplies' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delScreenUseSupplies' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [0,'desc'],
            "dom": 'rtlip',
            language: language
        });

    }
</script>
