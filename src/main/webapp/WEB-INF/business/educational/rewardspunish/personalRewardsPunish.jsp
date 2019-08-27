<%--教师个人奖惩信息查看
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/9/6
  Time: 15:16
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
                                <input id="p_rtime" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                奖惩名称：
                            </div>
                            <div class="col-md-2">
                                <input id="p_rfname" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">
                                    查询</button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="personalGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var personalTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JCLX", function (data) {
            addOption(data, 'p_leixing');
        });
        search();
        personalTable.on('click', 'tr a', function () {
            var data = personalTable.row($(this).parent()).data();
            var leixing = data.leixing;
            var id = data.id;
            if (this.id == "details") {
                if(leixing=='惩处'){
                    $("#dialog").load("<%=request.getContextPath()%>/punish/addpunish?id=" + id+"&flag=1");
                    $("#dialog").modal("show");
                }else{
                    $("#dialog").load("<%=request.getContextPath()%>/rewards/addrewards?id=" + id+"&flag=1");
                    $("#dialog").modal("show");
                }
            }
        });
    })
    /*清空*/
    function searchclear() {
        $("#p_rtime").val("");
        $("#p_rfname").val("");
        search();
    }
    /*查询*/
    function search() {
        var rtime=$("#p_rtime").val();
        var rfname=$("#p_rfname").val();
        if (rfname != "") {
            rfname = '%' + rfname + '%';
        }
        personalTable = $("#personalGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/rewardspunish/personalRewardsPunishList',
                "data": {
                    rtime: rtime,
                    rfname: rfname
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "rname", "title": "姓名"},
                {"width": "15%", "data": "rdept", "title": "部门"},
                {"width": "15%", "data": "rfname", "title": "奖惩名称"},
                {"width": "15%", "data": "leixing", "title": "奖惩类型"},
                {"width": "15%", "data": "rtime", "title": "奖惩时间"},
                {"width": "20%", "data": "remark", "title": "备注"},
                {"width": "10%","title": "操作","render": function () {return "<a id='details' class='icon-search' title='查看详情'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>
