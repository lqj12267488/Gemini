<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="">
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
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
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
                        <input id="receiver" value="${textBookDeclare.receiver}" disabled></input>
                    </div>
                </div>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--教材名称--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<input id="planName" type="text"--%>
                               <%--class="validate[required,maxSize[8]] form-control" value="${textBookDeclare.textbookName}" disabled/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--发放专业--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<select id="major" disabled></select>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--<span class="iconBtx">*</span> 实订数量--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<input id="num" value="${textBookDeclare.actualNum}"></input>--%>
                    <%--</div>--%>
                <%--</div>--%>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn"	 class="btn btn-success btn-clean" onclick="saveRelease()">修改</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<input id="remainderNum" value="${textBookDeclare.remainderNum}" hidden>
<input id="ids" value="${textBookDeclare.ids}" hidden>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
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
    })
    function saveRelease() {
        var id=$("#id").val();
        var ids=$("#ids").val();
        var num = $("#num").val();
        var reg = new RegExp("^[0-9]*$");
        if (num == "" ||num == null) {
            swal({
                title: "请填写实订数量！",
                type: "info"
            });
            return;
        } else if (!reg.test(num)) {
            swal({
                title: "实订数量必须为整数！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/textbook/saveActualNum", {
            ids:id,
            id:ids,
            // actualNum: num,                                           //新实订数
            remainderNum:num,                    //提交状态
            submitState:'${textBookDeclare.remainderNum}',           //原剩余数量
            declareNum:'${textBookDeclare.actualNum}'                //原实订数
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: msg.result});
                $("#textbookRelease").modal('hide');
                $('#table').DataTable().ajax.reload();
            }else {
                swal({title: msg.msg, type: "info"});
                $("#textbookRelease").modal('hide');
            }
        })
    }
</script>
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>