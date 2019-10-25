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
                                机构代码：
                            </div>
                            <div class="col-md-2">
                                <input id="organizationCodeSel">
                            </div>
                            <div class="col-md-1 tar">
                                机构名称(全称)：
                            </div>
                            <div class="col-md-2">
                                <input id="organizationNameSel">
                            </div>
                            <div class="col-md-1 tar">
                                负责人姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="personNameSel">
                            </div>
                            <div class="col-md-1 tar">
                                年份：
                            </div>
                            <div class="col-md-2">
                                <select id="yearss"></select>
                            </div>
                            <br>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content">
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'yearss');
        });

        search();
    })

    function search() {
        $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/informationpersonnel/getInformationPersonnelList',
                "data": {
                    organizationCode: $("#organizationCodeSel").val(),
                    organizationName: $("#organizationNameSel").val(),
                    personStaff: $("#personStaffSel").val(),
                    personName: $("#personNameSel").val(),
                    staffNumber: $("#staffNumberSel").val(),
                    employeNumber: $("#employeNumberSel").val(),
                    year:$("#yearss").val(),

                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "title": "主键id", "visible": false},
                {"data": "organizationCode", "title": "机构代码"},
                {"data": "organizationName", "title": "机构名称(全称)"},
                {"data": "personStaff", "title": "负责人教工号"},
                {"data": "personName", "title": "负责人姓名"},
                {"data": "staffNumber", "title": "专职人员数（个）"},
                {"data": "employeNumber", "title": "兼职人员数（个）"},
                {"data": "year", "title": "年份"},

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
        $("#dialog").load("<%=request.getContextPath()%>/informationpersonnel/toInformationPersonnelAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/informationpersonnel/toInformationPersonnelEdit?id=" + id)
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
            $.get("<%=request.getContextPath()%>/informationpersonnel/delInformationPersonnel?id=" + id, function (msg) {
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