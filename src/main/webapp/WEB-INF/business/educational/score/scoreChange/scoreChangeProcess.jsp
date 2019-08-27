<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 13:42
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
                                申请部门：
                            </div>
                            <div class="col-md-2">
                                <input id="f_dept" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="f_requester" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>

                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="f_date" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
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
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="scoreChangeGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var roleTable;

    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/scoreChange/autoCompleteDept", function (data) {
            $("#f_dept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_dept").val(ui.item.label);
                    $("#f_dept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/scoreChange/autoCompleteEmployee", function (data) {
            $("#f_requester").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_requester").val(ui.item.label);
                    $("#f_requester").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        search();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var scoreChangeProcessId = data.id;
            //修改
            if (this.id == "eidtScoreChangeProcess") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_JW_SCORE_CHANGE_WF",
                    businessId: scoreChangeProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: scoreChangeProcessId,
                            tableName: "T_JW_SCORE_CHANGE_WF",
                            url: "<%=request.getContextPath()%>/scoreChange/auditScoreChangeEdit?id=" + scoreChangeProcessId,
                            backUrl: "<%=request.getContextPath()%>/scoreChange/process"
                        });
                    }
                })
            }
            //办理
            if (this.id == "handleAudit") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_JW_SCORE_CHANGE_WF",
                    businessId: scoreChangeProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: scoreChangeProcessId,
                            tableName: "T_JW_SCORE_CHANGE_WF",
                            url: "/scoreChange/auditScoreChangeById?id=" + scoreChangeProcessId,
                            backUrl: "/scoreChange/process"
                        });
                    }
                })
            }

        });
    });

    function searchclear() {
        $("#f_dept").val("");
        $("#f_requester").val("");
        $("#f_date").val("");
        search();
    }

    function search() {
        var dept = $("#f_dept").val();
        if (dept != "")
            dept = '%' + dept + '%';
        var jbr = $("#f_requester").val();
        if (jbr != "")
            jbr = '%' + jbr + '%';
        var date = $("#f_date").val();
        if (date != "") {
            date = '%' + date + '%';
        }
        roleTable = $("#scoreChangeGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/scoreChange/getProcessList',
                "data": {
                    requester: jbr,
                    requestDate: date,
                    requestDept: dept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "6%","data": "requestDept", "title": "申请部门"},
                {"width": "6%","data": "requester", "title": "申请人"},
                {"width": "6%","data": "requestDate", "title": "申请日期"},
                {"width": "6%","data": "departmentsId", "title": "系部"},
                {"width": "6%","data": "majorCode", "title": "专业"},
                {"width": "6%","data": "classId", "title": "班级"},
                {"width": "6%","data": "studentId", "title": "学生姓名"},
                {"width": "6%","data": "studentNumber", "title": "学号"},
                {"width": "6%","data": "courseId", "title": "科目"},
                {"width": "6%","data": "term", "title": "学期"},
                {"width": "6%","data": "originalScore", "title": "原成绩"},
                {"width": "6%","data": "score", "title": "更改后成绩"},
                {"width": "6%","data": "reason", "title": "变更原因"},
                {"width": "6%","data": "time", "title": "变更时间"},
                {"width": "4%","data": "examinationStatus", "title": "考试状态"},
                {"width": "6%","title": "操作", "render":  function () {return  "<a id='handleAudit' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;"+
                        "<a id='eidtScoreChangeProcess' class='icon-edit' title='修改'></a>";}},

            ],
            'order' : [1,'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });

    }

</script>


