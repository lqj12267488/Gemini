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
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <%--<div class="block block-drop-shadow content block-fill-white">
                </div>--%>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <c:if test="${type == '1'}">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="$('#right').load('<%=request.getContextPath()%>/scoreMakeup/finalExamList')">
                                返回
                            </button>
                        </c:if>
                        <c:if test="${type != '1'}">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="$('#right').load('<%=request.getContextPath()%>/scoreMakeup/examList?type=${type}')">
                                返回
                            </button>
                        </c:if>

                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table11" cellpadding="0" cellspacing="0"
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
    var table11;
    $(document).ready(function () {
        table11 = $("#table11").DataTable({
            ajax: {
                type: "post",
                url: '<%=request.getContextPath()%>/scoreExam/getDetails?id=${id}',
            },
            columns: [
                {
                    data: "userName",
                    title: "教师姓名"
                },
                {
                    data: "courseName",
                    title: "科目"
                },
                {
                    data: "className",
                    title: "班级"
                },
                {
                    title: "状态",
                    render: function (data, type, row) {
                        switch (row.status) {
                            case '0':
                                return '未提交';
                            case '1':
                                return '全部提交';
                            case '2':
                                return '部分提交';
                        }
                    }
                }
            ],
            dom: 'rtlip',
            language: language
        });
    });

    function search() {
        var term = $("#searchTerm").val();
        table11.ajax.url("<%=request.getContextPath()%>/courseconstruction/getTeachingCalendarList?term=" + term).load();
    }

    function searchclear() {
        $("#searchTerm").val("");
        search();
    }

</script>