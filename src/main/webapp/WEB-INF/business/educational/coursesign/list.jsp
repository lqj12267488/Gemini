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
    <input id="creator" value="${userId}" hidden>
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            计划名称:
                        </div>
                        <div class="col-md-2">
                            <input id="planSel" type="text"/>
                        </div>
                        <div class="col-md-1 tar">
                            创建年份:
                        </div>
                        <div class="col-md-2">
                            <select id="yearSel" />
                        </div>
                        <div class="col-md-1 tar">
                            系部名称:
                        </div>
                        <div class="col-md-2">
                            <select id="departmentsSel"/>
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
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsSel');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'yearSel' );
        });

        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/courseplan/getList?creator='+$("#creator").val(),
            },
            "destroy": true,
            "columns": [
                {"data": "createTime","visible": false},
                {"data": "planName", "title": "计划名称"},
                {"data": "year", "title": "创建年份"},
                {"data": "departmentsId", "title": "系部名称"},
                {"data": "majorShow", "title": "专业名称"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="计划管理" onclick=planManage("' + row.planId + '","' + row.planName + '")/>';
                    }
                }
            ],
            'order' : [0,'desc'],
            "dom": 'rtlip',
            language: language
        });
    });

    function planManage(id, planName) {
        $("#right").load("<%=request.getContextPath()%>/coursesign/toPlanDetails?id=" + id + "&planName=" + planName)
    }

    function search() {
        var departmentsSel = $("#departmentsSel option:selected").val();
        if(departmentsSel == undefined || departmentsSel == null ){
            departmentsSel ="";
        }
        var yearSel = $("#yearSel option:selected").val();
        if(yearSel == undefined || yearSel == null ){
            yearSel ="";
        }
        var planName = $("#planSel").val();
        table.ajax.url("<%=request.getContextPath()%>/courseplan/getList?"+
            "planName=" + planName +"&departmentsId="+departmentsSel+"&year="+yearSel+'&creator='+$("#creator").val()
        ).load();
    }

    function searchclear() {
        $("#yearSel option:selected").val("");
        $("#yearSel").val("");
        $("#departmentsSel option:selected").val("");
        $("#departmentsSel").val("");
        $("#planSel").val("");
        search();
    }

</script>