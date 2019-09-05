<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white" style="width: 165%;">
        <div class="modal-header">
            <b style="margin-left: 240px">${workflowName}</b>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title"> &nbsp;</h4>
        </div>
        <div class="modal-body clearfix">
            <%--<button onclick="doPrint()" class="btn btn-default btn-clean" id="dayin">打印</button>--%>
            <div class="controls">
                <%--<div class="form-row">--%>
                <%--<div class="col-md-2 tar">--%>
                <%--报修种类:--%>
                <%--</div>--%>
                <%--<div class="col-md-4">${repair.repairTypeShow}--%>
                <%--</div>--%>
                <%--<div class="col-md-2 tar">--%>
                <%--所在部门:--%>
                <%--</div>--%>
                <%--<div class="col-md-4">${repair.dept}--%>
                <%--</div>--%>
                <%--<div class="col-md-2 tar">--%>
                <%--资产编号:--%>
                <%--</div>--%>
                <%--<div class="col-md-4">${repair.assetsID}--%>
                <%--</div>--%>
                <%--</div>--%>
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
                            创建部门
                        </div>
                        <div class="col-md-4">
                            <input id="createDept" type="text"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${archives.createDept}" readonly="readonly"/>
                        </div>
                        <div class="col-md-2 tar">
                            创建人
                        </div>
                        <div class="col-md-4">
                            <input id="creator" type="text"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${archives.creator}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span> 申请日期
                        </div>
                        <div class="col-md-4">
                            <input id="requestDate" type="date"
                                   class="validate[required,maxSize[20]] form-control"
                                   value="${archives.requestDate}" readonly="readonly"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span> 一级类别
                        </div>
                        <div class="col-md-4">
                            <select id="oneLevel" disabled="disabled"  class="validate[required,maxSize[100]] form-control"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span> 二级类别
                        </div>
                        <div class="col-md-4">
                            <select id="twoLevel" disabled="disabled"  class="validate[required,maxSize[100]] form-control"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>  档案类型
                        </div>
                        <div class="col-md-4">
                            <select id="fileType" disabled="disabled"  class="validate[required,maxSize[100]] form-control"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>  学校类别
                        </div>
                        <div class="col-md-4">
                            <select id="schoolType" disabled="disabled"  class="validate[required,maxSize[100]] form-control"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>  档案名称
                        </div>
                        <div class="col-md-4">
                            <input id="archivesName" readonly="readonly" type="text" class="validate[required,maxSize[100]] form-control"
                                   placeholder="请填写详细档案名称"
                                   value="${archives.archivesName}"/>
                        </div>
                    </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        申请时间:
                    </div>
                    <div class="col-md-4">${archives.requestDate}
                    </div>
                    <%--<div class="col-md-2 tar">--%>
                        <%--申请类型:--%>
                    <%--</div>--%>
                    <%--<div class="col-md-4">${archives.requestType}--%>
                    <%--</div>--%>
                </div>
                <%--   <div class="form-row">
                       <div class="col-md-2 tar">
                           111报修状态:
                       </div>
                       <div class="col-md-4" id="rflag" >
                           <select id="reFlag" class="js-example-basic-single"></select>
                       </div>
                       <div class="col-md-4" id="rpflag" >${repair.requestFlagShow}
                       </div>
                   </div>--%>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-2 tar">--%>
                        <%--审核人:--%>
                    <%--</div>--%>
                    <%--<div class="col-md-4">${archives.archivesName}--%>
                    <%--</div>--%>
                <%--</div>--%>
            </div>
            <div class="controls" id="doDiv" >
                <div class="col-md-2 tar">
                    <span class="iconBtx">*</span>
                    申请原因
                </div>
                <div class="col-md-9">
                        <textarea id="rcontent"
                                  onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                  maxlength="165" placeholder="最多输入165个字">${archives.reason}</textarea>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <%--<button type="button" id="doRepair" class="btn btn-default btn-clean" data-dismiss="modal"--%>
                    <%--onclick="agree()" >申请通过--%>
            <%--</button>--%>
            <%--<button type="button" id="doRepair" class="btn btn-default btn-clean" data-dismiss="modal"--%>
            <%--onclick="yesRepair()" >驳回--%>
            <%--</button>--%>
            <%--<button type="button" id="fenRepair" class="btn btn-default btn-clean" data-dismiss="modal"--%>
            <%--onclick="fpRepair()" style="display: none;">维修分配--%>
            <%--</button>--%>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="yesReaded()">已读
            </button>

            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>

        </div>
    </div>
</div>
<input id="resourceId" hidden value="${archives.archivesId}">

<script>
    $(document).ready(function () {
        var id = $("#archivesId").val();
        if ($("#archivesId").val() != '') {
            $("#fileType").attr("disabled", "disabled");
        }
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "TYPE_ID",
                text: "TYPE_NAME",
                tableName: "DZDA_TYPE",
                where: "WHERE PARENT_TYPE_ID='0'",
                orderby: "ORDER BY TYPE_ID"
            }
            , function (data) {
                addOption(data, 'oneLevel', '${archives.oneLevel}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "TYPE_ID",
                text: "TYPE_NAME",
                tableName: "DZDA_TYPE",
                orderby: "ORDER BY TYPE_ID"
            }
            , function (data) {
                addOption(data, 'twoLevel', '${archives.twoLevel}');
            });
        $("#twoLevel").append("<option value='' selected>请选择</option>");
        $("#oneLevel").change(function () {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: "TYPE_ID",
                    text: "TYPE_NAME",
                    tableName: "DZDA_TYPE",
                    where: "WHERE PARENT_TYPE_ID ='" + $("#oneLevel").val() + "'",
                    orderby: "ORDER BY TYPE_ID"
                }
                , function (data) {
                    addOption(data, 'twoLevel', '${archives.twoLevel}');
                });
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'yearCode', '${archives.yearCode}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DALX", function (data) {
            addOption(data, 'fileType', '${archives.fileType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXLB", function (data) {
            addOption(data, 'schoolType', '${archives.schoolType}');
        });

    })
    <%--var flag =${flag};--%>
    <%--var repairID = '${repair.repairID}';--%>
    <%--$(document).ready(function () {--%>
    <%--if('${repair.requestFlagShow}'=="维修未完成") {--%>
    <%--$.post("<%=request.getContextPath()%>/repair/checkRequestFlag", {--%>
    <%--repairID: repairID--%>
    <%--}, function (msg) {--%>
    <%--if (msg.status != 1) {--%>
    <%--document.getElementById("doRepair").style.display = "";--%>
    <%--document.getElementById("doDiv").style.display = "";--%>
    <%--document.getElementById("rflag").style.display = "";--%>
    <%--$.get("<%=request.getContextPath()%>/common/getSysDict?name=WXLCZT"+"&where= "+"(dic_code='2' or dic_code='3')",--%>
    <%--function (data) {--%>
    <%--addOption(data, 'reFlag');--%>
    <%--});--%>
    <%--}--%>
    <%--})--%>
    <%--}--%>
    <%--if('${repair.requestFlagShow}'=="维修分配中") {--%>
    <%--document.getElementById("fenRepair").style.display = "";--%>
    <%--document.getElementById("rpflag").style.display = "";--%>
    <%--}else {--%>
    <%--document.getElementById("rpflag").style.display = "";--%>
    <%--}--%>
    <%--})--%>

    function yesReaded() {
        var id = $("#resourceId").val();
        swal({
            title: "确定将本条信息标记为已读?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/archives/updateArchivesInfo", {
                id: id
            }, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"}, function () {
                        //$("#eChartsP").reload("<%=request.getContextPath()%>/index");
                        window.location.href = "<%=request.getContextPath()%>/index?system=GLPT&id=001";
                    });
                }


            });
        })
    }

    function agree() {
        var resourceId = $("#resourceId").val();
        var requestReason = $("#rcontent").val();
        if($("#rcontent").val() =="" || $("#rcontent").val() =="0" || $("#rcontent").val() == undefined){
            swal({
                title: "请填写申请原因！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/resourceLibrary/saveContent", {
            resourceId: resourceId,
            requestReason:requestReason
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#unAudit").load("<%=request.getContextPath()%>/loadIndexUnAudit");
            }
        })
    }
    function fpRepair() {
        $("#dialog").load("<%=request.getContextPath()%>/repair/getDistribution?repairID=" + repairID);
        $("#dialog").modal("show");
    }
</script>