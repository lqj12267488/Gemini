<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog" style="width: 60%;"><%--整个页面(有新增页)--%>
    <div class="modal-content block-fill-white"><%--新增页框--%>
        <div class="modal-header" style="height:7% ">
            教材申报详情
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <%--新增页头部--%>
            <span style="font-size: 14px;">${head}</span>
        </div>
        <div class="modal-body clearfix"><%--新增页体部--%>
            <div class="controls">
                <table id="table" cellpadding="0" cellspacing="0" width="100%"
                       class="table table-bordered table-striped sortable_default">
                    <thead>
                    <tr>
                        <th width="23%">教材名称</th>
                        <th width="22%">专业</th>
                        <th width="22%">班级</th>
                        <th width="10%">发放数量</th>
                        <th width="10%">发放日期</th>
                        <th width="10%">领取人</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<input id="d_textbookId" value="${textbookId}" hidden>
<script>
    var table;
    $(document).ready(function () {
        var textbookId_1 = $("#d_textbookId").val();
        table = $("#table").DataTable({
            "ajax": {
                "url": "<%=request.getContextPath()%>/textbook/getFaFang?textbookId=" + textbookId_1+"&personType=0",
            },
            "columns": [
                {"data": "textbookId"},
                {"data": "majorId"},
                {"data": "classId"},
                {"data": "declareNum"},
                {"data": "remark"},
                {"data": "receiver"},
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    });
</script>





