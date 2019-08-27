<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/17
  Time: 16:50
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
                                设备编号
                            </div>
                            <div class="col-md-2">
                                <input id="dcode" type="text"
                                       class="validate[required,maxSize[20]] form-control" />
                            </div>
                            <div class="col-md-1 tar">
                                设备名称
                            </div>
                            <div class="col-md-2">
                                <input id="dname" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchDeviceUseSupplies()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclearDeviceUseSupplies()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addDeviceUseSupplies()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="deviceUseSuppliesGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var deviceUseSuppliesTable;

    $(document).ready(function () {
        searchDeviceUseSupplies();

        deviceUseSuppliesTable.on('click', 'tr a', function () {
            var data = deviceUseSuppliesTable.row($(this).parent()).data();
            var id = data.id;
            var dicname = data.dicname;
            if (this.id == "uDeviceUseSupplies") {
                $("#dialog").load("<%=request.getContextPath()%>/deviceUse/getDeviceUseSuppliesById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delDeviceUseSupplies") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "设备名称："+dicname+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("/deviceUse/deleteDeviceUseSuppliesById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#deviceUseSuppliesGrid').DataTable().ajax.reload();
                        }
                    })
                });
              /*  if (confirm("请确认是否要删除本条记录?")) {
                    $.get("/deviceUse/deleteDeviceUseSuppliesById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#deviceUseSuppliesGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
        });
    })

    function addDeviceUseSupplies() {
        $("#dialog").load("<%=request.getContextPath()%>/deviceUse/addDeviceUseSupplies");
        $("#dialog").modal("show");
    }

    function searchclearDeviceUseSupplies() {
        $("#dcode").val("");
        $("#dname").val("");
        searchDeviceUseSupplies();
    }

    function searchDeviceUseSupplies() {
        var v_code = $("#dcode").val();
        var v_name = $("#dname").val();
        if (v_name != "")
            v_name = '%' + v_name + '%';
        deviceUseSuppliesTable = $("#deviceUseSuppliesGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/deviceUseSupplies/searchDeviceUseSupplies',
                "data": {
                    diccode: v_code,
                    dicname:v_name

                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "diccode", "title": "设备编号"},
                {"data": "dicname", "title": "设备名称"},
                {"data": "dicorder", "title": "排序"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uDeviceUseSupplies' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delDeviceUseSupplies' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";;
                    }
                }

            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
    }
</script>

