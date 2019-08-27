<%--
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
                                维修耗材名称：
                            </div>
                            <div class="col-md-2">
                                <input id="dname" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchUserDic()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclearComputerSupplies()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addComputerSupplies()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="repairTypeGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var repairTypeTable;

    $(document).ready(function () {
        repairTypeTable = $("#repairTypeGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/userDic/getUserDicList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"50%","data": "dicname", "title": "维修耗材名称"},
                {"data": "dicorder", "visible": false},
                {"data": "dictype", "visible": false},
                {
                    "width":"50%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uComputerSupplies' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delComputerSupplies' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [3,'desc'],
            "dom": 'rtlip',
            language: language
        });
        repairTypeTable.on('click', 'tr a', function () {
            var data = repairTypeTable.row($(this).parent()).data();
            var rid = data.id;
            var dicname = data.dicname;
            var editUrl="business/logistics/repair/editSuppliesType";
            if (this.id == "uComputerSupplies") {
                $("#dialog").load("<%=request.getContextPath()%>/userDic/editUserDic?id=" + rid +"&editUrl=" + editUrl);
                $("#dialog").modal("show");
            }
            if (this.id == "delComputerSupplies") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "维修耗材："+dicname+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/userDic/deleteUserDicById", {
                        id: rid
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#repairTypeGrid').DataTable().ajax.reload();

                    });

                });
               /* if (confirm("请确认是否要删除本条记录?")) {
                    $.get("/userDic/deleteUserDicById?id=" + rid, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#repairTypeGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
        });
    })

    function addComputerSupplies() {
        /*urlName 新增页jsp路径*/
        var urlName="business/logistics/repair/editSuppliesType";
        $("#dialog").load("<%=request.getContextPath()%>/userDic/addUserDicSupplies?urlName=" + urlName);
        $("#dialog").modal("show");
    }

    function searchclearComputerSupplies() {
        $("#dname").val("");
        searchUserDic();
    }

    function searchUserDic() {
        var dicname = $("#dname").val();
        repairTypeTable.ajax.url("<%=request.getContextPath()%>/userDic/searchUserDic?dicname=" +dicname).load();
    }
        /*var v_name = $("#dname").val();
        if (v_name != "") {
            v_name = '%' + v_name + '%';
        }
        repairTypeTable = $("#repairTypeGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '/userDic/searchUserDic',
                "data": {
                    dicname:v_name
                }
            }*/
           /* "destroy": true,
           /!* "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"50%","data": "dicname", "title": "维修耗材名称"},
                {"data": "dicorder", "visible": false},
                {"data": "dictype", "visible": false},
                {
                    "width":"50%",
                    "title": "操作",
                    "render": function () {
                        return render;
                    }
                }

            ],*!/
            'order' : [3,'desc'],
            "dom": '<"rtlip">rtlip',
            language: language*/
      /*  });*/
  /*  }*/
</script>
