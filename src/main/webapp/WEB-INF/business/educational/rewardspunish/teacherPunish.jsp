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
                                惩处日期：
                            </div>
                            <div class="col-md-2">
                                <input id="punishTime" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                被惩处人：
                            </div>
                            <div class="col-md-2">
                                <input id="s_punishPersonId" type="text"
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
                        <table id="punishGrid" cellpadding="0" cellspacing="0" width="100%"
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
                $("#dialog").load("<%=request.getContextPath()%>/punish/addpunish?id=" + id);
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
                    $.post("<%=request.getContextPath()%>/punish/deletepunishById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#punishGrid').DataTable().ajax.reload();

                    });
                })
            }
            if (this.id == "details") {
                $("#dialog").load("<%=request.getContextPath()%>/punish/addpunish?id=" + id+"&flag=1");
                $("#dialog").modal("show");
            }
        });
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#s_punishPersonId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#s_punishPersonId").val(ui.item.label);
                    $("#s_punishPersonId").attr("keycode", ui.item.value);
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
        $("#dialog").load("<%=request.getContextPath()%>/punish/addpunish");
        $("#dialog").modal("show");
    }
    /*清空*/
    function searchclear() {
        $("#punishTime").val("");
        $("#s_punishPersonId").val("");
        $("#s_punishPersonId").removeAttr("keycode");
        searchAssets();
    }
    /*查询*/
    function searchAssets() {

        var punishTime=$("#punishTime").val();
        if(punishTime!=""){
            punishTime=punishTime;
        }
        var rdeptname = $("#s_punishPersonId").attr("keycode");
        var rname;
        if(rdeptname==undefined||rdeptname==""||rdeptname=='undefined'){
            rname="";
        }else{
            var rdeptnameList = rdeptname.split(",");
            rname = rdeptnameList[1];
        }
        roleTable = $("#punishGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/punish/punishAction',
                "data": {
                    punishTime: punishTime,
                    punishPersonId: rname
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {
                    "width": "10%",
                    "data": "punishPersonId",
                    "title": "被惩处人",
                    "render": function (data, type, row) {
                        return '<span onclick=toShowTeacherCondition("' + row.personId + '")>'+row.punishPersonId+'</span>';
                    }
                },
                {"width": "15%", "data": "punishPersonDeptId", "title": "被惩处人所在部门"},
                {"width": "15%", "data": "punishName", "title": "惩处名称"},
                {"width": "10%", "data": "punishStatus", "title": "惩处撤销状态"},
                {"width": "10%", "data": "punishTime", "title": "惩处时间"},
                {"width": "15%", "data": "punishReason", "title": "惩处原因"},
                {"width": "15%", "data": "remark", "title": "备注"},
                {"width": "10%","title": "操作","render": function () {return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
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

