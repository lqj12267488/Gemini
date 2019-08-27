<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/9/30
  Time: 10:52
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/11
  Time: 10:09
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
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="departmentsIdSel" class="js-example-basic-single"></select>
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
                        <table id="employmentsGridid" cellpadding="0" cellspacing="0"
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
    var roleTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "departmentsIdSel");
            });
        search();
    })
    function searchclear() {
        $("#departmentsIdSel").val("");
        $("#departmentsIdSel option:selected").val("");
        search();
    }
    function search() {
        roleTable = $("#employmentsGridid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/employments/employmentSelectTongJi',
                "data": {
                    departmentsId:$("#departmentsIdSel option:selected").val()
                }
            },
            "destroy": true,
            "columns": [
                {"width": "12%", "data": "departmentsId", "title": "系部"},
                {"width": "14%", "data": "departmentsIdPersonNumber", "title": "系部总人数"},
                {"width": "12%", "data": "majorCode", "title": "专业"},
                {"width": "14%", "data": "majorCodePersonNumber", "title": "专业总人数"},
                {"width": "12%", "data": "employmentType", "title": "实习形式"},
                {"width": "12%", "data": "employmentPersonNumber", "title": "实习人数"},
                {"width": "12%", "data": "salaryShow", "title": "工资水平"},
                {"width": "12%", "data": "salaryPersonNumber", "title": "人数"},
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    }




</script>

