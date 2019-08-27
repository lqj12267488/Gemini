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
                                名称
                            </div>
                            <div class="col-md-2">
                                <SELECT id="f_rewardName"></SELECT>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">
                                    清空
                                </button>
                            </div>
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
    var table;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JLCF", function (data) {
            addOption(data, 'f_rewardName');
        });
        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teacher/getRewardList'
            },
            "destroy": true,
            "columns": [
                {"data": "rewardId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "rewardName", "title": "名称"},
                {"data": "rewardLevel", "title": "级别"},
                {"data": "cognizanceUnit", "title": "认定单位"},
                {"data": "cognizanceProcess", "title": "认定过程"},
                {"data": "cognizanceConclusion", "title": "认定结果"},
                {"data": "cognizanceDate", "title": "认定时间"},
                {"data": "termValidity", "title": "有效期"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.rewardId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.rewardId  + '")/>';
                    }
                }
            ],
            'order' : [5,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    })



    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/teacher/toAddReward")
        $("#dialog").modal("show")
    }

    function edit(rewardId) {
        $("#dialog").load("<%=request.getContextPath()%>/teacher/toAddReward?rewardId=" + rewardId)
        $("#dialog").modal("show")
    }

    function del(rewardId) {
        swal({
            title: "您确定要删除本条信息?",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/teacher/deleteRewardById", {
                rewardId: rewardId
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();

            });

        });

    }

    function search() {
        var rewardNameSearch = $("#f_rewardName").val();
        var url = "<%=request.getContextPath()%>/teacher/getRewardList?rewardName=" + rewardNameSearch;
        $("#table").DataTable().ajax.url(url).load();
    }

    function searchclear() {
        $("#f_rewardName").val("");
        $("#f_rewardName option:selected").val("");
        $("#table").DataTable().ajax.url("<%=request.getContextPath()%>/teacher/getRewardList").load();
    }
</script>
