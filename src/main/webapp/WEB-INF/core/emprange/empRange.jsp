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
<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">

                    <div class="content block-fill-white">

                        <div class="form-row">
                            <div class="col-md-1 tar">
                                人员姓名
                            </div>
                            <div class="col-md-2">
                                <input id="person" type="text" class="validate[required,maxSize[20]] form-control" />
                            </div>

                            <div class="col-md-1 tar">
                                所属部门
                            </div>
                            <div class="col-md-2">
                                <input id="dept" type="text" class="validate[required,maxSize[20]] form-control" />
                            </div>

                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchRange()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addRange()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="rangeDataId" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var computerTable;

    $(document).ready(function () {
        //部门自动提示框
        $.get("<%=request.getContextPath()%>/stamp/autoCompleteDept", function (data) {
            $("#dept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#dept").val(ui.item.label);
                    $("#dept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            }
        })
        //人员自动提示框
        $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#person").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#person").val(ui.item.label);
                    $("#person").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        searchRange();

        computerTable.on('click', 'tr a', function () {
            var data = computerTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editRange") {
                $("#dialog").load("<%=request.getContextPath()%>/emp/range/getEmpRangeById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delRange") {
                //if (confirm("请确认是否要删除本条记录?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "用户："+data.personId+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/emp/range/deleteEmpRangeById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            $('#rangeDataId').DataTable().ajax.reload();
                        }
                    })
                })
            }
        });
    })

    function addRange() {
        $("#dialog").load("<%=request.getContextPath()%>/emp/range/editRange");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#dept").val("");
        $("#person").val("");
        searchRange();
    }
    function searchRange() {
        var dept = $("#dept").val();
        var person = $("#person").val();
        if (dept != "")
            dept = '%' + dept + '%';

        if (person != "")
            person= '%' + person + '%';

        computerTable = $("#rangeDataId").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/emp/range/getEmpRangeList',
                "data": {
                    deptId: dept,
                    personId: person
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "30%","data": "personId", "title": "人员姓名"},
                {"width": "60%","data": "deptId", "title": "所属部门"},
                {
                    "width": "10%", "title": "操作",
                    "render": function () {
                        return "<a id='editRange' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRange' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [1,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });

    }

</script>
