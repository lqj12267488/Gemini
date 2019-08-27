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
<
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog"><%--整个页面(有新增页)--%>
    <div class="modal-content block-fill-white"><%--新增页框--%>
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button><%--新增页头部--%>
            <span style="font-size: 14px;">${head}</span>
        </div>
        <div class="modal-body clearfix"><%--新增页体部--%>
            <div class="controls"><%--''--%>
                <div class="form-row">
                    <div>
                        姓名：${party.personIdDept}
                    </div>
                </div>

                <table id="table" cellpadding="0" cellspacing="0" width="100%"
                       class="table table-bordered table-striped sortable_default">
                    <thead>
                    <tr>
                        <th width="20%">操作人</th>
                        <th width="15%">操作类型</th>
                        <th width="50%">日志</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
        <div class="modal-footer"><%--新增页尾部--%>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<input type="text" hidden id="l_personId" value="${party.personId}">
<script>
    var table;
    $(document).ready(function () {
       var personId= $("#l_personId").val();
        table = $("#table").DataTable({
            "ajax": {
                "url": "<%=request.getContextPath()%>/getPartyLog?personId=" +personId ,
            },
            "columns": [
                {"data": "creator"},
                {"data": "logType"},
                {"data": "logRemark"},
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [1, 'desc'],
            "dom": 'rt',
            language: language
        });
    });
</script>





