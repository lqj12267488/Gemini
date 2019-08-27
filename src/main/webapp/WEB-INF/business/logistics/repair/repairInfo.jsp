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
                                报修物品名称：
                            </div>
                            <div class="col-md-2">
                                <input id="rname" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                报修部门：
                            </div>
                            <div class="col-md-2">
                                <input id="rdept" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                报修时间段:
                            </div>
                            <div class="col-md-3">
                                <input type="datetime-local" id="changeStartTime"/>
                            </div>
                            <div class="col-md-3">
                                <input type="datetime-local" id="changeEndTime"/>
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
                <div class="content">
                    <%--<div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addRepair()">新增
                        </button>
                        <br>
                    </div>--%>
                    <table id="repairTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="repairID" hidden value="${repair.repairID}">
<input id="name" hidden>
<input id="dept" hidden>
<input id="dates" hidden>
<input id="datee" hidden>
<script>
    var repairTable;
    var dd="";
    //主页面显示的条件
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/leaveCancel/autoCompleteDept", function (data) {
            $("#rdept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#rdept").val(ui.item.label);
                    $("#rdept").attr("keycode", ui.item.value);
                    $("#dept").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/repair/getItemName", function (data) {
            $("#rname").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#rname").val(ui.item.label);
                    $("#rname").attr("keycode", ui.item.value);
                    $("#name").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        repairTable = $("#repairTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/repair/Info',
            },
            "destroy": true,
            "columns": [
                {"data": "repairID", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "repairType", "visible": false},
                { "width": "9%", "data":"repairTypeShow", "title": "报修种类"},
                /*{ "width":"8%", "data": "assetsID", "title": "资产编号"},*/
               /* { "width":"9%", "data": "position", "title": "所在位置"},*/
                { "width": "9%", "data":"dept", "title": "所在部门"},
                { "width": "9%", "data":"itemNameShow", "title": "报修物品名称"},
                { "width": "8%", "data":"repairAddress", "title": "维修地址"},
                { "width": "8%", "data":"faultDescription", "title": "故障描述"},
                { "width": "8%", "data":"contactNumber", "title": "联系人电话"},
                { "width": "9%", "data":"requestFlag", "title": "请求状态"},
                { "width": "8%", "data":"submitTime","title":"报修时间"},
                { "width": "8%", "data":"confirmTime", "title": "最终完成时间"},
                { "width": "8%", "data":"feedback", "title": "反馈意见"},
                { "width": "9%", "data":"feedbackFlag", "title": "反馈状态"},
                { "width": "8%", "data":"feedbackTime", "title": "反馈时间"},
                {"width": "6%","title": "操作", "render": function () {return "<a id='infoRepair' class='icon-search' title='详情'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            "language": language
        });
        repairTable.on('click', 'tr a', function () {
            var data = repairTable.row($(this).parent()).data();
            var repairID = data.repairID;
            //看详情
                if (this.id == "infoRepair") {
                    $("#dialog").load("<%=request.getContextPath()%>/repair/repairListInfo?repairID=" + repairID);
                    $("#dialog").modal("show");
                }
        });

    })
    function searchclear() {
        $("#name").val("");
        $("#dept").val("");
        $("#rname").val("");
        $("#rdept").val("");
        $("#changeStartTime").val("");
        $("#changeEndTime").val("");
        search();
    }

    function search() {
        //t_requestDate = t_requestDate.replace('T','');
        var changeStartTime = $("#changeStartTime").val().replace('T',' ');
        var changeEndTime = $("#changeEndTime").val().replace('T',' ');
        if(changeStartTime== "" || changeStartTime == null){
            if(changeEndTime!="" && changeEndTime != null&& changeEndTime != undefined){
                swal({
                    title: "报修起始时间不能为空！",
                    type: "info"
                });
                return;
            }
        }
        if(changeEndTime== "" || changeEndTime == null){
            if(changeStartTime!="" && changeStartTime != null&&changeStartTime != undefined){
                swal({
                    title: "报修结束时间不能为空！",
                    type: "info"
                });
                return;
            }
        }
        if (changeStartTime > changeEndTime) {
            swal({
                title: "报修起始时间不能大于报修结束时间！",
                type: "info"
            });
            return;
        }
        repairTable.ajax.url("<%=request.getContextPath()%>/repair/Info?itemName=" +$("#name").val()+
        "&dept="+$("#dept").val()+"&startDate="+$("#dateStar").val()+"&endDate="+$("#dateEnd").val()+
        "&changeStartTime="+changeStartTime+"&changeEndTime="+changeEndTime).load();
    }
</script>

