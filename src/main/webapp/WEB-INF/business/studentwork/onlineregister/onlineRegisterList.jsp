<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
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
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/onlineregister/getOnlineRegisterList',
            },
            "destroy": true,
            "columns": [
            {"data":"id","title":""},
{"data":"name","title":""},
{"data":"sex","title":""},
{"data":"nation","title":""},
{"data":"language","title":""},
{"data":"idcard","title":""},
{"data":"birthday","title":""},
{"data":"departmentsId","title":""},
{"data":"majorCode","title":""},
{"data":"province","title":""},
{"data":"city","title":""},
{"data":"county","title":""},
{"data":"registerType","title":""},
{"data":"registerOrigin","title":""},
{"data":"examinationCardNumber","title":""},
{"data":"examScore","title":""},
{"data":"examType","title":""},
{"data":"graduatedSchool","title":""},
{"data":"graduationDate","title":""},
{"data":"idcardImg","title":""},
{"data":"examinationImg","title":""},
{"data":"scoreImg","title":""},
{"data":"hukouImg","title":""},
{"data":"graduatedImg","title":""},
{"data":"fatherTel","title":""},
{"data":"motherTel","title":""},
{"data":"remark","title":""},

                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/onlineregister/toOnlineRegisterAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/onlineregister/toOnlineRegisterEdit?id=" + id)
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
            $.get("<%=request.getContextPath()%>/onlineregister/delOnlineRegister?id=" + id, function (msg) {
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