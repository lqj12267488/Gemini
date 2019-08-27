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
                                身份证号：
                            </div>
                            <div class="col-md-2">
                                <input id="idcardSel" type="text"></input>
                            </div>
                            　      <%--                            <div class="col-md-1 tar">
                                        教职工号：
                                    </div>
                                    <div class="col-md-2">
                                        <input id="staffIdSel" type="number"></input>
                                    </div>--%>
                            <div class="col-md-1 tar">
                                年：
                            </div>
                            <div class="col-md-2">
                                <input id="yearSel" type="number" min="2016" max="2050" ></input>
                            </div>
                            <div class="col-md-1 tar">
                                月：
                            </div>
                            <div class="col-md-2">
                                <input id="monthSel" type="number" min="1" max="12"></input>
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
                    <div class="form-row">
                        <button type="button" class="btn btn-info btn-clean" onclick="addSalary()">新增</button>
                        <a id="expdata" class="btn btn-info btn-clean" >导出</a>
                        <button type="button" class="btn btn-info btn-clean" onclick="showSalaryDialog()">导入</button>
                    </div>
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

        search();
        salaryTable.on('click', 'tr a', function () {
            var data = salaryTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "updateSalary") {
                $("#dialog").load("<%=request.getContextPath()%>/salary/getUpdateSalary?id=" + id);
        $("#dialog").modal("show");
    }
    if (this.id == "viewList") {
        $("#dialog").load("<%=request.getContextPath()%>/salary/viewList?id=" + id);
        $("#dialog").modal("show");
    }
    if (this.id == "deleteSalary") {
        <%--if (confirm("请确认是否要删除本条记录?")) {--%>
            <%--$.get("<%=request.getContextPath()%>/salary/deleteSalary?id=" + id, function (msg) {--%>
                <%--alert(msg.msg);--%>
                <%--search();--%>
            <%--})--%>
        <%--}--%>
    <%--}--%>
            swal({
                title: "您确定要删除本条信息?",
                text: "教职工姓名："+data.name+"\n\n删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                closeOnConfirm: false
            }, function () {
                $.get("<%=request.getContextPath()%>/salary/deleteSalary?id=" + id, function (msg) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    //alert(msg.msg);
                    search();
                });
            })

        }
    });
    })

    function addSalary() {
        $("#dialog").load("<%=request.getContextPath()%>/salary/getAddSalary");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#idcardSel").val("");
        //$("#staffIdSel").val("");
        $("#yearSel").val("");
        $("#monthSel").val("");
        search();
    }

    function search() {
        var idcardSel = $("#idcardSel").val();
        //var staffIdSel = $("#staffIdSel").val();
        var yearSel = $("#yearSel").val();
        var monthSel = $("#monthSel").val();
        if( null !=yearSel && yearSel!="" && (yearSel.length!=4  || yearSel< 0) ){
            alert("请输入正确的年份");
            $("#yearSel").val("");
            return;
        }

/*
        if( (null ==yearSel || yearSel=="" ) && monthSel.length>0 ){
            alert("请输入年份");
            $("#yearSel").val("");
            return;
        }
*/

        if( null !=monthSel && monthSel!="" && ( parseInt(monthSel)>12  || monthSel< 0 ) ){
            alert("请输入正确的月份");
            $("#monthSel").val("");
            return;
        }
        salaryTable = $("#salaryGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/salary/getSalaryList',
                "data": {
                    year:yearSel,
                    month:monthSel,
                    idcard:idcardSel
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "20%", "data": "name", "title": "教职工姓名"},
                {"width": "20%", "data": "idcard", "title": "身份证号"},
                /*{"width": "20%", "data": "staffId", "title": "教职工号"},*/
                {"width": "16%", "data": "year", "title": "年"},
                {"width": "16%", "data": "month", "title": "月"},
                {"width": "16%", "data": "realSalary", "title": "实发合计"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='updateSalary' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='viewList' class='icon-book' title='详细'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='deleteSalary' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
        exportSalary(idcardSel,yearSel,monthSel);
    }

    function exportSalary(idcardSel,yearSel,monthSel){
        var href = "<%=request.getContextPath()%>/salary/exportSalary?year="+yearSel+"&month="+monthSel+"&idcard="+idcardSel;//+"&staffId="+staffIdSel;
        $("#expdata").attr("href",href);
    }

    function showSalaryDialog() {
        $("#dialog").load("<%=request.getContextPath()%>/salary/toImportSalary");
        $("#dialog").modal("show");
    }

</script>