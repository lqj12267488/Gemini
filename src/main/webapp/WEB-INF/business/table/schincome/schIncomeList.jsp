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
                            学校总收入：
                        </div>
                        <div class="col-md-2">
                            <input id="incomeAllSel">
                        </div>
                        <div class="col-md-1 tar">
                            学费合计收入：
                        </div>
                        <div class="col-md-2">
                            <input id="sfAllSel">
                        </div>
                        <div class="col-md-1 tar">
                            学费序号：
                        </div>
                        <div class="col-md-2">
                            <input id="sfIndSel">
                        </div>
                  </div>
                        <div class="col-md-1 tar">
                            学生类别：
                        </div>
                        <div class="col-md-2">
                            <input id="sfStuTypeSel">
                        </div>
  <div class="form-row">
                        <div class="col-md-1 tar">
                            标准（元/生）：
                        </div>
                        <div class="col-md-2">
                            <input id="sfStdSel">
                        </div>
                        <div class="col-md-1 tar">
                            金额（万元）：
                        </div>
                        <div class="col-md-2">
                            <input id="sfMoneySel">
                        </div>
                        <div class="col-md-1 tar">
                            补助收入合计：
                        </div>
                        <div class="col-md-2">
                            <input id="awAllSel">
                        </div>
                  </div>
                        <div class="col-md-1 tar">
                            补助序号：
                        </div>
                        <div class="col-md-2">
                            <input id="awIndexSel">
                        </div>
  <div class="form-row">
                        <div class="col-md-1 tar">
                            项目名称（全称）：
                        </div>
                        <div class="col-md-2">
                            <input id="awProNameSel">
                        </div>
                        <div class="col-md-1 tar">
                            补助标准：
                        </div>
                        <div class="col-md-2">
                            <input id="awStdSel">
                        </div>
                        <div class="col-md-1 tar">
                            项目金额：
                        </div>
                        <div class="col-md-2">
                            <input id="awProMoneySel">
                        </div>
                  </div>
                        <div class="col-md-1 tar">
                            财政专项投入合计：
                        </div>
                        <div class="col-md-2">
                            <input id="finAllSel">
                        </div>
  <div class="form-row">
                        <div class="col-md-1 tar">
                            序号：
                        </div>
                        <div class="col-md-2">
                            <input id="finIndexSel">
                        </div>
                        <div class="col-md-1 tar">
                            项目名称（全称）：
                        </div>
                        <div class="col-md-2">
                            <input id="finProNameSel">
                        </div>
                        <div class="col-md-1 tar">
                            项目金额（万元）：
                        </div>
                        <div class="col-md-2">
                            <input id="finProMoneySel">
                        </div>
                  </div>
                        <div class="col-md-1 tar">
                            社会捐赠金额（万元）：
                        </div>
                        <div class="col-md-2">
                            <input id="ssDonateSel">
                        </div>
  <div class="form-row">
                        <div class="col-md-1 tar">
                            其他收入总额：
                        </div>
                        <div class="col-md-2">
                            <input id="otherIncomeSel">
                        </div>
                        <div class="col-md-1 tar">
                            贷款金额（万元）：
                        </div>
                        <div class="col-md-2">
                            <input id="loanSel">
                        </div>
                        <div class="col-md-1 tar">
                            贷款余额（万元）：
                        </div>
                        <div class="col-md-2">
                            <input id="loanBalSel">
                        </div>
                  </div>
                <div class="col-md-2 tar">
                    <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                    <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                </div>
            </div>
            </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
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
    $(document).ready(function () {


        search();
    })

    function search() {
        $("#table").DataTable({
             "processing": true,
             "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/SchIncome/getSchIncomeList',
                "data": {
                    incomeAll: $("#incomeAllSel").val(),
                    sfAll: $("#sfAllSel").val(),
                    sfInd: $("#sfIndSel").val(),
                    sfStuType: $("#sfStuTypeSel").val(),
                    sfStd: $("#sfStdSel").val(),
                    sfMoney: $("#sfMoneySel").val(),
                    awAll: $("#awAllSel").val(),
                    awIndex: $("#awIndexSel").val(),
                    awProName: $("#awProNameSel").val(),
                    awStd: $("#awStdSel").val(),
                    awProMoney: $("#awProMoneySel").val(),
                    finAll: $("#finAllSel").val(),
                    finIndex: $("#finIndexSel").val(),
                    finProName: $("#finProNameSel").val(),
                    finProMoney: $("#finProMoneySel").val(),
                    ssDonate: $("#ssDonateSel").val(),
                    otherIncome: $("#otherIncomeSel").val(),
                    loan: $("#loanSel").val(),
                    loanBal: $("#loanBalSel").val(),
                }
            },
            "destroy": true,
            "columns": [
                 {"data": "id", "title": "主键id", "visible": false},
                 {"data": "incomeAll", "title": "学校总收入"},
                 {"data": "sfAll", "title": "学费合计收入"},
                 {"data": "sfInd", "title": "学费序号"},
                 {"data": "sfStuType", "title": "学生类别"},
                 {"data": "sfStd", "title": "标准（元/生）"},
                 {"data": "sfMoney", "title": "金额（万元）"},
                 {"data": "awAll", "title": "补助收入合计"},
                 {"data": "awIndex", "title": "补助序号"},
                 {"data": "awProName", "title": "项目名称（全称）"},
                 {"data": "awStd", "title": "补助标准"},
                 {"data": "awProMoney", "title": "项目金额"},
                 {"data": "finAll", "title": "财政专项投入合计"},
                 {"data": "finIndex", "title": "序号"},
                 {"data": "finProName", "title": "项目名称（全称）"},
                 {"data": "finProMoney", "title": "项目金额（万元）"},
                 {"data": "ssDonate", "title": "社会捐赠金额（万元）"},
                 {"data": "otherIncome", "title": "其他收入总额"},
                 {"data": "loan", "title": "贷款金额（万元）"},
                 {"data": "loanBal", "title": "贷款余额（万元）"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            paging: true,
            language: language
        });
    }

    function searchClear() {
        $(".form-row div input,.form-row div select").val("");
        search();
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/SchIncome/toSchIncomeAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/SchIncome/toSchIncomeEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/SchIncome/delSchIncome?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#table').DataTable().ajax.reload();
                });
            })
        });
    }
</script>