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

                <div class="block block-drop-shadow content">
                    <div class="form-row" style="overflow-y:auto;">
                    <span style="font-size: 20px;">${head}</span><br>
                    </div>
                    <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
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
        table = $("#textBookGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/getTextBookInventoryList?textbookId=${id}',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "20%", "data": "textbookId", "title": "教材名称"},
                {"width": "10%", "data": "operationType", "title": "操作类型"},
                {"width": "10%", "data": "operationNum", "title": "入库数量"},
                {"width": "20%", "data": "creator", "title": "操作人"},
                {"width": "18%", "data": "operationTime", "title": "操作时间"},
                {"width": "20%", "data": "remark", "title": "备注"},
            ],
            'order': [5, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    });

    function searchClear() {
        $("#textbookName").val("");
        searchBranch();
    }
    function searchBranch() {
        var textbookName = $("#textbookName").val();
        if (textbookName != "")
            textbookName = '%' + textbookName + '%';
        table = $("#textBookGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/searchTextBookInventory?textbookId=${id}',
                "data": {
                    textbookName: textbookName
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "18%", "data": "textbookId", "title": "教材名称"},
                {"width": "18%", "data": "operationType", "title": "操作类型"},
                {"width": "18%", "data": "operationNum", "title": "入库数量"},
                {"width": "18%", "data": "creator", "title": "操作人"},
                {"width": "18%", "data": "operationTime", "title": "操作时间"},
                {"width": "20%", "data": "remark", "title": "备注"},
            ],
            'order': [5, 'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/textBookInventoryList");
        $("#right").modal("show");
    }
</script>
