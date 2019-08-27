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
                            <div class="col-md-1 tar">
                                教材性质
                            </div>
                            <div class="col-md-2">
                                <select id="f_textbookNature"/>
                            </div>
                            <div class="col-md-1 tar">
                                教材编号：
                            </div>
                            <div class="col-md-2">
                                <input id="f_textbookNumber"/>
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
                        <button type="button" class="btn btn-default btn-clean" onclick="exportTextBookReportAll()">导出
                        </button>
                        <button type="button" class="btn btn-default btn-clean" id="exportList" onclick="exportTextBookReport()">
                            导出当前数据
                        </button>
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

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JCXZ", function (data) {
            addOption(data, 'f_textbookNature');
        });

        table = $("#table").DataTable({
            "processing": false,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/getTextBookInventory',
            },
            "destroy": true,
            "columns": [
                {
                    width: "10%",
                    "title": '<input type="checkbox" class="checkall"  name="checkbox" />',
                    "render": function (data, type, row) {
                        return '<input type="checkbox" name="checkbox" value="' + row.textbookId + '"/>';
                    }
                },
                {"data": "createTime", "visible": false},
                {"data": "textbookId", "visible": false},
                {"data": "textbookName", "title": "教材名称"},
                {"data": "textbookNumber", "title": "教材编号"},
                {"data": "textbookNature", "title": "教材性质"},
                {"data": "textbookCategory", "title": "教材类型"},
                {"data": "publishingHouse", "title": "出版社"},
                {"data": "firstEditorCompany", "title": "第一主编单位"},
                {"data": "editor", "title": "主编"},
                {"data": "edition", "title": "版次"},
                {"data": "subscribeCode", "title": "征订代号"},
                {"data": "versionDate", "title": "版本日期"},
                {"data": "price", "title": "单价"},
                {"data": "textbookNumIn", "title": "在库数量"},
                {"data": "remark", "title": "备注"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        var str='<span class="icon-edit" title="入库" onclick=edit("' + row.textbookId + '","' + row.textbookNumIn + '")/>&ensp;&ensp;' +
                            '<span class="icon-search" title="详情" onclick=searchList("' + row.textbookId + '")/>';
                        //alert(str);
                        return str
                    }
                }
            ],
            'order' : [0,'desc'],
            paging:true,
            "dom": 'rtlip',
            language: language
        });
        $(".checkall").bind("click", function () {
            if ($(this).attr("checked") == 'checked') {
                $("input[name=checkbox]").each(function(i,o){
                    $(this).attr("checked", true);
                });
            } else {
                $("input[name=checkbox]").each(function(i,o){
                    $(this).attr("checked", false);
                });
            }
        });

    })

    function edit(id,textbookNumIn) {
        $("#dialog").load("<%=request.getContextPath()%>/addTextBookInventory?textbookId=" + id  +"&textbookNumIn=" + textbookNumIn );
        $("#dialog").modal("show");
    }

    function searchList(id) {
        $("#right").load("<%=request.getContextPath()%>/textBookLogList?id=" + id);
        $("#right").modal("show");
    }

    function search() {
        var textbookNature = $("#f_textbookNature").val();
        var textbookNumber = $("#f_textbookNumber").val();
        var textbookName = $("#searchTextbookName").val();
        var url = "<%=request.getContextPath()%>/getTextBookInventory?textbookName="+textbookName+"&textbookNature=" + textbookNature + "&textbookNumber=" + textbookNumber;
        $("#table").DataTable().ajax.url(url).load();
    }
    function exportTextBookReportAll() {
        window.location.href = "<%=request.getContextPath()%>/exportTextBookListInventory?textbookName=" + $("#searchTextbookName").val()
            + "&textbookNumber=" + $("#f_textbookNumber").val() + "&textbookNature=" + $("#f_textbookNature").val();
    }

    function exportTextBookReport() {
        var ids = "";
        $("input[name=checkbox]").each(function (index, item) {
            if ($(item).attr("checked") == 'checked') {
                ids += $(item).val() + "','";
            }
        });
        if (ids == "") {
            swal({
                title: "请选择要导出的学生！",
                type: "error"
            })
        } else {
            window.location.href = "<%=request.getContextPath()%>/exportTextBookListIds?ids=" + ids.substring(0, ids.length - 3);
        }
        $(".checkall").attr("checked", false);
    }

    function searchclear() {
        $("#f_textbookNature").val("");
        $("#f_textbookNumber").val("");
        $("#searchTextbookName").val("");
        $("#f_textbookNature option:selected").val("");
        var url = "<%=request.getContextPath()%>/getTextBookInventory";
        $("#table").DataTable().ajax.url(url).load();
    }

</script>