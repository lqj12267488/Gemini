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
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学生姓名:
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="studentSelect" />
                            </div>
                            <div class="col-md-1 tar">
                                异动类型:
                            </div>
                            <div class="col-md-2">
                                <select id="changeTypeSelect" />
                            </div>
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
                        <table id="studentLogGrid" cellpadding="0" cellspacing="0"
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
///studentChangeLog/searchGrid',
var studentLogGrid;

    $(document).ready(function (){
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSYDLX", function (data) {
            addOption(data, "changeTypeSelect");
        });

        $.get("<%=request.getContextPath()%>/common/getStudentClass", function (data) {
            $("#studentSelect").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#studentSelect").val(ui.item.label);
                    $("#studentSelect").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        studentLogGrid = $("#studentLogGrid").DataTable({
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"width": "10%","data": "changeTypeShow", "title": "异动类型"},
                {"width": "20%","data": "studentShow", "title": "学生姓名"},
                {"width": "25%","data": "oldContent", "title": "修改前信息"},
                {"width": "25%","data": "newContent", "title": "修改后信息"},
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
        search();
/*
        studentLogGrid.on('click', 'tr a', function () {
            var data = empLogGrid.row($(this).parent()).data();
        });
*/
    })

    function searchclear() {
        $("#studentSelect").val("");
        $("#studentSelect").attr("keycode", "").val("");
        $("#changeTypeSelect").val("");
        $("#changeTypeSelect option:selected").val("");
        search();
    }

    function search() {
        var personDept = $("#studentSelect").attr("keycode");
        var personId ="";
        if (null != personDept && personDept != "" && personDept != "undefined"){
            var lis = personDept.split(",");
            personId =lis[1];
        }
        var changeType = $("#changeTypeSelect option:selected").val();
        if (null == changeType || changeType == "" || changeType == "undefined"){
            changeType = "";
        }

        studentLogGrid.ajax.url("<%=request.getContextPath()%>/studentChangeLog/searchGrid?changeType=" + changeType+"&studentId="+personId).load();
    }

</script>