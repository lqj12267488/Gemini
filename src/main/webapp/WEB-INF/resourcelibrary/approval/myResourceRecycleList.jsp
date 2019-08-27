<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/datatables/jquery.dataTables.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/datatables/dataTables.bootstrap.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/datatables/language.js'></script>

<body>
<div >
    <table>
        <tr>
            <div class="form-row1 tk1">
                <div class="col-md">
                    资源名称：
                </div>
                <div class="col-md">
                    <input id="resourceNameSel" type="text" width="95%"/>
                </div>
                <div class="col-md">
                    资源类型：
                </div>
                <div class="col-md">
                    <select id="resourceTypeSel" width="95%"/>
                </div>
                <div class="col-md">
                    <button  type="button" class="btn btn-success" onclick="search()">查询</button>
                    <button  type="button" class="btn btn-success" onclick="searchclear()">清空</button>
                </div>
            </div>
        </tr>
    </table>
    <table id="tableRecycle" cellpadding="0" cellspacing="0"
           width="100%" style="max-height: 50%;min-height: 10%; margin-left:0px; width:100%; margin-top:4px"
           class="table table-bordered table-striped sortable_default">
    </table>
</div>
<input type="hidden" id="personId" value="${personId}">
</body>
</html>
<script>
    var tableRecycle;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " TYPE_ID ",
                text: " TYPE_NAME ",
                tableName: " ZYK_TYPE_CUSTOM ",
                where: " where CREATOR = '"+$("#personId").val()+"'",
                orderby: " order by CREATE_TIME "
            },
            function (data) {
                addOption(data, "resourceTypeSel");
            })

        tableRecycle = $("#tableRecycle").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourcePrivate/myResourceRecycleList',
            },
            "destroy": true,
            "columns": [
                {"data":"resourceId","visible":false},
                {"width": "15%","data":"resourceName","title":"资源名称"},
                {"width": "10%","data":"resourceType","title":"自定义分类"},
                {"width": "10%","data":"uploadPersonId","title":"上传人"},
                {"width": "10%","data":"uploadTime","title":"上传时间"},
                {"width": "10%","data":"publicFlagShow","title":"是否为公共资源"},
                {"width": "10%","data":"classicFlagShow","title":"是否为精品课"},
                {"width": "20%","data":"remark","title":"备注"},
                {
                    "width": "15%","title": "操作",
                    "render": function (data, type, row) {
                        var re = '<span class="icon-remove" title="物理删除" onclick=del("' + row.resourceId + '","'+row.resourceName+'")></span>';
                        if(row.classicFlag == 0 || row.classicFlag == '0' ){
                            re = re + '&ensp;&ensp;<span class="icon-share-alt" title="恢复资源" onclick=backreasources("' + row.resourceId + '","' + row.resourceName + '")/></span>';
                        }
                        return re;
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function del(id,resourceName) {
        swal({
            title: "确定要删除"+resourceName+"这条记录？",
            text: "",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/resourcePrivate/delResourceRecycle", {
                resourceId: id
            }, function (msg) {
                swal({title: msg.msg, type: msg.result});
                $('#tableRecycle').DataTable().ajax.reload();
            });
        })
    }
    function search() {
        var resourceName = $("#resourceNameSel").val();
        var resourceType = $("#resourceTypeSel").val();
        tableRecycle.ajax.url("<%=request.getContextPath()%>/resourcePrivate/myResourceRecycleList" +
            "?resourceName="+resourceName+"&resourceType="+resourceType).load();
    }
    function searchclear() {
        $("#resourceNameSel").val("");
        $("#resourceTypeSel").val("");
        search();
    }
    function backreasources(resourceId,resourceName) {
        swal({
            title: "确定要恢复"+resourceName+"这条资源？",
            text: "",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/resourcePrivate/backResourceRecycle", {
                resourceId: resourceId
            }, function (msg) {
                swal({title: msg.msg, type: msg.result});
                $('#tableRecycle').DataTable().ajax.reload();
            });
        })

    }

</script>
