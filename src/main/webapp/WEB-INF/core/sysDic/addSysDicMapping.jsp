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
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${Dicname} > 添加字典项</span>
                </div>
                <div class="block block-drop-shadow">

                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                字典名称：
                            </div>
                            <div class="col-md-2">
                                <input id="dname" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="selectName()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="clearName()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <button  type="button" class="btn btn-default btn-clean" onclick="addSysDic()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="sysDicMappingGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="idd" hidden value="${sysDic.id}">
<script>
    var sysDicMappingGrid;

    $(document).ready(function () {
        sysDicMappingGrid = $("#sysDicMappingGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/sysDic/sysDicMappingInfo',
                "data":{"id":$("#idd").val()}
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width":"25%","data": "dicname", "title": "字典名称"},
                {"width":"25%","data": "diccode", "title": "字典编码"},
                {"width":"25%","data": "dicorder", "title": "字典排序"},
                {
                    "width":"25%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editSysDic' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='deleteSysDicMapping' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        sysDicMappingGrid.on('click', 'tr a', function () {
            var data = sysDicMappingGrid.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editSysDic") {
                $("#dialog").load("<%=request.getContextPath()%>/sysDic/editDices?id=" + id +"&parentid=" + $("#idd").val());
                $("#dialog").modal("show");
            }
            if (this.id == "deleteSysDicMapping") {
                //if (confirm("请确认是否要删除本条记录?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "类型名称："+data.dicname+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/sysDic/deleteSysDic?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            $('#sysDicMappingGrid').DataTable().ajax.reload();
                        }
                    })
                });
            }
        });
    })

    function addSysDic() {
        $("#dialog").load("<%=request.getContextPath()%>/sysDic/editSysDicMapping?parentid="+$("#idd").val());
        $("#dialog").modal("show");
    }

    function clearName() {
        $("#dname").val("");
        selectName();
    }

    function selectName() {
        sysDicMappingGrid.ajax.url("<%=request.getContextPath()%>/sysDic/sysDicMappingInfo?dicname=" +$("#dname").val()).load();
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/sysDic/sysDicMapping");
    }
</script>
