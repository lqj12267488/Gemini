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
                                年份：
                            </div>
                            <div class="col-md-2">
                                <select id="selYear"/>
                            </div>
                            <div class="col-md-1 tar" style="width: 90px">
                                学校类别：
                            </div>
                            <div class="col-md-2">
                                <select id="selschoolType"/>
                            </div>
                            <div class="col-md-1 tar" style="width: 90px">
                                档案状态：
                            </div>
                            <div class="col-md-2">
                                <select id="selstate"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                文件形成时间(开始)
                            </div>
                            <div class="col-md-2">
                                <input id="formatTimeStart" type="date"
                                       class="validate[required,maxSize[20]] form-control"
                                />
                            </div>
                            <div class="col-md-1 tar" style="width: 90px">
                                档案名称：
                            </div>
                            <div class="col-md-2">
                                <input id="arname" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar" style="width: 90px">
                                档案编码：
                            </div>
                            <div class="col-md-2">
                                <input id="arcode" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar" style="width: 90px">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                文件形成时间(結束)
                            </div>
                            <div class="col-md-2">
                                <input id="formatTimeEnd" type="date"
                                       class="validate[required,maxSize[20]] form-control"
                                />
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
                        <%--<div class="form-row">--%>
                        <%--<div class="col-md-2">--%>
                        <%--<button type="button" class="btn btn-default btn-clean" onclick="search()">--%>
                        <%--查询--%>
                        <%--</button>--%>
                        <%--<button type="button" class="btn btn-default btn-clean" onclick="searchclear()">--%>
                        <%--清空--%>
                        <%--</button>--%>
                        <%--</div>--%>
                        <%--</div>--%>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="alldel()">
                            批量删除
                        </button>
                        <button type="button" class="btn btn-info btn-clean" onclick="showArchivesCode()">显示档案编码
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="listGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                            <thead>
                            <tr>
                                <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                                </th>
                                <th>id</th>
                                <th>time</th>
                                <th width="10%">创建部门</th>
                                <th width="7%">创建人</th>
                                <th width="10%">档案编码</th>
                                <th width="7%">一级类别</th>
                                <th width="7%">二级类别</th>
                                <th width="7%">档案类型</th>
                                <th width="7%">学校类别</th>
                                <th width="7%">档案名称</th>
                                <th width="7%">附件数量</th>
                                <th width="7%">文件形成时间</th>
                                <th width="7%">操作</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<script>
    var listTable;
    var flag = "0";
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
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "distinct TYPE_ID",
                text: "TYPE_NAME",
                tableName: "DZDA_TYPE",
                where: "WHERE PARENT_TYPE_ID !='0'",
                orderby: "ORDER BY TYPE_ID"
            }
            , function (data) {
                addOption(data, 'selTwo');
            });
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'selYear');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXLB", function (data) {
            addOption(data, 'selschoolType');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DAZT", function (data) {
            addOption(data, 'selstate');
        });
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/archives/getArchivesRecycleBinList',
            },
            "bAutoWidth": false,//自动宽度。
            "destroy": true,
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='" + row.archivesId + "'/>";
                    }
                },
                {"data": "archivesId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "createDept","width":"10%"},
                {"data": "creator","width":"10%"},
                {"data": "archivesCode", "visible": false},
                {
                    "width": "7%", "data": "oneLevel", "title": "一级类别",
                    "render": function (data, type, row, meta) {
                        if(row.oneLevel!=null || row.oneLevel!=undefined || row.oneLevel!=0){
                            var tt=row.oneLevel +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                {
                    "width": "7%", "data": "twoLevel", "title": "二级类别",
                    "render": function (data, type, row, meta) {
                        if(row.twoLevel!=null || row.twoLevel!=undefined || row.twoLevel!=0){
                            var tt=row.twoLevel +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                {"data": "fileType","width":"7%"},
                {"data": "schoolType","width":"7%"},
                {
                    "width": "10%", "data": "archivesName", "title": "档案名称",
                    "render": function (data, type, row, meta) {
                        if(row.archivesName!=null || row.archivesName!=undefined || row.archivesName!=0){
                            var tt=row.archivesName +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                {"data": "fileNum","width":"7%"},
                {"data": "formatTime","width":"7%"},
                {
                    "width": "7%", "render": function () {
                        return "<a id='reply' class='icon-reply' title='恢复'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delete' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order': [2, 'desc'],
            "dom": 'rtlip',
            language: language
        });
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var archivesId = data.archivesId;
            var archivesName = encodeURI(encodeURI(data.archivesName));
            var archivesCode = data.archivesCode;
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
                    $.get("<%=request.getContextPath()%>/archives/updateArchivesDelStateById?archivesId=" + archivesId +
                        "&archivesName=" + archivesName + "&archivesCode=" + archivesCode + "&delState=0", function (msg) {
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
                    text: "删除的记录和文件不可恢复",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确定",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/archives/deleteArchivesById?archivesId=" + archivesId +
                        "&archivesName=" + archivesName + "&archivesCode=" + archivesCode, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"});
                            $('#listGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
        });
    })

    //全选
    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }

    //批量删除
    function alldel() {
        var chk_value = "";
        if ($('input[name="checkbox"]:checked').length > 0) {
            $('input[name="checkbox"]:checked').each(function () {
                chk_value += $(this).val() + ",";
            });
            swal({
                title: "确定彻底删除?",
                text: "删除的记录和文件不可恢复",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "确定",
                closeOnConfirm: false
            }, function () {
                $.post("<%=request.getContextPath()%>/archives/archivesAlldel", {
                    ids: chk_value,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "info"
                        });
                        $('#listGrid').DataTable().ajax.reload();
                    }
                });
            })
        } else {
            swal({
                title: "请选择电子档案!",
                type: "info"
            });
        }
    }

    /*清空函数*/
    function searchclear() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "TYPE_ID",
                text: "TYPE_NAME",
                tableName: "DZDA_TYPE",
                where: "WHERE PARENT_TYPE_ID !='0'",
                orderby: "ORDER BY TYPE_ID"
            }
            , function (data) {
                addOption(data, 'selTwo');
            });
        $("#selOne").val("");
        $("#selTwo").val("");
        $("#selType").val("");
        $("#selschoolType").val("");
        $("#selYear").val("");
        $("#selstate").val("");
        $("#arcode").val("");
        $("#arname").val("");
        $("#formatTimeStart").val("");
        $("#formatTimeEnd").val("");
        search();
    }

    /*查询函数*/
    function search() {
        var oneLevel = $("#selOne").val();
        var twoLevel = $("#selTwo").val();
        var fileType = $("#selType").val();
        var schoolType = $("#selschoolType").val();
        var selYear = $("#selYear").val();
        var selstate = $("#selstate").val();
        var arcode = $("#arcode").val();
        var arname = $("#arname").val();
        var formatTimeStart = $("#formatTimeStart").val();
        var formatTimeEnd = $("#formatTimeEnd").val();
        listTable.ajax.url("<%=request.getContextPath()%>/archives/getArchivesRecycleBinList?oneLevel=" + oneLevel +
            "&twoLevel=" + twoLevel + "&fileType=" + fileType + "&yearCode=" + selYear + "&schoolType=" + schoolType +
            "&requestFlag=" + selstate + "&archivesCode=" + arcode + "&archivesName=" + arname +
            "&formatTimeStart=" + formatTimeStart + "&formatTimeEnd=" + formatTimeEnd).load();
    }

    function showArchivesCode() {
        if (flag == "0") {
            flag = "1";
            document.getElementById("listGrid").style.whiteSpace = 'nowrap';
            // document.getElementById("listGrid").style.tableLayout='fixed';
            listTable = $("#listGrid").DataTable({
                "ajax": {
                    "type": "post",
                    "url": '<%=request.getContextPath()%>/archives/getArchivesRecycleBinList',
                },
                "destroy": true,
                "columns": [
                    {
                        "render": function (data, type, row) {
                            return "<div style='width: 20px;height: 20px;'><input type='checkbox' name='checkbox' value='" + row.archivesId + "'/></div>";
                        }
                    },
                    {"data": "archivesId", "visible": false},
                    {"data": "createTime", "visible": false},
                    {"data": "createDept"},
                    {"data": "creator"},
                    {"data": "archivesCode"},
                    {
                        "width": "7%", "data": "oneLevel", "title": "一级类别",
                        "render": function (data, type, row, meta) {
                            if(row.oneLevel!=null || row.oneLevel!=undefined || row.oneLevel!=0){
                                var tt=row.oneLevel +"";
                                return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                            }
                        }
                    },
                    {"data": "twoLevel"},
                    {"data": "fileType"},
                    {"data": "schoolType"},
                    {"width": "10%", "data": "archivesName", "title": "档案名称"},
                    {"data": "fileNum"},
                    {"data": "formatTime"},
                    {
                        "width": "7%", "render": function () {
                            return "<a id='reply' class='icon-reply' title='恢复'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='delete' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                        }
                    }
                ],
                'order': [2, 'desc'],
                "dom": 'rtlip',
                language: language
            });
            listTable.on('click', 'tr a', function () {
                var data = listTable.row($(this).parent()).data();
                var archivesId = data.archivesId;
                var archivesName = encodeURI(encodeURI(data.archivesName));
                var archivesCode = data.archivesCode;
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
                        $.get("<%=request.getContextPath()%>/archives/updateArchivesDelStateById?archivesId=" + archivesId +
                            "&archivesName=" + archivesName + "&archivesCode=" + archivesCode + "&delState=0", function (msg) {
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
                        text: "删除的记录和文件不可恢复",
                        type: "warning",
                        showCancelButton: true,
                        cancelButtonText: "取消",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确定",
                        closeOnConfirm: false
                    }, function () {
                        $.get("<%=request.getContextPath()%>/archives/deleteArchivesById?archivesId=" + archivesId +
                            "&archivesName=" + archivesName + "&archivesCode=" + archivesCode, function (msg) {
                            if (msg.status == 1) {
                                swal({title: msg.msg, type: "success"});
                                $('#listGrid').DataTable().ajax.reload();
                            }
                        })
                    })
                }
            });
        } else {
            $("#right").load("<%=request.getContextPath()%>/archives/recycleBinArchivesList");
        }
    }
</script>

