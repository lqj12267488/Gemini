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
                                教材名称
                            </div>
                            <div class="col-md-2">
                                <input id="t_textbookName" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchTextBookStatistics()">
                                    查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="textBookGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var table;
    $(document).ready(function () {
        searchTextBookStatistics();
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.id;
            var textbookId = data.textbookId;
            if (this.id == "editTextBookStatistics") {
                $("#dialog").load("<%=request.getContextPath()%>/textbook/editTextBookStatistics?id=" + id);
                $("#dialog").modal("show");
            }
        });
    });

    function searchClear() {
        $("#t_textbookName").val("");
        searchTextBookStatistics();
    }

    function searchTextBookStatistics() {
        var textbookName = $("#t_textbookName").val();
        if (textbookName != "")
            textbookName = '%' + textbookName + '%';
        table = $("#textBookGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/textbook/getTextBookStatisticsList',
                "data": {
                    textbookName: textbookName,
                    personType:"1"
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "textbookId", "visible": false},
                {"width": "10%", "data": "textbookNumber", "title": "教材编号"},
                {"width": "10%", "data": "subscribeCode", "title": "征订代号"},
                {"width": "10%", "data": "textbookName", "title": "教材名称"},
                {"width": "10%", "data": "publishingHouse", "title": "出版社"},
                {"width": "10%", "data": "editor", "title": "主编"},
                {"width": "10%", "data": "price", "title": "单价"},
                {"width": "10%", "data": "declareNum", "title": "申报数量"},
                {"width": "10%", "data": "actualNum", "title": "实订数"},
                {"width": "10%", "data": "total", "title": "总金额"},
                {"width": "10%", "data": "remark", "title": "备注"},
                {
                    "width": "10%", "title": "操作", "render": function (data, type, row) {
                        return "<a onclick='showDetails(\"" + row.textbookId + "\")' class='icon-search' title='查看申报详情'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order': [5, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }

    function showDetails(textbookId) {
        $("#dialog").load("<%=request.getContextPath()%>/textbook/showTextBookTeacherDeclareDetails?textbookId=" + textbookId );
        $("#dialog").modal("show");
    }
</script>
