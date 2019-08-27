<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/19
  Time: 11:20
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
                                会员名称：
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="personSelect" />
                            </div>
                            <div class="col-md-1 tar">
                                会员编号：
                            </div>
                            <div class="col-md-2">
                                <input id="memberNumber" type="text" />
                            </div>
                            <div class="col-md-1 tar">
                                入会时间：
                            </div>
                            <div class="col-md-2">
                                <input id="joinTime" type="date"/>
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
                        <button type="button" class="btn btn-default btn-clean" onclick="addUnionMember()">新增</button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="unionMemberGrid" cellpadding="0" cellspacing="0"
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
    var unionMemberTable;

    $(document).ready(function () {
        unionMemberTable = $("#unionMemberGrid").DataTable({
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "15%", "data": "personIdShow", "title": "会员名称"},
                {"width": "15%", "data": "deptIdShow", "title": "部门"},
                {"width": "15%", "data": "memberNumber", "title": "会员编号"},
                {"width": "15%", "data": "unionDuties", "title": "工会职务"},
                {"width": "15%", "data": "joinTime", "title": "入会时间"},
                {"width": "15%", "data": "remark", "title": "备注"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='updateUnionMember' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='deleteUnionMember' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });

        search();
        unionMemberTable.on('click', 'tr a', function () {
            var data = unionMemberTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "updateUnionMember") {
                $("#dialog").load("<%=request.getContextPath()%>/unionMember/getUpdateUnionMember?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "deleteUnionMember") {
                //if (confirm("请确认是否要删除本条记录?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "会员编号："+data.memberNumber+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/unionMember/deleteUnionMember?id=" + id, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        //alert(msg.msg);
                        search();
                    })
                })
            }
        });
    })

    function addUnionMember() {
        $("#dialog").load("<%=request.getContextPath()%>/unionMember/getAddUnionMember");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#personSelect").val("");
        $("#personSelect").attr("keycode", "").val("");
        $("#memberNumber").val("");
        $("#joinTime").val("");
        search();
    }

    function search() {
        var personId =$("#personSelect").val();

        var memberNumber = $("#memberNumber").val();
        var joinTime =  $("#joinTime").val();
        unionMemberTable.ajax.url("<%=request.getContextPath()%>/unionMember/getUnionMemberList" +
            "?personId="+personId+"&memberNumber="+memberNumber+"&joinTime="+joinTime).load();

    }


</script>
