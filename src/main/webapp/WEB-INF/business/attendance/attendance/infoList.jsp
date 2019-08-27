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
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">

                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="f_nameSel" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                年：
                            </div>
                            <div class="col-md-2">
                                <input id="f_yearSel" type="number"/>
                            </div>
                            <div class="col-md-1 tar">
                                月：
                            </div>
                            <div class="col-md-2">
                                <input id="f_monthSel" type="number"/>
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
                        <button id="expdata" onclick="exportInfo()" class="btn btn-info btn-clean">导出</button>
                        <button class="btn btn-info btn-clean" onclick="showDialog()">导入</button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="infoGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var infoTable;

    $(document).ready(function () {
        search();
        infoTable.on('click', 'tr a', function () {
            var data = infoTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editInfo") {
                $("#dialog").load("<%=request.getContextPath()%>/attendance/editInfo?id=" + id);
                $("#dialog").modal("show");
            }
        });
    })

    function searchclear() {
        $("#f_nameSel").val("");
        $("#f_yearSel").val("");
        $("#f_monthSel").val("");
        search();
    }

    function search() {
        var nameSel = $("#f_nameSel").val();
        var yearSel = $("#f_yearSel").val();
        var monthSel = $("#f_monthSel").val();
        if (yearSel != "" && yearSel.length != 4) {
            swal({
                title: "您输入的年份不正确",
                type: "info"
            });
            return;
        }
        if (monthSel != "" && monthSel != "" && monthSel > 12) {
            swal({
                title: "您输入的月不正确",
                type: "info"
            });
            return;
        }
        infoTable = $("#infoGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/attendance/getInfoList',
                "data": {
                    nameSel: nameSel,
                    yearSel: yearSel,
                    monthSel: monthSel
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "coding", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "8%", "data": "name", "title": "姓名"},
                {"width": "4%", "data": "year", "title": "年"},
                {"width": "4%", "data": "month", "title": "月"},
                {"width": "10%", "data": "basicFrequency", "title": "应签到<br/>次数"},
                {"width": "10%", "data": "noSignInFrequency", "title": "未签到<br/>次数"},
                {"width": "10%", "data": "latestOutOfSignIn", "title": "最新<br/>未签到"},
                {"width": "10%", "data": "leaveNoSign", "title": "调休<br/>未签到"},
                {"width": "8%", "data": "publicHolidays", "title": "公假"},
                {"width": "8%", "data": "compassionateLeave", "title": "事假"},
                {"width": "8%", "data": "sickLeave", "title": "病假"},
                {"width": "15%", "data": "wrongSignOnBusiness", "title": "因公(因故)误签"},
                {
                    "width": "5%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editInfo' class='icon-edit' title='详细'></a>&nbsp;&nbsp;&nbsp;&nbsp;"
                            /*+"<a id='delInfo' class='icon-trash' title='删除'></a>"*/;
                    }
                }
            ],
            'order': [2, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }

    function showDialog() {
        $("#dialog").load("<%=request.getContextPath()%>/attendance/toImportInfo");
        $("#dialog").modal("show");
    }

    function exportInfo() {
        var nameSel = $("#nameSel").val();
        var yearSel = $("#yearSel").val();
        var monthSel = $("#monthSel").val();
        window.location.href = "<%=request.getContextPath()%>/attendance/exportInfo?nameSel=" + nameSel + "&yearSel=" + yearSel + "&monthSel=" + monthSel;
    }

</script>