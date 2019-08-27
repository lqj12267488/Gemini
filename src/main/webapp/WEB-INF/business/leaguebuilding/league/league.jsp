<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container ">
    <div class="row">
        <div class="col-md-3">
            <div class="block block-drop-shadow">
                <div class="content controls" style="height: 85%">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <div class="row">
                <div class="col-md-12">
                    <div class="block">
                        <div class="header">
                            <span id="stuName"
                                  style="font-size: 15px;margin-left: 20px">团员信息</span>
                        </div>
                        <div class="content">
                            <table id="leagueGrid" cellpadding="0" cellspacing="0" width="100%"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="branchCache" hidden>
</div>
<script>
    var leagueTable;
    var leagueTree;
    var setting = {
        view: {
            fontCss: {color: "white"},
            showLine: false
        },
        data: {
            simpleData: {
                enable: true,
            }
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                $("#branchCache").val(treeNode.id);
                $("#branchName").html(treeNode.name)
                leagueTable.ajax.url("<%=request.getContextPath()%>/league/getLeagueList?branchId=" + treeNode.id).load()
            }
        }
    };
    $(document).ready(function () {
        var branchId = $("#branchCache").val()+'%';
        $.get("<%=request.getContextPath()%>/league/getLeagueBranchTree", function (data) {
            leagueTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            leagueTree.expandAll(true);
        })
        leagueTable = $("#leagueGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/league/getLeagueList?branchId='+branchId,
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "12%", "data": "leagueMembersNumber", "title": "团员证号"},
                {"width": "15%", "data": "studentName", "title": "姓名"},
                {"width": "15%", "data": "branchName", "title": "团组织名称"},
                {"width": "13%", "data": "memberDuties", "title": "团内职务"},
                {"width": "15%", "data": "joinleagueTime", "title": "入团时间"},
                {"width": "20%", "data": "remark", "title": "备注"},
                {
                    "width": "10%", "title": "操作",
                    "render": function () {
                        return "<span id='editLeague' title='修改' class='icon-edit'></span>&ensp;" +
                            "<span id='deleteLeague' title='删除' class='icon-trash'></span>&ensp;";
                    }
                }
            ],

            "dom": '<"toolbar">rtlip',
            "language": language
        });
        $("div.toolbar").html('<button class="btn btn-info btn-clean" onclick="addLeague()">新增</button>');
        /* $("div.toolbar").html('<button class="btn btn-info btn-clean" onclick="addEmp()">新增</button>&ensp;' +
         '<a class="btn btn-info btn-clean" href="/exportEmp">导出</a>&ensp;' +
         '<button class="btn btn-info btn-clean" onclick="showEmpDialog()" ">导入</button>');*/
        leagueTable.on('click', 'tr span', function () {
            var data = leagueTable.row($(this).parent()).data();
            var id = data.id;
            var studentName=data.studentName;
            if (this.id == "editLeague") {
                $("#dialog").load("<%=request.getContextPath()%>/league/editLeague?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "deleteLeague") {
                swal({
                    title: "确定要删除该条数据吗?",
                    text: "团员名称为："+studentName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/league/deleteLeagueById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        leagueTable.ajax.reload();
                    });
                })
            }
        });
    })

    function addLeague() {
        var branchId = $("#branchCache").val();
        if (null == branchId || branchId == "") {
            swal({
                title: "请在左侧选择团组织后再进行人员添加！",
                type: "info"
            });
            return;
        } else {
            if(branchId==0){
                swal({
                    title: "本节点不允许执行新增团员操作！",
                    type: "info"
                });
                return;
            }if(branchId.length==3){
                swal({
                    title: "本节点不允许执行新增团员操作！",
                    type: "info"
                });
                return;
            }
            $("#dialog").load("<%=request.getContextPath()%>/league/addLeague?branchId=" + branchId);
            $("#dialog").modal("show");
        }
    }

</script>