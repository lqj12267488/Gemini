<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/5/8
  Time: 12:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="container">
    <div class="content">
        <button onclick="back()" class="btn btn-default btn-clean">返回</button>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        反馈状态
                    </div>
                    <div class="col-md-9">
                        <select  id="feedbackFlag" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        反馈意见
                    </div>
                    <div class="col-md-9">
                        <textarea id="feedback" class="validate[required,maxSize[100]] form-control"
                                  maxlength="330" placeholder="最多输入330个字">${feedback.feedback}</textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveFeedback()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal"  onclick="back()">关闭</button>
        </div>
    </div>
</div>
<input id="tableName" hidden value="${tableName}">
<input id="businessId" hidden value="${businessId}">

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GZLFKZT", function (data) {
            addOption(data, 'feedbackFlag','${feedback.feedbackFlag}');
        });
    })


    function saveFeedback() {
        if($("#feedbackFlag").val() =="" ||  $("#feedbackFlag option:selected").val() =="0" || $("#feedbackFlag").val() == undefined){
            swal({
                title: "请选择反馈状态",
                type: "info"
            });
            //alert("请选择反馈状态");
            return;
        }
        if($("#feedback").val() ==""  || $("#feedback").val() == undefined){
            swal({
                title: "请填写反馈意见",
                type: "info"
            });
            //alert("请填写反馈意见");
            return;
        }
            var feedbackFlag = $("#feedbackFlag option:selected").val();
            var feedback =  $("#feedback").val();
            $.post("<%=request.getContextPath()%>/feedback", {
                businessId: '${businessId}',
                tableName: '${tableName}',
                feedbackFlag: feedbackFlag,
                feedback: feedback
            }, function (data) {
                hideSaveLoading();
                if (data.status = 1) {
                    swal({
                        title: data.msg,
                        type: "success"
                    });
                    //alert(data.msg)
                    back()
                }
            })
        showSaveLoading();
    }
    function back() {
        $("#right").load('<%=request.getContextPath()%>${backUrl}');
    }
</script>

