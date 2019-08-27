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
                                人员姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="pname" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchMan()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addRepairMan()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="repairManGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var repairManGrid;

    $(document).ready(function () {
        repairManGrid = $("#repairManGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/repair/repairAdminList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"34%","data": "personName", "title": "负责人姓名"},
                {"width":"33%","data": "deptName", "title": "负责人部门"},
                {
                    "width":"33%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editRepairMan' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRepairMan' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";;
                    }
                }
            ],
            'order' : [3,'desc'],
            "dom": 'rtlip',
            language: language
        });
        repairManGrid.on('click', 'tr a', function () {
            var data = repairManGrid.row($(this).parent()).data();
            var id = data.id;
            var personName = data.personName;
            if (this.id == "editRepairMan") {
                $("#dialog").load("<%=request.getContextPath()%>/repair/editRepairAdmin?id=" +id);
                $("#dialog").modal("show");
            }
            if (this.id == "delRepairMan") {
                $.get("<%=request.getContextPath()%>/repair/getRepairByRepairMan?id=" + id, function (boolean) {
                    /*if (boolean == true) {
                        swal({
                            title: "维修员有维修任务未完成，不能删除维修员！",
                            type: "info"
                        });
                        return;
                    }else{*/
                        swal({
                            title: "您确定要删除本条信息?",
                            text: "维修员："+personName+"\n\n删除后将无法恢复，请谨慎操作！",
                            type: "warning",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "删除",
                            closeOnConfirm: false
                        }, function () {
                            $.post("<%=request.getContextPath()%>/repair/delRepairAdmin", {
                                id: id
                            }, function (msg) {
                                swal({
                                    title: msg.msg,
                                    type: "success"
                                });
                                $('#repairManGrid').DataTable().ajax.reload();

                            });

                        });
                    //}

                })

               /* if (confirm("请确认是否要删除本条记录?")) {
                    $.get("/repair/delRepairMan?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#repairManGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
        });
    })

    function addRepairMan() {
        $("#dialog").load("<%=request.getContextPath()%>/repair/addRepairAdmin");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#pname").val("");
        searchMan();
    }

    function searchMan() {
        var personName = $("#pname").val();
        repairManGrid.ajax.url("<%=request.getContextPath()%>/repair/repairAdminList?personName=" + personName).load();
    }
</script>
