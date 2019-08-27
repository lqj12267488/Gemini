<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/18
  Time: 10:52
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
                            <div  class="col-md-1 tar">
                                专业名称：
                            </div>
                            <div class="col-md-2">
                                <select id="majorCodeSel" class="js-example-basic-single"></select>
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
                        <table id="employmentsGrid" cellpadding="0" cellspacing="0"
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
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " major_code",
            text: " major_name ",
            tableName: " t_xg_major ",
            where: " WHERE 1 = 1 and valid_flag = '1' " ,
            orderby: " order by create_time desc"
        },function (data) {
            addOption(data, "majorCodeSel");
        });
        search();

    })

    function searchclear() {
        $("#majorCodeSel").val("");
        $("#majorCodeSel option:selected").val("");
        search()
    }

    function search() {
        roleTable = $("#employmentsGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/employments/selectEmploymentStatistics',
                "data": {
                    majorCode:$("#majorCodeSel option:selected").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "majorCode", "title": "专业名称"},
                {"width": "10%", "data": "employmentYear", "title": "毕业年份"},
                {"width": "10%", "data": "legalPerson", "title": "就业人数"},
                {"width": "10%", "data": "registeredCapital", "title": "实习留用人数"},
                {"width": "10%", "data": "personNumber", "title": "对口就业人数"},
                {"width": "10%", "data": "unitProperty", "title": "就业去向"},
                {"width": "10%", "data": "employmentIndustryShow", "title": "就业产业"},
                {"width": "10%", "data": "employmentAreaShow", "title": "就业地域"},
                {"width": "10%", "data": "employmentPlaceShow", "title": "就业地点"},
                {"width": "10%", "data": "enterpriseCategory", "title": "就业渠道"},

            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    }
</script>

