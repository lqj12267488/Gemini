<%--资产报废申请
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
    @media screen and (max-width: 1050px) {
        .tar {
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
                                获奖日期：
                            </div>
                            <div class="col-md-2">
                                <input id="rewordTime" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                获奖人：
                            </div>
                            <div class="col-md-2">
                                <input id="rewordPersonId" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="searchAssets()">
                                    查询</button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addRewards()">
                            新增</button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="rewardsGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_ASSETSSCRAP_WF">
<input id="businessId" hidden>
<script>
    var roleTable;

    $(document).ready(function () {
        searchAssets();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/rewards/addrewards?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delRole") {
                swal({
                    title: "请确认是否要删除本条申请?",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/rewards/deleterewardsById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#rewardsGrid').DataTable().ajax.reload();

                    });
                })
            }
            if (this.id == "details") {
                $("#dialog").load("<%=request.getContextPath()%>/rewards/addrewards?id=" + id+"&flag=1");
                $("#dialog").modal("show");
            }
        });

        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#rewordPersonId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#rewordPersonId").val(ui.item.label);
                    $("#rewordPersonId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })


    })
    /*添加*/
    function addRewards() {
        $("#dialog").load("<%=request.getContextPath()%>/rewards/addrewards");
        $("#dialog").modal("show");
    }
    /*清空*/
    function searchclear() {
        $("#rewordTime").val("");
        $("#rewordPersonId").val("");
        $("#rewordPersonId").removeAttr("keycode");
        searchAssets();
    }
    /*查询*/
    function searchAssets() {
        var rewordTime=$("#rewordTime").val();
        if(rewordTime!=""){
            rewordTime=rewordTime;
        }
        var rdeptname = $("#rewordPersonId").attr("keycode");
        var rname;
        if(rdeptname==undefined||rdeptname==""||rdeptname=='undefined'){
            rname="";
        }else{
            var rdeptnameList = rdeptname.split(",");
            rname = rdeptnameList[1];
        }
        roleTable = $("#rewardsGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/rewards/rewardsAction',
                "data": {
                    rewordTime: rewordTime,
                    rewordPersonId: rname
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {
                    "width": "15%",
                    "data": "rewordPersonId",
                    "title": "获奖人姓名",
                    "render": function (data, type, row) {
                        return '<span onclick=toShowTeacherCondition("' + row.personId + '")>'+row.rewordPersonId+'</span>';
                    }
                },
                {"width": "15%", "data": "rewordPersonDeptId", "title": "获奖人部门"},
                {"width": "15%", "data": "rewordName", "title": "奖励名称"},
                {"width": "20%", "data": "rewordTime", "title": "获奖时间"},
                {"width": "20%", "data": "remark", "title": "备注"},
                {"width": "15%","title": "操作","render": function () {return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='details' class='icon-search' title='查看详情'></a>"
                        /*     "<a id='addRelation' class='icon-sitemap' title='授权人员'></a>&nbsp;&nbsp;&nbsp;"+
                         "<a id='addRelationMenu' class='icon-cogs'  title='添加菜单'></a>";*/;}}
            ],
            'order' : [1,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
</script>

