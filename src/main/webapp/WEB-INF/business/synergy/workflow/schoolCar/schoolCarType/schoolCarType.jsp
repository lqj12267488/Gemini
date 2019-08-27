<%--学校车辆类型管理页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/12
  Time: 10:38
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
                                车辆类型：
                            </div>
                            <div class="col-md-2">
                                <input id="dname" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchUserDic()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclearSchoolCarType()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addSchoolCarType()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="schoolCarTypeGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var schoolCarTypeTable;

    $(document).ready(function () {
        searchUserDic();

        schoolCarTypeTable.on('click', 'tr a', function () {
            var data = schoolCarTypeTable.row($(this).parent()).data();
            var id = data.id;
            var dicname = data.dicname;
            var editUrl="/business/synergy/workflow/schoolCar/schoolCarType/editSchoolCarType";
            if (this.id == "uSchoolCarType") {
                $("#dialog").load("<%=request.getContextPath()%>/userDic/editUserDic?id=" + id +"&editUrl=" + editUrl);
                $("#dialog").modal("show");
            }
            if (this.id == "delSchoolCarType") {
                swal({
                    title: "申请人确定要确认吗?",
                    text: "车辆类型："+dicname+"\n\n删除后将无法恢复，请谨慎操作！",
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
                            $('#schoolCarTypeGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
        });
    })

    function addSchoolCarType() {
        /*urlName 新增页jsp路径*/
        var urlName="/business/synergy/workflow/schoolCar/schoolCarType/editSchoolCarType";
        $("#dialog").load("<%=request.getContextPath()%>/userDic/addUserDicSupplies?urlName=" + urlName);
        $("#dialog").modal("show");
    }

    function searchclearSchoolCarType() {
        $("#dname").val("");
        searchUserDic();
    }

    function searchUserDic() {
        var v_name = $("#dname").val();
        if (v_name != "") {
            v_name = '%' + v_name + '%';
        }
        schoolCarTypeTable = $("#schoolCarTypeGrid").DataTable({
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
                {"width":"50%","data": "dicname", "title": "车辆类型"},
                {"data": "dicorder", "visible": false},
                {"data": "dictype", "visible": false},
                {
                    "width":"50%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uSchoolCarType' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delSchoolCarType' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }

            ],
            'order' : [3,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
    }
</script>

