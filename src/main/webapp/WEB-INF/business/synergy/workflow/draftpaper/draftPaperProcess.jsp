<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/25
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
                                拟稿部门：
                            </div>
                            <div class="col-md-2">
                                <%-- <select id="dept" class="js-example-basic-single"></select>--%>
                                <input id="dept" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                核稿人：
                            </div>
                            <div class="col-md-2">
                                <input id="ngr"/>

                            </div>
                            <div class="col-md-1 tar">
                                拟稿日期：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
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
                        <table id="draftTable" cellpadding="0" cellspacing="0" width="100%"
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
    var draftTable;

    $(document).ready(function () {
         //部门下拉
        /*$.get("/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE PARENT_DEPT_ID <> 0 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "dept");
            });*/
        //部门提示
        $.get("<%=request.getContextPath()%>/stamp/autoCompleteDept", function (data) {
            $("#dept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#dept").val(ui.item.label);
                    $("#dept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#ngr").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#ngr").val(ui.item.label);
                    $("#ngr").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        draftTable = $("#draftTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/draftPaper/getProcessList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "title", "title": "标题"},
                {"width": "8%", "data": "paperNumber", "title": "文号"},
                {"width": "10%", "data": "draftDept", "title": "拟稿人部门"},
                {"width": "10%", "data": "drafter", "title": "拟稿人"},
                {"width": "10%", "data": "draftDate", "title": "拟稿日期"},
                {"width": "10%", "data": "checkerShow", "title": "核稿人"},
                {
                    "width": "10%", "title": "操作", "render": function () {
                    return "<a id='handleAudit' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='editPaperProcess' class='icon-edit' title='修改'></a>";
                }
                },

            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
        draftTable.on('click', 'tr a', function () {
            var data = draftTable.row($(this).parent()).data();
            var draftId = data.id;
            //修改
            if (this.id == "editPaperProcess") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_BG_DRAFTPAPER_WF",
                    businessId: draftId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: draftId,
                            tableName: "T_BG_DRAFTPAPER_WF",
                            url: "<%=request.getContextPath()%>/draftPaper/auditDraftPaperEdit?id=" + draftId,
                            backUrl: "<%=request.getContextPath()%>/draftPaper/process"
                        });
                    }
                })
            }
            //办理
            if (this.id == "handleAudit") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_DRAFTPAPER_WF",
                    businessId: draftId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: draftId,
                            tableName: "T_BG_DRAFTPAPER_WF",
                            url: "/draftPaper/auditDraftPaperById?id=" + draftId,
                            backUrl: "/draftPaper/process"
                        });
                    }
                })
            }

        });
    });

    function searchclear() {
        $("#dept").val("");
        $("#hgr").val("");
        $("#date").val("");
        draftTable.ajax.url("<%=request.getContextPath()%>/draftPaper/getProcessList").load();
    }

    function search() {
        //var dept =$("#dept option:selected").val();
        var dept =$("#dept").val();
        var hgr = $("#hgr").val();
        var date = $("#date").val();
        if (date == "" && hgr == "" && dept == "") {

        } else {
            $("#draftTable").DataTable().ajax.url("<%=request.getContextPath()%>/draftPaper/getProcessList?draftDate=" + date + "&drafter=" + hgr + "&draftDept=" + dept).load();
        }

    }

</script>
