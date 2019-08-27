<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
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
                               表格种类：
                            </div>
                            <div class="col-md-2">
                                <input id="cName" class="js-example-basic-single"></input>
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
                </div>
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addTabularType()">新增
                        </button>
                        <br>
                    </div>
                    <table id="costItemTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#costItemTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/userDic/getUserDicList',

            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "diccode", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"50%","data": "dicname", "title": "表格种类"},
                {
                    "width":"50%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editCost' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delCost' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [0,'desc'],
            "dom": 'rtlip',
            "language": language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.id;
            var dicCode = data.diccode;
            var dicName = data.dicname;
            var editUrl="/business/tabular/editTabularType";
            if (this.id == "editCost") {
                $("#dialog").load("<%=request.getContextPath()%>/userDic/editUserDic?id=" + id +"&editUrl=" +editUrl);
                $("#dialog").modal("show");
            }
            if (this.id == "delCost") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "表格种类："+dicName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/tabular/checkTabular", {
                        tabularType: dicCode
                    }, function (msg) {
                        if(msg.status==1){
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                        }else{
                            $.get("<%=request.getContextPath()%>/userDic/deleteUserDicById?id=" + id, function (msg) {
                                if (msg.status == 1) {
                                    swal({
                                        title: msg.msg,
                                        type: "success"
                                    });
                                    $('#costItemTable').DataTable().ajax.reload();
                                }
                            })
                        }

                    })

                });
            }
        });
    })

    function addTabularType() {
        var urlName="/business/tabular/addTabularType";
        $("#dialog").load("<%=request.getContextPath()%>/userDic/addUserDicSupplies?urlName=" + urlName);
        $("#dialog").modal("show");
    }



    function searchClear() {
        $("#cName").val("");
        table.ajax.url("<%=request.getContextPath()%>/userDic/searchUserDic").load();
    }

    function search() {
        var cName = $("#cName").val();
        if (cName != "") {
            table.ajax.url("<%=request.getContextPath()%>/userDic/searchUserDic?dicname="+cName).load();
        }
    }


</script>