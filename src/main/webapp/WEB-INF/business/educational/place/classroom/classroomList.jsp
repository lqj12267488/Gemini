<%--教室场地维护管理页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/15
  Time: 10:01
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
                                教室名称
                            </div>
                            <div class="col-md-2">
                                <input id="classroomName" type="text"
                                       class="validate[required,maxSize[20]] form-control" />
                            </div>
                            <div class="col-md-1 tar">
                                所在楼层：
                            </div>
                            <div class="col-md-2">
                                <select id="floor" />
                            </div>

                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClassroom()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclearClassroom()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addClassroom()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="classroomGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var classroomTable;
    $(document).ready(function () {
        $.get("/common/getSysDict?name=LC", function (data) {
            addOption(data, 'floor');
        });
        $.get("<%=request.getContextPath()%>/classroom/selectClassroomName", function (data) {
            $("#classroomName").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#classroomName").val(ui.item.label);
                    $("#classroomName").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        searchClassroom();
        classroomTable.on('click', 'tr a', function () {
            var data = classroomTable.row($(this).parent()).data();
            var id = data.id;
            var classroomName = data.classroomName;
            if (this.id == "uClassroom") {
                $("#dialog").load("<%=request.getContextPath()%>/classroom/updateClassroom?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delClassroom") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "教室名称："+classroomName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/classroom/deleteClassroom?id=" + id, function (msg) {
                        swal({
                            title: msg.msg,
                            type: msg.result
                        });
                        $('#classroomGrid').DataTable().ajax.reload();
                    })
                });
                /* if (confirm("确定删除此教室场地信息?")) {
                    $.get("/classroom/deleteClassroom?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#classroomGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
        });
    })

    function addClassroom() {
        $("#dialog").load("<%=request.getContextPath()%>/classroom/insertClassroom");
        $("#dialog").modal("show");
    }

    function searchclearClassroom() {
        $("#classroomName").val("");
        $("#floor").val("");
        searchClassroom();
    }

    function searchClassroom() {
        var classroomName = $("#classroomName").val();
        if (classroomName != "") {
            classroomName = '%' + classroomName + '%';
        }
        classroomTable = $("#classroomGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/classroom/getClassroomList',
                "data":{
                    classroomName: classroomName,
                    floor: $("#floor option:selected").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"15%","data": "classroomName", "title": "教室名称"},
                {"width":"15%","data": "buildingId", "title": "所在楼宇"},
                {"width":"15%","data": "floor", "title": "所在楼层"},
                {"width":"15%","data": "roomType", "title": "教室类型"},
                {"width":"15%","data": "peopleNumber", "title": "容纳人数"},
                {"width":"15%","data": "remark", "title": "备注"},
                {"width":"10%","title": "操作","render": function () {return "<a id='uClassroom' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='delClassroom' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>