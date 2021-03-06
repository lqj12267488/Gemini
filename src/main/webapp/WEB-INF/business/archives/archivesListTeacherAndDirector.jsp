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
                            <%--<div class="col-md-1 tar" style="width: 90px">--%>
                            <%--全文检索：--%>
                            <%--</div>--%>
                            <%--<div class="col-md-2">--%>
                            <%--<input id="condition"/>--%>
                            <%--</div>--%>
                            <div class="form-row">
                                <div class="col-md-1 tar" style="width: 90px">
                                    一级类别：
                                </div>
                                <div class="col-md-2">
                                    <select id="selOne"/>
                                    <%--<input id="selOne" type="text"/>--%>
                                </div>
                                <div class="col-md-1 tar" style="width: 90px">
                                    二级类别：
                                </div>
                                <div class="col-md-2">
                                    <select id="selTwo"/>
                                    <%--<input id="selTwo" type="text"/>--%>
                                </div>
                                <div class="col-md-1 tar" style="width: 90px">
                                    档案类型：
                                </div>
                                <div class="col-md-2">
                                    <select id="selType"/>
                                    <%--<input id="selType" type="text"/>--%>
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
                                <div class="col-md-1 tar" style="width: 90px">
                                    创建部门：
                                </div>
                                <div class="col-md-2">
                                    <select id="selDept"></select>
                                </div>
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
                        <button type="button" class="btn btn-info btn-clean" onclick="printDate()">打印</button>
                        <a id="expdata" class="btn btn-info btn-clean">导出</a>
                        <button type="button" class="btn btn-info btn-clean" onclick="showArchivesCode()">显示档案编码
                        </button>
                    </div>
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
    var flag = "0";
    $(document).ready(function () {
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DAZT", function (data) {
            addOption(data, 'selstate');
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

        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/archives/getLeaderArchivesList?roleFlag=0',
            },
            "destroy": true,
            "columns": [
                {"data": "archivesId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "9%", "data": "createDept", "title": "创建部门"},
                {"width": "10%", "data": "creator", "title": "创建人"},
                {"width": "10%", "data": "archivesCode", "title": "档案编码", "visible": false},
                {
                    "width": "9%", "data": "oneLevel", "title": "一级类别",
                    "render": function (data, type, row, meta) {
                        if(row.oneLevel!=null || row.oneLevel!=undefined || row.oneLevel!=0){
                            var tt=row.oneLevel +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                {
                    "width": "9%", "data": "twoLevel", "title": "二级类别",
                    "render": function (data, type, row, meta) {
                        if(row.twoLevel!=null || row.twoLevel!=undefined || row.twoLevel!=0){
                            var tt=row.twoLevel +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                {"width": "9%", "data": "fileType", "title": "档案类型"},
                {"width": "9%", "data": "schoolType", "title": "学校类型"},
                {"width": "9%", "data": "state", "title": "档案状态"},
                {
                    "width": "10%", "data": "archivesName", "title": "档案名称",
                    "render": function (data, type, row, meta) {
                        if(row.archivesName!=null || row.archivesName!=undefined || row.archivesName!=0){
                            var tt=row.archivesName +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                {"width": "9%", "data": "fileNum", "title": "附件数量"},
                {"width": "9%", "data": "formatTime", "title": "文件形成时间"},
                {
                    "width": "7%", "title": "操作", "render": function () {
                        return "<a id='preview' class='icon-eye-open' title='查看附件'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
        expList("", "", "", "", "", "", "", "", "", "");
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var archivesId = data.archivesId;
            if (this.id == "preview") {
                $("#dialog").load("<%=request.getContextPath()%>/archives/preview?archivesId=" + archivesId + "&role=leader");
                $("#dialog").modal("show");
            }
        });
    })

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
        $("#selPerson").val("");
        $("#selDept").val("");
        $("#selschoolType").val("");
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
        var yearCode = $("#selYear").val();
        var personName = $("#selPerson").val();
        var deptId = $("#selDept").val();
        var schoolType = $("#selschoolType").val();
        var selstate = $("#selstate").val();
        var arcode = $("#arcode").val();
        var arname = $("#arname").val();
        var formatTimeStart = $("#formatTimeStart").val();
        var formatTimeEnd = $("#formatTimeEnd").val();
        arname = encodeURI(encodeURI(arname));
        personName = encodeURI(encodeURI(personName));
        //var cond=$("#condition").val();
        listTable.ajax.url("<%=request.getContextPath()%>/archives/getLeaderArchivesList?roleFlag=0" + "&oneLevel=" + oneLevel +
            "&twoLevel=" + twoLevel + "&fileType=" + fileType + "&yearCode=" + yearCode + "&personName=" + personName + "&deptId=" + deptId +
            "&schoolType=" + schoolType + "&requestFlag=" + selstate + "&archivesCode=" + arcode + "&archivesName=" + arname +
            "&formatTimeStart=" + formatTimeStart + "&formatTimeEnd=" + formatTimeEnd).load();
        expList(oneLevel, twoLevel, fileType, yearCode, personName, schoolType, selstate, arcode, arname, deptName);

    }

    function expList(oneLevel, twoLevel, fileType, yearCode, personName, schoolType, selstate, arcode, arname, deptName) {
        var href = "<%=request.getContextPath()%>/archives/expList?oneLevel=" + oneLevel + "&twoLevel=" + twoLevel +
            "&fileType=" + fileType + "&schoolType=" + schoolType + "&yearCode=" + yearCode + "&archivesCode=" + arcode +
            "&archivesName=" + arname + "&requestFlag=" + selstate + "&personName=" + personName + "&deptName=" + deptName + "&roleFlag=0";
        $("#expdata").attr("href", href);
    }

    function printDate() {
        var oneLevel = $("#selOne").val();
        var twoLevel = $("#selTwo").val();
        var fileType = $("#selType").val();
        var yearCode = $("#selYear").val();
        var personName = $("#selPerson").val();
        var deptName = $("#selDept").val();
        var schoolType = $("#selschoolType").val();
        var selstate = $("#selstate").val();
        var arcode = $("#arcode").val();
        var arname = $("#arname").val();
        arname = encodeURI(encodeURI(arname));
        personName = encodeURI(encodeURI(personName));
        deptName = encodeURI(encodeURI(deptName));
        var print = "<%=request.getContextPath()%>/archives/printArchives?roleFlag=0" + "&oneLevel=" + oneLevel +
            "&twoLevel=" + twoLevel + "&fileType=" + fileType + "&yearCode=" + yearCode + "&personName=" + personName + "&deptName=" + deptName +
            "&schoolType=" + schoolType + "&requestFlag=" + selstate + "&archivesCode=" + arcode + "&archivesName=" + arname;
        var bdhtml = window.document.body.innerHTML;
        $.get(print, function (html) {
            window.document.body.innerHTML = html;
            window.print();
            window.document.body.innerHTML = bdhtml;
            $("#right").load("<%=request.getContextPath()%>/archives/directorArchivesList");
        })
    }

    function showArchivesCode() {
        if (flag == "0") {
            flag = "1";
            document.getElementById("listGrid").style.whiteSpace = 'nowrap';
            listTable = $("#listGrid").DataTable({
                "ajax": {
                    "type": "post",
                    "url": '<%=request.getContextPath()%>/archives/getLeaderArchivesList?roleFlag=0',
                },
                "destroy": true,
                "columns": [
                    {"data": "archivesId", "visible": false},
                    {"data": "createTime", "visible": false},
                    {"width": "9%", "data": "createDept", "title": "创建部门"},
                    {"width": "10%", "data": "creator", "title": "创建人"},
                    {"width": "10%", "data": "archivesCode", "title": "档案编码"},
                    {
                        "width": "9%", "data": "oneLevel", "title": "一级类别",
                        "render": function (data, type, row, meta) {
                            if(row.oneLevel!=null || row.oneLevel!=undefined || row.oneLevel!=0){
                                var tt=row.oneLevel +"";
                                return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                            }
                        }
                    },
                    {"width": "9%", "data": "twoLevel", "title": "二级类别"},
                    {"width": "9%", "data": "fileType", "title": "档案类型"},
                    {"width": "9%", "data": "schoolType", "title": "学校类型"},
                    {"width": "9%", "data": "state", "title": "档案状态"},
                    {"width": "10%", "data": "archivesName", "title": "档案名称"},
                    {"width": "9%", "data": "fileNum", "title": "附件数量"},
                    {"width": "9%", "data": "formatTime", "title": "文件形成时间"},
                    {
                        "width": "7%", "title": "操作", "render": function () {
                            return "<a id='preview' class='icon-eye-open' title='查看附件'></a>&nbsp;&nbsp;&nbsp;";
                        }
                    }
                ],
                'order': [1, 'desc'],
                "dom": 'rtlip',
                language: language
            });
            expList("", "", "", "", "", "", "", "", "", "");
            listTable.on('click', 'tr a', function () {
                var data = listTable.row($(this).parent()).data();
                var archivesId = data.archivesId;
                if (this.id == "preview") {
                    $("#dialog").load("<%=request.getContextPath()%>/archives/preview?archivesId=" + archivesId + "&role=leader");
                    $("#dialog").modal("show");
                }
            });
        } else {
            $("#right").load("<%=request.getContextPath()%>/archives/directorArchivesList");
        }
    }
</script>

