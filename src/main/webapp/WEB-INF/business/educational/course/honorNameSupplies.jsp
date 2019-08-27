<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/6
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px){
        .tar{
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
                                荣誉名称：
                            </div>
                            <div class="col-md-2">
                                <input id="dname" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchUserDic()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclearHonorNameSupplies()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addHonorNameSupplies()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="honorNameSuppliesGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var honorNameSuppliesTable;
    $(document).ready(function () {
        searchUserDic();

        honorNameSuppliesTable.on('click', 'tr a', function () {
            var data = honorNameSuppliesTable.row($(this).parent()).data();
            var id = data.id;
            var dicname= data.dicname;
            var editUrl="/business/educational/course/editHonorNameSupplies";
            if (this.id == "uHonorNameSupplies") {
                $("#dialog").load("<%=request.getContextPath()%>/userDic/editUserDic?id=" + id +"&editUrl=" + editUrl);
                $("#dialog").modal("show");
            }
            if (this.id == "delHonorNameSupplies") {
                swal({
                    title: "请确认是否要删除本条记录?",
                    text: "荣誉名称："+dicname+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "green",
                    confirmButtonText: "确认",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/userDic/deleteUserDicById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"});
                            $('#honorNameSuppliesGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
        });
    })

    function addHonorNameSupplies() {
        /*urlName 新增页jsp路径*/
        var urlName="/business/educational/course/addHonorNameSupplies";
        $("#dialog").load("<%=request.getContextPath()%>/userDic/addUserDicSupplies?urlName=" + urlName);
        $("#dialog").modal("show");
    }

    function searchclearHonorNameSupplies() {
        $("#dname").val("");
        searchUserDic();
    }

    function searchUserDic() {
        var v_name = $("#dname").val();
        if (v_name != "") {
            v_name = '%' + v_name + '%';
        }
        honorNameSuppliesTable = $("#honorNameSuppliesGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/userDic/searchUserDic',
                "data": {
                    dicname:v_name
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"50%","data": "dicname", "title": "荣誉名称"},
                {"data": "dicorder", "visible": false},
                {"data": "dictype", "visible": false},
                {
                    "width":"50%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uHonorNameSupplies' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delHonorNameSupplies' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [3,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
    }
</script>
