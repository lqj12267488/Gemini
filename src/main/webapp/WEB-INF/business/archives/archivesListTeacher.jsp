<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2018/1/24
  Time: 10:02
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
                            <div class="col-md-1 tar" style="width: 90px">
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
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addArchives()">
                            新增
                        </button>
                        <button type="button" class="btn btn-info btn-clean" onclick="showArchivesCode()">显示档案编码
                        </button>
                        <%--<button type="button" class="btn btn-default btn-clean" onclick="alldel()">--%>
                        <%--批量删除--%>
                        <%--</button>--%>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="listGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                            <%--<thead>--%>
                            <%--<tr>--%>
                            <%--&lt;%&ndash;<th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</th>&ndash;%&gt;--%>
                            <%--<th>id</th>--%>
                            <%--<th>time</th>--%>
                            <%--<th width="10%">创建部门</th>--%>
                            <%--<th width="10%">创建人</th>--%>
                            <%--<th width="10%">档案编码</th>--%>
                            <%--<th width="7%">一级类别</th>--%>
                            <%--<th width="7%">二级类别</th>--%>
                            <%--<th width="7%">档案类型</th>--%>
                            <%--<th width="7%">学校类别</th>--%>
                            <%--<th width="7%">档案名称</th>--%>
                            <%--<th width="7%">档案状态</th>--%>
                            <%--<th width="7%">附件数量</th>--%>
                            <%--<th width="7%">文件形成时间</th>--%>
                            <%--<th width="7%">备注</th>--%>
                            <%--<th width="7%">操作</th>--%>
                            <%--</tr>--%>
                            <%--</thead>--%>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var listTable;
    var flag="0";
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
                "url": '<%=request.getContextPath()%>/archives/getTeacherArchivesList',
            },
            "bAutoWidth": false,//自动宽度。
            "destroy": true,
            "columns": [
                {"data": "archivesId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "createDept", "title": "创建部门","width":"10%"},
                {"data": "creator", "title": "创建人","width":"7%"},
                {"data": "archivesCode", "title": "档案编码", "visible": false},
                {
                    "width": "7%", "data": "oneLevel", "title": "一级类别",
                    "render": function (data, type, row, meta) {
                        if(row.oneLevel!=null || row.oneLevel!=undefined || row.oneLevel!=0){
                            var tt=row.oneLevel +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                // {"data": "twoLevel", "title": "二级类别","width":"7%"},
                {
                    "width": "7%", "data": "twoLevel", "title": "二级类别",
                    "render": function (data, type, row, meta) {
                        if(row.twoLevel!=null || row.twoLevel!=undefined || row.twoLevel!=0){
                            var tt=row.twoLevel +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                {"data": "fileType", "title": "档案类型","width":"7%"},
                {"data": "schoolType", "title": "学校类别","width":"8%"},
                {
                    "width": "10%", "data": "archivesName", "title": "档案名称",
                    "render": function (data, type, row, meta) {
                        if(row.archivesName!=null || row.archivesName!=undefined || row.archivesName!=0){
                            var tt=row.archivesName +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                {"data": "state", "title": "档案状态","width":"10%"},
                {"data": "fileNum", "title": "附件数量","width":"7%"},
                {"data": "formatTime", "title": "文件形成时间","width":"10%"},
                // {"data": "remark", "title": "备注","width":"10%"},
                {
                    "width": "10%", "data": "remark", "title": "备注",
                    "render": function (data, type, row, meta) {
                        if(row.remark!=null && row.remark!=undefined && row.remark!=0 && row.remark!=""){
                            var tt=row.remark +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }else {
                            return "<span title=''>" + "" + "</span>";
                        }
                    }
                },
                {
                    "width": "7%", "title": "操作", "render": function () {
                        return "<a id='update' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delete' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='submit' class='icon-ok' title='提交审查'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='preview' class='icon-eye-open' title='查看附件'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='request' class='icon-upload-alt' title='申请变更'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var archivesId = data.archivesId;
            var archivesName = encodeURI(encodeURI(data.archivesName));
            var archivesCode = data.archivesCode;
            var requestFlag = data.requestFlag;
            var fileNum = data.fileNum;
            //修改
            if (this.id == "update") {
                if (requestFlag == "6" || requestFlag == "2" || requestFlag == "4" || requestFlag == "8"|| requestFlag == "7") {
                    $("#dialog").load("<%=request.getContextPath()%>/archives/editArchives?archivesId=" + archivesId + "&role=teacher");
                    $("#dialog").modal("show");
                } else {
                    swal({title: "档案已提交，请在变更申请通过后操作！", type: "info"});
                    return;
                }
            }
            //上传附件
            if (this.id == "upload") {
                if (requestFlag == "6" || requestFlag == "2" || requestFlag == null) {
                    $("#dialog").load("<%=request.getContextPath()%>/archives/uploadFiles?archivesId=" + archivesId +
                        "&archivesName=" + archivesName + "&archivesCode=" + archivesCode + "&role=teacher");
                    $("#dialog").modal("show");
                } else {
                    swal({title: "档案已提交，请在变更申请通过后操作！", type: "info"});
                    return;
                }
            }
            //删除
            if (this.id == "delete") {
                if (requestFlag == "6" || requestFlag == "2" || requestFlag == "8"|| requestFlag == "7") {
                    swal({
                        title: "确定将该档案移入回收站?",
                        type: "info",
                        showCancelButton: true,
                        cancelButtonText: "取消",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确定",
                        closeOnConfirm: false
                    }, function () {
                        $.get("<%=request.getContextPath()%>/archives/updateArchivesDelStateById?archivesId=" + archivesId +
                            "&archivesName=" + archivesName + "&archivesCode=" + archivesCode + "&delState=1", function (msg) {
                            if (msg.status == 1) {
                                swal({title: msg.msg, type: "success"});
                                $('#listGrid').DataTable().ajax.reload();
                            }
                        })
                    })
                } else {
                    swal({title: "档案已提交，请在变更申请通过后操作！", type: "info"});
                    return;
                }
            }
            if (this.id == "submit") {
                if (requestFlag != "6" && requestFlag != null && requestFlag != "2" && requestFlag != "8" && requestFlag != "4" && requestFlag != "7") {
                    swal({title: "该档案已提交", type: "info"});
                    return;
                } else {
                    if (fileNum == 0) {
                        swal({title: "请上传附件！", type: "info"});
                        return;
                    } else {
                        swal({
                            title: "您确定提交档案?",
                            type: "warning",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "#green",
                            confirmButtonText: "提交",
                            closeOnConfirm: false
                        }, function () {
                            $.get("<%=request.getContextPath()%>/archives/saveArchivesRequest?requestFlag=0&archivesId=" +
                                archivesId + "&archivesName=" + archivesName + "&archivesCode=" + archivesCode, function (msg) {
                                if (msg.status == 1) {
                                    swal({title: msg.msg, type: "success"});
                                    $('#listGrid').DataTable().ajax.reload();
                                }
                            })
                        })
                    }

                }
            }
            if (this.id == "request") {
                if (requestFlag == "6") {
                    swal({title: "该档案的尚未提交", type: "info"});
                    return;
                } else if (requestFlag == "1") {
                    swal({title: "该档案的变更申请正在审核", type: "info"});
                    return;
                }
                else if (requestFlag == "2") {
                    swal({title: "已通过审核，不需要再次提交申请", type: "info"});
                    return;
                } else {
                    $("#dialog").load("<%=request.getContextPath()%>/archives/archivesEditRequest?archivesId=" + archivesId +
                        "&archivesName=" + archivesName + "&archivesCode=" + archivesCode);
                    $("#dialog").modal("show");
                }
            }
            if (this.id == "preview") {
                $("#dialog").load("<%=request.getContextPath()%>/archives/preview?archivesId=" + archivesId + "&role=leader");
                $("#dialog").modal("show");
            }

        });
    })

    /*添加函数*/
    function addArchives() {
        $("#dialog").load("<%=request.getContextPath()%>/archives/editArchives?ptyh=${ptyh}");
        $("#dialog").modal("show");
    }

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
                title: "确定移入回收站?",
                type: "info",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "确定",
                closeOnConfirm: false
            }, function () {
                $.post("<%=request.getContextPath()%>/archives/archivesAllrecycleBin", {
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
                id: "distinct TYPE_ID",
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
        listTable.ajax.url("<%=request.getContextPath()%>/archives/getTeacherArchivesList?oneLevel=" + oneLevel +
            "&twoLevel=" + twoLevel + "&fileType=" + fileType + "&yearCode=" + selYear + "&schoolType=" + schoolType +
            "&requestFlag=" + selstate + "&archivesCode=" + arcode + "&archivesName=" + arname + "&formatTimeStart=" + formatTimeStart + "&formatTimeEnd=" + formatTimeEnd).load();
    }

    function showArchivesCode() {
        if (flag == "0") {
            flag="1";
            document.getElementById("listGrid").style.whiteSpace = 'nowrap';
            listTable = $("#listGrid").DataTable({
                "ajax": {
                    "type": "post",
                    "url": '<%=request.getContextPath()%>/archives/getTeacherArchivesList',
                },
                "destroy": true,
                "columns": [
                    {"data": "archivesId", "visible": false},
                    {"data": "createTime", "visible": false},
                    {"data": "createDept", "title": "创建部门"},
                    {"data": "creator", "title": "创建人"},
                    {"data": "archivesCode", "title": "档案编码"},
                    {
                        "width": "7%", "data": "oneLevel", "title": "一级类别",
                        "render": function (data, type, row, meta) {
                            if(row.oneLevel!=null || row.oneLevel!=undefined || row.oneLevel!=0){
                                var tt=row.oneLevel +"";
                                return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                            }
                        }
                    },
                    {"data": "twoLevel", "title": "二级类别"},
                    {"data": "fileType", "title": "档案类型"},
                    {"data": "schoolType", "title": "学校类别"},
                    // {"data": "archivesName", "title": "档案名称"},
                    {"width": "10%", "data": "archivesName", "title": "档案名称"},
                    {"data": "state", "title": "档案状态"},
                    {"data": "fileNum", "title": "附件数量"},
                    {"data": "formatTime", "title": "文件形成时间"},
                    {"data": "remark", "title": "备注"},
                    {
                        "width": "7%", "title": "操作", "render": function () {
                            return "<a id='update' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='upload' class='icon-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='delete' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='submit' class='icon-ok' title='提交审查'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='preview' class='icon-eye-open' title='查看附件'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='request' class='icon-upload-alt' title='申请变更'></a>";
                        }
                    }
                ],
                'order': [1, 'desc'],
                "dom": 'rtlip',
                language: language
            });
            listTable.on('click', 'tr a', function () {
                var data = listTable.row($(this).parent()).data();
                var archivesId = data.archivesId;
                var archivesName = encodeURI(encodeURI(data.archivesName));
                var archivesCode = data.archivesCode;
                var requestFlag = data.requestFlag;
                var fileNum = data.fileNum;
                //修改
                if (this.id == "update") {
                    if (requestFlag == "6" || requestFlag == "2" || requestFlag == "4" || requestFlag == "7") {
                        $("#dialog").load("<%=request.getContextPath()%>/archives/editArchives?archivesId=" + archivesId + "&role=teacher");
                        $("#dialog").modal("show");
                    } else {
                        swal({title: "档案已提交，请在变更申请通过后操作！", type: "info"});
                        return;
                    }
                }
                //上传附件
                if (this.id == "upload") {
                    if (requestFlag == "6" || requestFlag == "2" || requestFlag == null) {
                        $("#dialog").load("<%=request.getContextPath()%>/archives/uploadFiles?archivesId=" + archivesId +
                            "&archivesName=" + archivesName + "&archivesCode=" + archivesCode + "&role=teacher");
                        $("#dialog").modal("show");
                    } else {
                        swal({title: "档案已提交，请在变更申请通过后操作！", type: "info"});
                        return;
                    }
                }
                //删除
                if (this.id == "delete") {
                    if (requestFlag == "6" || requestFlag == "2") {
                        swal({
                            title: "确定将该档案移入回收站?",
                            type: "info",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "确定",
                            closeOnConfirm: false
                        }, function () {
                            $.get("<%=request.getContextPath()%>/archives/updateArchivesDelStateById?archivesId=" + archivesId +
                                "&archivesName=" + archivesName + "&archivesCode=" + archivesCode + "&delState=1", function (msg) {
                                if (msg.status == 1) {
                                    swal({title: msg.msg, type: "success"});
                                    $('#listGrid').DataTable().ajax.reload();
                                }
                            })
                        })
                    } else {
                        swal({title: "档案已提交，请在变更申请通过后操作！", type: "info"});
                        return;
                    }
                }
                if (this.id == "submit") {
                    if (requestFlag != "6" && requestFlag != null && requestFlag != "2" && requestFlag != "4" && requestFlag != "7") {
                        swal({title: "该档案已提交", type: "info"});
                        return;
                    } else {
                        if (fileNum == 0) {
                            swal({title: "请上传附件！", type: "info"});
                            return;
                        } else {
                            swal({
                                title: "您确定提交档案?",
                                type: "warning",
                                showCancelButton: true,
                                cancelButtonText: "取消",
                                confirmButtonColor: "#green",
                                confirmButtonText: "提交",
                                closeOnConfirm: false
                            }, function () {
                                $.get("<%=request.getContextPath()%>/archives/saveArchivesRequest?requestFlag=0&archivesId=" +
                                    archivesId + "&archivesName=" + archivesName + "&archivesCode=" + archivesCode, function (msg) {
                                    if (msg.status == 1) {
                                        swal({title: msg.msg, type: "success"});
                                        $('#listGrid').DataTable().ajax.reload();
                                    }
                                })
                            })
                        }

                    }
                }
                if (this.id == "request") {
                    if (requestFlag == "6") {
                        swal({title: "该档案尚未提交", type: "info"});
                        return;
                    } else if (requestFlag == "1") {
                        swal({title: "该档案的变更申请正在审核", type: "info"});
                        return;
                    }
                    else if (requestFlag == "2") {
                        swal({title: "已通过审核，不需要再次提交申请", type: "info"});
                        return;
                    } else {
                        $("#dialog").load("<%=request.getContextPath()%>/archives/archivesEditRequest?archivesId=" + archivesId +
                            "&archivesName=" + archivesName + "&archivesCode=" + archivesCode);
                        $("#dialog").modal("show");
                    }
                }
                if (this.id == "preview") {
                    $("#dialog").load("<%=request.getContextPath()%>/archives/preview?archivesId=" + archivesId + "&role=leader");
                    $("#dialog").modal("show");
                }

            });
        }else {
            $("#right").load("<%=request.getContextPath()%>/archives/archivesListTeacher");
        }
    }
</script>
