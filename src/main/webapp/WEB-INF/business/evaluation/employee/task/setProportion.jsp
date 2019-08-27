<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${taskName} 设置不计分比例</h4>
            <input id="id" value="${id}" hidden>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-6 tar">
                        <span class="iconBtx">*</span>
                        去掉最高分比例:
                    </div>
                    <div class="col-md-3">
                        <input id="limitHig" type="text" maxlength="2" placeholder="请输入数字" value="${task.limitHig}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" />
                    </div>
                    <div class="col-md-3">%</div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 tar">
                        <span class="iconBtx">*</span>
                        去掉最低分比例:
                    </div>
                    <div class="col-md-3">
                        <input id="limitMin"  type="text" maxlength="2" placeholder="请输入数字" value="${task.limitMin}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"/>
                    </div>
                    <div class="col-md-3">%</div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()" id="saveBtn">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    var eType = '0';
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

    })

    function save() {
        var id = $("#id").val();
        var limitMin = $("#limitMin").val();
        var limitHig = $("#limitHig").val();
        if (limitHig == "" || limitHig == null) {
            swal({
                title: "去掉最高分比例不能为空！",
                type: "info"
            });
            return;
        }
        if (limitMin == "" || limitMin == null) {
            swal({
                title: "去掉最低分比例不能为空！",
                type: "info"
            });
            return;
        }
        if(isNaN(limitMin)|| isNaN(limitHig) || limitHig.substr(0,1) =='.' || limitHig.substr(1,1) =='.' ||limitMin.substr(0,1) =='.' || limitMin.substr(1,1) =='.'){
            swal({
                title: "去掉最高分比例,去掉最低分比例请填写数字！",
                type: "info"
            });
            return;
        }
        if(parseInt(limitMin)+parseInt(limitHig) >= 100){
            swal({
                title: "比例和已经超过100！",
                type: "info"
            });
            return;
        }
        // showSaveLoading();
        $.post("<%=request.getContextPath()%>/evaluation/saveProportion", {
            taskId: id,
            limitMin: limitMin,
            limitHig: limitHig
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal("hide");
            taskTable.ajax.reload();
        })
    }
</script>