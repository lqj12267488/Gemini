<%--协同办公-通讯录
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/24
  Time: 15:16
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
                                部门：
                            </div>
                            <div class="col-md-2">
                                <input id="selDept" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="selName" />
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
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
        $.get("<%=request.getContextPath()%>/mailList/autoCompleteDept", function (data) {
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
        $.get("<%=request.getContextPath()%>/mailList/autoCompleteEmployee", function (data) {
            $("#selName").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#selName").val(ui.item.label);
                    $("#selName").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        search();
    });
    function searchclear() {
        $("#selDept").val("");
        $("#selName").val("");
        search();
    }
    function search() {
        var deptName = $("#selDept").val();
        if (deptName != "")
            deptName = '%' + deptName + '%';
        var name = $("#selName").val();
        if (name != "")
            name = '%' + name + '%';
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/mailList/getMailList',
                "data": {
                    deptName: deptName,
                    name: name
                }
            },
            "destroy": true,
            "columns": [
                {"data": "deptId", "visible": false},
                {"width": "6%","data": "name", "title": "教师姓名"},
                {"width": "10%","data": "deptName", "title": "所属部门"},
                {"width": "6%","data": "tel", "title": "电话"},
            ],
            'order' : [0,'asc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>

