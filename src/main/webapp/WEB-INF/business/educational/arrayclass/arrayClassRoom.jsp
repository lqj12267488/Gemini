<%--排课场地维护页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/8/11
  Time: 9:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                教室类型：
                            </div>
                            <div class="col-md-2">
                                <select id="roomType" class="validate[required,maxSize[100]] form-control" onchange="changeEditRoom()"></select>
                            </div>
                            <div class="col-md-1 tar">
                                教室名称：
                            </div>
                            <div class="col-md-2">
                                <select id="roomId" class="validate[required,maxSize[100]] form-control"></select>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="batch()">批量新增
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="arrayClassRoomGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="r_arrayClassId" value="${arrayClassId}" hidden >
</div>
<script>
    var arrayClassRoom;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSLX", function (data) {
            addOption(data, 'roomType');
        });
        if($("#roomType").val()=="" || $("#roomType").val()==undefined){
            $("#roomId").append("<option value='' selected>请选择</option>");
        }else{
            var roomType = $("#roomType").val();
            $.post("<%=request.getContextPath()%>/common/getTableDict", {
                id: " ID",
                text: " CLASS_ROOM_NAME ",
                tableName: " T_JW_CLASSROOM ",
                where: " WHERE 1 = 1 and ROOM_TYPE = '"+ roomType +"'"
            },function (data) {
                addOption(data, "roomId");
            });
        }
        search();
        arrayClassRoom.on('click', 'tr a', function () {
            var data = arrayClassRoom.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "edit") {
                $("#dialog").load("<%=request.getContextPath()%>/arrayClassRoom/editArrayClassRoom?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "del") {
                swal({
                    title: "您确定要删除本条信息?",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/arrayClassRoom/deleteArrayClassRoomById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#arrayClassRoomGrid').DataTable().ajax.reload();
                    });
                })

            }
        });
    })

    function add() {
        var arrayClassId=$("#r_arrayClassId").val();
        $("#dialog").load("<%=request.getContextPath()%>/arrayClassRoom/addArrayClassRoom?arrayClassId="+arrayClassId);
        $("#dialog").modal("show");
    }

    function batch() {
        var arrayClassId=$("#r_arrayClassId").val();
        $.get("<%=request.getContextPath()%>/arrayClassRoom/addArrayClassRoomBatch?arrayClassId=" + arrayClassId, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $('#arrayClassRoomGrid').DataTable().ajax.reload();
            }
        })
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClassRoom/request");
        $("#right").modal("show");
    }

    function searchclear() {
        $("#roomType").val("");
        $("#roomId").val("");
        search();
    }

    function search() {
        var roomType = $("#roomType").val();
        var roomId = $("#roomId").val();
        var arrayClassId = $("#r_arrayClassId").val();
        arrayClassRoom = $("#arrayClassRoomGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClassRoom/getArrayClassRoomList',
                "data": {
                    roomType: roomType,
                    roomId: roomId,
                    arrayClassId:arrayClassId
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "30%", "data": "roomId", "title": "教室名称"},
                {"width": "30%", "data": "roomType", "title": "教室类型"},
                {"width": "30%", "data": "studentNumber", "title": "容纳学生数量"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='edit' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='del' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
    function changeEditRoom() {
        var roomType = $("#roomType").val();
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " ID",
            text: " CLASS_ROOM_NAME ",
            tableName: " T_JW_CLASSROOM ",
            where: " WHERE 1 = 1 and ROOM_TYPE = '"+ roomType +"'"
        },function (data) {
            addOption(data, "roomId");
        });
    }
</script>
