<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/8/29
  Time: 15:33
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
                                <input id="arrayClassName"/>
                            </div>
                            <div class="col-md-1 tar">
                                学期：
                            </div>
                            <div class="col-md-2">
                                <select id="term" class="validate[required,maxSize[100]] form-control"></select>
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
    var arrayClassTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'term','${arrayClass.term}');
        });
        search();
        arrayClassTable.on('click', 'tr a', function () {
            var data = arrayClassTable.row($(this).parent()).data();
            var arrayClassId = data.arrayClassId;
            var arrayClassName = data.arrayClassName;
            if (this.id == "classList") {
                $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/classSyllabusList?arrayClassId=" + arrayClassId+"&arrayClassName="+arrayClassName);
            }
        });
    })

    function searchclear() {
        $("#arrayClassName").val("");
        $("#term").val("");
        search();
    }

    function search() {
        var arrayClassName = $("#arrayClassName").val();
        arrayClassName='%'+arrayClassName+'%';
        var term = $("#term option:selected").val();
        arrayClassTable = $("#arrayClassGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClassResultClass/getArrayClassList',
                "data": {
                    arrayClassName:  arrayClassName,
                    term: term
                }
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
                        return "<a id='classList' class='icon-th-list' title='查看教师列表'></a>";
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    }
</script>
