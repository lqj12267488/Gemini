<%--
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
                                培训类别：
                            </div>
                            <div class="col-md-2">
                                <select id="type"/>
                            </div>
                            <div class="col-md-1 tar">
                                培训日期：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="searchGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var searchTable;

    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PXLB", function (data) {
            addOption(data, 'type');
        });

        searchTable = $("#searchGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/training/personal/getSearchList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "12%","data": "trainingProjectName", "title": "培训项目名称"},
                {"width": "10%","data": "requestDept", "title": "申请部门"},
                {"width": "10%","data": "requester", "title": "经办人"},
                {"width": "10%","data": "requestDate", "title": "申请日期"},
                {"width": "10%","data": "trainingTypeShow", "title": "培训类别"},
                {"width": "10%","data": "trainingDate", "title": "培训日期"},
                {"data": "trainingDays", "visible": false},
                {"data": "trainingPlace", "visible": false},
                {"width": "8%", "title": "操作", "render": function () {return "<a id='handleFlowTtrack' class='icon-search' title='查看流程轨迹'></a>";
                    /*"<a id='feedbackReport' class='icon-comments' title='反馈'></a>"*/
                    /*     "<a id='addRelation' class='icon-sitemap' title='授权人员'></a>&nbsp;&nbsp;&nbsp;"+
                     "<a id='addRelationMenu' class='icon-cogs'  title='添加菜单'></a>";*/;}},

            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        searchTable.on('click', 'tr a', function () {
            var data = searchTable.row($(this).parent()).data();
            var id = data.id;
            //查看流程轨迹
            if (this.id == "handleFlowTtrack") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_RS_TRAINING_WF",
                    url: "<%=request.getContextPath()%>/training/personal/auditPersonalById?id=" + id,
                    backUrl: "/training/personal/search"
                });
            }
            //反馈
            if (this.id == "feedbackReport") {
                var data = searchTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_RS_TRAINING_WF",
                        businessId: id,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg)
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: id,
                                tableName: "T_RS_TRAINING_WF",
                                backUrl: "/training/personal/search"
                            });
                        }
                    })
                }else{
                    swal({
                        title: "本申请已经完成反馈!",
                        type: "info"
                    });
                    //alert("本申请已经完成反馈！");
                }


            }

        });
    });

    function searchclear() {
        $("#type option:selected").val("");
        $("#date").val("");
        searchTable.ajax.url("<%=request.getContextPath()%>/training/personal/getSearchList").load();
    }

    function search() {
        var type = $("#type option:selected").val();
        var date = $("#date").val();
        if (type == "" && date == "" ) {

        } else{
            searchTable.ajax.url("<%=request.getContextPath()%>/training/personal/getSearchList?trainingType="+type+"&trainingDate="+date).load();
        }
    }
</script>
