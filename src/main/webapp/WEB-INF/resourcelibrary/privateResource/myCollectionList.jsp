<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div>
    <div class="form-row1 tk1" style="background:#f0f0f0; width:100%; padding:0" >
	<div style="overflow:hidden; display:block; float:left">
        	<div style="overflow:hidden; display:block; width:300px; padding:7px 10px; float:left">
            	    <div style="width: 100px; padding:0px 10px; display:block; float:left">资源名称：</div>
                    <input id="resourceNameSel"  style="width: 160px;" type="text"/>
		</div>
        	<div style="overflow:hidden; display:block; width:300px; padding:7px 10px; float:left">
            	    <div style="width: 100px; padding:0px 10px;  display:block; float:left">资源类型：</div>
            	    <select id="resourceTypeSel" style="width: 160px;"/>
		</div>
        </div>
        <div style="overflow:hidden; width:140px; display:block;  padding:7px 10px; float:left">
             	<button  type="button" class="btn btn-success" onclick="search()">查询</button>
             	<button  type="button" class="btn btn-success" onclick="searchclear()">清空</button>
        </div>
          
    </div>
    <div class="form-row block" style="overflow-y:auto;">
        <table id="tableCollection" cellpadding="0" cellspacing="0"
               width="100%" style="max-height: 50%;min-height: 10%; margin:0px; margin-bottom:10px"
               class="table table-bordered table-striped sortable_default">
        </table>
    </div>
</div>
<script>
    var tableCollection;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYLX", function (data) {
            addOption(data,'resourceTypeSel');
        });

        tableCollection = $("#tableCollection").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourceLibrary/collection/getResourceCollectionList',
            },
            "destroy": true,
            "columns": [
                {"data":"id","visible":false},
                {"data":"personId","visible":false},
                {"data":"resourceId","visible":false},
                {"data":"resourceType","visible":false},
                {"data":"resourceName","title":"资源名称"},
                {"data":"personShow","title":"上传人"},
                {"data":"resourceTypeShow","title":"资源类型"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="查看" onclick=view("' + row.id + '","' + row.resourceId + '","' + row.personId + '")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function view(id,resourceId,personId) {
        window.open("<%=request.getContextPath()%>/resourcePublic/getPublicResourceViewMain?resourceId="+resourceId+"&publicPersonId="+personId);
    }

    function del(id) {
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
            $.post("<%=request.getContextPath()%>/resourceLibrary/collection/delResourceCollection", {
                id: id
            }, function (msg) {
                swal({title: msg.msg,type: msg.result});
                $('#tableApproval').DataTable().ajax.reload();
            });
        })
    }

    function search() {
        var resourceName = $("#resourceNameSel").val();
        var resourceType = $("#resourceTypeSel").val();
        tableCollection.ajax.url("<%=request.getContextPath()%>/resourceLibrary/collection/getResourceCollectionList" +
            "?resourceName="+resourceName+"&resourceType="+resourceType).load();
    }

    function searchclear() {
        $("#resourceNameSel").val("");
        $("#resourceTypeSel").val("");
        search();
    }

</script>