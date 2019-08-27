<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/21
  Time: 9:27
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
                            <div class="col-md-1 tar" style="width:100px">
                                超市名称：
                            </div>
                            <div class="col-md-2">
                                <input id="supermarketName" type="text"/>
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
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="schoolBurseGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var schoolBurseTable;
    var render="<a id='update' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
        "<a id='delete' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"
       /* "<a id='detail' class='icon-search' title='查看'></a>";*/
    $(document).ready(function () {
        search();
        schoolBurseTable.on('click', 'tr a', function () {
            var data = schoolBurseTable.row($(this).parent()).data();
            var name = data.name;
            var id = data.id;
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/canteen/getcanteenById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delete") {
                swal({
                    title: "您删除："+name+"这个食堂吗?",
                    text: "请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/canteen/checkcanteenStaffById?id="+id, function (data) {
                        if(data.status ==1){
                            swal({
                                title: data.msg,
                                type: "error"
                            });
                        }else{
                            $.get("<%=request.getContextPath()%>/canteen/canteenDelete?id=" + id, function (msg) {
                                if (msg.status == 1) {
                                    swal({
                                        title: msg.msg,
                                        type: "success"
                                    });
                                    $('#schoolBurseGrid').DataTable().ajax.reload();
                                }
                            })
                        }
                    });
                });
            }
        });
    })
    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/canteen/canteenEdit" );
        $("#dialog").modal("show");
    }
    function searchclear() {
        $("#supermarketName").val("");
        search();
    }
    function search() {
        var supermarketName = $("#supermarketName").val();
        schoolBurseTable = $("#schoolBurseGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/canteen/canteenList',
                "data":{
                    name: supermarketName
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"10%","data": "name", "title": "食堂名称"},
                {"width":"10%","data": "address", "title": "食堂位置"},
                {"width":"10%","data": "personName", "title": "负责人姓名"},
                {"width":"10%","data": "personidCard", "title": "负责人身份证号"},
                {"width":"10%","data": "personTel", "title": "负责人联系方式"},
                {"width":"10%","data": "startTime", "title": "租赁开始时间"},
                {"width":"10%","data": "endTime", "title": "租赁到期时间"},
                {"width":"8%","title": "操作","render": function () {return render;}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>


