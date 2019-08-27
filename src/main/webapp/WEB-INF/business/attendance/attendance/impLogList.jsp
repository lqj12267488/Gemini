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
                                操作人：
                            </div>
                            <div class="col-md-2">
                                <input id="operatorSel" type="text" />
                            </div>
                            <div class="col-md-1 tar">
                                导入时间：
                            </div>
                            <div class="col-md-2">
                                <input id="operatorTimeSel" type="date" />
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
                        <table id="impLogGrid" cellpadding="0" cellspacing="0"
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
    var impLogTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#operatorSel").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#operatorSel").val(ui.item.label);
                    $("#operatorSel").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })


        search();
        impLogTable.on('click', 'tr a', function () {
            var data = impLogTable.row($(this).parent()).data();
            var coding = data.coding;
            if (this.id == "viewImpLog") {
                $("#dialog").load("<%=request.getContextPath()%>/attendance/impLogInfo?coding=" + coding);
                $("#dialog").modal("show");
            }
            if (this.id == "delimpLog") {
                //if (confirm("确定要删除?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "文件名："+data.importFileName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/attendance/delImplogList?coding=" + coding, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        //alert(msg.msg);
                        search();
                    })
                })
            }
        });
    })

    function searchclear() {
        $("#operatorTimeSel").val("");
        $("#operatorSel").val("");
         search();
    }

    function search() {
        var czrid="";
        var czrSelList ;
        if($("#operatorSel").val()!=""){
            var czrSelT =$("#operatorSel").attr("keycode");
            czrSelList = czrSelT.split(",");
            czrid =  czrSelList[1];
        }
        var operatorTime =  $("#operatorTimeSel").val();


        impLogTable = $("#impLogGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/attendance/getImpLogList',
                "data": {
                    operator:czrid,
                    operatorTime:operatorTime,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "coding", "visible": false},
                {"width": "20%", "data": "operator", "title": "操作人"},
                {"width": "20%", "data": "importFileName", "title": "导入文件名"},
                {"width": "20%", "data": "importNumber", "title": "导入条数"},
                {"width": "20%", "data": "operatorTime", "title": "导入时间"},
                {
                    "width": "20%",
                    "title": "操作",
                    "render": function () {
                        return  "<a id='viewImpLog' class='icon-edit' title='详细'></a>&nbsp;&nbsp;&nbsp;&nbsp;" +
                            "<a id='delimpLog' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }

</script>