<%--资产报废申请
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
                                文件名称：
                            </div>
                            <div class="col-md-2">
                                <input id="rewordPersonId" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="searchAssets()">
                                    查询</button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addRewards()">
                            新增</button>
                        <br>
                    </div>
                    <table id="collegeDocumentGrid" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                        <thead>
                        <tr>

                            <th width="10%">序号</th>
                            <th>id</th>
                            <th>createTime</th>
                            <th width="30%">文件名称</th>
                            <th width="20%">上传时间</th>
                            <th width="10%">附件数量</th>
                            <th width="10%">操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_JW_POLICY_DOCUMENT">
<input id="businessId" hidden>
<script>
    var roleTable;

    $(document).ready(function () {
        searchAssets();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var documentName =data.documentName;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/policyDocument/addPolicyDocument?id=" + id +"&type=3");
                $("#dialog").modal("show");
            }
            if (this.id == "upload"){
                $.get("<%=request.getContextPath()%>/policyDocument/getRoleByPersonIds", function (boolean) {
                    if (boolean) {
                        $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_JW_POLICY_DOCUMENT');
                        $('#dialogFile').modal('show');
                    } else {
                        $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload1?businessId=' + id + '&businessType=TEST&tableName=T_JW_POLICY_DOCUMENT');
                        $('#dialogFile').modal('show');
                    }
                })
            }
            if (this.id == "delRole") {
                swal({
                    title: "请确认是否要删除本条申请?",
                    text: "文件名称："+documentName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/policyDocument/deleteCollegeDocumentById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#collegeDocumentGrid').DataTable().ajax.reload();

                    });
                })
            }
        });
    })
    /*添加*/
    function addRewards() {
        $("#dialog").load("<%=request.getContextPath()%>/policyDocument/addPolicyDocument?type=3");
        $("#dialog").modal("show");
    }
    /*清空*/
    function searchclear() {
        $("#rewordPersonId").val("");
        searchAssets();
    }
    /*查询*/
    function searchAssets() {
        var rewordPersonId=$("#rewordPersonId").val();
        if(rewordPersonId!=""){
            rewordPersonId=rewordPersonId;
        }
        roleTable = $("#collegeDocumentGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/policyDocument/collegeDocumentAction',
                "data": {
                    documentName: rewordPersonId
                }
            },
            "destroy": true,
            "columns": [
                { name: "SerialNum", data: "serialNumber", "searchable": false, "orderable": false },
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                { "data": "documentName"},
                { "data": "time"},
                { "data": "fileNumber"},
                { "render": function ()
                    {return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                        "<a id='delRole' class='icon-trash' title='删除'></a>"
                    }
                }
            ],
            "columnDefs": [{
                "orderable": false
            }],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        roleTable.on('order.dt search.dt',function(){
            roleTable.column(0,{
                search: 'applied',
                order: 'applied'
            }).nodes().each(function(cell,i){
                i = i + 1;
                var page = roleTable.page.info();
                var pageno = page.page;
                var length = page.length;
                var columnIndex = (i+pageno*length);
                cell.innerHTML = columnIndex;
            });
        }).draw();
    }
    function reloadFileNumber() {
        $('#collegeDocumentGrid').DataTable().ajax.reload();
    }
</script>

