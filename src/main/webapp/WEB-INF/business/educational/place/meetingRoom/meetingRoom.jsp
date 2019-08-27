<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/14
  Time: 14:46
  To change this template use File | Settings | File Templates.
--%>
<%--会议场地维护首页--%>
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
                            <div class="col-md-1 tar" style="width:100px">
                                会议室名称：
                            </div>
                            <div class="col-md-2">
                                <input id="meetingRoomName" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                所在楼层：
                            </div>
                            <div class="col-md-2">
                                <select id="floor" />
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
                        <button type="button" class="btn btn-default btn-clean" onclick="addMeetingRoom()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="meetingRoom" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="t_jw_meetingroom">
<input id="businessId" hidden>
<script>
    var roleTable;
    $(document).ready(function () {
        $(document).ready(function () {
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=LC", function (data) {
                addOption(data, 'floor', '${meetingRoom.floor}');
            });
        })
        search();

        roleTable = $("#meetingRoom").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/meetingRoom/getMeetingRoomList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "15%", "data": "meetingRoomName", "title": "会议室名称"},
                {"width": "15%", "data": "buildingId", "title": "所在楼宇"},
                {"width": "14%", "data": "peopleNumber", "title": "容纳人数"},
                {"width": "14%", "data": "roomNumber", "title": "房间号"},
                {"width": "14%", "data": "floor", "title": "所在楼层"},
                {"width": "14%", "data": "remark", "title": "备注"},
                {
                    "width": "14%",
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
        roleTable.on('click', 'tr a', function () {
            //var data = roleTable.row(this.parent).data();
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var meetingRoomName = data.meetingRoomName;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/meetingRoom/getMeetingRoomById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "会议室："+meetingRoomName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/meetingRoom/deleteMeetingRoomById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#meetingRoom').DataTable().ajax.reload();
                        }
                    })
                });
               /* if (confirm("请确认是否要删除本条数据?")) {
                    $.get("/meetingRoom/deleteMeetingRoomById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#meetingRoom').DataTable().ajax.reload();
                        }
                    })
                }*/
            }

        });
    });
    function addMeetingRoom() {
        $("#dialog").load("<%=request.getContextPath()%>/meetingRoom/addMeetingRoom");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#meetingRoomName").val("");
        $("#floor").val("");
        search();
    }

    function search() {
        var meetingroomname = $("#meetingRoomName").val();
        if (meetingroomname != "")
            meetingroomname = '%'+meetingroomname+ '%';
        roleTable = $("#meetingRoom").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/meetingRoom/search',
                "data": {
                    meetingRoomName: meetingroomname,
                    floor: $("#floor option:selected").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false },
                {"width": "15%", "data": "meetingRoomName", "title": "会议室名称"},
                {"width": "15%", "data": "buildingId", "title": "所在楼宇"},
                {"width": "14%", "data": "peopleNumber", "title": "容纳人数"},
                {"width": "14%", "data": "roomNumber", "title": "房间号"},
                {"width": "14%", "data": "floor", "title": "所在楼层"},
                {"width": "14%", "data": "remark", "title": "备注"},
                {
                    "width": "14%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
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


