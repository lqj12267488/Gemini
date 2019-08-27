<%--公告已读未读人员查看
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/24
  Time: 10:13
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
                        <div class="form-row" >
                            <header class="mui-bar mui-bar-nav">
                                <h5 class="mui-title">已读未读人员一览</h5>
                            </header>
                        </div>
                        <div class="form-row" >
                            <div class="col-md-1 tar">
                                申请部门：
                            </div>
                            <div class="col-md-2">
                                <select id="selDept"></select>
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
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <div class="form-row block">
                            <table id="listGrid" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;border: none;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="id" value="${id}" hidden>
</div>
<script>
    var listTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept", function (data) {
            addOption(data, 'selDept');
        });
        search();
    })
    function searchclear() {
        $("#selDept").val("");
        search();
    }
    function search() {
        var id=$("#id").val();
        var deptId=$("#selDept").val();
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/getNoticePersonList',
                "data":{
                    id:id,
                    deptId:deptId
                }
            },
            "destroy": true,
            "columns": [
                {"data": "deptId", "visible": false},
                {"width":"12%","data": "persinIdShow", "title": "姓名"},
                {"width":"8%","data": "deptIdShow", "title": "所属部门"},
                {"width":"8%","data": "flag", "title": "是否已读"},
                {"width":"8%","data": "abc", "title": "已读时间"},
            ],
            "scrollY":"400px",
            'order' : [0,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
    function back(){
        $("#right").load("<%=request.getContextPath()%>/noticeList");
    }
</script>