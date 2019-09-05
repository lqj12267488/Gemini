<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2018/1/25
  Time: 16:24
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
                                创建人：
                            </div>
                            <div class="col-md-2">
                                <input id="selPerson" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
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
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addArchives()">
                            新增
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
                                <%--<th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>--%>
                                <%--</th>--%>
                                <th>id</th>
                                <th>time</th>
                                <th>pid</th>
                                <th width="10%">创建部门</th>
                                <th width="7%">创建人</th>
                                <th width="10%">档案编码</th>
                                <th width="7%">一级类别</th>
                                <th width="7%">二级类别</th>
                                <th width="7%">档案类型</th>
                                <th width="7%">学校类别</th>
                                <th width="7%">档案名称</th>
                                <th width="7%">档案状态</th>
                                <th width="7%">附件数量</th>
                                <th width="7%">文件形成时间</th>
                                <th width="7%">备注</th>
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
<script>
    var listTable;
    var flag="0";
    var login = '${login}';
    $.get("<%=request.getContextPath()%>/archives/getRequester", function (data) {
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
                id: "TYPE_ID",
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DAZT&where=(dic_code = '5' or dic_code='6')", function (data) {
            addOption(data, 'selstate');
        });
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/archives/getSchLeaderArchivesList',
            },
            "bAutoWidth": false,//自动宽度。
            "destroy": true,
            "columns": [
                {"data": "archivesId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "personId", "visible": false},
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
                {"data": "fileType","width":"8%"},
                {"data": "schoolType","width":"10%"},
                {
                    "width": "10%", "data": "archivesName", "title": "档案名称",
                    "render": function (data, type, row, meta) {
                        if(row.archivesName!=null || row.archivesName!=undefined || row.archivesName!=0){
                            var tt=row.archivesName +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                {"data": "state","width":"7%"},
                {"data": "fileNum","width":"7%"},
                {"data": "formatTime","width":"10%"},
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
                    "width": "7%", "title": "操作", "render":
                        function () {
                            return "<a id='update' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='upload' class='icon-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='delete' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='preview' class='icon-eye-open' title='查看附件'></a>&nbsp;&nbsp;&nbsp;" +
                                "<a id='submit' class='icon-ok' title='提交'></a>&nbsp;&nbsp;&nbsp;";
                            /*  "<a id='audit' class='icon-file-text-alt' title='电子档案审查'></a>";*/
                        }
                }
            ],
            'order': [[1, 'desc']],
            "dom": 'rtlip',
            language: language
        });
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var archivesId = data.archivesId;
            var archivesName = encodeURI(encodeURI(data.archivesName));
            var archivesCode = data.archivesCode;
            var requestFlag = data.requestFlag;
            var creator = data.creator;
            var fileNum = data.fileNum;
            var personId = data.personId;
            //修改
            if (this.id == "update") {
                $.post("<%=request.getContextPath()%>/archives/checkArchivesPerson", {
                    creator: creator,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "info"
                        });
                    } else {
                        $("#dialog").load("<%=request.getContextPath()%>/archives/editArchives?archivesId=" + archivesId + "&role=leader");
                        $("#dialog").modal("show");
                    }
                });
            }
            //上传附件
            if (this.id == "upload") {
                $.post("<%=request.getContextPath()%>/archives/checkArchivesPerson", {
                    creator: creator,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "info"
                        });
                    } else {
                        $("#dialog").load("<%=request.getContextPath()%>/archives/uploadFiles?archivesId=" + archivesId +
                            "&archivesName=" + archivesName + "&archivesCode=" + archivesCode + "&delState=1&role=leader");
                        $("#dialog").modal("show");
                    }
                });
            }
            //删除
            if (this.id == "delete") {
                $.post("<%=request.getContextPath()%>/archives/checkArchivesPerson", {
                    creator: creator,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "info"
                        });
                    } else {
                        swal({
                            title: "确定将该档案移入回收站?",
                            type: "info",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "确定",
                            closeOnConfirm: false
                        }, function () {
                            $.get("<%=request.getContextPath()%>/archives/updateValidFlag?archivesId=" + archivesId +
                                "&archivesName=" + archivesName + "&archivesCode=" + archivesCode, function (msg) {
                                if (msg.status == 1) {
                                    swal({title: msg.msg, type: "success"});
                                    $('#listGrid').DataTable().ajax.reload();
                                }
                            })
                        })
                    }
                });
            }
            if (this.id == "submit") {
                if (requestFlag != null && requestFlag != '7' && requestFlag != '8' && requestFlag != "4" && requestFlag != "6") {
                    swal({title: "该档案已提交", type: "info"});
                    return;
                } else {
                    if (personId != login) {
                        swal({title: "只能提交自己创建的档案！", type: "info"});
                    }
                    else {
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
                                $.get("<%=request.getContextPath()%>/archives/saveArchivesRequest?requestFlag=5&archivesId=" +
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
            }
            if (this.id == "audit") {
                if (requestFlag == "0" || requestFlag == "0") {
                    $("#dialog").load("<%=request.getContextPath()%>/archives/archivesAudit?archivesId=" + archivesId);
                    $("#dialog").modal("show");
                } else if (requestFlag == "4" || requestFlag == "5") {
                    swal({title: "您已经审查过了！", type: "info"});
                }
                else {
                    swal({title: "该档案未提交修改申请！", type: "info"});
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
        $("#dialog").load("<%=request.getContextPath()%>/archives/editArchivesManager");
        $("#dialog").modal("show");
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
        $("#selPerson").val("");
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
        var selPerson = $("#selPerson").val();
        var formatTimeStart = $("#formatTimeStart").val();
        var formatTimeEnd = $("#formatTimeEnd").val();
        arname = encodeURI(encodeURI(arname));
        selPerson = encodeURI(encodeURI(selPerson));
        listTable.ajax.url("<%=request.getContextPath()%>/archives/getSchLeaderArchivesList?oneLevel=" + oneLevel +
            "&twoLevel=" + twoLevel + "&fileType=" + fileType + "&yearCode=" + selYear + "&personName=" + selPerson +
            "&schoolType=" + schoolType + "&requestFlag=" + selstate + "&archivesCode=" + arcode + "&archivesName=" + arname + "&formatTimeStart=" + formatTimeStart + "&formatTimeEnd=" + formatTimeEnd).load();
    }

    //全选
    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }

    //批量授权
    function allEmpRole() {
        var chk_value = "'";
        if ($('input[name="checkbox"]:checked').length > 0) {
            $('input[name="checkbox"]:checked').each(function () {
                chk_value += $(this).val() + "','";
            });
            $("#dialog").load("<%=request.getContextPath()%>/archives/archivesAllPerRole?ids=" + chk_value + "&flag=1");
            $("#dialog").modal("show");
            $('#listGrid').DataTable().ajax.reload();
        } else {
            swal({
                title: "请选择电子档案!",
                type: "info"
            });
        }

    }

    //批量收回
    function roleTakeback() {
        var chk_value = "";
        if ($('input[name="checkbox"]:checked').length > 0) {
            $('input[name="checkbox"]:checked').each(function () {
                chk_value += $(this).val() + ",";
            });
            $.post("<%=request.getContextPath()%>/archives/archivesRoleTakeBack", {
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
        } else {
            swal({
                title: "请选择电子档案!",
                type: "info"
            });
        }

    }

    function showArchivesCode() {
        if (flag == "0") {
            flag = "1";
            document.getElementById("listGrid").style.whiteSpace = 'nowrap';
            listTable = $("#listGrid").DataTable({
                "ajax": {
                    "type": "post",
                    "url": '<%=request.getContextPath()%>/archives/getSchLeaderArchivesList',
                },
                "destroy": true,
                "columns": [
                    {"data": "archivesId", "visible": false},
                    {"data": "createTime", "visible": false},
                    {"data": "personId", "visible": false},
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
                    {"data": "state"},
                    {"data": "fileNum"},
                    {"data": "formatTime"},
                    {"data": "remark"},
                    {
                        "width": "7%", "title": "操作", "render":
                            function () {
                                return "<a id='update' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                                    "<a id='upload' class='icon-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;" +
                                    "<a id='delete' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                                    "<a id='preview' class='icon-eye-open' title='查看附件'></a>&nbsp;&nbsp;&nbsp;" +
                                    "<a id='submit' class='icon-ok' title='提交'></a>&nbsp;&nbsp;&nbsp;";
                                /*  "<a id='audit' class='icon-file-text-alt' title='电子档案审查'></a>";*/
                            }
                    }
                ],
                'order': [[1, 'desc']],
                "dom": 'rtlip',
                language: language
            });
            listTable.on('click', 'tr a', function () {
                var data = listTable.row($(this).parent()).data();
                var archivesId = data.archivesId;
                var archivesName = encodeURI(encodeURI(data.archivesName));
                var archivesCode = data.archivesCode;
                var requestFlag = data.requestFlag;
                var creator = data.creator;
                var fileNum = data.fileNum;
                var personId = data.personId;
                //修改
                if (this.id == "update") {
                    $.post("<%=request.getContextPath()%>/archives/checkArchivesPerson", {
                        creator: creator,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "info"
                            });
                        } else {
                            $("#dialog").load("<%=request.getContextPath()%>/archives/editArchives?archivesId=" + archivesId + "&role=leader");
                            $("#dialog").modal("show");
                        }
                    });
                }
                //上传附件
                if (this.id == "upload") {
                    $.post("<%=request.getContextPath()%>/archives/checkArchivesPerson", {
                        creator: creator,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "info"
                            });
                        } else {
                            $("#dialog").load("<%=request.getContextPath()%>/archives/uploadFiles?archivesId=" + archivesId +
                                "&archivesName=" + archivesName + "&archivesCode=" + archivesCode + "&delState=1&role=leader");
                            $("#dialog").modal("show");
                        }
                    });
                }
                //删除
                if (this.id == "delete") {
                    $.post("<%=request.getContextPath()%>/archives/checkArchivesPerson", {
                        creator: creator,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "info"
                            });
                        } else {
                            swal({
                                title: "确定将该档案移入回收站?",
                                type: "info",
                                showCancelButton: true,
                                cancelButtonText: "取消",
                                confirmButtonColor: "#DD6B55",
                                confirmButtonText: "确定",
                                closeOnConfirm: false
                            }, function () {
                                $.get("<%=request.getContextPath()%>/archives/updateValidFlag?archivesId=" + archivesId +
                                    "&archivesName=" + archivesName + "&archivesCode=" + archivesCode, function (msg) {
                                    if (msg.status == 1) {
                                        swal({title: msg.msg, type: "success"});
                                        $('#listGrid').DataTable().ajax.reload();
                                    }
                                })
                            })
                        }
                    });
                }
                if (this.id == "submit") {
                    if (requestFlag != null && requestFlag != '7' && requestFlag != '8' && requestFlag != "4" && requestFlag != "6") {
                        swal({title: "该档案已提交", type: "info"});
                        return;
                    } else {
                        if (personId != login) {
                            swal({title: "只能提交自己创建的档案！", type: "info"});
                        }
                        else {
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
                                    $.get("<%=request.getContextPath()%>/archives/saveArchivesRequest?requestFlag=5&archivesId=" +
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
                }
                if (this.id == "audit") {
                    if (requestFlag == "0" || requestFlag == "0") {
                        $("#dialog").load("<%=request.getContextPath()%>/archives/archivesAudit?archivesId=" + archivesId);
                        $("#dialog").modal("show");
                    } else if (requestFlag == "4" || requestFlag == "5") {
                        swal({title: "您已经审查过了！", type: "info"});
                    }
                    else {
                        swal({title: "该档案未提交修改申请！", type: "info"});
                    }
                }
                if (this.id == "preview") {
                    $("#dialog").load("<%=request.getContextPath()%>/archives/preview?archivesId=" + archivesId + "&role=leader");
                    $("#dialog").modal("show");
                }

            });
        } else {
            $("#right").load("<%=request.getContextPath()%>/archives/archivesListSchLeader");
        }
    }
</script>
