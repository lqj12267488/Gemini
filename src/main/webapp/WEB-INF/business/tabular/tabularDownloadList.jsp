<%--
  Created by IntelliJ IDEA.
  User: fn
  Date: 2017/7/27
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container"><%--最外层div--%>
    <div class="row"><%--top_extend_div--%>
        <div class="block">
            <div class="block block-drop-shadow content">
                <div class="block block-drop-shadow content"
                     style="background: none;border-bottom: none;padding-left: 2px;box-shadow: 0px 0px;">
                    <div class="col-md-1 tar" style="margin-left: -1px;margin-top: 6px;">
                        表格名称：
                    </div>
                    <div class="col-md-2">
                        <input id="tabName" style="width: 101.5%;" type=""
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                    <div class="col-md-1 tar">
                        表格种类
                    </div>
                    <div class="col-md-2">
                        <select id="tabType"/>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="search()">查询
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="searchClear()">清空
                        </button>
                    </div>
                </div>
            </div>
            <div class="block block-drop-shadow content">
                <div class="form-row">
                   <%-- <button type="button" class="btn btn-default btn-clean"
                            onclick="addTabular()">新增
                    </button>--%>
                </div>
                <table id="tabularGrid" cellpadding="0" cellspacing="0" width="100%"
                       class="table table-bordered table-striped sortable_default">
                    <thead>
                    <tr>

                        <th width="10%">序号</th>
                        <th>id</th>
                        <th>time</th>
                        <th width="30%">表格名称</th>
                        <th width="20%">表格种类</th>
                        <th width="30%">上传时间</th>
                        <th width="10%">操作</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getUserDict?name=BGZL", function (data) {
            addOption(data, 'tabType');
        });
        table = $("#tabularGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/tabular/getTabularList',
            },
            "columns": [
                { name: "SerialNum", data: "serialNumber", "searchable": false, "orderable": false },
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "tabularName"},
                {"data": "tabularType"},
                {"data": "uploadTime"},
                {
                    "render": function (data, type, row) {

                        var str = "<a id='upload' class='icon-download' title='下载' href='<%=request.getContextPath()%>/tabular/downloadTabularFile?id="+row.id+"'></a>";
                        return str;
                    },
                },
            ],
            "columnDefs": [{
                "orderable": false
            }],
            'order': [2, 'desc'],
            "dom": 'rtlip',
            language: language
        });
        //为dataTable增加序号
        table.on('order.dt search.dt',function(){
            table.column(0,{
                search: 'applied',
                order: 'applied'
            }).nodes().each(function(cell,i){
                i = i + 1;
                var page = table.page.info();
                var pageno = page.page;
                var length = page.length;
                var columnIndex = (i+pageno*length);
                cell.innerHTML = columnIndex;
            });
        }).draw();
    });


    function addTabular() {
        $("#dialog").load("<%=request.getContextPath()%>/tabular/addTabular");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#tabName").val("");
        $("#tabType").val("");
        search();
    }

    function search() {
        var tabularName = $("#tabName").val();
        var tabularType = $("#tabType").val();
        table.ajax.url("<%=request.getContextPath()%>/tabular/getTabularList?tabularName=" + tabularName+"&tabularType="+tabularType).load();
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/tabular/editTabular?id=" + id);
        $("#dialog").modal("show");
    }

    function del(id, tabularName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "表格名称：" + tabularName + "\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/tabular/deleteTabular", {
                id: id
            }, function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    table.ajax.reload();
                }
            });
        })
    }
</script>





