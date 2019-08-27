<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
    </style>
</head>
<div class="modal-dialog">
    <input type="hidden" name="majorId" id="majorId" value="${majorId}">
    <input type="hidden" name="eYear" id="eYear" value="${year}">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 费用
                    </div>
                    <div class="col-md-9">
                        <input  id="majorFee" name="majorFee"  value="${costMajor.majorFee}"/>
                    </div>
                </div>


            </div>
        </div>
        <div class="modal-footer">
            <button type="button"  id="saveBtn"class="btn btn-success btn-clean" onclick="saveSingle()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

    })



    function saveSingle() {
        var  majorFee=$("#majorFee").val();
        var  majorId=$("#majorId").val();
        var  eYear=$("#eYear").val();
        if(majorFee == "" || majorFee == undefined || majorFee == null){
            swal({
                title: "请填写费用!",
                type: "info"
            });
            return;
        }
        // showSaveLoading();
        swal({
            title: "您是否确认设置此专业的费用?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确定",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/payment/major/saveSingle", {
                majorId: majorId,
                year:eYear,
                majorFee:majorFee
            }, function (msg) {
                hideSaveLoading();
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#costMajorGrid').DataTable().ajax.reload();

            })

        });

    }

</script>

