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
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">

                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                排课计划：
                            </div>
                            <div class="col-md-2">
                                <input id="s_arrayClassName"/>
                            </div>
                            <div class="col-md-1 tar">
                                学期：
                            </div>
                            <div class="col-md-2">
                                <select id="s_term"
                                        class="validate[required,maxSize[100]] form-control"></select>
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
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="arrayClassGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var arrayClass;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 's_term', '${arrayClass.term}');
        });
        arrayClass = $("#arrayClassGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClassResultClass/getArrayClassList',
            },
            "destroy": true,
            "columns": [
                {"data": "arrayClassId", "visible": false},
                {"width": "22%", "data": "arrayClassName", "title": "排课计划"},
                {"width": "22%", "data": "term", "title": "学期"},
                {"width": "22%", "data": "arrayClassFlagShow", "title": "排课状态"},
                {"width": "22%", "data": "remark", "title": "备注"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='viewFlag' class='icon-edit' title='查看班级列表'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delArray' class='icon-trash' title='清空排课'></a>";
                    }
                }
            ],
            'order': [[2, 'desc'], [1, 'desc']],
            "dom": 'rtlip',
            language: language
        });
        arrayClass.on('click', 'tr a', function () {
            var data = arrayClass.row($(this).parent()).data();
            var id = data.arrayClassId;
            var arrayClassName = data.arrayClassName;
            if (this.id == "viewFlag") {
                $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/classList?arrayClassId=" + id+"&arrayClassName="+data.arrayClassName);
            }
            if (this.id == "delArray") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "排课计划："+arrayClassName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/arrayClass/deleteArrayClassById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#arrayClassGrid').DataTable().ajax.reload();
                    });
                })
            }
        });
    })

//    function add() {
//        $("#dialog").load("/arrayClass/addArrayClass");
//        $("#dialog").modal("show");
//    }

    function searchclear() {
        $("#s_arrayClassName").val("");
        $("#s_term").val("");
        search();
    }

    function search() {
        var t_arrayClassName = $("#s_arrayClassName").val();
        var t_term = $("#s_term option:selected").val();
        arrayClass.ajax.url("<%=request.getContextPath()%>/arrayClassResultClass/getArrayClassList" +
            "?arrayClassName="+t_arrayClassName+"&term="+t_term).load();
    }
</script>