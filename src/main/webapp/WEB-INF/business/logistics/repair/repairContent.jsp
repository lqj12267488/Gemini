<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="flag" type="hidden" value="${flag}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        报修种类:
                    </div>
                    <div class="col-md-4">${repair.repairTypeShow}
                    </div>
                    <div class="col-md-2 tar">
                        所在部门:
                    </div>
                    <div class="col-md-4">${repair.dept}
                    </div>
                    <%--<div class="col-md-2 tar">--%>
                        <%--资产编号:--%>
                    <%--</div>--%>
                    <%--<div class="col-md-4">${repair.assetsID}--%>
                    <%--</div>--%>
                </div>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-2 tar">--%>
                        <%--所在位置:--%>
                    <%--</div>--%>
                    <%--<div class="col-md-4">${repair.position}--%>
                    <%--</div>--%>
                    <%----%>
                <%--</div>--%>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        物品名称:
                    </div>
                    <div class="col-md-4">${repair.itemNameShow}
                    </div>
                    <div class="col-md-2 tar">
                        维修地址:
                    </div>
                    <div class="col-md-4">${repair.repairAddress}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        故障描述:
                    </div>
                    <div class="col-md-4">${repair.faultDescription}
                    </div>
                    <div class="col-md-2 tar">
                        联系方式:
                    </div>
                    <div class="col-md-4">${repair.contactNumber}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        报修状态:
                    </div>
                    <div class="col-md-4" id="rflag">
                        <select id="reFlag" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                </div>
            </div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        维修说明
                    </div>
                    <div class="col-md-9">
                        <textarea id="rcontent" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                  maxlength="165" placeholder="最多输入165个字">${repair.repairResult}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closedwindow()">关闭</button>
        </div>
    </div>
</div>
<input id="reID" hidden value="${repair.repairID}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var repairID=$("#reID").val();
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=WXLCZT"+"&where= "+"(dic_code='2' or dic_code='3')",
            function (data) {
                addOption(data, "reFlag", '${repair.requestFlag}');
            });
    })

    function closedwindow(){
        $("input").removeAttr("readOnly");
    }
    function saveDept() {
        if($("#rcontent").val() =="" || $("#rcontent").val() =="0" || $("#rcontent").val() == undefined){
            swal({
                title: "请填写维修说明！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/repair/saveContent", {
            repairID: repairID,
            requestFlag:$("#reFlag").val(),
            content:$("#rcontent").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#repairTable').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>
<script type="text/javascript">//多选树z-tree.js数据格式 end

</script>



