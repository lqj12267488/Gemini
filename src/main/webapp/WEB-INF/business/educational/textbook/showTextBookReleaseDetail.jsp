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
<div class="modal-dialog" style="width: 60%"><%--整个页面(有新增页)--%>
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
                        <th>id</th>
                        <th>personType</th>
                        <th width="10%">教材名称</th>
                        <th width="10%">所属学院</th>
                        <th width="10%">专业</th>
                        <th width="10%">班级</th>
                        <th width="10%">实发数量</th>
                        <th width="10%">领取人</th>
                        <th width="10%">操作</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="guanbi()">关闭</button>
        </div>
    </div>
</div>
<div class="textbookRelease modal-dialog" id="textbookRelease" style="margin-top: -60px;">
</div>
<input id="d_textbookId" value="${textbookId}" hidden>
<input id="d_declareId" value="${declareId}" hidden>
<script>
    var table;
    $(document).ready(function () {
        var textbookId_1 = $("#d_textbookId").val();
        table = $("#table").DataTable({
            "ajax": {
                "url": "<%=request.getContextPath()%>/textbook/getTextBookReleaseList?textbookId=" + textbookId_1  + "&submitState=2&personType=0&declareId="+ $("#d_declareId").val(),
            },
            "columns": [
                {"data": "id", "visible": false},
                {"data": "personType", "visible": false},
                {"data": "textbookId"},
                {"data": "college"},
                {"data": "majorId"},
                {"data": "classId"},
                {"data": "actualNum"},
                {"data": "receiver"},
                {
                    "render": function (data, type, row) {
                        var str = '<span class="icon-indent-right" title="发放" id="th" onclick=release("' + row.id + '","'+row.personType+'")/>&nbsp;&nbsp;&nbsp;'+
                            '<span id="edit" class="icon-edit" title="修改实订数量" onclick=edit("' + row.id + '","'+row.personType+'","'+row.remainderNum+'")/>'
                        return str;
                    },
                },
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    });

    function release(id,personType) {
        $("#textbookRelease").load("<%=request.getContextPath()%>/textbook/releaseTextbookById?id=" + id+"&personType="+personType+"&declareId="+ $("#d_declareId").val());
        $("#textbookRelease").modal("show");
    }

    function edit(id,personType,remainderNum) {
        $("#textbookRelease").load("<%=request.getContextPath()%>/textbook/editActualNum?id=" + id+"&personType="+personType+"&remainderNum="+remainderNum+"&declareId="+ $("#d_declareId").val());
        $("#textbookRelease").modal("show");
    }
    function guanbi() {
        $('#textBookGrid').DataTable().ajax.reload();
    }
</script>





