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
                                创建部门：
                            </div>
                            <div class="col-md-2">
                                <select id="selDept"/>
                            </div>
                            <div class="col-md-1 tar" style="width: 90px">
                                创建人：
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
                                学校类别：
                            </div>
                            <div class="col-md-2">
                                <select id="selschoolType"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar" style="width: 90px">
                                档案状态：
                            </div>
                            <div class="col-md-2">
                                <select id="selstate"/>
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
                        <button type="button" class="btn btn-default btn-clean" onclick="allEmpRole()">
                            批量授权
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="roleTakeback()">
                            权限收回
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="allRole()">
                            全部授权
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="allRoleTakeBack()">
                            全部权限收回
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
                                <th width="9%">创建人</th>
                                <th width="10%">档案编码</th>
                                <th width="9%">一级类别</th>
                                <th width="9%">二级类别</th>
                                <th width="9%">档案类型</th>
                                <th width="9%">学校类别</th>
                                <th width="9%">档案名称</th>
                                <th width="9%">档案状态</th>
                                <th width="9%">附件数量</th>
                                <th width="9%">授权状态</th>
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
    $(document).ready(function () {
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/archives/getManagerArchivesList',
            },
            "destroy": true,
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='" + row.archivesId + "'/>";
                    }
                },
                {"data": "archivesId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "createDept"},
                {"data": "creator"},
                {"data": "archivesCode"},
                {
                    "data": "oneLevel",
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
                {"data": "fileType"},
                {"data": "schoolType"},
                {
                    "width": "10%", "data": "archivesName", "title": "档案名称",
                    "render": function (data, type, row, meta) {
                        if(row.archivesName!=null || row.archivesName!=undefined || row.archivesName!=0){
                            var tt=row.archivesName +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                {"data": "state"},
                {"data": "fileNum"},
                {"data": "roleState"},
                {
                    "width": "7%", "title": "操作", "render": function () {
                        return "<a id='addEmpRole' class='icon-tags' title='授权教职员工'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='empRoleView' class='icon-eye-open' title='查看已授权人员'></a>&nbsp;&nbsp;&nbsp;"
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
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
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "dept_id",
                text: "dept_name",
                tableName: "T_SYS_DEPT",
                where: " WHERE dept_id not in( '001001' , '001')  ",
                orderby: "ORDER BY dept_id"
            }
            , function (data) {
                addOption(data, 'selDept');
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

        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var archivesId = data.archivesId;
            var requestFlag = data.requestFlag;
            var requestType = data.requestType;
            var editedId = data.editedId;
            //修改
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/archives/editArchives?archivesId=" + archivesId);
                $("#dialog").modal("show");
            }
            //上传附件
            if (this.id == "upload") {
                $("#dialog").load("<%=request.getContextPath()%>/archives/uploadFiles?archivesId=" + archivesId);
                $("#dialog").modal("show");
            }
            //删除
            if (this.id == "delete") {
                swal({
                    title: "确定将该档案移入回收站?",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/archives/updateArchivesDelStateById?archivesId=" + archivesId + "&delState=1", function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"});
                            $('#listGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
            if (this.id == "submit") {
                if (requestFlag != null && requestFlag != '7' && requestFlag != '8') {
                    swal({title: "该档案已提交", type: "info"});
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
                        $.get("<%=request.getContextPath()%>/archives/saveArchivesRequest?requestFlag=0&archivesId=" + archivesId, function (msg) {
                            if (msg.status == 1) {
                                swal({title: msg.msg, type: "success"});
                                $('#listGrid').DataTable().ajax.reload();
                            }
                        })
                    })
                }
            }
            if (this.id == "addEmpRole") {
                $("#dialog").load("<%=request.getContextPath()%>/archives/archivesPerRole?archivesId=" + archivesId);
                $("#dialog").modal("show");
            }
            if (this.id == "empRoleView") {
                $("#dialog").load("<%=request.getContextPath()%>/archives/archivesPerRoleView?archivesId=" + archivesId);
                $("#dialog").modal("show");
            }
            if (this.id == "audit") {
                if (requestFlag == "1") {
                    $("#dialog").load("<%=request.getContextPath()%>/archives/archivesRequestAudit?archivesId=" + archivesId + "&requestType=" + requestType + "&editedId=" + editedId);
                    $("#dialog").modal("show");
                } else {
                    swal({title: "该档案未提交修改申请", type: "info"});
                }
            }
        });
    })

    //全选
    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
            $("input[name='checkbox']").each(function () {
                this.checked = true;
            })
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
            $("#dialog").load("<%=request.getContextPath()%>/archives/archivesAllPerRole?ids=" + chk_value);
            $("#dialog").modal("show");
        } else {
            swal({
                title: "请选择电子档案!",
                type: "info"
            });
        }

    }

    function allRole() {
        var oneLevel = $("#selOne").val();
        var twoLevel = $("#selTwo").val();
        var fileType = $("#selType").val();
        var yearCode = $("#selYear").val();
        var deptId = $("#selDept").val();
        var personName = $("#selPerson").val();
        var schoolType = $("#selschoolType").val();
        var selstate = $("#selstate").val();
        var arcode = $("#arcode").val();
        var arname = $("#arname").val();
        personName = encodeURI(encodeURI(personName));
        arname = encodeURI(encodeURI(arname));
        $("#dialog").load("<%=request.getContextPath()%>/archives/archivesAllRole?oneLevel=" + oneLevel +
            "&twoLevel=" + twoLevel + "&fileType=" + fileType + "&yearCode=" + yearCode + "&deptId=" + deptId +
            "&personName=" + personName + "&schoolType=" + schoolType + "&requestFlag=" + selstate +
            "&archivesCode=" + arcode + "&archivesName=" + arname);
        $("#dialog").modal("show");

    }

    //批量收回
    function allRoleTakeBack() {
        var oneLevel = $("#selOne").val();
        var twoLevel = $("#selTwo").val();
        var fileType = $("#selType").val();
        var yearCode = $("#selYear").val();
        var deptId = $("#selDept").val();
        var personName = $("#selPerson").val();
        var schoolType = $("#selschoolType").val();
        var selstate = $("#selstate").val();
        var arcode = $("#arcode").val();
        var arname = $("#arname").val();
        personName = encodeURI(encodeURI(personName));
        arname = encodeURI(encodeURI(arname));
        $.post("<%=request.getContextPath()%>/archives/allArchivesId", {
            oneLevel: oneLevel,
            twoLevel: twoLevel,
            fileType: fileType,
            yearCode: yearCode,
            deptId: deptId,
            personName: personName,
            schoolType: schoolType,
            requestFlag: selstate,
            archivesCode: arcode,
            archivesName: arname
        }, function (data) {
            $.post("<%=request.getContextPath()%>/archives/archivesRoleTakeBack", {
                ids: data.msg,
            }, function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "info"
                    });
                    $('#listGrid').DataTable().ajax.reload();
                }
            });
        });
    }

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
        $("#selYear").val("");
        $("#selDept").val("");
        $("#selPerson").val("");
        $("#selschoolType").val("");
        $("#selstate").val("");
        $("#arcode").val("");
        $("#arname").val("");
        search();
    }

    /*查询函数*/
    function search() {
        var oneLevel = $("#selOne").val();
        var twoLevel = $("#selTwo").val();
        var fileType = $("#selType").val();
        var yearCode = $("#selYear").val();
        var deptId = $("#selDept").val();
        var personName = $("#selPerson").val();
        var schoolType = $("#selschoolType").val();
        var selstate = $("#selstate").val();
        var arcode = $("#arcode").val();
        var arname = $("#arname").val();
        personName = encodeURI(encodeURI(personName));
        arname = encodeURI(encodeURI(arname));
        listTable.ajax.url("<%=request.getContextPath()%>/archives/getManagerArchivesList?oneLevel=" + oneLevel +
            "&twoLevel=" + twoLevel + "&fileType=" + fileType + "&yearCode=" + yearCode + "&deptId=" + deptId + "&personName=" +
            personName + "&schoolType=" + schoolType + "&requestFlag=" + selstate + "&archivesCode=" + arcode + "&archivesName=" + arname).load()

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
</script>
