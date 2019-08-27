<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/25
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
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
                                学生姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="selStudentId" type="text"/>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                惩处级别：
                            </div>
                            <div class="col-md-2">
                                <select id="selPunishLevel" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                惩处日期:
                            </div>
                            <div class="col-md-2">
                                <input id="selPunishTime" type="date"/>
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
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="studentPunishGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var studentPunishTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSCCJB", function (data) {
            addOption(data, 'selPunishLevel', '${studentPunish.punishLevel}');
        });
        search();
        studentPunishTable.on('click', 'tr a', function () {
            var data = studentPunishTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "detail") {
                $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/studentPunish/edit?id="+id+"&flag=1");
                $("#dialog").modal("show");
            }
        });
    })

    function searchclear() {
        $("#selStudentId").val("");
        $("#selPunishLevel").val("");
        $("#selPunishTime").val("");
        search();
    }
    function search() {
        var studentId = $("#selStudentId").val();
        studentId="%"+studentId+"%";
        var punishLevel = $("#selPunishLevel").val();
        var punishTime = $("#selPunishTime").val();
        studentPunishTable = $("#studentPunishGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/studentRewardPunish/studentPunish/getSelectList',
                "data":{
                    studentId: studentId,
                    punishLevel: punishLevel,
                    punishTime: punishTime
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"7%","data": "studentId", "title": "姓名"},
                {"width":"8%","data": "sexShow", "title": "性别"},
                {"width":"7%","data": "departmentsId", "title": "系部"},
                {"width":"7%","data": "majorShow", "title": "专业"},
                {"width":"8%","data": "classId", "title": "班级"},
                {"width":"8%","data": "punishName", "title": "惩处名称"},
                {"width":"8%","data": "punishLevel", "title": "惩处级别"},
                {"width":"8%","data": "punishTime", "title": "惩处时间"},
                {"width":"8%","data": "punishingCycle", "title": "惩处周期"},
                {"width":"8%","data": "restTime", "title": "惩处到期时间"},
                {"width":"10%","data": "restDay", "title": "剩余期限(天)"},
                {"width":"8%","data": "punishStatus", "title": "惩处状态"},
                {"width":"7%","title": "操作","render": function () {return "<a id='detail' class='icon-search' title='查看'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>