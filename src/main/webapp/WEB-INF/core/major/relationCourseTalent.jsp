<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${head}</span>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="relationCTGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tid" hidden value="${tid}">
<input id="tname" hidden value="${tname}">
<script>
    var relationCTGrid;
    var isEdit='';
    $(document).ready(function () {
        $.post("/major/getStatusByTid", {
            tid: $("#tid").val()
        },function (res) {
            isEdit=res.res;
        });
        relationCTGrid = $("#relationCTGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/major/getrelationCT',
                "data": {
                    id: $("#tid").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "planId", "visible": false},
                {"width":"25%","data": "planName", "title": "计划名称"},
                {"width":"25%","data": "trainingLevel", "title": "是否关联"},
                {
                    "width":"25%",
                    "title": "操作",
                    "render": function () {
                        if(isEdit==='审批中'||isEdit==='审核通过'){
                            return '';
                        }else {
                            return "<a id='editSysDic' class='icon-edit' title='关联'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='del' class='icon-trash' title='取消关联'></a>&nbsp;&nbsp;&nbsp;"
                        }
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        relationCTGrid.on('click', 'tr a', function () {
            var data = relationCTGrid.row($(this).parent()).data();
            var id = data.planId;
            var planName=data.planName;
            if (this.id == "editSysDic") {
                if(data.trainingLevel=="是"){
                    swal({
                        title:"此教学计划已关联，不可重复关联！",
                        type: "info"
                    });
                }
                else {
                    swal({
                        title: "您确定要与本条教学计划关联?",
                        text: "计划名称：" + planName,
                        type: "warning",
                        showCancelButton: true,
                        cancelButtonText: "取消",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确定",
                        closeOnConfirm: false
                    }, function () {
                        $.post("<%=request.getContextPath()%>/major/saveRelationTalent", {
                            planId: id,
                            planName: planName,
                            trainName: $("#tname").val(),
                            id: $("#tid").val()
                        }, function (msg) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#relationCTGrid').DataTable().ajax.reload();

                        });

                    });
                }
            }
            if (this.id == "del") {
                if(data.trainingLevel=="否"){
                    swal({
                        title:"此计划未关联，不必撤销！",
                        type: "info"
                    });
                }
                else {
                    swal({
                        title: "您确定撤销本条教学计划关联?",
                        text: "计划名称：" + planName,
                        type: "warning",
                        showCancelButton: true,
                        cancelButtonText: "取消",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确定",
                        closeOnConfirm: false
                    }, function () {
                        $.post("<%=request.getContextPath()%>/major/delRelationTalent", {
                            pid: id,
                            tid: $("#tid").val()
                        }, function (msg) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#relationCTGrid').DataTable().ajax.reload();

                        });

                    });
                }
            }
        });
    })
    function back() {
        $("#right").load("<%=request.getContextPath()%>/major/talentTrain");
    }
</script>
