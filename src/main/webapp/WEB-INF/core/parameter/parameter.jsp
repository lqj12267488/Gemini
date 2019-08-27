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
                                参数名称：
                            </div>
                            <div class="col-md-2">
                                <input id="pname" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-1 tar">
                                参数代码：
                            </div>
                            <div class="col-md-2">
                                <input id="pcode" type="text"
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
                        <button  type="button" class="btn btn-default btn-clean" onclick="addParameter()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="parameterGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script>
    var parameterGrid;

    $(document).ready(function () {
        parameterGrid = $("#parameterGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/parameter/parameterInfo',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width":"20%","data": "parametername", "title": "参数名称"},
                {"width":"20%","data": "parametercode", "title": "参数代码"},
                {"width":"20%","data": "parametertype", "title": "参数类型"},
                {"width":"20%","data": "parametervalue", "title": "参数值"},
                {
                    "width":"20%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editParameter' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                        //        "<a id='addSysDicMapping' class='icon-plus' title='添加字典项'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='deleteParameter' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        parameterGrid.on('click', 'tr a', function () {
            var data = parameterGrid.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editParameter") {
                $("#dialog").load("<%=request.getContextPath()%>/parameter/editParameter?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "deleteParameter") {
                //if (confirm("请确认是否要删除本条记录?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "参数名称："+data.parametername+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/parameter/deleteParameter?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            $('#parameterGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
        });
    })

    function addParameter() {
        $("#dialog").load("<%=request.getContextPath()%>/parameter/addParameter");
        $("#dialog").modal("show");
    }

    function clearName() {
        $("#pname").val("");
        $("#pcode").val("");
        selectName();
    }

    function selectName() {
        parameterGrid.ajax.url("<%=request.getContextPath()%>/parameter/parameterInfo?parametername=" +$("#pname").val() +"&parametercode=" +$("#pcode").val()).load();
    }
</script>
