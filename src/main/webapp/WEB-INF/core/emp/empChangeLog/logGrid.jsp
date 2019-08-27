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
                            <div class="col-md-1 tar">
                                教职工姓名：
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="personSelect" />
                            </div>
                            <div class="col-md-1 tar">
                                异动类型：
                            </div>
                            <div class="col-md-2">
                                <select id="changeTypeSelect" />
                            </div>
                            <%--<div class="col-md-1 tar">
                                角色类型：
                            </div>
                            <div class="col-md-2">
                                <select class="select2" id="searchreroletype"></select>
                            </div>--%>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="empLogGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var empLogGrid;

    $(document).ready(function (){
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGYDLX", function (data) {
            addOption(data, "changeTypeSelect");
        });

        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#personSelect").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#personSelect").val(ui.item.label);
                    $("#personSelect").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        search();
        empLogGrid.on('click', 'tr a', function () {
            var data = empLogGrid.row($(this).parent()).data();
/*
            if (this.id == "uRole") {
                $("#dialog").load("/getRoleById?id=" + roleid);
                $("#dialog").modal("show");
            }
            if (this.id == "delRole") {
                if (confirm("确定要删除" + data.rolename + "?")) {
                    $.get("/deleteRoleById?id=" + roleid, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#roleGrid').DataTable().ajax.reload();
                        }
                    })
                }
            }
*/
        });
    })

    function searchclear() {
        $("#personSelect").val("");
        $("#personSelect").attr("keycode", "").val("");
        $("#changeTypeSelect").val("");
        $("#changeTypeSelect option:selected").val("");
        search();
    }

    function search() {
        var personDept = $("#personSelect").attr("keycode");
        var personId ="";
        if (null != personDept && personDept != ""){
            var lis = personDept.split(",");
            personId =lis[1];
        }
        var changeType = $("#changeTypeSelect option:selected").val();
        empLogGrid = $("#empLogGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/empChangeLog/searchGrid',
                "data": {
                    changeType: changeType,
                    personId: personId,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "personId", "visible": false},
                {"width": "10%","data": "changeTypeShow", "title": "异动类型"},
                {"width": "10%","data": "personShow", "title": "异动人员"},
                {"width": "30%","data": "oldContent", "title": "修改前信息"},
                {"width": "30%","data": "newContent", "title": "修改后信息"},
                {"width": "15%","data": "logTime", "title": "异动时间" },
                /*{
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='异动还原'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }*/
            ],
            'order' : [5,'desc'],
            "dom": 'rtlip',
            language: language
        });

    }
</script>