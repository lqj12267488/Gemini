<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/25
  Time: 9:27
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
                            <div class="col-md-1 tar" style="width:100px">
                                学生姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="selStudentId" type="text"/>
                            </div>
                            <div class="col-md-1 tar" style="width:120px">
                                班级名称：
                            </div>
                            <div class="col-md-2">
                                <input id="selClassId" type="text"/>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                奖惩类型:
                            </div>
                            <div class="col-md-2">
                                <select id="selRewardPunishType" class="js-example-basic-single"></select>
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
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="rewardpunishCountGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var countTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSJCLX", function (data) {
            addOption(data, 'selRewardPunishType');
        });
        search();
        countTable.on('click', 'tr a', function () {
            var data = countTable.row($(this).parent()).data();
            var id = data.id;
            var type=data.rewardpunishType;
            if (this.id == "detail") {
                if(type=="1"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/studentPunish/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="11"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/schoolBurse/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="12"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/stateBurse/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="13"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/fullBurse/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="14"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/tuitionFree/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="15"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/grants/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="16"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/studentLoan/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="17"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/studentCadres/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else{
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/miyoshiClass/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }
            }
        });
    })
    function searchclear() {
        $("#selStudentId").val("");
        $("#selClassId").val("");
        $("#selRewardPunishType").val("");
        search();
    }
    function search() {
        var studentId = $("#selStudentId").val();
        studentId="%"+studentId+"%";
        var classId = $("#selClassId").val();
        classId="%"+classId+"%";
        var rewardpunishType = $("#selRewardPunishType").val();
        countTable = $("#rewardpunishCountGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/studentRewardPunish/rewardpunishCount/getList',
                "data":{
                    studentId: studentId,
                    classId:classId ,
                    rewardpunishType: rewardpunishType
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"12%","data": "studentId", "title": "姓名"},
                {"width":"8%","data": "sexShow", "title": "性别"},
                {"width":"8%","data": "idcard", "title": "身份证号"},
                {"width":"12%","data": "typeShow", "title": "奖惩类型"},
                {"width":"10%","data": "departmentsId", "title": "系部"},
                {"width":"12%","data": "majorShow", "title": "专业"},
                {"width":"8%","data": "classId", "title": "班级"},
                {"width":"8%","title": "操作","render": function () {return "<a id='detail' class='icon-search' title='查看'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>