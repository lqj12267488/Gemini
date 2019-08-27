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
                                耗材名称：
                            </div>
                            <div class="col-md-2">
                                <input id="dname" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchExpSupplies()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclearExpSupplies()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addExpSupplies()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="expSuppliesGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var expSuppliesTable;
    $(document).ready(function () {
        searchExpSupplies();

        expSuppliesTable.on('click', 'tr a', function () {
            var data = expSuppliesTable.row($(this).parent()).data();
            var id = data.id;
            var editUrl="business/synergy/workflow/expsupplies/editExpSupplies";
            if (this.id == "uExpSupplies") {
                $("#dialog").load("<%=request.getContextPath()%>/userDic/editUserDic?id=" + id +"&editUrl=" + editUrl);
                $("#dialog").modal("show");
            }
            if (this.id == "delExpSupplies") {
                //if (confirm("请确认是否要删除本条记录?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "耗材名称："+data.dicname+"\n\n删除后将无法恢复，请谨慎操作！",
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
                            //alert(msg.msg);
                            $('#expSuppliesGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
        });
    })

    function addExpSupplies() {
        var urlName="business/synergy/workflow/expsupplies/addExpSupplies";
        $("#dialog").load("<%=request.getContextPath()%>/userDic/addUserDicSupplies?urlName="+ urlName);
        $("#dialog").modal("show");
    }

    function searchclearExpSupplies() {
        $("#dname").val("");
        searchExpSupplies();
    }

    function searchExpSupplies() {
        var v_dname = $("#dname").val();
        if (v_dname != "")
            v_dname = '%' + v_dname + '%';
        expSuppliesTable = $("#expSuppliesGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/userDic/searchUserDic',
                "data": {
                    dicname:v_dname
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"50%","data": "dicname", "title": "耗材名称"},
                {"data": "dictype", "visible": false},
                {
                    "width":"50%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uExpSupplies' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delExpSupplies' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [0,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
    }
</script>
