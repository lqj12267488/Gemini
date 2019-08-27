<%--
  Description: 意见箱--教师--回复列表
  Creator: 郭千恺
  Date: 2018/9/27 9:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean" onclick="back()">返回
                            </button>
                        </div>
                        <div class="form-row block" style="overflow-y:auto;">
                            <table id="table" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/suggestionBox/teacher/getReplyList?id=' + '${suggestion.id}'
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "replierName", "title": "回复人"},
                {"data": "deptName", "title": "所属部门"},
                {"data": "reply", "title": "回复"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-zoom-in" title="详情" onclick=detail("'+row.id+'")/>';
                    }
                }
            ],
            'order' : [0,'desc'],
            "dom": 'rtlip',
            language: language
        });
    });
    <!-- 回复详情 -->
    function detail(id) {
        $("#dialog").load("<%=request.getContextPath()%>/suggestionBox/teacher/replyDetail?id=" + id);
        $("#dialog").modal("show");
    }
    <!-- 返回上级 -->
    function back() {
        $("#right").load("<%=request.getContextPath()%>/suggestionBox/teacher/suggestionListPage");
    }
</script>