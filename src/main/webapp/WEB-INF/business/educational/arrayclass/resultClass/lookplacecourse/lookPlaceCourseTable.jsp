<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/29
  Time: 14:11
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
                        <header class="mui-bar mui-bar-nav">
                            <h5 class="mui-title">${arrayClassName} > 场地列表查看</h5>
                            <input id="arrayClassId" value="${arrayClassId}" hidden>
                        </header>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                教室名称：
                            </div>
                            <div class="col-md-2">
                                <input id="roomName" type="text">
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
        search();
        arrayClassRoom.on('click', 'tr a', function () {
            var data = arrayClassRoom.row($(this).parent()).data();
            var id = data.arrayClassId;
            var roomId = data.roomId;
            var roomType = data.roomType;
            if (this.id == "lookPlace") {
                $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/lookPlaceView"+
                    "?arrayClassId=" + id+
                    "&roomId="+roomId+"&roomType="+roomType+
                    "&arrayClassName=${arrayClassName}");
            }

        });
    })



    function back() {
        $("#right").load("<%=request.getContextPath()%>/place/look");
        $("#right").modal("show");
    }

    function searchclear() {
        $("#roomName").val("");
        search();
    }

    function search() {
        var roomName = $("#roomName").val();
        roomName='%'+roomName+'%';
        var arrayClassId = $("#r_arrayClassId").val();
        arrayClassRoom = $("#arrayClassRoomGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClassRoom/getArrayClassRoomList',
                "data": {
                    roomName:roomName,
                    arrayClassId:arrayClassId
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "30%", "data": "roomId", "title": "教室名称"},
                {"width": "30%", "data": "roomType", "title": "教室类型"},
                {"width": "30%", "data": "peopleNumber", "title": "容纳学生数量"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='lookPlace' class='icon-th' title='查看场地课表'></a>";
                    }
                }
            ],
            'order' : [1,'asc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>



