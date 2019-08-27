<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/26
  Time: 15:29
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
                            <div class="col-md-1 tar">
                                异动类型:
                            </div>
                            <div class="col-md-2">
                                <select id="changeTypeSelect"/>
                            </div>
                            <div id = "status">
                            <div  class="col-md-1 tar">
                                异动后学籍状态:
                            </div>
                            <div class="col-md-2">
                                <select id="changeStatus"/>
                            </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                异动开始时间:
                            </div>
                            <div class="col-md-2">
                                <input type="date" id="changeStartTime"/>
                            </div>
                            <div class="col-md-1 tar">
                                异动结束时间:
                            </div>
                            <div class="col-md-2">
                                <input type="date" id="changeEndTime"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">统计
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchClear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <div  id="LogGrid">
                        <table id="studentLogGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                        </div>
                        <div id="LogGridGroup" style="display: none">
                        <table id="studentLogGridGroup" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script>
    var studentLogGrid;
    var studentLogGridGroup;
    $("#changeTypeSelect").change(function () {
        if($("#changeTypeSelect").val()==1){
            $("#status").hide();
        }else{
            $("#status").show();
        }
    });
    $(document).ready(function () {
        $("#status").hide()
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSYDLX", function (data) {
            addOption(data, "changeTypeSelect");
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSZT", function (data) {
            addOption(data, 'changeStatus');
        });
        studentLogGrid = $("#studentLogGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/studentChangeLog/searchGrid',
                "data": {
                }
            },
            "destroy": true,
            "columns":  [
                {"data": "studentId", "visible": false},
                {"width": "10%", "data": "changeTypeShow", "title": "异动类型"},
                {"width": "20%", "data": "studentShow", "title": "学生姓名"},
                {"width": "25%", "data": "oldContent", "title": "修改前信息"},
                {"width": "25%", "data": "newContent", "title": "修改后信息"},
                {"width": "15%", "data": "logTime", "title": "异动时间"},
            ],
            'order': [5, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    });

    function searchClear() {
        $("#LogGridGroup").css("display","none");
        $("#LogGrid").css("display","block");

        $("#changeTypeSelect").val("");
        $("#changeStatus").val("");
        $("#changeStartTime").val("");
        $("#changeEndTime").val("");
        $("#status").hide();
        studentLogGrid.ajax.url("<%=request.getContextPath()%>/studentChangeLog/searchGrid").load();
    }

    function search() {
        var changeType = $("#changeTypeSelect option:selected").val();
        var changeStatus = $("#changeStatus option:selected").val();
        var changeStartTime = $("#changeStartTime").val();
        var changeEndTime = $("#changeEndTime").val();
        if(changeStartTime== "" || changeStartTime == null){
            if(changeEndTime!="" && changeEndTime != null&& changeEndTime != undefined){
                swal({
                    title: "异动开始时间不能为空！",
                    type: "info"
                });
                return;
            }
        }
        if(changeEndTime== "" || changeEndTime == null){
            if(changeStartTime!="" && changeStartTime != null&&changeStartTime != undefined){
                swal({
                    title: "异动结束时间不能为空！",
                    type: "info"
                });
                return;
            }
        }
        if (changeStartTime > changeEndTime) {
            swal({
                title: "异动开始时间不能大于异动结束时间！",
                type: "info"
            });
            return;
        }
        $("#LogGrid").css("display","none");
        $("#LogGridGroup").css("display","block");
        studentLogGridGroup = $("#studentLogGridGroup").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/studentChangeLog/getStudentChangeStatisticsList',
                "data": {
                    changeType: changeType,
                    changeStatus: changeStatus,
                    changeStartTime:changeStartTime,
                    changeEndTime:changeEndTime
                }
            },
            "destroy": true,
            "columns": [
                {"width": "100%", "data": "studentCount", "title": "异动学生数量"},
            ],
            'order': [0, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>
