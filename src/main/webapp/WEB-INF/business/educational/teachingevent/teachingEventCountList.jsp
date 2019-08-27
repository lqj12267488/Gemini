<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
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
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="departmentsId" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                活动名称：
                            </div>
                            <div class="col-md-2">
                                <input id="eventName" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
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
                <div class="content">
                    <table id="eventTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var eventTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "departmentsId");
            });
        eventTable = $("#eventTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/educational/teachingEvent/getTeachingEventCountList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "10%", "data": "departmentsIdShow", "title": "系部"},
                {"width": "10%", "data": "eventName", "title": "活动名称"},
                {"width": "10%", "data": "hostIdShow", "title": "主持人"},
                {"width": "10%", "data": "startTime", "title": "开始时间"},
                {"width": "10%", "data": "endTime", "title": "结束时间"},
                {"width": "10%", "data": "eventContent", "title": "活动内容"},
                {"width": "10%", "data": "eventEffect", "title": "活动效果"},

            ],
            "dom": 'rtlip',
            "language": language
        });
    })
    function searchclear() {
        $("#departmentsId").val("");
        $("#eventName").val("");
        eventTable.ajax.url("<%=request.getContextPath()%>/educational/teachingEvent/getTeachingEventCountList").load();
    }

    function search() {
        var departmentsId =$("#departmentsId option:selected").val();
        var eventName = $("#eventName").val();
        if (departmentsId == null || departmentsId == undefined)
            departmentsId="";
        eventTable.ajax.url("<%=request.getContextPath()%>/educational/teachingEvent/getTeachingEventCountList?departmentsId="+departmentsId+"&eventName="+eventName).load();

    }


</script>