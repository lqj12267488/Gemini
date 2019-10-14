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
                            学校总支出（万元）：
                        </div>
                        <div class="col-md-2">
                            <input id="expAllSel">
                        </div>
                        <div class="col-md-1 tar">
                            征地（万元）：
                        </div>
                        <div class="col-md-2">
                            <input id="landSel">
                        </div>
                        <div class="col-md-1 tar">
                            基础设施建设（万元）：
                        </div>
                        <div class="col-md-2">
                            <input id="expInfSel">
                        </div>
                  </div>
                        <div class="col-md-1 tar">
                            设备采购（万元）合计：
                        </div>
                        <div class="col-md-2">
                            <input id="expDevAllSel">
                        </div>
  <div class="form-row">
                        <div class="col-md-1 tar">
                            教学科研仪器设备值：
                        </div>
                        <div class="col-md-2">
                            <input id="expTeachDevSel">
                        </div>
                        <div class="col-md-1 tar">
                            实(验)训耗材：
                        </div>
                        <div class="col-md-2">
                            <input id="trainCostSel">
                        </div>
                        <div class="col-md-1 tar">
                            实习专项：
                        </div>
                        <div class="col-md-2">
                            <input id="trainProSel">
                        </div>
                  </div>
                        <div class="col-md-1 tar">
                            聘请兼职教师经费：
                        </div>
                        <div class="col-md-2">
                            <input id="hirePtTeachSel">
                        </div>
  <div class="form-row">
                        <div class="col-md-1 tar">
                            体育维持费：
                        </div>
                        <div class="col-md-2">
                            <input id="sportSel">
                        </div>
                        <div class="col-md-1 tar">
                            其他日常教学经费：
                        </div>
                        <div class="col-md-2">
                            <input id="dailyOthSel">
                        </div>
                        <div class="col-md-1 tar">
                            教学改革及研究合计经费：
                        </div>
                        <div class="col-md-2">
                            <input id="rsAllSel">
                        </div>
                  </div>
                        <div class="col-md-1 tar">
                            序号：
                        </div>
                        <div class="col-md-2">
                            <input id="rsIndSel">
                        </div>
  <div class="form-row">
                        <div class="col-md-1 tar">
                            项目名称（全称）：
                        </div>
                        <div class="col-md-2">
                            <input id="rsProNameSel">
                        </div>
                        <div class="col-md-1 tar">
                            项目金额：
                        </div>
                        <div class="col-md-2">
                            <input id="rsProMoneySel">
                        </div>
                        <div class="col-md-1 tar">
                            师资建设合计（万元）：
                        </div>
                        <div class="col-md-2">
                            <input id="tcAllSel">
                        </div>
                  </div>
                        <div class="col-md-1 tar">
                            序号：
                        </div>
                        <div class="col-md-2">
                            <input id="tcIndSel">
                        </div>
  <div class="form-row">
                        <div class="col-md-1 tar">
                            项目名称（全称）：
                        </div>
                        <div class="col-md-2">
                            <input id="tcProNameSel">
                        </div>
                        <div class="col-md-1 tar">
                            项目金额：
                        </div>
                        <div class="col-md-2">
                            <input id="tcProMoneySel">
                        </div>
                        <div class="col-md-1 tar">
                            图书购置费：
                        </div>
                        <div class="col-md-2">
                            <input id="libCostSel">
                        </div>
                  </div>
                        <div class="col-md-1 tar">
                            其他总支持：
                        </div>
                        <div class="col-md-2">
                            <input id="othCostSel">
                        </div>
  <div class="form-row">
                        <div class="col-md-1 tar">
                            还贷金额（万元）：
                        </div>
                        <div class="col-md-2">
                            <input id="payLoanSel">
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
                "url": '<%=request.getContextPath()%>/SchExpend/getSchExpendList',
                "data": {
                    expAll: $("#expAllSel").val(),
                    land: $("#landSel").val(),
                    expInf: $("#expInfSel").val(),
                    expDevAll: $("#expDevAllSel").val(),
                    expTeachDev: $("#expTeachDevSel").val(),
                    trainCost: $("#trainCostSel").val(),
                    trainPro: $("#trainProSel").val(),
                    hirePtTeach: $("#hirePtTeachSel").val(),
                    sport: $("#sportSel").val(),
                    dailyOth: $("#dailyOthSel").val(),
                    rsAll: $("#rsAllSel").val(),
                    rsInd: $("#rsIndSel").val(),
                    rsProName: $("#rsProNameSel").val(),
                    rsProMoney: $("#rsProMoneySel").val(),
                    tcAll: $("#tcAllSel").val(),
                    tcInd: $("#tcIndSel").val(),
                    tcProName: $("#tcProNameSel").val(),
                    tcProMoney: $("#tcProMoneySel").val(),
                    libCost: $("#libCostSel").val(),
                    othCost: $("#othCostSel").val(),
                    payLoan: $("#payLoanSel").val(),
                }
            },
            "destroy": true,
            "columns": [
                 {"data": "id", "title": "主键id", "visible": false},
                 {"data": "expAll", "title": "学校总支出（万元）"},
                 {"data": "land", "title": "征地（万元）"},
                 {"data": "expInf", "title": "基础设施建设（万元）"},
                 {"data": "expDevAll", "title": "设备采购（万元）合计"},
                 {"data": "expTeachDev", "title": "教学科研仪器设备值"},
                 {"data": "trainCost", "title": "实(验)训耗材"},
                 {"data": "trainPro", "title": "实习专项"},
                 {"data": "hirePtTeach", "title": "聘请兼职教师经费"},
                 {"data": "sport", "title": "体育维持费"},
                 {"data": "dailyOth", "title": "其他日常教学经费"},
                 {"data": "rsAll", "title": "教学改革及研究合计经费"},
                 {"data": "rsInd", "title": "序号"},
                 {"data": "rsProName", "title": "项目名称（全称）"},
                 {"data": "rsProMoney", "title": "项目金额"},
                 {"data": "tcAll", "title": "师资建设合计（万元）"},
                 {"data": "tcInd", "title": "序号"},
                 {"data": "tcProName", "title": "项目名称（全称）"},
                 {"data": "tcProMoney", "title": "项目金额"},
                 {"data": "libCost", "title": "图书购置费"},
                 {"data": "othCost", "title": "其他总支持"},
                 {"data": "payLoan", "title": "还贷金额（万元）"},
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
        $("#dialog").load("<%=request.getContextPath()%>/SchExpend/toSchExpendAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/SchExpend/toSchExpendEdit?id=" + id)
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
            $.get("<%=request.getContextPath()%>/SchExpend/delSchExpend?id=" + id, function (msg) {
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