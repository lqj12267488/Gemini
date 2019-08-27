<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/27
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
            <input id="dataId" hidden value="${data.dataId}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 资料名称：
                    </div>
                    <div class="col-md-9">
                        <input id="dataName" placeholder="请填写资料名称" type="text"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字" value="${data.dataName}"></input>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 一级菜单：
                    </div>
                    <div class="col-md-9">
                        <select id="dataFirstType" class="js-example-basic-single"/></div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>二级菜单：
                    </div>
                    <div class="col-md-9">
                        <select id="dataSecondType"
                                class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>三级菜单：
                    </div>
                    <div class="col-md-9">
                        <select id="dataThirdType"
                                class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        日期
                    </div>
                    <div class="col-md-9">
                        <input id="submitTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${data.submitTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>房间：
                    </div>
                    <div class="col-md-9">
                        <select id="bookshelfName" class="js-example-basic-single"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 柜号：
                    </div>
                    <div class="col-md-9">
                        <select id="bookshelfLayer" class="js-example-basic-single"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>档案盒名称：
                    </div>
                    <div class="col-md-9">
                        <select id="arrayLocation" class="js-example-basic-single"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveData()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "TYPE_ID",
                text: "TYPE_NAME",
                tableName: "T_ZL_DATA_TYPE",
                where: "WHERE PARENT_TYPE_ID='0'",
                orderby: "ORDER BY TYPE_ID"
            }
            , function (data) {
                addOption(data, 'dataFirstType', '${data.dataFirstType}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "TYPE_ID",
                text: "TYPE_NAME",
                tableName: "T_ZL_DATA_TYPE",
                where: "WHERE PARENT_TYPE_ID ='" + '${data.dataFirstType}' + "'",
                orderby: "ORDER BY TYPE_ID"
            }
            , function (data) {
                addOption(data, 'dataSecondType', '${data.dataSecondType}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "TYPE_ID",
                text: "TYPE_NAME",
                tableName: "T_ZL_DATA_TYPE",
                where: "WHERE PARENT_TYPE_ID ='" + '${data.dataSecondType}' + "'",
                orderby: "ORDER BY TYPE_ID"
            }
            , function (data) {
                addOption(data, 'dataThirdType', '${data.dataThirdType}');
            });
        $("#dataSecondType").append("<option value='' selected>请选择</option>");
        $("#dataThirdType").append("<option value='' selected>请选择</option>");
        $("#dataFirstType").change(function () {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: "TYPE_ID",
                    text: "TYPE_NAME",
                    tableName: "T_ZL_DATA_TYPE",
                    where: "WHERE PARENT_TYPE_ID ='" + $("#dataFirstType").val() + "'",
                    orderby: "ORDER BY TYPE_ID"
                }
                , function (data) {
                    addOption(data, 'dataSecondType', '${data.dataSecondType}');
                });
        })

        $("#dataSecondType").change(function () {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: "TYPE_ID",
                    text: "TYPE_NAME",
                    tableName: "T_ZL_DATA_TYPE",
                    where: "WHERE PARENT_TYPE_ID ='" + $("#dataSecondType").val() + "'",
                    orderby: "ORDER BY TYPE_ID"
                }
                , function (data) {
                    addOption(data, 'dataThirdType', '${data.dataThirdType}');
                });
        })

        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "LOCATION_ID",
                text: "LOCATION_NAME",
                tableName: "T_ZL_DATA_LOCATION",
                where: "WHERE PARENT_LOCATION_ID='0'",
                orderby: "ORDER BY LOCATION_ID"
            }
            , function (data) {
                addOption(data, 'bookshelfName', '${data.bookshelfName}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "LOCATION_ID",
                text: "LOCATION_NAME",
                tableName: "T_ZL_DATA_LOCATION",
                where: "WHERE PARENT_LOCATION_ID ='" + '${data.bookshelfName}' + "'",
                orderby: "ORDER BY LOCATION_ID"
            }
            , function (data) {
                addOption(data, 'bookshelfLayer', '${data.bookshelfLayer}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "LOCATION_ID",
                text: "LOCATION_NAME",
                tableName: "T_ZL_DATA_LOCATION",
                where: "WHERE PARENT_LOCATION_ID ='" + '${data.bookshelfLayer}' + "'",
                orderby: "ORDER BY LOCATION_ID"
            }
            , function (data) {
                addOption(data, 'arrayLocation', '${data.arrayLocation}');
            });
        $("#bookshelfLayer").append("<option value='' selected>请选择</option>");
        $("#arrayLocation").append("<option value='' selected>请选择</option>");
        $("#bookshelfName").change(function () {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: "LOCATION_ID",
                    text: "LOCATION_NAME",
                    tableName: "T_ZL_DATA_LOCATION",
                    where: "WHERE PARENT_LOCATION_ID ='" + $("#bookshelfName").val() + "'",
                    orderby: "ORDER BY LOCATION_ID"
                }
                , function (data) {
                    addOption(data, 'bookshelfLayer', '${data.bookshelfLayer}');
                });
        })
        $("#bookshelfLayer").change(function () {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: "LOCATION_ID",
                    text: "LOCATION_NAME",
                    tableName: "T_ZL_DATA_LOCATION",
                    where: "WHERE PARENT_LOCATION_ID ='" + $("#bookshelfLayer").val() + "'",
                    orderby: "ORDER BY LOCATION_ID"
                }
                , function (data) {
                    addOption(data, 'arrayLocation', '${data.arrayLocation}');
                });
        })
    })


    function saveData() {
        var dataId = $("#dataId").val();
        var dataName = $("#dataName").val();
        var dataFirstType = $("#dataFirstType option:selected").val();
        var dataSecondType = $("#dataSecondType option:selected").val();
        var dataThirdType = $("#dataThirdType option:selected").val();
        var bookshelfName = $("#bookshelfName option:selected").val();
        var bookshelfLayer = $("#bookshelfLayer option:selected").val();
        var arrayLocation = $("#arrayLocation option:selected").val();
        var submitTime = $("#submitTime").val();
        if (dataName == "" || dataName == null || dataName == undefined) {
            swal({
                title: "请填写资料名称!",
                type: "info"
            });
            return;
        }

        if (dataFirstType == "" || dataFirstType == null || dataFirstType == undefined) {
            swal({
                title: "请选择一级菜单！",
                type: "info"
            });
            return;
        }
        if (dataSecondType == "" || dataSecondType == null || dataSecondType == undefined) {
            swal({
                title: "请选择二级菜单！",
                type: "info"
            });
            return;
        }
        if (dataThirdType == "" || dataThirdType == null || dataThirdType == undefined) {
            swal({
                title: "请选择三级菜单！",
                type: "info"
            });
            return;
        }
        if (submitTime == "" || submitTime == null || submitTime == undefined) {
            swal({
                title: "请选择日期！",
                type: "info"
            });
            return;
        }
        if (bookshelfName == "" || bookshelfName == null || bookshelfName == undefined) {
            swal({
                title: "请选择房间！",
                type: "info"
            });
            return;
        }
        if (bookshelfLayer == "" || bookshelfLayer == null || bookshelfName == undefined) {
            swal({
                title: "请选择柜号!",
                type: "info"
            });
            return;
        }
        if (arrayLocation == "" || arrayLocation == null || arrayLocation == undefined) {
            swal({
                title: "请选择档案盒名称!",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/data/saveData", {
            dataId: $("#dataId").val(),
            dataName: dataName,
            dataFirstType: dataFirstType,
            dataSecondType: dataSecondType,
            dataThirdType: dataThirdType,
            submitTime:submitTime,
            bookshelfName: bookshelfName,
            bookshelfLayer: bookshelfLayer,
            arrayLocation: arrayLocation,
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#dataGrid').DataTable().ajax.reload();
            }
        })


    }

</script>


