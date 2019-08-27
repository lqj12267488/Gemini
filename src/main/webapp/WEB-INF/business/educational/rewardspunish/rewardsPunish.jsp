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
                                <input id="rtime" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                被奖惩人：
                            </div>
                            <div class="col-md-2">
                                <input id="rname" type="text"
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
                        <%-- <button type="button" class="btn btn-default btn-clean" onclick="addRewards()">
                             新增</button>
                         <br>--%>
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

<script>
    var roleTable;

    $(document).ready(function () {
        searchAssets();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
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
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#rname").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#rname").val(ui.item.label);
                    $("#rname").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

    })
    /*清空*/
    function searchclear() {
        $("#rtime").val("");
        $("#rname").val("");
        $("#rname").removeAttr("keycode");
       // $("#rewordPersonId").removeAttr("value");
        searchAssets();
    }
    /*查询*/
    function searchAssets() {

        var rtime=$("#rtime").val();
        if(rtime!=""){
            rtime=rtime;
        }
        var rdeptname = $("#rname").attr("keycode");
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
                "url": '<%=request.getContextPath()%>/rewardspunish/rewardsPunishAction',
                "data": {
                    rtime: rtime,
                    rname: rname
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {
                    "width": "10%",
                    "data": "rname",
                    "title": "姓名",
                    "render": function (data, type, row) {
                        return '<span onclick=toShowTeacherCondition("' + row.personId + '")>'+row.rname+'</span>';
                    }
                },
                {"width": "15%", "data": "rdept", "title": "部门"},
                {"width": "15%", "data": "rfname", "title": "奖惩名称"},
                {"width": "15%", "data": "leixing", "title": "奖惩类型"},
                {"width": "15%", "data": "rtime", "title": "奖惩时间"},
                {"width": "20%", "data": "remark", "title": "备注"},
                {"width": "10%","title": "操作","render": function () {return  "<a id='details' class='icon-search' title='查看详情'></a>";}}
            ],
            'order' : [1,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
    /**
     * 弹出教师自然状态页面
     */
    function toShowTeacherCondition(id) {
        $("#dialog").load("${pageContext.request.contextPath}/teacher/showTeacherCondition?teacherId="+id);
        $("#dialog").show();
    }
</script>

