<%--寝室信息维护管理页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/15
  Time: 15:03
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
                                寝室名称
                            </div>
                            <div class="col-md-2">
                                <input id="dormName" type="text"
                                       class="validate[required,maxSize[20]] form-control" />
                            </div>
                            <div class="col-md-1 tar">
                                所在楼层：
                            </div>
                            <div class="col-md-2">
                                <select id="floor" />
                            </div>

                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchDorm()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclearDorm()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addDorm()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="dormGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var dormTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=LC", function (data) {
            addOption(data, 'floor');
        });
        $.get("<%=request.getContextPath()%>/dorm/selectDormName", function (data) {
            $("#dormName").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#dormName").val(ui.item.label);
                    $("#dormName").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        dormTable = $("#dormGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/dorm/getDormList'
                // ,
                // "data":{
                //     dormName: dormName,
                //     floor: $("#floor option:selected").val()
                // }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"15%","data": "dormName", "title": "寝室名称"},
                {"width":"15%","data": "dormTypeShow", "title": "寝室类型"},
                {"width":"15%","data": "buildingId", "title": "楼宇"},
                {"width":"15%","data": "floor", "title": "所在楼层"},
                {"width":"15%","data": "peopleNumber", "title": "容纳人数"},
                {"width":"15%","data": "remark", "title": "备注"},
                {"width":"10%","title": "操作","render": function () {return "<a id='uDorm' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='delDorm' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";;}}
            ],
            'order' : [1,'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
        dormTable.on('click', 'tr a', function () {
            var data = dormTable.row($(this).parent()).data();
            var id = data.id;
            var dormName = data.dormName;
            if (this.id == "uDorm") {
                $("#dialog").load("<%=request.getContextPath()%>/dorm/updateDorm?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delDorm") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "寝室名称："+dormName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/dorm/deleteDorm?id=" + id, function (msg) {
                        swal({
                            title: msg.msg,
                            type: msg.result
                        });
                        $('#dormGrid').DataTable().ajax.reload();
                    })
                });
               /* if (confirm("确定删除此寝室场地信息?")) {
                    $.get("/dorm/deleteDorm?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#dormGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
        });
    })

    function addDorm() {
        $("#dialog").load("<%=request.getContextPath()%>/dorm/insertDorm");
        $("#dialog").modal("show");
    }

    function searchclearDorm() {
        $("#dormName").val("");
        $("#floor").val("");
        var url = "<%=request.getContextPath()%>/dorm/getDormList";
        dormTable.ajax.url(url).load();
    }

    function searchDorm() {
        var url = "<%=request.getContextPath()%>/dorm/getDormList?floor="+$("#floor option:selected").val()+"&dormName="+$("#dormName").val();
        dormTable.ajax.url(url).load();
    }
</script>
