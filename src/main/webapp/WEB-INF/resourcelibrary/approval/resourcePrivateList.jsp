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
                                资源名称：
                            </div>
                            <div class="col-md-2">
                                <input id="resourceName" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div>
                        <div class="form-row block" style="overflow-y:auto;">
                            <table id="tablePrivate" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var tablePrivate;
    $(document).ready(function () {
        tablePrivate = $("#tablePrivate").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourcePrivate/getResourcePrivateList',
            },
            "destroy": true,
            "columns": [
                {"data":"resourceId","visible":false},
                {"data": "uploadPersonCode", "visible": false},
                {"data": "uploadDeptCode", "visible": false},
                {"data": "resourceTypeCode", "visible": false},
                {"width": "15%","data":"resourceName","title":"资源名称"},
                {"width": "10%","data":"resourceType","title":"资源分类"},
                {"width": "10%","data":"uploadPersonId","title":"上传人"},
                {"width": "10%","data":"uploadDeptId","title":"上传人部门"},
                {"width": "10%","data":"uploadTime","title":"上传时间"},
                {"width": "15%","data":"publicFlagShow","title":"公共资源标识"},
                {"width": "15%","data":"classicFlagShow","title":"精品课标识"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        var re = '<span class="icon-edit" title="查看" onclick=edit("' + row.resourceId + '")></span>';
                        if(row.publicFlag == 0 || row.publicFlag == '0' ){
                            re = re + "&ensp;&ensp;<span class='icon-arrow-up' title='设置共享资源' onclick=upreasources('"
                                + row.uploadPersonId + "','" + row.resourceId + "','" + row.resourceName + "','" +
                                row.resourceTypeCode + "','" + row.uploadPersonCode + "','" + row.uploadDeptCode +
                                "')/></span>";
                        }
/*                        if(row.classicFlag == 0 || row.classicFlag == '0' ){
                            re = re + '&ensp;&ensp;<span class="icon-gift" title="设置精品课" onclick=upreasources("' + row.resourceId + '","' + row.resourceName + '","2")/></span>';
                        }*/
                        if(row.publicFlag == 0 || row.publicFlag == '0' || row.classicFlag == 0 || row.classicFlag == '0' ){
                            re = re +'&ensp;&ensp;<span class="icon-trash" title="删除" onclick=del("' + row.resourceId + '","'+row.resourceName+'")/></span>&ensp;&ensp;';
                        }
                        return re;
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/resourcePrivate/toResourcePrivateAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        window.open("<%=request.getContextPath()%>/resourcePrivate/getPrivateResourceViewMain?resourceId="+id);
    }

    function del(id,resourceName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "资源名称："+resourceName+"  ,  删除后将无法恢复，请谨慎操作！",
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
                    type: "success"
                });
                tablePrivate.ajax.reload();
            });
        })
    }
    function search() {
        var resourceName = $("#resourceName").val();
        if (resourceName == "") {
        } else{
            tablePrivate.ajax.url("<%=request.getContextPath()%>/resourcePrivate/getResourcePrivateList?resourceName="+resourceName).load();
        }
    }
    function searchclear() {
        $("#resourceName").val("");
        tablePrivate.ajax.url("<%=request.getContextPath()%>/resourcePrivate/getResourcePrivateList?").load();
    }
    function upreasources(requester, resourceId, resourceName, resourceTypeCode, uploadPersonCode, uploadDeptCode) {

        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/approval/setPublicResource2" +
            "?resourceId=" + resourceId +
            "&resourceName=" + resourceName +
            "&requester=" + requester + "&resourceType=" + resourceTypeCode + "&uploadPersonCode=" + uploadPersonCode + "&uploadDeptCode=" + uploadDeptCode);
        $("#dialog").modal("show")
    }
</script>
