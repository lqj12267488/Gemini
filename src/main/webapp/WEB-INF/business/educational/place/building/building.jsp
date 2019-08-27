<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/14
  Time: 8:52
  To change this template use File | Settings | File Templates.
--%>
<%--楼宇场地维护首页--%>
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
                                楼宇名称：
                            </div>
                            <div class="col-md-2">
                                <input id="buildingName" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                楼宇类型：
                            </div>
                            <div class="col-md-2">
                                <select id="buildingType"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addBuilding()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="building" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="t_jw_building">
<input id="businessId" hidden>
<script>

    var roleTable;
    $(document).ready(function () {
        $(document).ready(function () {
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=LYLX", function (data) {
                addOption(data, 'buildingType', '${building.buildingType}');
            });
        })
    })

    $(document).ready(function () {
        search();

        roleTable.on('click', 'tr a', function () {
            //var data = roleTable.row(this.parent).data();
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var buildingName = data.buildingName;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/building/getBuildingById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delRole") {

                $.get("<%=request.getContextPath()%>/building/selectAll?id=" + id, function (aa) {

                    if(aa == false){
                        swal({
                            title: "您要删除的楼宇正在使用不能删除！",
                            type: "error"
                        });
                        return;
                    }else{
                        swal({
                            title: "您确定要删除本条信息?",
                            text: "楼宇名称："+buildingName+"\n\n删除后将无法恢复，请谨慎操作！",
                            type: "warning",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "删除",
                            closeOnConfirm: false
                        }, function () {
                            $.get("<%=request.getContextPath()%>/building/deleteBuildingById?id=" + id, function (msg) {
                                if (msg.status == 1) {
                                    swal({
                                        title: msg.msg,
                                        type: "success"
                                    });
                                    $('#building').DataTable().ajax.reload();
                                }
                            })

                        });
                       /* if (confirm("请确认是否要删除本条数据?")) {
                            $.get("/building/deleteBuildingById?id=" + id, function (msg) {
                                if (msg.status == 1) {
                                    alert(msg.msg);
                                    $('#building').DataTable().ajax.reload();
                                }
                            })
                        }*/
                    }
                })

            }

        });
    });
    function addBuilding() {
        $("#dialog").load("<%=request.getContextPath()%>/building/addBuilding");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#buildingName").val("");
        $("#buildingType ").val("");
        $("#buildingType option:selected").val("");
        search();
    }

    function search() {
        var buildingname = $("#buildingName").val();
        if (buildingname != "")
            buildingname =  '%'+buildingname+ '%';
        roleTable = $("#building").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/building/search',
                "data": {
                    buildingName: buildingname,
                    buildingType: $("#buildingType option:selected").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "13%", "data": "buildingName", "title": "楼宇名称"},
                {"width": "13%", "data": "buildingType", "title": "楼宇类型"},
                {"width": "13%", "data": "area", "title": "楼宇面积（㎡）"},
                {"width": "12%", "data": "floorNumber", "title": "楼层数"},
                {"width": "13%", "data": "roomNumber", "title": "房间数"},
                {"width": "12%", "data": "address","title": "地址"},
                {"width": "12%", "data": "remark", "title": "备注"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
        /* $("div.toolbar").html('<button  type="button" class="btn btn-info btn-clean" onclick="addEmp()">新增</button>');*/

    }
</script>
<%--
<style>
    .sorting{
        width: 10% !important;
    }
</style>--%>

