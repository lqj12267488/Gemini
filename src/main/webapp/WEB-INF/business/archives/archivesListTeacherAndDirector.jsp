<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2018/1/26
  Time: 14:39
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
                            <div class="col-md-1 tar" style="width: 90px">
                                全文检索：
                            </div>
                            <div class="col-md-2">
                                <input id="condition"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">
                                    查询
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
                        <button type="button" class="btn btn-info btn-clean" onclick="printDate()">打印</button>
                        <a id="expdata" class="btn btn-info btn-clean">导出</a>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="listGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var listTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "TYPE_ID",
                text: "TYPE_NAME",
                tableName: "DZDA_TYPE",
                where: "WHERE PARENT_TYPE_ID='0'",
                orderby: "ORDER BY TYPE_ID"
            }
            , function (data) {
                addOption(data, 'selOne');
            });
        $("#selTwo").append("<option value='' selected>请选择</option>");
        $("#selOne").change(function () {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: "TYPE_ID",
                    text: "TYPE_NAME",
                    tableName: "DZDA_TYPE",
                    where: "WHERE PARENT_TYPE_ID ='" + $("#selOne").val() + "'",
                    orderby: "ORDER BY TYPE_ID"
                }
                , function (data) {
                    addOption(data, 'selTwo');
                });
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DALX", function (data) {
            addOption(data, 'selType');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGSS", function (data) {
            addOption(data, 'selSchool');
        });
        $.get("<%=request.getContextPath()%>/archives/selectDept", function (data) {
            $("#selDept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#selDept").val(ui.item.label);
                    $("#selDept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/archives/getPerson", function (data) {
            $("#selPerson").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#selPerson").val(ui.item.label);
                    $("#selPerson").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/archives/getLeaderArchivesList?roleFlag=1',
            },
            "destroy": true,
            "columns": [
                {"data": "archivesId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "createDept", "title": "创建部门"},
                {"width": "10%", "data": "creator", "title": "创建人"},
                {"width": "10%", "data": "archivesCode", "title": "档案编码"},
                {"width": "10%", "data": "oneLevel", "title": "一级类别"},
                {"width": "10%", "data": "twoLevel", "title": "二级类别"},
                {"width": "10%", "data": "fileType", "title": "档案类型"},
                {"width": "10%", "data": "remark", "title": "档案说明"},
                {
                    "width": "7%", "title": "操作", "render": function () {
                        return "<a id='preview' class='icon-eye-open' title='查看附件'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
        expList($("#condition").val());
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var archivesId = data.archivesId;
            if (this.id == "preview") {
                $("#dialog").load("<%=request.getContextPath()%>/archives/preview?archivesId=" + archivesId + "&role=leader");
                $("#dialog").modal("show");
            }
        });
    })

    /*清空函数*/
    function searchclear() {
        $("#condition").val("");
        search();
    }

    /*查询函数*/
    function search() {
        listTable.ajax.url("<%=request.getContextPath()%>/archives/getLeaderArchivesList?condition=" + $("#condition").val()+"&roleFlag=1").load();
    }

    function expList() {
        var href = "<%=request.getContextPath()%>/archives/expList?condition=" + $("#condition").val()+"&roleFlag=1";
        $("#expdata").attr("href", href);
    }

    function printDate() {
        var print = "<%=request.getContextPath()%>/archives/printArchives?condition=" + $("#condition").val()+"&roleFlag=1";
        var bdhtml = window.document.body.innerHTML;
        $.get(print, function (html) {
            window.document.body.innerHTML = html;
            window.print();
            window.document.body.innerHTML = bdhtml;
        })
    }
</script>

