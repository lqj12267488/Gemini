<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<script type='text/javascript'
        src='<%=request.getContextPath()%>/libs/js/plugins/datatables/jquery.dataTables.js'></script>
<script type='text/javascript'
        src='<%=request.getContextPath()%>/libs/js/plugins/datatables/dataTables.bootstrap.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/datatables/language.js'></script>

<body>
<div>
    <table>
        <div class="form-row1 tk1" style="padding:0">
            <div style="overflow:hidden; display:block; float:left">
                <div style="overflow:hidden; display:block; width:300px; padding:7px 10px; float:left">
                    <div style="width: 100px; padding:0px 10px; display:block; float:left">资源名称：</div>
                    <input id="resourceNameSel" style="width: 160px;" type="text"/>
                </div>
                <div style="overflow:hidden; display:block; width:300px; padding:7px 10px; float:left">
                    <div style="width: 100px; padding:0px 10px;  display:block; float:left">资源类型：</div>
                    <select id="resourceTypeSel" style="width: 160px;"/>
                </div>
            </div>
            <div style="overflow:hidden; width:140px; display:block;  padding:7px 10px; float:left">
                <button type="button" class="btn btn-success" onclick="search()">查询</button>
                <button type="button" class="btn btn-success" onclick="searchclear()">清空</button>
            </div>

        </div>
    </table>
    <div class="form-row tk1" style=" width:100%; padding:0px">
        <div class="col-md" style="padding-left:0px">
            <button type="button" class="btn btn-success" onclick="add()">新增资源</button>
            <button type="button" class="btn btn-success" onclick="batchAdd()">批量新增</button>
        </div>
        <table id="tablePrivate" cellpadding="0" cellspacing="0"
               style="max-height: 50%;min-height: 10%; margin:4px 0px 10px 0px; width:100%;"
               class="table table-bordered table-striped sortable_default">
        </table>
    </div>
</div>
<input type="hidden" id="personId" value="${personId}">
</body>
</html>
<script>
    var tablePrivate;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " TYPE_ID ",
                text: " TYPE_NAME ",
                tableName: " ZYK_TYPE_CUSTOM ",
                where: " where CREATOR = '" + $("#personId").val() + "'",
                orderby: " order by CREATE_TIME "
            },
            function (data) {
                addOption(data, "resourceTypeSel");
            })

        tablePrivate = $("#tablePrivate").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourcePrivate/getPrivateLibraryList',
            },
            "destroy": true,
            "columns": [
                {"data": "resourceId", "visible": false},
                {"width": "15%", "data": "resourceName", "title": "资源名称"},
                {"width": "15%", "data": "resourceType", "title": "资源分类"},
                {"width": "10%", "data": "resourceCustom", "title": "自定义分类"},
                {"width": "10%", "data": "uploadTime", "title": "上传时间"},
                {"width": "15%", "data": "publicFlagShow", "title": "公共资源标识"},
                {"width": "15%", "data": "classicFlagShow", "title": "精品课标识"},
                {
                    "width": "10%", "title": "操作",
                    "render": function (data, type, row) {
                        var re = '<span class="icon-eye-open" title="查看" onclick=getpublicViewRightMain("' + row.resourceId + '")></span>&ensp;&ensp;' +
                            '<span class="icon-edit" title="修改" onclick=edit("' + row.resourceId + '")></span>';
                        if (row.publicFlag == 0 || row.publicFlag == '0') {
                            re = re + '&ensp;&ensp;<span class="icon-arrow-up" title="申请设置此条为公共资源" onclick=upreasources("' + row.resourceId + '","' + row.resourceName + '","1")/></span>';
                        }
                        /*
                                                if(row.classicFlag == 0 || row.classicFlag == '0' ){
                                                    re = re + '&ensp;&ensp;<span class="icon-gift" title="申请设置此条为精品课" onclick=upreasources("' + row.resourceId + '","' + row.resourceName + '","2")/></span>';
                                                }
                        */
                        if (row.publicFlag == 0 || row.publicFlag == '0' || row.classicFlag == 0 || row.classicFlag == '0') {
                            re = re + '&ensp;&ensp;<span class="icon-trash" title="删除" onclick=del("' + row.resourceId + '","' + row.resourceName + '")/></span>&ensp;&ensp;';
                        }
                        return re;
                    }
                }
            ],
            'order': [4, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    })

    function batchAdd() {
        $("#dialog").load("<%=request.getContextPath()%>/resourcePrivate/toBatchAdd")
        $("#dialog").css('display', 'block');
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/resourcePrivate/toResourcePrivateAdd")
        $("#dialog").css('display', 'block');
    }

    function getpublicViewRightMain(resourceId) {
        window.open("<%=request.getContextPath()%>/resourcePrivate/getPrivateResourceViewMain?resourceId=" + resourceId);
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/resourcePrivate/toResourcePrivateEdit?id=" + id)
        $("#dialog").css('display', 'block');
    }

    function del(id, resourceName) {
        swal({
            title: "确定要删除这条记录?",
            text: "",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/resourcePrivate/delResourcePrivate", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#tablePrivate').DataTable().ajax.reload();
            });
        })

    }

    function search() {
        var resourceName = $("#resourceNameSel").val();
        var resourceType = $("#resourceTypeSel").val();
        tablePrivate.ajax.url("<%=request.getContextPath()%>/resourcePrivate/getPrivateLibraryList" +
            "?resourceName=" + resourceName + "&resourceCustom=" + resourceType).load();
    }

    function searchclear() {
        $("#resourceNameSel").val("");
        $("#resourceTypeSel").val("");
        search();
    }

    function upreasources(resourceId, resourceName, requestType) {
        $("#dialog").load("<%=request.getContextPath()%>/resourcePrivate/toUpResourcePrivate?" +
            "resourceId=" + resourceId + "&resourceName=" + resourceName + "&requestType=" + requestType);
        $("#dialog").css('display', 'block');
    }

</script>
