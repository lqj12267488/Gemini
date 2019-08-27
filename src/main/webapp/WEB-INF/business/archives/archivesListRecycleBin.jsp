<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2018/1/26
  Time: 14:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar" style="width: 90px">
                                一级类别：
                            </div>
                            <div class="col-md-2">
                                <select id="selOne"/>
                            </div>
                            <div class="col-md-1 tar" style="width: 90px">
                                二级类别：
                            </div>
                            <div class="col-md-2">
                                <select id="selTwo"/>
                            </div>
                            <div class="col-md-1 tar" style="width: 90px">
                                档案类型：
                            </div>
                            <div class="col-md-2">
                                <select id="selType"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar" style="width: 90px">
                                申请部门：
                            </div>
                            <div class="col-md-2">
                                <input id="selDept"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar" style="width: 90px">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="selPerson"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar" style="width: 90px">
                                年份：
                            </div>
                            <div class="col-md-2">
                                <select id="selYear"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">
                                    查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="listGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var listTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "TYPE_ID",
                text: "TYPE_NAME",
                tableName: "DZDA_TYPE",
                where: "WHERE PARENT_TYPE_ID='0'",
                orderby: "ORDER BY TYPE_ID"
            }
            , function (data) {
                addOption(data, 'selOne');
            });
        $("#selTwo").append("<option value='' selected>请选择</option>");
        $("#selOne").change(function () {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: "TYPE_ID",
                    text: "TYPE_NAME",
                    tableName: "DZDA_TYPE",
                    where: "WHERE PARENT_TYPE_ID ='" + $("#selOne").val() + "'",
                    orderby: "ORDER BY TYPE_ID"
                }
                , function (data) {
                    addOption(data, 'selTwo');
                });
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DALX", function (data) {
            addOption(data, 'selType');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGSS", function (data) {
            addOption(data, 'selSchool');
        });
        $.get("<%=request.getContextPath()%>/archives/selectDept", function (data) {
            $("#selDept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#selDept").val(ui.item.label);
                    $("#selDept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/archives/getPerson", function (data) {
            $("#selPerson").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#selPerson").val(ui.item.label);
                    $("#selPerson").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        search();
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var archivesId = data.archivesId;
            //上传附件
            if (this.id == "reply") {
                swal({
                    title: "确定将该档案恢复至初始列表当中?",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "恢复",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/archives/updateArchivesDelStateById?archivesId=" + archivesId + "&delState=0", function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"});
                            $('#listGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
            if (this.id == "delete") {
                swal({
                    title: "确定将该档案彻底删除?",
                    text:"删除的记录和文件不可恢复",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "恢复",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/archives/deleteArchivesById?archivesId=" + archivesId, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"});
                            $('#listGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
        });
    })

    /*清空函数*/
    function searchclear() {
        $("#selOne").val("");
        $("#selTwo").val("");
        $("#selType").val("");
        $("#selYear").val("");
        $("#selDept").val("");
        $("#selPerson").val("");
        search();
    }

    /*查询函数*/
    function search() {
        var oneLevel = $("#selOne").val();
        var twoLevel = $("#selTwo").val();
        var fileType = $("#selType").val();
        var yearCode = $("#selYear").val();
        var deptName = $("#selDept").val();
        var personName = $("#selPerson").val();
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/archives/getArchivesRecycleBinList',
                "data": {
                    oneLevel: oneLevel,
                    twoLevel: twoLevel,
                    fileType: fileType,
                    yearCode: yearCode,
                    deptName: deptName,
                    personName: personName
                }
            },
            "destroy": true,
            "columns": [
                {"data": "archivesId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "createDept", "title": "创建部门"},
                {"width": "10%", "data": "creator", "title": "创建人"},
                {"width": "10%", "data": "archivesCode", "title": "档案编码"},
                {"width": "10%", "data": "oneLevel", "title": "一级类别"},
                {"width": "10%", "data": "twoLevel", "title": "二级类别"},
                {"width": "10%", "data": "fileType", "title": "档案类型"},
                {"width": "10%", "data": "remark", "title": "档案说明"},
                {
                    "width": "7%", "title": "操作", "render": function () {
                        return "<a id='reply' class='icon-reply' title='恢复'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delete' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>

