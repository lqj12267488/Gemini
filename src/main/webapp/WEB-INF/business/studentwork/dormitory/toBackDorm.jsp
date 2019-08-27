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
    <input type="hidden" name="ids" id="ids" value="${ids}">
    <input type="hidden" name="check_value" id="check_value" value="${check_value}">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">

            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        退寝方式
                    </div>
                    <div class="col-md-9">
                        <select  id="backType" >

                        </select>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="backDormSave()">退寝</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TQFS", function (data) {
            addOption(data, 'backType');
        });


    })


    //退寝
    function backDormSave() {
        var backType = $("#backType option:selected").val();
        var backTypeText = $("#backType option:selected").text();
         var ids=$("#ids").val();
         var check_value=$("#check_value").val();
        if(backType == "" || backType == undefined || backType == null){
            swal({
                title: "请选择退寝方式！",
                type: "info"
            });
            return;
        }
        swal({
            title: "您确定要把选中的记录设置成退寝?",
            //text: "目标寝室："+qstext+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: " 确定",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/dorm/saveBackDorm", {
                ids: ids,
                check_value: check_value,
                backType:backType,
                backTypeText: backTypeText

            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#backTable').DataTable().ajax.reload();

            })

        });

    }

</script>

