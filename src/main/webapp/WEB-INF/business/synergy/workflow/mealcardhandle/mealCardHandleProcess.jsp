<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/10
  Time: 16:24
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
                                申请教师：
                            </div>
                            <div class="col-md-2">
                                <input id="f_requester" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>

                            </div>
                            <div class="col-md-1 tar">
                                办卡时间：
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
                        <table id="mealCardHandleGrid" cellpadding="0" cellspacing="0" width="100%"
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

        $.get("<%=request.getContextPath()%>/mealCardHandle/autoCompleteDept", function (data) {
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

        $.get("<%=request.getContextPath()%>/mealCardHandle/autoCompleteEmployee", function (data) {
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
            var mealCardHandleProcessId = data.id;
            //修改
            if (this.id == "eidtMealCardHandleProcess") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_BG_MEALCARD_HANDLE_WF",
                    businessId: mealCardHandleProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "error"});
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: mealCardHandleProcessId,
                            tableName: "T_BG_MEALCARD_HANDLE_WF",
                            url: "<%=request.getContextPath()%>/mealCardHandle/auditMealCardHandleEdit?id=" + mealCardHandleProcessId,
                            backUrl: "<%=request.getContextPath()%>/mealCardHandle/process"
                        });
                    }
                })
            }
            //办理
            if (this.id == "handleAudit") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_MEALCARD_HANDLE_WF",
                    businessId: mealCardHandleProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "error"});
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: mealCardHandleProcessId,
                            tableName: "T_BG_MEALCARD_HANDLE_WF",
                            url: "/mealCardHandle/auditMealCardHandleById?id=" + mealCardHandleProcessId,
                            backUrl: "/mealCardHandle/process"
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

        roleTable = $("#mealCardHandleGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/mealCardHandle/getProcessList',
                "data": {
                    teacherId: jbr,
                    mealCardTime: date,
                    deptId: dept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "15%", "data": "deptId", "title": "申请部门"},
                {"width": "15%", "data": "teacherId", "title": "申请教师"},
                {"width": "20%", "data": "mealCardTime", "title": "申请办卡时间"},
                {"width": "20%", "data": "mealCardTypeShow", "title": "饭卡类型"},
                {"width": "20%", "data": "remark", "title": "备注"},
                {
                    "width": "10%", "title": "操作",
                    "render": function () {
                        return "<a id='handleAudit' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='eidtMealCardHandleProcess' class='icon-edit' title='修改'></a>";
                    }
                },
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

</script>


