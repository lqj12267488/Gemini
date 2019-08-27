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
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${head}</span>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="relationCTGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tid" hidden value="${tid}">
<input id="tname" hidden value="${tname}">
<script>
    var relationCTGrid;

    $(document).ready(function () {
        relationCTGrid = $("#relationCTGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/major/getrelationMajor',
                "data": {
                    id: $("#tid").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "planId", "visible": false},
                {"width":"25%","data": "planName", "title": "计划名称"},
                {"width":"25%","data": "year", "title": "关联时间"},
                // {
                //     "width":"25%",
                //     "title": "操作",
                //     "render": function () {
                //         return "<a id='editSysDic' class='icon-edit' title='关联'></a>&nbsp;&nbsp;&nbsp;"+
                //             "<a id='del' class='icon-trash' title='取消关联'></a>&nbsp;&nbsp;&nbsp;"
                //     }
                // }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        relationCTGrid.on('click', 'tr a', function () {
            var data = relationCTGrid.row($(this).parent()).data();
        });
    })
    function back() {
        $("#right").load("<%=request.getContextPath()%>/major/talentTrainProcess");
    }
</script>
