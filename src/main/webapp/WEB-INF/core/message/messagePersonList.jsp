<%--通知已读未读人员查看
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/23
  Time: 19:16
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
                        <header class="mui-bar mui-bar-nav">
                            <h5 class="mui-title">已读未读人员一览</h5>
                        </header>
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
        search();
    })
    function search() {
        var id=$("#id").val();
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/getMessagePersonList',
                "data":{
                    id:id
                }
            },
            "destroy": true,
            "columns": [
                {"data": "deptId", "visible": false},
                {"width":"12%","data": "empIdShow", "title": "姓名"},
                {"width":"8%","data": "deptIdShow", "title": "所属部门"},
                {"width":"8%","data": "range", "title": "是否已读"},
                {"width":"8%","data": "abc", "title": "已读时间"},
            ],
            "scrollY":"400px",
            'order' : [0,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
    function back(){
        $("#right").load("<%=request.getContextPath()%>/messageList");
    }
</script>
