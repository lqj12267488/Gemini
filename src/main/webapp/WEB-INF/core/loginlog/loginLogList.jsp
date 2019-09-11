<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/20
  Time: 16:05
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/19
  Time: 11:20
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
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                用户账号:
                            </div>
                            <div class="col-md-2">
                                <input id="userAccount1" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                登录时间:
                            </div>
                            <div class="col-md-2">
                                <input id="loginTime1" type="date"/>
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
                        <table id="loginLogGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var loginLogTable;

    $(document).ready(function () {
        selectList();
    })
    function searchclear() {
        $("#userAccount1").val("");
        $("#loginTime1").val("");
        selectList();
    }
    function selectList() {
        loginLogTable = $("#loginLogGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/loginLog/getLoginLogByAccountTime'
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "userId", "visible": false},
                {"width": "25%", "data": "userAccount", "title": "登录账号"},
                {"width": "25%", "data": "loginTimeShow", "title": "登录时间"},
                {"width": "25%", "data": "ip", "title": "ip地址"},
/*
                {"width": "25%", "data": "mac", "title": "mac地址"},
*/
            ],
            'order' : [[1,'desc'],[2,'desc']],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
    function search() {
        var memberNumber = $("#userAccount1").val();
        if(memberNumber != ""){
            memberNumber = memberNumber;
        }
        var joinTime =$("#loginTime1").val();
        if(joinTime != ""){
            joinTime = joinTime;
        }
        // if(joinTime ==""){
            loginLogTable = $("#loginLogGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/loginLog/getLoginLogByAccountTime',
                "data":{
                    userAccount : memberNumber,
                    loginTimeShow :joinTime,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "userId", "visible": false},
                {"width": "25%", "data": "userAccount", "title": "登录账号"},
                {"width": "25%", "data": "loginTimeShow", "title": "登录时间"},
                {"width": "25%", "data": "ip", "title": "ip地址"},
/*
                {"width": "25%", "data": "mac", "title": "mac地址"},
*/
            ],
                'order' : [[1,'desc'],[2,'desc']],
                paging: true,
                "dom": 'rtlip',
                language: language
        });
    // }
    }


</script>

