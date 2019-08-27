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

                <div class="block block-drop-shadow content block-fill-white">
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
                            <select id="s_term"/>
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
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 's_term', '${arrayClass.term}');
        });
        $("#arrayClassGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClass/getArrayClassList',
            },
            "destroy": true,
            "columns": [
                {"width": "22%", "data": "arrayClassName", "title": "排课计划"},
                {"width": "22%", "data": "term", "title": "学期"},
                {"width": "22%", "data": "arrayClassFlagShow", "title": "排课状态"},
                {"width": "22%", "data": "remark", "title": "备注"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="维护班级教学计划" onclick=toArrayClassClassList("' + row.arrayClassId + '","'+row.arrayClassName+'")/>&ensp;&ensp;';
                    }
                }
            ],
            'order': [[1, 'desc'], [2, 'desc']],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    })

    function toArrayClassClassList(id,arrayClassName) {
        $("#right").load("<%=request.getContextPath()%>/arrayclassplan/toArrayClassClassList?id=" + id + "&arrayClassName=" + arrayClassName);

    }

    function searchclear() {
        $("#s_arrayClassName").val("");
        $("#s_term").val("");
        search();
    }

    function search() {
        var t_arrayClassName = $("#s_arrayClassName").val();
        var t_term = $("#s_term option:selected").val();
        $('#arrayClassGrid').DataTable().ajax.url("<%=request.getContextPath()%>/arrayClass/getArrayClassList?term=" + t_term + "&arrayClassName=" + t_arrayClassName).load();
    }
</script>