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
<input id="id" hidden value="${planId}">
<input id="pId" hidden value="${pId}">
<div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
<div id="index">
    <div>
        <h5>
            新增指标
        </h5>
    </div>
    <div class="form-row">
        <div class="col-md-3 tar">
            <span class="iconBtx">*</span>
            指标名称
        </div>
        <div class="col-md-9">
            <input id="indexName" type="text"
                   class="validate[required,maxSize[8]] form-control"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="30" placeholder="最多输入30个字"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-3 tar">
            <span class="iconBtx">*</span>
            分数
        </div>
        <div class="col-md-9">
            <input id="score" type="number"
                   class="validate[required,minSize[5],maxSize[10]] form-control"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="10" placeholder="最多输入10个数字"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-3 tar">
            <span class="iconBtx">*</span>
            权重（百分比）
        </div>
        <div class="col-md-9">
            <input id="weights" type="number"
                   class="validate[required,minSize[5],maxSize[10]] form-control"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="10" placeholder="最多输入10个数字"/>
        </div>
    </div>
    <div class="form-row">
        <div style="text-align: center">
            <button class="btn btn-default btn-clean" onclick="save()"  id="saveBtn">保存</button>
            <button class="btn btn-default btn-clean" onclick="cancel()">取消</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    function save() {
        var indexName = $("#indexName").val();
        if (indexName == "" || indexName == null) {
            swal({
                title: "名称不为空！",
                type: "info"
            });
            return;
        }
        var score = $("#score").val();
        if (score == "" || score == null) {
            swal({
                title: "分数不为空！",
                type: "info"
            });
            return;
        }
        if (score < 1) {
            swal({
                title: "分数不能为负数和0！",
                type: "info"
            });
            return;
        }
        var weights = $("#weights").val();
        if (weights == "" || weights == null) {
            swal({
                title: "权重不为空！",
                type: "info"
            });
            return;
        }
        if (weights < 1) {
            swal({
                title: "权重不能为负数和0！",
                type: "info"
            });
            return;
        }

        if (weights > 100) {
            swal({
                title: "权重不能超过100！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/xgEvaluation/saveIndex", {
            indexName: indexName,
            score: score,
            weights: weights,
            planId: $("#id").val(),
            parentIndexId: $("#pId").val(),
            indexLevel: level + 1
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#right").load("<%=request.getContextPath()%>/xgEvaluation/toIndex", {
                    id: '${planId}'
                });
            } else {
                swal({
                    title: msg.msg,
                    type: "error"
                });
            }
        })
    }

    function cancel() {
        $("#index").hide();
    }
</script>