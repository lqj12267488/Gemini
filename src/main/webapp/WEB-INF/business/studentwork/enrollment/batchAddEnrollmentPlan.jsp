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
    <input type="hidden" name="id" id="id" value="${id}">
    <input type="hidden" name="hyear" id="hyear" value="${hyear}">
    <div class="modal-content block-fill-white">
        <div class="modal-header" style="height: 50px">
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
                        <span class="iconBtx">*</span> 学习形式
                    </div>
                    <div class="col-md-9">
                        <select  id="learningType" name="learningType" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 班级数
                    </div>
                    <div class="col-md-9">
                        <input  id="classAmount" name="classAmount" value="${enrollment.classAmount}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 招生人数
                    </div>
                    <div class="col-md-9">
                        <input  id="number" name="number" value="${enrollment.planNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 主干课程
                    </div>
                    <div class="col-md-9">
                        <input  id="mainCourse" name="mainCourse" value="${enrollment.mainCourse}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 合作企业
                    </div>
                    <div class="col-md-9">
                        <input  id="cooperativeEnterprise" name="cooperativeEnterprise" value="${enrollment.cooperativeEnterprise}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 技能证书
                    </div>
                    <div class="col-md-9">
                        <input  id="skillTicket" name="skillTicket" value="${enrollment.skillTicket}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 发证单位
                    </div>
                    <div class="col-md-9">
                        <input  id="f_issuingUnit" name="skillTicket" value="${enrollment.issuingUnit}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveManyPlan()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXXS", function (data) {
            addOption(data, 'learningType',$("#type").val());
        });

    })


    //调寝
    function saveManyPlan() {
        var  learningType=$("#learningType option:selected").val();
        var  classAmount=$("#classAmount").val();
        var  mainCourse=$("#mainCourse").val();
        var  cooperativeEnterprise=$("#cooperativeEnterprise").val();
        var  skillTicket=$("#skillTicket").val();
        var  number=$("#number").val();
        var  ids=$("#ids").val();
        var  id=$("#id").val();
        var  hyear=$("#hyear").val();
        var issuingUnit=$("#f_issuingUnit").val();
        if(number == "" || number == undefined || number == null){
             swal({
                title: "请填写招生人数!",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        swal({
            title: "您是否要批量设置招生计划?",
            //text: "专业名称："+internshipUnitName+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确定",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/enrollment/saveManyPlan", {
                planNumber: number,
                ids: ids,
                id: id,
                year:hyear,
                learningType:learningType,
                classAmount:classAmount,
                mainCourse:mainCourse,
                issuingUnit:issuingUnit,
                cooperativeEnterprise:cooperativeEnterprise,
                skillTicket:skillTicket
            }, function (msg) {
                hideSaveLoading();
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#enrollmentGrid').DataTable().ajax.reload();

            })

        });


    }

</script>

