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
                                年：
                            </div>
                            <div class="col-md-2">
                                <input id="yearSel" type="number" />
                            </div>
                            <div class="col-md-1 tar">
                                月：
                            </div>
                            <div class="col-md-2">
                                <input id="monthSel" type="number" />
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
                        <table id="salaryGrid" cellpadding="0" cellspacing="0"
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
    var salaryTable;

    $(document).ready(function () {
        salaryTable = $("#salaryGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/salary/getSalaryList',
            },
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "20%", "data": "name", "title": "教职工姓名"},
                {"width": "20%", "data": "idcard", "title": "身份证号"},
                {"width": "16%", "data": "year", "title": "年"},
                {"width": "16%", "data": "month", "title": "月"},
                {"width": "16%", "data": "realSalary", "title": "实发合计"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='viewList' class='icon-book' title='详细'></a>";
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
        exportSalary();
        salaryTable.on('click', 'tr a', function () {
            var data = salaryTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "viewList") {
                $("#dialog").load("<%=request.getContextPath()%>/salary/viewList?id=" + id);
                $("#dialog").modal("show");
            }
        });
    })


    function searchclear() {
        $("#yearSel").val("");
        $("#monthSel").val("");
        search();
    }

    function search() {
        var yearSel = $("#yearSel").val();
        var monthSel = $("#monthSel").val();
        if( null !=yearSel && yearSel!="" && (yearSel.length!=4  || yearSel< 0) ){
            alert("请输入正确的年份");
            $("#yearSel").val("");
            return;
        }
        if( null !=monthSel && monthSel!="" && ( parseInt(monthSel)>12  || monthSel< 0 ) ){
            alert("请输入正确的月份");
            $("#monthSel").val("");
            return;
        }
        var href = "<%=request.getContextPath()%>/salary/exportSalary?year="+yearSel+"&month="+monthSel;

    }

    function exportSalary(){
        var yearSel = $("#yearSel").val();
        var monthSel = $("#monthSel").val();

        var href = "<%=request.getContextPath()%>/salary/exportSalary?year="+yearSel+"&month="+monthSel;
        $("#expdata").attr("href",href);
    }

</script>