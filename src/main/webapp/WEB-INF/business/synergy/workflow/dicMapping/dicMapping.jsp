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
                                字典名称：
                            </div>
                            <div class="col-md-2">
                                <input id="dmname" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchDicMapping()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclearDicMapping()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addDicMapping()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="dicMappingGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script>
    var dicMappingTable;

    $(document).ready(function () {
        searchDicMapping();

        dicMappingTable.on('click', 'tr a', function () {
            var data = dicMappingTable.row($(this).parent()).data();
            var id = data.id;
            var dictype=data.dictype;
            var dicname=data.dicname;
            if (this.id == "editDicMapping") {
                $("#dialog").load("<%=request.getContextPath()%>/dicMapping/editDicMapping?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id=="getDicMapping"){
                $("#right").load("<%=request.getContextPath()%>/dicMapping/detailDicMapping?dictype=" + dictype +"&dicname=" + dicname);
            }
            if (this.id == "deleteDicMapping") {
                //if (confirm("请确认是否要删除本条记录?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "字典名称："+dicname+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/dicMapping/deleteDicMapping?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            $('#dicMappingGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
        });
    })

    function addDicMapping() {
        $("#dialog").load("<%=request.getContextPath()%>/dicMapping/addDicMapping");
        $("#dialog").modal("show");
    }

    function searchclearDicMapping() {
        $("#dmname").val("");
        searchDicMapping();
    }

    function searchDicMapping() {
        var v_name = $("#dmname").val();
        if (v_name != "") {
            v_name = '%' + v_name + '%';
        }
        dicMappingTable = $("#dicMappingGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/dicMapping/searchDicMapping',
                "data": {
                    dicname:v_name
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width":"25%","data": "dicname", "title": "字典名称"},
                {"width":"25%","data": "dictype", "title": "字典类型"},
                {"width":"25%","data": "dicurl", "title": "URL"},
                {
                    "width":"25%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editDicMapping' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='getDicMapping' class='icon-search' title='详情'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='deleteDicMapping' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [0,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>
