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
                                教材名称：
                            </div>
                            <div class="col-md-2">
                                <input id="searchTextbookName"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">
                                    清空
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
                        <a id="expdata" class="btn btn-default btn-clean" >导出</a>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
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
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/textbook/getTextBookList?textbookType=${type}',
            },
            "destroy": true,
            "columns": [
                {"data": "createTime", "visible": false},
                {"data": "textbookName", "title": "教材名称"},
                {"data": "textbookNumber", "title": "教材编号"},
                {"data": "textbookNature", "title": "教材性质"},
                {"data": "textbookCategory", "title": "教材类型"},
                {"data": "publishingHouse", "title": "出版社"},
                {"data": "firstEditorCompany", "title": "第一主编单位"},
                {"data": "editor", "title": "主编"},
                {"data": "edition", "title": "版次"},
                {"data": "price", "title": "单价"},
                {"data": "versionDate", "title": "版本日期"},
                {"data": "remark", "title": "备注"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.textbookId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.textbookId + '","' + row.textbookName + '")/>';
                    }
                }
            ],
            'order' : [0,'desc'],
            paging:true,
            "dom": 'rtlip',
            language: language
        });
        exportTextBook();
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/textbook/toAddTextBook", {
            type: '${type}'
        })
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/textbook/toEditTextBook?id=" + id+"&type=1")
        $("#dialog").modal("show")
    }
    function exportTextBook() {
        var href = "<%=request.getContextPath()%>/textbook/exportTextBook?textbookType=${type}";
        $("#expdata").attr("href",href);
    }

    function del(id,textbookName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "教材名称："+textbookName+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/textbook/delTextBook?id=" + id, function (data) {
                if(data.status==1){
                    swal({
                        title: data.msg,
                        type: "success"
                    });
                }else{
                    swal({
                        title: data.msg,
                        type: "error"
                    });
                }

                $('#table').DataTable().ajax.reload();
            })

        });
        /*if (confirm("确定要删除这条记录？")) {
            $.get("/textbook/delTextBook?id=" + id, function (data) {
                alert(data.msg);
                $('#table').DataTable().ajax.reload();
            })
        }*/
    }

    function search() {
        var textbookName = $("#searchTextbookName").val();
        $("#table").DataTable().ajax.url("<%=request.getContextPath()%>/textbook/getTextBookList?textbookType=${type}&textbookName=" + textbookName).load();
    }

    function searchclear() {
        $("#searchTextbookName").val("");
        $("#table").DataTable().ajax.url("<%=request.getContextPath()%>/textbook/getTextBookList?textbookType=${type}").load();
    }
</script>