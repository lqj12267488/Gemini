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
                                标题：
                            </div>
                            <div class="col-md-2">
                                <input id="selTitle" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                类型：
                            </div>
                            <div class="col-md-2">
                                <select id="typeSelect" />
                            </div>
                            <%--<div class="col-md-1 tar">
                                角色类型
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
                        <table id="messageGrid" cellpadding="0" cellspacing="0"
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
    var messageTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TZLX", function (data) {
            addOption(data, "typeSelect");
        })
        search();
        messageTable.on('click', 'tr a', function () {
            var data = messageTable.row($(this).parent()).data();
            var noticeId = data.id;
                $("#dialog").load("<%=request.getContextPath()%>/messageInfo?id=" + noticeId +"&type="+'1');
                $("#dialog").modal("show");
        });
    })

    function searchclear() {
        $("#selTitle").val("");
        $("#typeSelect option:selected").val("");
        search();
    }

    function search() {
        var selTitle =  $("#selTitle").val();
        var type = $("#typeSelect option:selected").val();
        if (selTitle != "")
            selTitle = '%' + selTitle + '%';
        messageTable = $("#messageGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/getMessageList',
                "data": {
                    title: selTitle,
                    type:type,
                    messageType:2
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "type", "visible": false},
                {"width": "9%", "data": "requester", "title": "申请人"},
                {"width": "12%", "data": "requestDept", "title": "申请部门"},
                {"width": "11%", "data": "publicTime", "title": "申请日期"},
                {
                    "width": "8%", "data": "title", "title": "标题",
                    "render": function (data, type, row, meta) {
                        if(row.title!=null || row.title!=undefined){
                            var ss=row.title +"";
                            return "<span title='" + ss + "'>" + ss.substr(0,10) + "</span>";
                        }
                    }
                },
                {"width": "8%", "data": "typeShow", "title": "类型"},
                {"width": "5%", "data": "empIdShow", "title": "发送人员"},
                {"width": "24%", "data": "deptIdShow", "title": "发送部门"},
                {
                    "width": "8%", "data": "content", "title": "内容",
                    "render": function (data, type, row, meta) {
                        if(row.content!=null || row.content!=undefined || row.content!=0){
                            var tt=row.content +"";
                            return "<span title='" + tt + "'>" + tt.substring(0,10) + "</span>";
                        }
                    }
                },
                {
                    "width": "11%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='viewNotice' class='icon-search' title='查看'></a>";
                    }
                }
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });

    }
</script>