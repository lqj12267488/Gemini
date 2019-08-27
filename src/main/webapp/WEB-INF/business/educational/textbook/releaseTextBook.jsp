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
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        教材名称
                    </div>
                    <div class="col-md-9">
                        <input id="planName" type="text"
                               class="validate[required,maxSize[8]] form-control"
                               value="${textBookDeclare.textbookName}" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        发放专业
                    </div>
                    <div class="col-md-9">
                        <select id="major" disabled></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 发放数量
                    </div>
                    <div class="col-md-9">
                        <input id="num" value="${textBookDeclare.remainderNum}"></input>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 领取人
                    </div>
                    <div class="col-md-9">
                        <input id="f_receiver" value="${textBookDeclare.receiver}"></input>
                    </div>
                </div>
            </div>
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
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveRelease()">发放</button>
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
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " MAJOR_CODE",
                text: " MAJOR_NAME ",
                tableName: "T_XG_MAJOR",
                where: " WHERE 1 = 1",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "major", '${textBookDeclare.majorId}');
            });
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

    function saveRelease() {
        var id = $("#id").val();
        var remainderNum = $("#remainderNum").val();
        var operationNum = $("#num").val();
        var textbookId = $("#textbookId").val();
        var reg = new RegExp("^[0-9]*$");
        var receivers = $("#f_receiver").val();
        if (operationNum == "" || operationNum == null ) {
            swal({
                title: "请填写教材发放数量！",
                type: "info"
            });
            return;
        } else if (!reg.test(operationNum)) {
            swal({
                title: "教材发放数量必须为整数！",
                type: "info"
            });
            return;
        } else if (operationNum<1) {
            swal({
                title: "教材发放数量必须大于0！",
                type: "info"
            });
            return;
        }else if (operationNum -  remainderNum> 0 ) {
            swal({
                title: "教材发放数量不能大于剩余发放数量！",
                type: "info"
            });
            return;
        }
        if  (receivers == "" || receivers == null)
        {
            swal({
                title: "请填写领取人！",
                type: "info"
            });
            return;
        }
        else {
            showSaveLoading();
            $.post("<%=request.getContextPath()%>/textbook/saveTextBookRelease", {
                id: id,
                textbookId: textbookId,
                operationNum: operationNum,
                personType:'${personType}',
                receiver:receivers
            }, function (msg) {
                hideSaveLoading();
                if (msg.status == 1) {
                    swal({title: msg.msg, type: msg.result});
                    $("#dialog").modal('hide');
                    $('#tableGrant').DataTable().ajax.reload();
                    $('#textBookGrid').DataTable().ajax.reload();
                }
            })
        }
    }
</script>
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>