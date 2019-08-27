<%--详情查看
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/5
  Time: 17:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 800px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
            <input id="studentGrantsId" type="hidden" value="${studentGrants.id}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-2 tar">
                        报修种类
                    </div>
                    <div class="col-md-4">
                        <input id="repairTypeShow" readonly="readonly" type="text" value="${repair.repairTypeShow}"/>
                    </div>
                    <div class="col-md-2 tar">
                        所在部门
                    </div>
                    <div class="col-md-4">
                        <input id="dept" readonly="readonly" type="text" value="${repair.dept}"/>
                    </div>
                    <%--<div class="col-md-2 tar">
                        资产编号
                    </div>
                    <div class="col-md-4">
                        <input id="assetsID" readonly="readonly" type="text" value="${repair.assetsID}"/>
                    </div>--%>
                </div>

                <%--<div class="form-row">

                    <div class="col-md-2 tar">
                        所在位置
                    </div>
                    <div class="col-md-4">
                        <input id="position" readonly="readonly" type="text" value="${repair.position}"/>
                    </div>

                </div>--%>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        报修物品名称
                    </div>
                    <div class="col-md-4">
                        <input id="itemName" readonly="readonly" type="text" value="${repair.itemNameShow}"/>
                    </div>
                    <div class="col-md-2 tar">
                        维修地址
                    </div>
                    <div class="col-md-4">
                        <input id="repairAddress" readonly="readonly" type="text" value="${repair.repairAddress}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        故障描述
                    </div>
                    <div class="col-md-4">
                        <input id="faultDescription" readonly="readonly" type="text" value="${repair.faultDescription}"/>
                    </div>
                    <div class="col-md-2 tar">
                        联系方式
                    </div>
                    <div class="col-md-4">
                        <input id="contactNumber" readonly="readonly" type="text" value="${repair.contactNumber}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        报修状态
                    </div>
                    <div class="col-md-4">
                        <input id="requestFlag" type="text"
                               value="${repair.requestFlag}" readonly="readonly"/>
                    </div>
                    <div class="col-md-2 tar">
                        反馈意见
                    </div>
                    <div class="col-md-4">
                        <input id="feedback" type="text" readonly
                               value="${repair.feedback}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        反馈状态
                    </div>
                    <div class="col-md-4">
                        <input id="feedbackFlag" type="text"
                            value="${repair.feedbackFlag}" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        维修说明
                    </div>
                    <div class="col-md-4">
                        <input id="rcontent" type="text"
                               value="${repair.repairResult}" readonly="readonly"/>
                    </div>
                </div>
            </div>
        </div>
       <div class="modal-footer">
           <button type="button" class="btn btn-default btn-clean" onclick="closeWork()">关闭流程</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<input id="repairID" hidden value="${repair.repairID}">
<script>
    function closeWork() {
        swal({
            title: "确认要关闭此流程?",
            text: "报修种类："+$("#repairTypeShow").val()+"\n\n关闭后无法再编辑，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/repair/closeWork?repairID=" + $("#repairID").val(), function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"},function () {
                        $("#dialog").modal("hide");
                    });
                    $('#repairTable').DataTable().ajax.reload();

                }
            })
        })
    }
</script>
