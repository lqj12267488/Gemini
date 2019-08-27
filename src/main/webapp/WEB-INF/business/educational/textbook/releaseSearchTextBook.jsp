<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 40%">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="textbookId" hidden value="${textBookDeclare.textbookId}">
            <input id="id" hidden value="${textBookDeclare.id}">
        </div>
        <div class="modal-body clearfix"><%--新增页体部--%>
            <div class="controls">
                <table id="tableGrant" cellpadding="0" cellspacing="0" width="100%"
                       class="table table-bordered table-striped sortable_default">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>personType</th>
                        <th width="10%">教材名称</th>
                        <th width="10%">所属学院</th>
                        <th width="10%">专业</th>
                        <th width="10%">班级</th>
                        <th width="10%">实发数量</th>
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
<input id="remainderNum" value="${textBookDeclare.remainderNum}" hidden>
<input id="f_declareId" value="${textBookDeclare.id}" hidden>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var tableGrant;
    $(document).ready(function () {
        tableGrant = $("#tableGrant").DataTable({
            "ajax": {
                "url": "<%=request.getContextPath()%>/textbook/getGrantList?declareId=" + $("#f_declareId").val(),
            },
            "columns": [
                {"data": "id", "visible": false},
                {"data": "personType", "visible": false},
                {"data": "textbookId"},
                {"data": "collegeShow"},
                {"data": "majorId"},
                {"data": "classId"},
                {"data": "giveNum"},
                {"data": "receiver"}
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    })
</script>
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>