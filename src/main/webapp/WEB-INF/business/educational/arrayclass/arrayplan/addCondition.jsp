<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/23
  Time: 10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/common/treeSelect.jsp" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <span style="font-size: 14px;">${head}</span>
            <input id="id" hidden value="${arrayClassCondition.id}">
            <input id="elementsId" hidden value="${elementsId}">
            <input id="arrayClassId" hidden value="${arrayClassId}">
            <input id="elementsType" hidden value="${elementsType}">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        约束条件类型
                    </div>
                    <div class="col-md-9">
                        <select id="conditionType" class="js-example-basic-single" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        禁排星期
                    </div>
                    <div class="col-md-9">
                        <select id="limitWeek2" class="js-example-basic-single" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        禁排学时类型
                    </div>
                    <div class="col-md-9">
                        <select id="limitHoursType" class="js-example-basic-single" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        禁排学时
                    </div>
                    <div class="col-md-9">
                        <select id="limitHoursCode" class="js-example-basic-single" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>

    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PKYSTJLX", function (data) {
            addOption(data, 'conditionType', '${arrayClassCondition.conditionType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQZ", function (data) {
            addOption(data, 'limitWeek2', '${arrayClassCondition.limitWeek}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PKXSLX", function (data) {
            addOption(data, 'limitHoursType', '${arrayClassCondition.limitHoursType}');
        });
        $("#limitHoursType").blur(function(){
            var r =$("#limitHoursType option:selected").val();
            if(r==1){
                $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " id ",
                    text: " hours_name ",
                    tableName: " T_JW_ARRAYCLASS_TIME ",
                    where: " WHERE 1 = 1 and arrayclass_id='${arrayClassId}'and hours_type=1" ,
                    orderby: " order by create_time desc"
                }, function (data) {
                    addOption(data, 'limitHoursCode', '${arrayClassCondition.limitHoursCode}');
                })
            }else if(r==2){
                $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " id ",
                    text: " hours_name ",
                    tableName: " T_JW_ARRAYCLASS_TIME ",
                    where: " WHERE 1 = 1 and arrayclass_id='${arrayClassId}'and hours_type=2" ,
                    orderby: " order by create_time desc"
                }, function (data) {
                    addOption(data, 'limitHoursCode', '${arrayClassCondition.limitHoursCode}');
                })
            }else if(r==3){
                $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " id ",
                    text: " hours_name ",
                    tableName: " T_JW_ARRAYCLASS_TIME ",
                    where: " WHERE 1 = 1 and arrayclass_id='${arrayClassId}'and hours_type=3" ,
                    orderby: " order by create_time desc"
                }, function (data) {
                    addOption(data, 'limitHoursCode', '${arrayClassCondition.limitHoursCode}');
                })
            }else if(r==4){
                $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " id ",
                    text: " hours_name ",
                    tableName: " T_JW_ARRAYCLASS_TIME ",
                    where: " WHERE 1 = 1 and arrayclass_id='${arrayClassId}'and hours_type=4" ,
                    orderby: " order by create_time desc"
                }, function (data) {
                    addOption(data, 'limitHoursCode', '${arrayClassCondition.limitHoursCode}');
                })
            }else{
                $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " id ",
                    text: " hours_name ",
                    tableName: " T_JW_ARRAYCLASS_TIME ",
                    where: " WHERE 1 = 1 and arrayclass_id='${arrayClassId}'and hours_type=5" ,
                    orderby: " order by create_time desc"
                }, function (data) {
                    addOption(data, 'limitHoursCode', '${arrayClassCondition.limitHoursCode}');
                })
            }
        })



            /*$.get("/common/getTableDict", {
                id: " id ",
                text: " hours_name ",
                tableName: " T_JW_ARRAYCLASS_TIME ",
                where: " WHERE 1 = 1 and arrayclass_id='arrayClassId}' and hours_type=" ,
                orderby: " order by create_time desc"
            }, function (data) {
                addOption(data, 'limitHoursCode', 'arrayClassCondition.limitHoursCode}');
            })*/


    });
    function save() {
        var id = $("#id").val();
        var arrayClassId = $("#arrayClassId").val();
        var elementsId = $("#elementsId").val();
        var elementsType = $("#elementsType").val();
        var conditionType = $("#conditionType").val();
        var limitWeek2 = $("#limitWeek2").val();
        var limitHoursType = $("#limitHoursType").val();
        var limitHoursCode = $("#limitHoursCode").val();

        if (conditionType == "" || conditionType == undefined || conditionType == null) {
            swal({
                title: "请选择约束条件类型！",
                type: "info"
            });
            return;
        }
        if (limitWeek2== "" || limitWeek2 == undefined || limitWeek2 == null) {
            swal({
                title: "请选择禁排星期！",
                type: "info"
            });
            return;
        }
        if (limitHoursType == "" || limitHoursType == undefined || limitHoursType == null) {
            swal({
                title: "请选择禁排学时类型！",
                type: "info"
            });
            return;
        }

        if (limitHoursCode == "" || limitHoursCode == undefined || limitHoursCode == null) {
            swal({
                title: "请选择禁排学时！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/arrayClassCourse/saveArrayClassCondition", {
            id: id,
            arrayclassId:arrayClassId,
            elementsId: elementsId,
            elementsType: elementsType,
            conditionType: conditionType,
            limitWeek: limitWeek2,
            limitHoursType:limitHoursType,
            limitHoursCode:limitHoursCode
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#arrayClassConditionGrid').DataTable().ajax.reload();
        })
    }
</script>




